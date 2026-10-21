<?php

namespace Peanut\contacts\services;

use Peanut\contacts\db\ContactsManager;
use Peanut\users\AccountManager;
use Tops\sys\IUserAccountManager;
use Tops\sys\TCmsEvents;
use Tops\sys\TObjectContainer;
use Tops\sys\TUser;

class CreateContactAccountCommand extends \Tops\services\TServiceCommand
{

    protected function run()
    {
        $request = $this->getRequest();

        if (empty($request)) {
            $this->addErrorMessage('No request received');
            return;
        }
        $username = $request->username ?? null;
        if (empty($username)) {
            $this->addErrorMessage('Username required for new account');
            return;
        }

        $roles = $request->roles ?? null;
        if (!is_array($roles)) {
            $this->addErrorMessage('Role list not received');
            return;
        }

        $password = $request->password ?? null;
        if (empty($password)) {
            $this->addErrorMessage('Password required for new account');
            return;
        }
        $contactId = $request->contactId ?? null;

        $profile = [];
        if (!empty($request->fullName)) {
             $profile[TUser::profileKeyFullName] = $request->fullName;
        }
        $email = $request->email ?? null;
        // todo: validate email
        if (empty($email)) {
             $this->addErrorMessage('Email is required.');
        }

        if (!TObjectContainer::HasDefinition('account.manager')) {
            $this->addErrorMessage('Account manager not defined');
            return;
        }
        /**
         * @var IUserAccountManager
         */
        $accountManager = TObjectContainer::Get('account.manager');
        TCmsEvents::Enable(false);
        try {
            $account = $accountManager->addAccount($request->username, $request->password, $email, $request->roles, $profile);
            $error = $account->errorCode ?? false;
            if ($error !== false) {
                $this->addErrorMessage($account->errorCode);
                return;
            }
        }
        finally {
            TCmsEvents::Enable(true);
        }

        $contactManager = new ContactsManager();
        $updated = $contactManager->setContactSiteAccount($contactId,$account->accountId);
        if (!$updated) {
            $this->addErrorMessage('Account created but failed to update contact.');
            return;
        }

        $this->setReturnValue($account->accountId);
    }
}
