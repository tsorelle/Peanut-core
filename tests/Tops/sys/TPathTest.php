<?php

namespace unit;

use Tops\sys\TPath;
use PHPUnit\Framework\TestCase;

class TPathTest extends TestCase
{

    public function testStripBaseDir()
    {
        $expected = 'my/path/to/directory';
        $testPath = BASE_DIR.'/my/path/to/directory';
        $actual = TPath::stripBaseDir($testPath);
        $this->assertNotEmpty($actual);
        $this->assertEquals('/'.$expected,$actual);

        $actual = TPath::stripBaseDir($testPath,1);
        $this->assertNotEmpty($actual);
        $this->assertEquals($expected,$actual);



    }

    public function testNormalizeFilename()
    {

        $expected = 'my-fav-file.txt';

        $actual = TPath::normalizeFilename($expected);
        $this->assertNotEmpty($actual);
        $this->assertEquals($expected,$actual);

//        $old = TPath::oldNormalizeFilename($expected);
//        $this->assertEquals($old,$actual);



        $testPath = 'my  fav_file.txt';
        $actual = TPath::normalizeFilename($testPath);
        $this->assertNotEmpty($actual);
        $this->assertEquals($expected,$actual);
/*        $old = TPath::oldNormalizeFilename($expected);
        $this->assertEquals($old,$actual);*/


        $testPath = 'my-fav_file.txt';
        $actual = TPath::normalizeFilename($testPath);
        $this->assertNotEmpty($actual);
        $this->assertEquals($expected,$actual);
//        $old = TPath::oldNormalizeFilename($expected);
//        $this->assertEquals($old,$actual);

        $testPath = 'My-FAV_file.txt';
        $actual = TPath::normalizeFilename($testPath);
        $this->assertNotEmpty($actual);
        $this->assertEquals($expected,$actual);

        $testPath = 'My fav file.TXT';
        $actual = TPath::normalizeFilename($testPath);
        $this->assertNotEmpty($actual);
        $this->assertEquals($expected,$actual);


    }
}
