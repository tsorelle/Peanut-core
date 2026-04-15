<?php
/**
 * Created by PhpStorm.
 * User: Terry
 * Date: 8/15/2017
 * Time: 10:32 AM
 */

use PHPUnit\Framework\TestCase;
use Tops\db\TDatabase;

class DatabaseTest extends TestCase
{
    private function ClearCaches() {
        \Tops\sys\TObjectContainer::ClearCache();
        \Tops\db\TDatabase::ClearCache();
    }


    public function testDatabaseConfig() {
        $this->ClearCaches();
        $actual = \Tops\db\TDatabase::getDbConfigurationForTest();
        $this->assertNotNull($actual);
        $this->assertNotEmpty($actual->connections);
        $keyExists=array_key_exists('bookstore',$actual->connections);
        $this->assertTrue($keyExists);
        $this->assertEquals($actual->default,'bookstore');
    }
    public function testGetConnection()
    {
        $db = new TDatabase();
        $dbh = $db->getConnection();
        $this->assertNotNull($dbh);

    }

}
