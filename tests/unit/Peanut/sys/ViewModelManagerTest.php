<?php

namespace Peanut\sys;

use PHPUnit\Framework\TestCase;

class ViewModelManagerTest extends TestCase
{
    public function testExtractVmName()
    {
		$actual = ViewModelManager::extractVmName('http://localhost/peanut/vm/test');
		$this->assertEquals('peanut/vm/test',$actual);
		printf("extractVmName: %s\n",$actual);
    }

    public function testGetPackageList()
    {
		$actual = ViewModelManager::getPackageList();
		$this->assertNotEmpty( $actual);
		printf("getPackageList: %s\n",count($actual));
    }

    public function testGetViewModelSettings()
    {
		$actual = ViewModelManager::getViewModelSettings('mailboxes');
		$this->assertNotEmpty( $actual);
		printf("getViewModelSettings: %s\n",$actual->vmName);
    }


    public function testGetPeanutVersion()
    {
		$actual = ViewModelManager::GetPeanutVersion();
		$this->assertNotEmpty( $actual);
		printf("GetPeanutVersion: %s\n",$actual);
    }

    public function testGetStartScript()
    {
		$actual = ViewModelManager::GetStartScript();
		$this->assertNotEmpty( $actual);
		printf("GetStartScript: %s\n",$actual);
    }

    public function testAuthorize()
	{
		// todo: implement this test
		$this->assertTrue(true);
    }

    public function testGetVmUrl()
    {
		$actual = ViewModelManager::getVmUrl('tests/SimpleTest');
		$this->assertNotEmpty( $actual);
		printf("getVmUrl: %s\n",$actual);

		$actual = ViewModelManager::getVmUrl('Mailboxes','mailboxes');
		$this->assertNotEmpty( $actual);
		printf("getVmUrl: %s\n",$actual);

		$actual = ViewModelManager::getVmUrl('Document','qnut-documents');
		$this->assertNotEmpty( $actual);
		printf("getVmUrl: %s\n",$actual);

    }

    public function testSetVmInfo()
    {
		// todo: implement this test
		$this->assertTrue(true);

	}

    public function testGetPackagePath()
    {
		$actual = ViewModelManager::getPackagePath();
		$this->assertNotEmpty( $actual);
        $this->assertEquals('tq-peanut/pnut/packages',$actual);
		printf("getPackagePath: %s\n",$actual);
    }
}
