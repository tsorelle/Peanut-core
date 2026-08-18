<?php
/**
 * Created by PhpStorm.
 * User: Terry
 * Date: 3/1/2019
 * Time: 9:50 AM
 */

namespace Peanut\PeanutMailings\services;

use Peanut\PeanutMailings\sys\SubscriptionManager;
use stdClass;
use Tops\services\TServiceCommand;
use Tops\sys\TConfiguration;
use Tops\sys\TL;
use Tops\sys\TLanguage;

class UnsubscribeListCommand extends TServiceCommand
{

    protected function run()
    {
        $request = $this->getRequest();
        $response = new \stdClass();

        $response->translations = TLanguage::getTranslations([
            'manage-subscriptions'
        ]);
        $response->subscriptionsLink = TConfiguration::getValue('subscriptionsUrl','pages','user/subscriptions');
        $response->message = TLanguage::text('unsubscribe-failed');

        if (empty($request)) {
            $this->addErrorMessage('service-no-request');
            return;
        }
        if (empty($request->uid)) {
            $this->addErrorMessage('Error, no person uid');
            return;
        }
        if (empty($request->listId)) {
            $this->addErrorMessage('Error no list id');
            return;
        }

        $submanager = SubscriptionManager::getInstance();
        $list = $submanager->getEmailList($request->listId);
        if (empty($list)) {
            $this->addErrorMessage('unsubscribe-error-no-list');
            return;
        }
        $person = $submanager->getSubscriberByUid($request->uid);
        if (empty($person)) {
            $this->addErrorMessage('dir-no-person-found');
            return;
        }
        $subscriptions = $submanager->getEmailSubscriptions($person->getId());
        if (in_array($request->listId,$subscriptions)) {
            $submanager->unsubscribe($person->getId(),$request->listId);
            $response->message = sprintf('Unsubscribed %s from %s list.',$person->getFullName(),$list->name);
        }
        else {
            $response->message = sprintf('%s is not subscribed to list "%s"',$person->getFullName(),$list->name);
        }
        $this->setReturnValue($response);
    }
}
