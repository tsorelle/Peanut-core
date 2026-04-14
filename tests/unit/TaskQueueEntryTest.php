<?php
/**
 * Created by PhpStorm.
 * User: Terry
 * Date: 4/9/2019
 * Time: 6:58 AM
 */

use Peanut\PeanutTasks\TaskQueueEntry;
use PHPUnit\Framework\TestCase;
use Tops\sys\TConfiguration;
use Tops\sys\TDates;

class TaskQueueEntryTest extends TestCase
{

    private $ordinals = [
            '', '1st','2nd','3rd','4th','5th'
        ];



    /**
     * @param $intervalType
     * @param $frequency
     * @param null $last
     * @throws Exception
     */
    private function readyToRun($intervalType,$frequency,$modifyLast=false,$expected=true) {
        if ($modifyLast === false) {
            $last = false;
        }
        else {
            $last = new \DateTime();
            if ($modifyLast) {
                $last->modify($modifyLast);
            }
        }
        $test = new TaskQueueEntry();
        $lastRun = $last ? $last->format('Y-m-d  H:i:s') : false;
        $test->intervalType = $intervalType;
        $test->frequency = $frequency;
        $actual = $test->readyToRun($lastRun);
        $this->assertEmpty($actual->error,$actual->error);
        $actual = @$actual->ready;
        $this->assertEquals($expected, $actual,"Type = $test->intervalType, Frequency = $test->frequency, Last = ". $lastRun ?? '(none)');
    }
    /**
     * @throws Exception
     */
    public function testReadyToRun()
    {
        $tz = TConfiguration::getValue('timezone', 'site');
        if ($tz) {
            date_default_timezone_set($tz);
        }

        $this->readyToRun(1, '');
        $this->readyToRun(2, '1 hour', '-2 HOUR');
        $this->readyToRun(2, '1 hour', '-30 minutes', false);

        $dow = date('l');
        $weekNumber = TDates::GetWeekNumber();
        $ordinal = $this->ordinals[$weekNumber];
        $this->readyToRun(3, "$ordinal $dow", '-1 day');

        $time = date('H:i');
        $this->readyToRun(3, "$ordinal $dow $time", '-1 day');

        $testdate = new \DateTime();
        $testdate->modify('1 hour');
        $time = $testdate->format('H:i');
        $this->readyToRun(3, "$ordinal $dow $time", '-1 day', false);

        $dow = date('l');
        $this->readyToRun(3, $dow, '-1 day');

        $testdate = new \DateTime();
        $testdate->modify('-1 day');
        $dow = $testdate->format('l');
        $this->readyToRun(3, $dow, '-1 day', false);

        $time = date('H:i');
        $dow = date('l');
        $this->readyToRun(3, "$dow $time", '-1 day');

        $testdate = new \DateTime();
        $testdate->modify('-1 day');
        $dow = $testdate->format('l');
        $this->readyToRun(3, "$dow $time", '-1 day', false);


        $testdate = new \DateTime();
        $interval = $testdate->format('D H:i');
        $this->readyToRun(3, $interval, '-1 day');

        $testdate->modify('-1 day');
        $interval = $testdate->format('D H:i');
        $this->readyToRun(3, $interval, '-1 day',false);


        $this->readyToRun(4,'','-1 day');

        $testdate = new \DateTime();
        $this->readyToRun(5, $testdate->format('Y-m-d'), '-1 day');

        $testdate = new \DateTime();
        $this->readyToRun(5, $testdate->format('Y-m-d'), null, false);
        $testdate->modify('1 hour');
        $this->readyToRun(5, $testdate->format('Y-m-d H:i'), null, false);

        $testdate = new \DateTime();
        $this->readyToRun(5, $testdate->format('Y-m-d H:i'));

        $testdate->modify('1 hour');
        $this->readyToRun(5, $testdate->format('Y-m-d H:i'), null, false);



    }

    public function testTimeConveraion() {
        $time = '1:22 pm';
        $expected = '13:22';
        $actual = TDates::To24HourTime($time);
        $this->assertEquals($expected,$actual);

        $time = '1:22 am';
        $expected = '01:22';
        $actual = TDates::To24HourTime($time);
        $this->assertEquals($expected,$actual);

        $time = '13:22';
        $expected = '13:22';
        $actual = TDates::To24HourTime($time);
        $this->assertEquals($expected,$actual);

        $expected = date('H:i');
        $actual = TDates::To24HourTime();
        $this->assertEquals($expected,$actual);

        $time = 'invalid time here';
        $actual = TDates::To24HourTime($time);
        $this->assertTrue($actual !== true);

        $time = '25:63';
        $actual = TDates::To24HourTime($time);
        $this->assertTrue($actual !== true);

        $time = '13:03 am';
        $actual = TDates::To24HourTime($time);
        $this->assertTrue($actual !== true);

        $time = '';
        $actual = TDates::To24HourTime($time);
        $expected = '00:00';
        $this->assertEquals($actual,$expected);

        $time = '';
        $actual = TDates::To24HourTime($time,true);
        $this->assertTrue($actual === '');

        $time = 'now';
        $expected = $expected = date('H:i');
        $actual = TDates::To24HourTime($time);
        $this->assertEquals($actual,$expected);

        $time = '';
        $actual = TDates::To24HourTime($time,false);
        $this->assertTrue($actual === false);

        $time = '';
        $actual = TDates::To24HourTime($time,'no time');
        $expected = 'no time';
        $this->assertEquals($actual,$expected);

    }

    public function testValidation() {
        $test = new TaskQueueEntry();
        $actual = $test->validate();
        $this->assertTrue($actual !== true);

        $test->taskname = 'testTask';
        $test->intervalType = 1;
        $actual = $test->validate();
        $this->assertTrue($actual);

        $test->intervalType = 2;

        $test->frequency = '';
        $actual = $test->validate();
        $this->assertTrue($actual !== true);

        $test->frequency = 'invalid freq';
        $actual = $test->validate();
        $this->assertTrue($actual !== true);

        $test->frequency = '7 Days';
        $actual = $test->validate();
        $this->assertTrue($actual);

        $test->intervalType = 3;

        $test->frequency = 'sixth friday';
        $actual = $test->validate();
        $this->assertTrue($actual !== true);

        $test->frequency = '3rd Wednesday';
        $actual = $test->validate();
        $this->assertTrue($actual);

        $test->frequency = '3rd wednesday';
        $actual = $test->validate();
        $this->assertTrue($actual);
        $this->assertEquals('3rd Wed',$test->frequency);

        $test->frequency = '3rd wednesday 7:00 pm';
        $actual = $test->validate();
        $this->assertTrue($actual);

        $test->frequency = '3rd wednesday 17:00 pm';
        $actual = $test->validate();
        $this->assertTrue($actual !== true);

        $test->frequency = 'wednesday';
        $actual = $test->validate();
        $this->assertTrue($actual);
        $this->assertEquals('Wed',$test->frequency);

        $test->frequency = 'wednesday 7:00 pm';
        $actual = $test->validate();
        $this->assertTrue($actual);

        $test->frequency = 'wednesday 17:00 pm';
        $actual = $test->validate();
        $this->assertTrue($actual !== true);

        $test->intervalType = 4;

        $test->frequency = '';
        $actual = $test->validate();
        $this->assertTrue($actual);

        $test->frequency = '13:20';
        $actual = $test->validate();
        $this->assertTrue($actual);

        $test->frequency = '1:20 pm';
        $actual = $test->validate();
        $this->assertTrue($actual);
        $this->assertEquals('13:20',$test->frequency);

        $test->frequency = 'invalid time';
        $actual = $test->validate();
        $this->assertTrue($actual !== true);

        $test->frequency = '13:69';
        $actual = $test->validate();
        $this->assertTrue($actual !== true);

        $test->frequency = '0:69 pm';
        $actual = $test->validate();
        $this->assertTrue($actual !== true);

        $test->intervalType = 5;

        $test->frequency = date('Y-m-d h:i:s');
        $actual = $test->validate();
        $this->assertTrue($actual);

        $test->frequency = date('Y-m-d');
        $actual = $test->validate();
        $this->assertTrue($actual);

        $test->frequency = '';
        $actual = $test->validate();
        $this->assertTrue($actual !== true);


        $test->frequency = '2019-02-foo';
        $actual = $test->validate();
        $this->assertTrue($actual !== true);



    }

    public function testShortDow() {
        $dow = 'Sunday';
        $expected = 'Sun';
        $actual = TDates::ToShortDow($dow);
        $this->assertEquals($expected,$actual);

        $dow = 'SUNday';
        $expected = 'Sun';
        $actual = TDates::ToShortDow($dow);
        $this->assertEquals($expected,$actual);

        $dow = 'friday';
        $expected = 'Fri';
        $actual = TDates::ToShortDow($dow);
        $this->assertEquals($expected,$actual);

        $expected = date('D');
        $actual = TDates::ToShortDow();
        $this->assertEquals($expected,$actual);

        $dow = 1;
        $expected = 'Sun';
        $actual = TDates::ToShortDow($dow);
        $this->assertEquals($expected,$actual);

        $dow = '';
        $actual = TDates::ToShortDow($dow);
        $this->assertTrue($actual === false);

        $dow = 'my birthday';
        $actual = TDates::ToShortDow($dow);
        $this->assertTrue($actual === false);






    }

    public function testGetWeekNumber() {
        $date = '2019-04-02';
        $test = new \DateTime($date);
        for($expected=1;$expected<6;$expected++) {
            $actual = TDates::GetWeekNumber($test);
            $this->assertEquals($expected,$actual);
            $test->modify('1 week');
        }
    }

}
