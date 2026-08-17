<?php

namespace Peanut\contacts\services;

use Peanut\contacts\db\ContactsManager;
use Peanut\PeanutMailings\sys\SubscriptionManager;

class GetContactDetailsCommand extends \Tops\services\TServiceCommand
{

    protected function run()
    {
        $id = $this->getRequest();
        if (!is_numeric($id)) {
            $this->addErrorMessage('Invalid contact id');
            return;
        }
        $response = new \stdClass();
        $subscriptionManager = new SubscriptionManager();
        $response->subscriptions = $subscriptionManager->getEmailSubscriptions($id);
        $this->setReturnValue($response);
    }
}
