<?php
if (!isset($source)) {
    $source = $argv[1] ?? 'all';
}
// $source = $argv[1] ?? 'all';
/*if ($argc < 2) {
    print "Usage: php bin/build-docs.php all | [file name]\n";
    exit;
}*/
// update this to match your project structure
$projectFileRoot =   str_replace('\\','/', realpath(__DIR__.'/..'));
$bootstrapDir = '/web.root/tq-peanut/bootstrap';
// $indexFileUrl = '/peanut/docs';
$indexFileUrl = '/help/docs';
// $projectFileRoot =   str_replace('\\','/', realpath(__DIR__.'/..')).'/web.root/';
print "Project root: $projectFileRoot\n";
include_once $projectFileRoot.$bootstrapDir.'/definitions.php';

if (!isset($docType)) {
    $docType = "docs";
}
if (!isset($srcDir)) {
    $srcDir = "public";
}

if ($docType === 'help') {
    $docPath = DIR_ROOT . "/" . $docType;
    $docUrl =  "/" . $docType;
}
else {
    $docPath = PNUT_APPLICATON . "/" . $docType;
    $docUrl = URL_APPLICATION . "/" . $docType;
}
$srcPath = "$projectFileRoot/doc/$srcDir";
$commonPath = "$projectFileRoot/doc/common";

include_once DIR_PEANUT_ROOT."/src/tops/sys/TStrings.php";
include_once DIR_PEANUT_ROOT."/src/tops/sys/TParseDown.php";

if (!isset($source)) {
    $source = 'all';
}
/*print "Source path: $srcPath\n";
print "Doc path: $docPath\n";*/
if($source === 'all') {
    $sections = [];
    $dirs = scandir($srcPath);
    $files = [];

    foreach ($dirs as $section) {
        if ($section == '.'
            || $section == '..'
            || (!is_dir("$srcPath/$section"))
        ) {
            continue;
        }

        $filenames = scandir("$srcPath/$section");
        foreach ($filenames as $filename) {
            $ext = pathinfo($filename, PATHINFO_EXTENSION);
            if ($ext === 'md') {
                $files[] = "$section/$filename";
            }
        }
        if (count($files) > 0) {
            $sections[] = $section;
        }

    }


}
else {
    $files = $argv;
    array_shift($files);
}

$template = file_get_contents("$commonPath/doc-template.html");
if (empty($template)) {
    print "Template not found.\n";
    exit;
}
foreach($files as $filename) {
    if (str_starts_with($filename,'/')) {
        $filename = substr($filename, 1);
    }
    $srcFile = "$srcPath/".$filename;
    print  "Processing: $srcFile...";
    // $filename = pathinfo($srcFile, PATHINFO_FILENAME);

    $content = \Tops\sys\TParseDown::ParseMdFile($srcFile);
    $content = str_ireplace('../../index.md', $indexFileUrl, $content);
    $content = str_ireplace('../index.md', $indexFileUrl, $content);
    $content = str_ireplace('.md', '.html', $content);
    print "\n";
    $title = 'Peanut Documentation';
    $content = sprintf($template,$title,$content);

    $outFile = str_ireplace('.md','.html',"$docPath/$filename");
    print "\nWriting: $outFile...";
    $outDir = dirname($outFile);

    if (!is_dir($outDir) && !mkdir($outDir, 0777, true) && !is_dir($outDir)) {
        throw new RuntimeException("Failed to create directory: $outDir");
    }
    file_put_contents($outFile,$content);
    print "\n";
}

if ($source === 'all') {
    $srcFile = "$srcPath/index.md";
    if ($docType === 'help') {
        $outFile = DIR_ROOT."/help/index.html";
    }
    else {
        $outFile = PNUT_APPLICATON."/content/pages/$docType-index.php";
    }
    print  "Processing: $srcFile...";
    $content = \Tops\sys\TParseDown::ParseMdFile($srcFile);
    $content = str_ireplace('.md', '.html', $content);
    foreach ($sections as $section) {
        $search = 'href="' . $section . '/';
        $fix = 'href="'. $docUrl . '/' . $section. '/'  ;
        $content = str_ireplace($search, $fix, $content);

        $imageDirSrc = "$srcPath/$section/img";
        if (!is_dir($imageDirSrc)) {
            continue;
        }
        $imageDirDest = "$docPath/$section/img";
        if (!is_dir($imageDirDest) && !mkdir($imageDirDest, 0777, true) && !is_dir($imageDirDest)) {
            throw new RuntimeException("Failed to create directory: $imageDirDest");
        }
        $imageFiles = scandir($imageDirSrc);
        foreach ($imageFiles as $imageFile) {
            if (str_starts_with($imageFile,'.')) {
                continue;
            }
            $srcFile = "$imageDirSrc/$imageFile";
            $destFile = "$imageDirDest/$imageFile";
            print "Copying: $imageFile...\n";
            copy($srcFile, $destFile);
        }
    }
    print "\nWriting index file: $outFile...\n";
    file_put_contents($outFile,$content);

    $sourceFile = "$commonPath/markdown.css";
    $destFile = "$docPath/markdown.css";
    print "\nWriting css file: $destFile...\n";
    copy($sourceFile, $destFile);

    $htaccess_path ="$docPath/.htaccess";
    if (!file_exists($htaccess_path)) {
        $result = file_put_contents($htaccess_path, "Require all granted\n");
        if ($result === false) {
            // handle error — log it, throw an exception, etc.
            error_log("Failed to create .htaccess at {$htaccess_path}");
        }
    }
}

print "Done.\n";

