<?php

namespace Peanut\contacts\services;

use Peanut\contacts\db\ContactsManager;
use Tops\services\TServiceCommand;
use Tops\sys\TConfiguration;
use Tops\sys\TLanguage;

class GetContactSubscriptionsCommand extends TServiceCommand
{

    protected function run()
    {
        $manager = new ContactsManager();
        $user = $this->getUser();
        $request = $this->getRequest();
        $response = false;

        if ($request && !empty($request->userId)) {
            $response = $manager->getSubscriptionValues($request->userId);
        }
        else if ($user->isAuthenticated()) {
            $response = $manager->getSubscriptionValues($user->getId());
        }
        if ($response === false) {
            $response = new \stdClass();
            if (!$user->isAuthenticated()) {
                $response->redirect = TConfiguration::getValue('login-page','pages','/login');
            }
            else {
                $this->addErrorMessage('Cannot find user account.');
            }
            $this->setReturnValue($response);
            return;
        }
        if ($user->isAuthenticated() && ($user->getId() == $response->accountId)) {
            $response->pageHeading = TLanguage::text('subscription-header-default');
        }
        else {
            $response->pageHeading = TLanguage::formatText('subscription-header-format',$response->personName);
        }
        $response->emailLists = $manager->getEmailListLookup($user->isAdmin());
        // $response->postalLists = $manager->getPostalListLookup();
        $response->translations =
            TLanguage::getTranslations([
                'label-email-lists',
                'label-postal-lists',
                'label-save-changes',
                'label-notifications',
                'notifications-description'
            ]);

        $this->setReturnValue($response);
    }
}
