<?php
namespace unit;
// include __DIR__ . '/../../web.root/application/config/peanut-bootstrap.php';

use Peanut\Bootstrap;
use PHPUnit\Framework\TestCase;


class BootstrapTest extends TestCase
{

    public function testFindFileRoot()
    {

        $expected = str_replace("\\","/", realpath(__DIR__ . '/../..')).'/web.root/';
        $actual = Bootstrap::findFileRoot();
        $this->assertEquals($expected,$actual);

    }

    public function testGetSettings()
    {

        $actual = Bootstrap::getSettings();
        $this->assertNotEmpty($actual);
    }
}
