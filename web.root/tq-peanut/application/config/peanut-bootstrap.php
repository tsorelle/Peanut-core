<?php
/**
 * Created by PhpStorm.
 * User: Terry
 * Date: 5/1/2017
 * Time: 10:33 AM
 */

namespace Peanut;
use Tops\sys\TKeyValuePair;
use Tops\sys\TLanguage;
use Tops\sys\TPath;
use Tops\sys\TStrings;
use Peanut\sys\ViewModelManager;
use Tops\sys\TWebSite;

class Bootstrap
{
    /**
     * scriptDirectoryLevel constant.
     *
     * The following routine determines the path from which all the rest are offset.
     * Usually this is the document root but the whole system might be copied into a subdirectory.  E.g.  /TestSite
     * If this script is located at 'application/settings' scriptDirectoryLevel = 2 but if
     * I moved it to sites/all/modules/peanut/configuration, scriptDirectoryLevel should = 5
     *
     * Adjust accordingly if you move the file.
     */
    const scriptDirectoryLevel = 2;

    /**
     * @return array
     * @throws \Exception
     */
    public static function readPeanutSettings($configPath = null): array
    {
        if ($configPath === null) {
            $configPath = __DIR__;
        }
        $ini = parse_ini_file($configPath. '/settings.ini', true);
        if ($ini === false) {
            throw new \Exception('Settings file not found');
        }
        $settings = $ini['peanut'] ?? null;
        if ($settings === null) {
            throw new \Exception('Section [peanut] not found in Settings file');
        }
        return array($ini, $settings);
    }
    private static function toPsr4Namespace($ns)
    {
        if (empty($ns)) {
            return '\\';
        }
        if (strpos($ns, '\\') === 0) {
            $ns = substr($ns,1);
        }
        if (substr($ns,-1) != '\\') {
            $ns .= '\\';
        }
        return $ns;
    }

    public static function testAutoload($testPaths = []): void
    {
        // Check one class in each mapped path
        $testPaths = array_merge($testPaths,  [
            'Tops\sys\TUser',
            'Peanut\sys\TVmContext',
            'Peanut\PeanutPermissions\services\GetPermissionsCommand'
        ]);
        $testPaths = array_merge($testPaths,
           include 'required-classes.php'
        );

        $failed = [];
        if (class_exists('Tops\sys\TWebSite')) {
            switch (TWebSite::GetCmsType()) {
                case 'ConcreteCMS':
                    $testPaths[] = 'Tops\concrete5\Concrete5AccountManager';
                    break;
                case 'WordPress':
                    $testPaths[] = 'Tops\wordpress\TWordpressUser';
                    break;
                Case 'Nutshell' :
                    $testPaths[] = 'Nutshell\cms\SiteMap';
                    break;
            }
        }
        else {
            $failed[] = 'Tops\sys\TWebSite';
        }
        foreach ($testPaths as $path) {
            if (!class_exists($path)) {
                $failed[] = $path;
            }
        }
        if (!empty($failed)) {
            $list = implode('; ',$failed);
            throw new \Exception('Failed to load test paths: '.$list);
        }
    }
    public static function initialize($fileRoot=null) {
        if ($fileRoot === null) {
            $fileRoot = self::getDocumentRoot();
        }
        $configDir = self::normalizePath(__DIR__);
        $applicationDir = self::normalizePath(__DIR__ . '/..');
        // Define constants matching those in ConcreteCMS
        if (!defined('DIR_BASE')) {
            define('DIR_BASE', $fileRoot);
        }
        if (!str_ends_with($fileRoot,'/')) {
            $fileRoot .= '/';
        }
        if (!defined('DIR_CONFIG_SITE')) {
            define('DIR_CONFIG_SITE', $configDir);
        }
        if (!defined('DIR_CONFIG')) {
            define('DIR_CONFIG', $configDir);
        }
        if (!defined('DIR_APPLICATION')) {
            define('DIR_APPLICATION', $applicationDir);
        }

        $settings = self::getBootSettings();
        $autoloadFile = $fileRoot.$settings->composerPath.'/autoload.php';
        if (!file_exists($autoloadFile)) {
            exit ("No autoload file: $autoloadFile");
        }
        include_once $autoloadFile;

        $topsRoot = $settings->topsLocation;
        $appSrcRoot = $settings->mvvmPath.'src';
        $loader = Autoloader::getInstance();
        // $applicationRoot = realpath(__DIR__.'/..');
        // $test = $fileRoot. $settings->applicationPath;

        $loader->addPsr4('Peanut\Application',$fileRoot.$appSrcRoot);
        $loader->addPsr4('Tops',$fileRoot.$topsRoot);
        $loader->addPsr4('Peanut',$fileRoot.$settings->peanutSrcLocation);
        $loader->addPsr4('Application', $fileRoot. $settings->applicationPath.'/src');

        $packages = ViewModelManager::getPackageList();
        if (!empty($packages)) {
            $packagePath = ViewModelManager::getPackagePath();
            foreach ($packages as $package) {
                $namespace = null;
                $iniPath = $fileRoot.$packagePath."/$package/package.ini";
                if (file_exists($iniPath)) {
                    $ini = parse_ini_file($iniPath, false);
                    if (isset($ini['namespace'])) {
                        $namespace = $ini['namespace'];
                    }
                }

                if (!$namespace) {
                    $namespace = 'Peanut\\'.TStrings::toCamelCase($package);
                }
                $srcRoot = $fileRoot.$packagePath."/$package/src";
                $loader->addPsr4($namespace.'\\', $srcRoot);
            }
        }


        foreach ($settings->autoloadItems as $namespace => $srcRoot) {
            // todo: review and consider nested str_replace
            $srcRoot = str_replace('[pnut-src]',$settings->srcLocation,$srcRoot);
            $srcRoot = str_replace('[app-src]','application/src',$srcRoot);
            $srcRoot = str_replace('\\',DIRECTORY_SEPARATOR,$srcRoot);
            $p = $fileRoot.$srcRoot;
            $loader->addPsr4($namespace . '\\', $fileRoot.$srcRoot);
        }



        TPath::Initialize($fileRoot);

        // note: these lines needed for Tops security token handling.
        // however on some CMS systems (e.g. Concrete5) it interferes with the CMS'
        // session handling.  Call \Tops\sys\TSession::Initialize() after the session has been started.
        // usually in module startup code.
        // session_start();
        // \Tops\sys\TSession::Initialize();


        if ($settings->language !== 'en-us') {
            $translations = TLanguage::getTranslations(
                array(
                    'wait-please',
                    'wait-action-loading',
                    'wait-action-update',
                    'wait-action-add',
                    'wait-action-delete'
                )
            );
            TKeyValuePair::CreateCookie($translations,'peanutTranslations');
        }
        else  if (isset($_COOKIE['peanutTranslations'])) {
            // remove cookies
            setcookie('peanutTranslations', '', time() - 3600, '/');
            setcookie('peanutTranslations', '', time() - 3600, '/peanut/service');
            setcookie('peanutTranslations', '', time() - 3600, '/peanut');
            unset($_COOKIE['peanutTranslations']);
        }

        $response = new \stdClass();
        $response->loader = $loader;
        $response->settings = $settings;
        return $response;
    }

    private static function getCssOverrides() {
        $test = __DIR__ . '/../assets/styles/pnut';
        $overrideDir = realpath($test);
        if ($overrideDir === false) {
            return [];
        }
        $files =  scandir($overrideDir);
        $result = array();
        foreach ($files as $file) {
            if (strcasecmp(pathinfo($file, PATHINFO_EXTENSION), 'css') == 0) {
                $result[] = $file;
            }
        }
        return $result;
    }

    private static $rootOffset;
    private static $documentRoot;

    private static function getRootOffset() {
        self::getDocumentRoot();
        return self::$rootOffset;
    }

    private static function  getDocumentRoot()
    {
        if (!isset(self::$documentRoot)) {
            $root = $_SERVER['DOCUMENT_ROOT'] ?? null;
            if (!empty($root)) {
                self::$documentRoot = $root;
            }
            else {
                $parts = explode(DIRECTORY_SEPARATOR, __DIR__);
                while (!empty($parts)) {
                    $currentDir = implode(DIRECTORY_SEPARATOR, $parts);
                    if (file_exists($currentDir . '/index.php')) {
                        self::$documentRoot = $currentDir;
                        self::$rootOffset = strlen($currentDir);
                        return self::$documentRoot;
                    }
                    array_pop($parts);
                }
            }
        }
        self::$rootOffset = strlen(self::$documentRoot);
        return self::$documentRoot;
    }

    private static function getRelativePath($path) {
        $path = self::normalizePath($path);
        if ($path === false) {
            return false;
        }
        return substr($path,self::getRootOffset());
    }

    private static function normalizePath($path,$stripRoot=true) {
        $path = realpath($path);
        if ($path === false) {
            return false;
        }
        $path = str_replace('\\','/',$path).'/';
        return $path;
    }

    public static function getSettings() : \stdClass
    {
        // assumes cwd in config
        list($ini, $settings) = self::readPeanutSettings();
        $root = empty($settings['commonRootPath']) ? '/' : $settings['commonRootPath'];
        $root = str_replace('\\','/', $root);
        $applicationPath = self::getRelativePath(__DIR__ . '/..');

        $result = new \stdClass();

        $libDefaults = [];
        if (empty($ini['libraries'])) {
            $result->libraries = $libDefaults;
        } else {
            $result->libraries = $ini['libraries'];
            foreach ($libDefaults as $key => $value) {
                if (!array_key_exists($key, $result->libraries)) {
                    $result->libraries[$key] = $value;
                }
            }
        }

        $modulePath = (empty($settings['modulePath']) ? 'tq-peanut' : $settings['modulePath']);
        $peanutRoot = (empty($settings['peanutRootPath']) ? "$modulePath/pnut" : $settings['peanutRootPath']);
        $peanutPath = $root . $peanutRoot;
        $mvvmPath = (empty($settings['mvvmPath']) ?  $applicationPath.'peanut' : $root.$settings['mvvmPath']);
        $corePath = $root . (empty($settings['corePath']) ? $peanutRoot . '/core' : $settings['corePath']);
        $packagePath = $root . (empty($settings['packagePath']) ? $peanutRoot . "/packages" : $settings['packagePath']);
        // $srcLocation = empty($ini['locations']['src']) ? "$modulePath/src" : $ini['locations']['src'];

        if (isset($settings['optimize'])) {
            $optimize = $settings['optimize'] == 0 ? false : true;
        } else {
            $optimize = true;
        }

        /* not supported in this version
            if ($optimize) {
                    $result->dependencies = $peanutPath . '/dist/peanut.min.js';
        }*/

        //  knockout always first
        // $result->dependencies = ["$corePath/lib/knockout/knockout-3.5.1.js"];
        $result->dependencies = ["https://cdnjs.cloudflare.com/ajax/libs/knockout/3.5.1/knockout-latest.min.js"];
        $dependencies = empty($settings['dependencies']) ?
            [] 
            : explode(',', $settings["dependencies"]);
        foreach ($dependencies as $dependency) {
            switch ($dependency) {
                case 'ajax' :
                    $result->dependencies[] = "$corePath/lib/ajax/jqueryajax-2.1.1-min.js";
                    break;
                case 'jquery' :
                    $result->dependencies[] = "https://code.jquery.com/jquery-3.6.0.min.js";
                    break;
                case 'fontawesome' :
                    $result->dependencies[] = "https://kit.fontawesome.com/e3f06c8db4.js";
                    break;
            }
        }
        if ($optimize) {
            $result->dependencies[] = "$corePath/peanut-core.min.js";
        }
        else {
            $result->dependencies[] = "$corePath/App.js";
            $result->dependencies[] = "$corePath/KnockoutHelper.js";
            $result->dependencies[] = "$corePath/WaitMessage.js";
            $result->dependencies[] = "$corePath/Services.js";
            $result->dependencies[] = "$corePath/ViewModelBase.js";
        }
        $result->applicationVersionNumber = empty($settings['applicationVersionNumber']) ? '0.0' : $settings['applicationVersionNumber'];
        $result->commonRootPath = $root;
        $result->applicationPath = $applicationPath;
        $result->libraryPath = empty($settings['libraryPath']) ? $result->applicationPath . "assets/js/libraries/" : $settings['libraryPath'] . '/';
        $result->stylesPath = empty($settings['stylesPath']) ? $result->applicationPath . "assets/styles/" : $settings['stylesPath'] . '/';
        $result->peanutRootPath = $peanutPath . '/';
        $result->corePath = $peanutPath . '/core/';
        $result->packagePath = $packagePath . '/';
        $result->mvvmPath = $mvvmPath . '/';
        $result->serviceUrl = empty($settings['serviceUrl']) ? '/peanut/service/execute' : $settings['serviceUrl'];
        $result->vmNamespace = empty($settings['vmNamespace']) ? 'Peanut' : $settings['vmNamespace'];
        $result->uiExtension = empty($settings['uiExtension']) ? 'BootstrapFA' : $settings['uiExtension'];

/*        $result->srcLocation = $srcLocation;
        $result->topsLocation = empty($ini['locations']['tops']) ? "$srcLocation/tops" : $ini['locations']['tops'];
        $result->peanutSrcLocation = "$srcLocation/peanut";
        $result->autoloadItems = empty($ini['autoload']) ? array() : $ini['autoload'];
*/
        $result->peanutUrl = empty($ini['pages']['peanutUrl']) ? 'peanut' : $ini['pages']['peanutUrl'];
//        $result->composerPath = empty($ini['locations']['composer']) ? '../vendor' : $ini['locations']['composer'];
        $result->language = empty($settings['language']) ? 'en-us' : $settings['language '];
        if (empty($settings['loggingMode'])) {
            $result->loggingMode = $optimize ?
                'errors' : // errors and fatals
                'verbose'; // verbose - everything
        } else {
            $result->loggingMode = $settings['loggingMode'];
        }
        $result->optimize = $optimize;
        $result->cssOverrides = self::getCssOverrides();
        return $result;
    }
    private static function getBootSettings() : \stdClass
    {
        // assumes cwd in config
        // $configPath = self::getRelativePath(__DIR__);
        $documentRoot = self::getDocumentRoot();
        $applicationDir = self::normalizePath(__DIR__ . '/..');
        $applicationPath = substr($applicationDir,strlen($documentRoot));
        list($ini, $settings) = self::readPeanutSettings();
        $root = empty($settings['commonRootPath']) ? '/' : $settings['commonRootPath'];
        $root = str_replace('\\','/', $root);
        $result = new \stdClass();
        $result->optimize = ($settings['optimize'] ?? 0) == 1 ? true : false;
        $modulePath = (empty($settings['modulePath']) ? 'tq-peanut' : $settings['modulePath']);
        $peanutRoot = (empty($settings['peanutRootPath']) ? "$modulePath/pnut" : $settings['peanutRootPath']);
        $peanutPath = $root . $peanutRoot;
        $mvvmPath = (empty($settings['mvvmPath']) ?  $applicationPath.'peanut' : $root.$settings['mvvmPath']);
        $corePath = $root . (empty($settings['corePath']) ? $peanutRoot . '/core' : $settings['corePath']);
        $packagePath = $root . (empty($settings['packagePath']) ? $peanutRoot . "/packages" : $settings['packagePath']);
        $srcLocation = empty($ini['locations']['src']) ? "$modulePath/src" : $ini['locations']['src'];
        $result->composerPath = empty($ini['locations']['composer']) ? '../vendor' : $ini['locations']['composer'];
        $result->applicationPath = $applicationPath;
        $result->topsLocation = empty($ini['locations']['tops']) ? "$srcLocation/tops" : $ini['locations']['tops'];
        $result->mvvmPath = $mvvmPath . '/';
        $result->peanutSrcLocation = "$srcLocation/peanut";
        $result->autoloadItems = empty($ini['autoload']) ? array() : $ini['autoload'];
        $result->srcLocation = $srcLocation;
        $result->language = empty($settings['language']) ? 'en-us' : $settings['language '];


        return $result;
    }
}

/**
 * Use this standard ps4 autoloader if not using Composer Autoload.
 *
 * Adapted from: https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-4-autoloader-examples.md
 * Added static method Autoloader::LoadTops
 *
 * Example:
 *    $loader = include __DIR__."(relative /../)tops/lib/Autoloader.php";
 *     // add additional namespaces:
 *    $loader->addNamespace('Bookstore', $boostoreSrcPath);
 *
 * An example of a general-purpose implementation that includes the optional
 * functionality of allowing multiple base directories for a single namespace
 * prefix.
 *
 * Given a foo-bar package of classes in the file system at the following
 * paths ...
 *
 *     /path/to/packages/foo-bar/
 *         src/
 *             Baz.php             # Foo\Bar\Baz
 *             Qux/
 *                 Quux.php        # Foo\Bar\Qux\Quux
 *         tests/
 *             BazTest.php         # Foo\Bar\BazTest
 *             Qux/
 *                 QuuxTest.php    # Foo\Bar\Qux\QuuxTest
 *
 * ... add the path to the class files for the \Foo\Bar\ namespace prefix
 * as follows:
 *
 *      <?php
 *      // instantiate the loader
 *      $loader = new \Example\Psr4AutoloaderClass;
 *
 *      // register the autoloader
 *      $loader->register();
 *
 *      // register the base directories for the namespace prefix
 *      $loader->addNamespace('Foo\Bar', '/path/to/packages/foo-bar/src');
 *      $loader->addNamespace('Foo\Bar', '/path/to/packages/foo-bar/tests');
 *
 * The following line would cause the autoloader to attempt to load the
 * \Foo\Bar\Qux\Quux class from /path/to/packages/foo-bar/src/Qux/Quux.php:
 *
 *      <?php
 *      new \Foo\Bar\Qux\Quux;
 *
 * The following line would cause the autoloader to attempt to load the
 * \Foo\Bar\Qux\QuuxTest class from /path/to/packages/foo-bar/tests/Qux/QuuxTest.php:
 *
 *      <?php
 *      new \Foo\Bar\Qux\QuuxTest;
 */
class Autoloader
{
    private static $instance;
    public static function getInstance() {
        if (!isset(self::$instance)) {
            self::$instance = new Autoloader();
            self::$instance->register();
        }
        return self::$instance;
    }

    /**
     * An associative array where the key is a namespace prefix and the value
     * is an array of base directories for classes in that namespace.
     *
     * @var array
     */
    protected $prefixes = array();

    /**
     * Register loader with SPL autoloader stack.
     *
     * @return void
     */
    public function register()
    {
        spl_autoload_register(array($this, 'loadClass'));
    }

    /**
     * Adds a base directory for a namespace prefix.
     *
     * @param string $prefix The namespace prefix.
     * @param string $base_dir A base directory for class files in the
     * namespace.
     * @param bool $prepend If true, prepend the base directory to the stack
     * instead of appending it; this causes it to be searched first rather
     * than last.
     * @return void
     */
    public function addNamespace($prefix, $base_dir, $prepend = false)
    {
        // normalize namespace prefix
        $prefix = trim($prefix, '\\') . '\\';

        // normalize the base directory with a trailing separator
        $base_dir = rtrim($base_dir, DIRECTORY_SEPARATOR) . '/';

        // initialize the namespace prefix array
        if (isset($this->prefixes[$prefix]) === false) {
            $this->prefixes[$prefix] = array();
        }

        // retain the base directory for the namespace prefix
        if ($prepend) {
            array_unshift($this->prefixes[$prefix], $base_dir);
        } else {
            array_push($this->prefixes[$prefix], $base_dir);
        }
    }

    // alias for addNamespace - simulates composer autoloader syntax
    public function addPsr4($prefix, $base_dir, $prepend = false)  {
        $this->addNamespace($prefix,$base_dir);
    }

    /**
     * Loads the class file for a given class name.
     *
     * @param string $class The fully-qualified class name.
     * @return mixed The mapped file name on success, or boolean false on
     * failure.
     */
    public function loadClass($class)
    {
        // the current namespace prefix
        $prefix = $class;

        // work backwards through the namespace names of the fully-qualified
        // class name to find a mapped file name
        while (false !== $pos = strrpos($prefix, '\\')) {

            // retain the trailing namespace separator in the prefix
            $prefix = substr($class, 0, $pos + 1);

            // the rest is the relative class name
            $relative_class = substr($class, $pos + 1);

            // try to load a mapped file for the prefix and relative class
            $mapped_file = $this->loadMappedFile($prefix, $relative_class);
            if ($mapped_file) {
                return $mapped_file;
            }

            // remove the trailing namespace separator for the next iteration
            // of strrpos()
            $prefix = rtrim($prefix, '\\');
        }

        // never found a mapped file
        return false;
    }

    /**
     * Load the mapped file for a namespace prefix and relative class.
     *
     * @param string $prefix The namespace prefix.
     * @param string $relative_class The relative class name.
     * @return mixed Boolean false if no mapped file can be loaded, or the
     * name of the mapped file that was loaded.
     */
    protected function loadMappedFile($prefix, $relative_class)
    {
        // are there any base directories for this namespace prefix?
        if (isset($this->prefixes[$prefix]) === false) {
            return false;
        }

        // look through base directories for this namespace prefix
        foreach ($this->prefixes[$prefix] as $base_dir) {

            // replace the namespace prefix with the base directory,
            // replace namespace separators with directory separators
            // in the relative class name, append with .php
            $file = $base_dir
                . str_replace('\\', '/', $relative_class)
                . '.php';

            // if the mapped file exists, require it
            if ($this->requireFile($file)) {
                // yes, we're done
                return $file;
            }
        }

        // never found it
        return false;
    }

    /**
     * If a file exists, require it from the file system.
     *
     * @param string $file The file to require.
     * @return bool True if the file exists, false if not.
     */
    protected function requireFile($file)
    {
        if (file_exists($file)) {
            require $file;
            return true;
        }
        return false;
    }
}
