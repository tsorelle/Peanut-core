<?php

use Peanut\bootstrap\PathFinder;

defined('PEANUT_PHP_VERSION') or define('PEANUT_PHP_VERSION', 80200);
if (PEANUT_PHP_VERSION < 80200) {
    exit('PHP version 8.2 or higher is required.');
}

include_once 'PathFinder.php';

if (!defined('DIR_BASE')) {
    $path = PathFinder::getDocumentRoot();
    define('DIR_BASE', $path);
}

if (!defined('PEANUT_ROOT')) {
    $path = PathFinder::normalize(__DIR__ . '/..');
    define('PEANUT_ROOT', $path);
}

if (!defined('DIR_APPLICATION')) {
    $path = realpath(__DIR__."/../application");
    if ($path) {
        $path = PathFinder::normalize($path);
        define('DIR_APPLICATION', $path);
    }
    else if  (is_dir(DIR_BASE . '/application')){
        $path = PathFinder::normalize(DIR_BASE . '/application');
        define('DIR_APPLICATION', $path);
    }
}
if (!defined('DIR_APPLICATION')) {
    exit('Application directory not found.');
}
if (!defined('DIR_CONFIG_SITE')) {
    define('DIR_CONFIG_SITE', DIR_APPLICATION . '/config');
}

defined('PEANUT_SRC') or define('PEANUT_SRC', PEANUT_ROOT . '/src');

if (!defined('APPLICATION_URL')) {
    $path = PathFinder::ToUrl(DIR_APPLICATION);
    define('APPLICATION_URL', $path);
}

return true;