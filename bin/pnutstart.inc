<?php
/**
 * Startup fie for scripts that require Peanut classes.  If ConcreteCMS classes are required, use cmsstart.inc
 */

// update this to match your project structure
$bootstrapDir = '/tq-peanut/bootstrap';

$projectFileRoot =   str_replace('\\','/', realpath(__DIR__.'/..')).'/web.root/';
print "Document root: $projectFileRoot\n";
include_once $projectFileRoot.$bootstrapDir.'/definitions.php';
include_once DIR_PEANUT_ROOT.'/src/tops/sys/TPath.php';
\Tops\sys\TPath::Initialize(DIR_APPLICATION.'/config');
include_once DIR_APPLICATION.'/config/peanut-bootstrap.php';
\Peanut\Bootstrap::initialize($projectFileRoot);
print class_exists('\Tops\services\TServiceCommand') ? "Ready.\n" : "Initialization Failed\n";

