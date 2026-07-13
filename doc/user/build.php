<?php
$source = $argv[1] ?? 'all';
$srcDir = 'user';
$docType = "help";
include_once '../../bin/build-docs.php';