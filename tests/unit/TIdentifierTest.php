<?php

namespace unit;

use Tops\sys\TIdentifier;
use PHPUnit\Framework\TestCase;

class TIdentifierTest extends TestCase
{

    public function testNewId()
    {
        $actual = TIdentifier::newId();
        $this->assertNotEmpty($actual);
    }

    public function testIsValid()
    {
        $actual = TIdentifier::newId();
        $this->assertTrue(TIdentifier::isValid($actual));

    }
}
