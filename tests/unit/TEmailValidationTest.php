<?php
/**
 * Created by PhpStorm.
 * User: Terry
 * Date: 4/8/2019
 * Time: 4:29 PM
 */

namespace unit;

use Tops\mail\TEmailValidator;
use PHPUnit\Framework\TestCase;

class TEmailValidationTest extends TestCase
{

    public function testValidate()
    {
        $e = 'lizy@2quakers.net';
        $actual = TEmailValidator::Invalid($e);
        $this->assertFalse($actual);
    }
}

