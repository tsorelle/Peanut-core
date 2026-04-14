<?php
/**
 * Created by PhpStorm.
 * User: Terry
 * Date: 3/20/2019
 * Time: 4:55 AM
 */

use Soundasleep\Html2Text;
use Tops\mail\TPostOffice;
use PHPUnit\Framework\TestCase;

class Html2TextTest extends TestCase
{

    /**
     * @throws \Soundasleep\Html2TextException
     */
    public function testConversion()
    {
        $filepath = __DIR__.DIRECTORY_SEPARATOR.'files'.DIRECTORY_SEPARATOR;
        $html = file_get_contents($filepath.'conversiontest1.html');
        $actual = Html2Text::convert($html,['ignore_errors' => true]);
        $this->assertNotEmpty($actual);

    }
}
