<?php
namespace Peanut\contacts\db;

use Peanut\contacts\db\model\entity\Contact;
use Peanut\contacts\db\model\repository\ContactsRepository;
use Peanut\PeanutMailings\db\model\repository\EmailListsRepository;
use Peanut\contacts\db\model\repository\ContactSubscriptionAssociation;
use Peanut\PeanutMailings\db\model\repository\EmailSubscriptionAssociation;
use Peanut\PeanutMailings\sys\ISubscriptionManager;
use Tops\db\IBasicContact;
use Tops\db\model\repository\LookupTableRepository;
use Tops\services\IMessageContainer;
use Tops\services\NullMessageContainer;
use Tops\sys\IContactManager;

class ContactsManager implements IContactManager
{


    private ContactsRepository $contactsRepository;

    private function getContactsRepository(): ContactsRepository
    {
        if (!isset($this->contactsRepository)) {
            $this->contactsRepository = new ContactsRepository();
        }
        return $this->contactsRepository;
    }

    private $emailListsRepository;

    private function getEmailListsRepository()
    {
        if (!isset($this->emailRepository)) {
            $this->emailListsRepository = new EmailListsRepository();
        }
        return $this->emailListsRepository;
    }


    public function getContactsAndLookups()
    {
        $result = new \stdClass();
        $contactsRepo = $this->getContactsRepository();
        $result->contacts = $contactsRepo->getContactList();
        $result->emailLists = $this->getEmailListsRepository()->getAll();
        $result->listingTypes = $contactsRepo->getListingTypes();
        return $result;
    }

    public function getContacts($filter = null, $activeOnly = true)
    {
        return $this->getContactsRepository()->getContactList($filter);
    }

    public function getContactSubscriptions($id)
    {
        $association = $this->getEmailSubscriptionsAssociation();
        return $association->getListValues($id);
    }

    public function updateContact($contactDTO, array $subscriptions = null)
    {
        $repo = $this->getContactsRepository();
        $isNew = empty($contactDTO->id);
        $contact = $isNew ? new Contact() : $repo->get($contactDTO->id);
        if (!$contact) {
            return false;
        }
        if (empty($contactDTO->sortkey)) {
            $name = $contactDTO->fullname;
            $parts = explode(' ', $contactDTO->fullname);
            $last = array_pop($parts);
            if (count($parts)) {
                $name = $last . ', ' . implode(' ', $parts);
            }
            $contactDTO->sortkey = $name;
        }
        $contact->assignFromObject($contactDTO);
        if (empty($contact->uid)) {
            $contact->uid = uniqid();
        }
        if ($isNew) {
            $id = $repo->insert($contact);
        } else {
            $repo->update($contact);
            $id = $contact->id;
        }
        if ($id === false) {
            return false;
        }

        return $id;
    }

    public function setContactSiteAccount($contactId, $accountId)
    {
        $repo = $this->getContactsRepository();
        $contact = $repo->get($contactId);
        if (!$contact) {
            return false;
        }
        $contact->accountId = $accountId;
        $repo->update($contact);
        return true;
    }


    /*private function getPersonByUid($userId)
    {
        return $this->getContactsRepository()->getEntityByUid($userId);
    }*/
    public function getEmailListLookup($includeAdminOnly = false, $translate = false)
    {
        $filter = 'cansubscribe=1';
        if ($includeAdminOnly) {
            $filter .= ' OR adminonly=1';
        }
        $repository = new LookupTableRepository('qnut_email_lists');
        return $repository->getLookupList($translate, $filter);
    }

    public function updateEmailSubscriptions($personId, $emailSubscriptions)
    {
        $this->getEmailSubscriptionsAssociation()->updateSubscriptions($personId, $emailSubscriptions);
    }

    public function getContactDefinitions(): array
    {
        return $this->getContactsRepository()->getContactDefinitions();
    }

    public function getPersonById($personId, array $includes = [], array $addressIncludes = []): IBasicContact | false
    {
        return $this->getContactsRepository()->getEntityById($personId);
    }

    public function getPersonByUid($uid): IBasicContact|false
    {
        return $this->getContactsRepository()->getByUid($uid);
    }

    public function getPostalListLookup($translate = false)
    {
        return []; // postal lists not supported
    }

    public function getPersonByAccountId($accountId): IBasicContact | false
    {
        return $this->getContactsRepository()->getByAccountId($accountId);
    }

    public function receivesNotifications($uid): bool
    {
        return true;  // everybody receives notifications
    }

    public function getAddressId($userId): int
    {
        return 0; // addresses not supported
    }

    public function getPostalSubscriptions($addressId): array
    {
        return []; // addresses not supported
    }

    public function getAllByEmail($email): array
    {
        return $this->getContactsRepository()->getAllByEmail($email);
    }

    public function unsubscribeByUid($uid, $listId): bool|\stdClass
    {
        return $this->getContactsRepository()->unsubscribeByUid($uid, $listId);
    }
}
