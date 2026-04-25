<?php
namespace unit;
// include __DIR__ . '/../../web.root/application/config/peanut-bootstrap.php';

use Peanut\Bootstrap;
use PHPUnit\Framework\TestCase;


include_once( DIR_CONFIGURATION.'/peanut-bootstrap.php');
class BootstrapTest extends TestCase
{
    // note: remove \Peanut\Bootstrap::initialize(); from inittesting.php

    public function testGetSettings()
    {
        $tests = [
            'commonRootPath' => '/'								,
            'peanutRootPath' => '/tq-peanut/pnut/'              ,
            'packagePath' => '/tq-peanut/pnut/packages/'        ,
            'mvvmPath' => '/tq-peanut/application/peanut/'                ,
            'corePath' => '/tq-peanut/pnut/core/'               ,
            'serviceUrl' => '/peanut/service/execute'           ,
            'uiExtension' => 'BootstrapFiveFA'                  ,
            'applicationPath' => '/tq-peanut/application/'               ,
            'libraryPath' => '/tq-peanut/application/assets/js/libraries/',
            'stylesPath' => '/tq-peanut/application/assets/styles/'       ,
            'vmNamespace' => 'Peanut'
        ];

        $actual = Bootstrap::getSettings();
        $this->assertNotEmpty($actual);
        foreach ($tests as $key => $value) {
            $actualValue = $actual->$key ?? null;
            $this->assertEquals($value, $actualValue);
        }
        $actualValue = $actual->cssOverrides ?? null;
        $this->assertIsArray( $actualValue);

        $actualValue = $actual->dependencies ?? null;
        $this->assertIsArray( $actualValue);

        $actualValue = $actual->libraries ?? null;
        $this->assertIsArray( $actualValue);
        $actualValue = $actual->libraries['tinymce'] ?? null;
        $expected = '/tq-peanut/application/assets/js/libraries/tinymce/js/tinymce/tinymce.min.js';
        $this->assertEquals($expected, $actualValue);
    }
    public function testInitialAutoLoad() {
        $testClasses = [
            // TOPS
            'Tops\sys\TUser',
            // Peanut core
            'Peanut\sys\TVmContext',
            // Packages
            'Peanut\QnutCalendar\db\model\repository\CalendarCommitteeAssociation',
            'Peanut\PeanutPermissions\services\GetPermissionsCommand',
            'Peanut\Mailboxes\services\UpdateMailboxCommand',
            // Application
            'Peanut\Application\bookstore\BookstoreManager',
            // Vendor
            'Mailgun\Mailgun',
            // Peanut testing, as mapped in settings.ini [autoload]
            'PeanutTest\services\helloWorldCommand',
            // test scripts
            'PeanutTest\scripts\AddaccountTest',
            'PeanutTest\scripts\UserTest',
            // custom autoloads from settings.ini
            'TwoQuakers\Songs\SongBook'
        ];
        $failed = [];
        foreach ($testClasses as $className) {
            $ok = class_exists($className);
            if (!$ok) {
                $failed[] = $className;
            }
        }
        $this->assertEmpty($failed, 'Failed to load: '.implode(', ',$failed));
    }


}
