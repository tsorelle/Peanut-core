<?php
/**
 * Created by PhpStorm.
 * User: terry
 * Date: 5/14/2017'
 * Time: 6:01 AM
 */
$projectFileRoot =   str_replace('\\','/', realpath(__DIR__.'/../../web.root')).'/';
$location = $projectFileRoot.'nutshell\src\tops\sys\TPath.php';
include_once $location;
\Tops\sys\TPath::Initialize($projectFileRoot,'application/config');
include_once $projectFileRoot.'application/config/peanut-bootstrap.php';
\Peanut\Bootstrap::initialize($projectFileRoot);
