<?php
namespace Nutshell\bootstrap;
/*
 * ----------------------------------------------------------------------------
 * Ensure that we have a currently defined time zone.
 * This needs to be done very early in order to avoid Whoops quitting with
 * "It is not safe to rely on the system's timezone settings."
 * ----------------------------------------------------------------------------
 */
// @date_default_timezone_set(@date_default_timezone_get() ?: 'UTC');
// todo: handle timezone settings

use Nutshell\cms\routing\RouteFinder;

const NUTSHELL = true;
if (!empty($_SERVER['REQUEST_URI'])) {
    $reqExtension = strtolower( pathinfo($_SERVER['REQUEST_URI'], PATHINFO_EXTENSION));
    if (!(empty($reqExtension) || $reqExtension == 'js' || $reqExtension == 'php')) {
        // skip peant initializations for images etc.
         return;
    }
}

// location of definitions.php determines all file location constants.
// If peanut istallation is elsewhere, change this require_once statement.
require_once  __DIR__ . '/../../tq-peanut/bootstrap/definitions.php';
require_once DIR_APPLICATION . '/config/peanut-bootstrap.php';
$bootResponse  = \Peanut\Bootstrap::initialize();
// map Nutshell php soruces
$bootResponse->loader->addPsr4('Nutshell\\', __DIR__.'/../src');
if ($response->settings->optimize ?? false) {
    \Peanut\Bootstrap::testAutoload([
        'Nutshell\cms\Router',
        'Nutshell\cms\SiteMap',
        'Nutshell\cms\routing\RouteFinder'
    ]);
}

// execute request
if (isset($_SERVER['REQUEST_URI']) && !empty($_SERVER['REQUEST_URI'])) {
    $uri = preg_replace("/(^\/)|(\/$)/","",$_SERVER['REQUEST_URI']);
   //  require DIR_BASE.'/nutshell/src/cms/routing/RouteFinder.php';
    $matched = RouteFinder::matchWithRedirect($uri);
    if ($matched) { // \Nutshell\cms\RouteFinder::match($uri)) {
        unset($uri);
        if (!class_exists('\Nutshell\cms\Router')) {
            throw new \Exception('Initialization failed');
        };

        if (\Nutshell\cms\Router::Execute()) {
            exit;
        }
    }
    if (!file_exists(DIR_BASE.'/'.$uri)) {
        $redirect = false;
        $configFile = __DIR__ . '/../application/config/settings.ini';
        if (file_exists($configFile)) {
            $config = parse_ini_file($configFile, true);
            if (isset($config['site']['redirect404'])) {
                $redirect = $config['site']['redirect404'];
            }
        }

        if ($redirect) {
            $redirection = sprintf('Location: %s/%s', $redirect, $uri);
            header($redirection);
            exit;
        }
        else {
            header("HTTP/1.0 404 Not Found");
        }
    }
}

return;





