<?php
/**
 * Created by PhpStorm.
 * User: Terry
 * Date: 3/25/2019
 * Time: 7:08 AM
 */

use Tops\db\TTokens;
use PHPUnit\Framework\TestCase;

class TokensTest extends TestCase
{

    public function testGet()
    {
        $expected = TTokens::Create();
        $actual = TTokens::Get($expected);
        $this->assertEquals($expected,$actual);
    }

    public function testCreate()
    {
        $value = TTokens::Create();
        $this->assertNotEmpty($value);
        $actual = strlen($value);
        $this->assertEquals($actual,72);
    }
}
