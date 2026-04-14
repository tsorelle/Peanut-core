<?php

namespace tests\unit;

use Peanut\PeanutTasks\TaskLogRepository;
use PHPUnit\Framework\TestCase;

class TaskLogRepositoryTest extends TestCase
{

    public function testGetLastEntry()
    {
        $repository = new TaskLogRepository();
        $taskname = 'processMessageQueue';
        $actual = $repository->getLastEntry($taskname);
        $this->assertNotNull($actual);

    }
}
