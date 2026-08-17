<?php

namespace Peanut\contacts\db;

use PHPUnit\Framework\TestCase;

class ContactsManagerTest extends TestCase
{
/*
    public function testGetContactSubscriptions()
    {

    }

    public function testUnsubscribeEmail()
    {

    }*/

    public function testGetSubscriptionValues()
    {
        $contactsManager = new ContactsManager();
        /* Test data
            id  fullname         email                    accountId  uid                                   active
        ------  ---------------  -----------------------  ---------  ------------------------------------  --------
           207  Terry SoRelle    twoquakedev@outlook.com        126  23aa63a4-d5ee-4cd7-8bf8-d14f6c35a342         1
           208  Marc Talbot      marc@ultimatetalbot.com        128  9af23d2d-d25a-458c-a376-ee62cbe1a8ef         1
           209  Elizabeth Yeats  liz.yeats@outlook.com            0  03c1eff2-3583-4696-aa49-b9285c4a563f         1
           210  Test User        test@gmail.com              (NULL)  (NULL)                                       0
        */
        $testId = 126;
        $actual = $contactsManager->getSubscriptionValues($testId);
        $this->assertNotEmpty($actual);
    }

/*    public function testUpdateEmailSubscriptions()
    {

    }*/
}
