<?php

namespace unit;

use PHPUnit\Framework\TestCase;

class PeanutConstTest extends TestCase
{
    public function testConst() {
        $expectedPeanutRoot = 'tq-peanut';
        $expectedAppRoot = $expectedPeanutRoot.'/application';
        $docRoot = realpath(__DIR__.'/../../').'/web.root';
        if(substr($docRoot,1,1) == ':') {
            $docRoot = substr($docRoot,2);
        }
        $docRoot = str_replace("\\","/",$docRoot);


        $this->assertTrue(defined('DIR_ROOT'));
        $this->assertEquals($docRoot,DIR_ROOT);

        $this->assertTrue(defined('DIR_PEANUT_ROOT'));
        $expected = "$docRoot/$expectedPeanutRoot";
        $this->assertEquals($expected,DIR_PEANUT_ROOT);

        $this->assertTrue(defined('URL_PEANUT_ROOT'));
        $expected = "/$expectedPeanutRoot";
        $this->assertEquals($expected,URL_PEANUT_ROOT);

        $this->assertTrue(defined('DIR_APPLICATION'));
        $expected = "$docRoot/$expectedAppRoot";
        $this->assertEquals($expected,DIR_APPLICATION);

        $this->assertTrue(defined('URL_APPLICATION'));
        $expected = "/$expectedAppRoot";
        $this->assertEquals($expected,URL_APPLICATION);
        $this->assertTrue(defined('DIR_CONFIGURATION'));
        $expected = "$docRoot/$expectedAppRoot/config";
        $this->assertEquals($expected,DIR_CONFIGURATION);
        $this->assertTrue(defined('DIR_CONFIGURATION'));
        $expected = "$docRoot/$expectedAppRoot/config";
        $this->assertEquals($expected,DIR_CONFIGURATION);
    }


}
