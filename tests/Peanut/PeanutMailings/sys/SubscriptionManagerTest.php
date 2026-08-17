<?php

namespace Peanut\PeanutMailings\sys;

use PHPUnit\Framework\TestCase;

class SubscriptionManagerTest extends TestCase
{

    public function testGetUserSubscriptions()
    {
        $userId = '03c1eff2-3583-4696-aa49-b9285c4a563f'; // liz
        // $userId = '23aa63a4-d5ee-4cd7-8bf8-d14f6c35a342';
        $subscriptionManager = new SubscriptionManager();
        $subscriptions = $subscriptionManager->getUserSubscriptions($userId);
        $this->assertNotEmpty($subscriptions);
    }

    public function testUpdateEmailSubscriptions()
    {
        $uid = '03c1eff2-3583-4696-aa49-b9285c4a563f'; // liz
        $userId = 209;
        $subscriptionManager = new SubscriptionManager();

        $subs = $subscriptionManager->getUserSubscriptions($uid);
        $expected= [1];
        $actual = $subs->emailSubscriptions;
        $expected= [1];
        $subscriptionManager->updateEmailSubscriptions($userId, $expected);
        $subs = $subscriptionManager->getUserSubscriptions($uid);
        $actual = $subs->emailSubscriptions;
        $this->assertEquals($expected,$actual);

        $expected= [2];
        $subscriptionManager->updateEmailSubscriptions($userId, $expected);
        $subs = $subscriptionManager->getUserSubscriptions($uid);
        $actual = $subs->emailSubscriptions;
        $this->assertEquals($expected,$actual);

        $expected= [1,2];
        $subscriptionManager->updateEmailSubscriptions($userId, $expected);
        $subs = $subscriptionManager->getUserSubscriptions($uid);
        $actual = $subs->emailSubscriptions;
        $this->assertEquals($expected,$actual);

        $expected= [];
        $subscriptionManager->updateEmailSubscriptions($userId, $expected);
        $subs = $subscriptionManager->getUserSubscriptions($uid);
        $actual = $subs->emailSubscriptions;
        $this->assertEquals($expected,$actual);

    }
}
