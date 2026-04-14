<?php
/**
 * Created by PhpStorm.
 * User: Terry
 * Date: 12/22/2018
 * Time: 10:53 AM
 */

use Tops\concrete5\Concrete5DataManager;
use PHPUnit\Framework\TestCase;

class Concrete5DataManagerTest extends TestCase
{

    public function testGetBlockTypeData()
    {
        $testId = 184;
        $manager = new Concrete5DataManager();
        $actual = $manager->getBlockTypeData('KnockoutView',$testId);
        $this->assertNotEmpty($actual);

    }
}
