<?php

namespace Peanut\PeanutMailings\sys;

use Peanut\PeanutMailings\db\EMailQueue;
use Peanut\PeanutMailings\db\model\entity\EmailList;
use Peanut\PeanutMailings\db\model\entity\EmailMessage;
use Peanut\PeanutMailings\db\model\repository\EmailListsRepository;
use Peanut\PeanutMailings\db\model\repository\EmailMessagesRepository;
use Peanut\PeanutMailings\db\model\repository\EmailSubscriptionAssociation;
use stdClass;
use Tops\db\TEntityRepository;
use Tops\services\IMessageContainer;
use Tops\sys\IContactManager;
use Tops\sys\TConfiguration;
use Tops\sys\TLanguage;
use Tops\sys\TObjectContainer;
use Tops\sys\TUser;

class SubscriptionManager
{
    private IContactManager $contactManager;
    private static SubscriptionManager $instance;
    public static function getInstance()
    {
        if (!isset(self::$instance)) {
            self::$instance = new SubscriptionManager();
        }
        return self::$instance;
    }

    public function getContactManager(): IContactManager
    {
        if (!isset($this->contactManager)) {
            $this->contactManager = TObjectContainer::Get('contact.manager');
        }
        return $this->contactManager;
    }
    public function getEmailSubscriptions($personId)
    {
        return $this->getEmailSubscriptionsAssociation()->getListValues($personId);
    }
    public function getUserSubscriptions($userId)
    {
        $manager = $this->getContactManager();
        $isAdmin = TUser::getCurrent()->isAdmin();
        $response = new \stdClass();
        $response->emailSubscriptions = [];
        $response->postalSubscriptions = [];
        $response->personId = 0;
        $response->addressId = 0;
        $response->personName = '';
        $response->accountId = 0;


        if (is_numeric($userId)) {
            // when person is current user. Value from TUser->getCurrentUser()->getId()
            $person = $manager->getPersonByAccountId($userId);
            if (!$person) {
                //no contact for account, create one.
                $person = $manager->createPersonObject();
                $user = TUser::getById($userId);
                if (!$user) {
                    return false;
                }
            }
        }
    else {
            // when using person unique id, as from an email link
            $person = $manager->getPersonByUid($userId);
            if (!$person) {
                // contact was deleted
                return false;
            }
        }

        $response->personName = $person->getFullName();
        $response->personId = $person->getId();
        $response->accountId = $person->getAccountId();
        $response->emailSubscriptions =  $this->getEmailSubscriptionsAssociation()->getListValues($person->getId());
        $response->notifications = $manager->receivesNotifications($person->getUid()); // todo: refactor notification handling
        $addressId = $manager->getAddressId($response->personId);
        if ($addressId) {
            $response->addressId = $addressId;
            $response->postalSubscriptions = $manager->getPostalSubscriptions($addressId);
        }
        $response->emailLists = $manager->getEmailListLookup($isAdmin);
        $response->postalLists = $manager->getPostalListLookup();
        $response->translations =
            TLanguage::getTranslations([
                'label-email-lists',
                'label-postal-lists',
                'label-save-changes',
                'label-notifications',
                'notifications-description'
            ]);
        return $response;

    }

    private $subscriptionsAssociation;
    public function getEmailSubscriptionsAssociation()
    {
        if (!isset($this->subscriptionsAssociation)) {
            $definitions = $this->getContactManager()->getContactDefinitions();
            $this->subscriptionsAssociation = new EmailSubscriptionAssociation($definitions['table'],$definitions['entity']);
        }
        return $this->subscriptionsAssociation;
    }

    private EmailListsRepository $emailListsRepository;

    public function getEmailListsRepository()
    {
        if (!isset($this->emailListsRepository)) {
            $this->emailListsRepository = new EmailListsRepository();
        }
        return $this->emailListsRepository;
    }

    public function unsubscribeEmail($uid,$listId) : bool | \stdclass {
        $person = $this->getContactManager()->getPersonByUid($uid);
        if (!$person) {
            return false;
        }
        $list = $this->getEmailListsRepository()->get($listId);
        if (!$list) {
            return false;
        }
        $this->getEmailSubscriptionsAssociation()->unsubscribe($person->id,$listId);

        $result = new \stdClass();
        $result->removed = true; // todo: confirm how used
        $result->personName = $person ? $person->fullname : null;
        $result->listName = $list->name;
        return $result;
    }

    public function updateContactAndSubscriptions($uid,$emailSubscriptions)
    {
        $id = $this->getContactManager()->updateContact($uid);
        if ($id && is_array($emailSubscriptions)) {
            $subscriptionsRepo = $this->getEmailSubscriptionsAssociation();
            $subscriptionsRepo->updateSubscriptions($id, $emailSubscriptions);
        }
        return $id;
    }

    function unsubscribeByUid($uid,$listId)
    {
        $person = $this->getContactManager()->getPersonByUid($uid);
        if ($person) {
            $this->getEmailSubscriptionsAssociation()->unsubscribe($person->id,$listId);
        }
        return $person;
    }

    function unsubscribe($personId,$listId)
    {
        $this->getEmailSubscriptionsAssociation()->unsubscribe($personId,$listId);
    }

    public function updateEmailSubscriptions($personId,array $newSubscriptions) {
        $this->getEmailSubscriptionsAssociation()->updateSubscriptions($personId,$newSubscriptions);
    }

    public function updatePostalSubscriptions($addressId,array $newSubscriptions) {
        // todo: implement postal subscription support
    }

    public function getEmailSubscriptionList()
    {
        return $this->getEmailListsRepository()->getAll();
    }

    public function getEmailList($arg)
    {
        $listRepository = $this->getEmailListsRepository();
        if (is_numeric($arg)) {
            return $listRepository->get($arg);
        } else {
            return $listRepository->getListByCode($arg);
        }
    }

    public function createMessageListRequest($listArg, $subject, $content, $contentType='html', $template='Unsubscribe.html'): \stdClass | null
    {
        $list = is_object($listArg) ? $listArg : $this->getEmailList($listArg);
        if (empty($list)) {
            return null;
        }
        $messageDto = new \stdClass();
        $messageDto->tags = $list->getCode();
        $messageDto->sender = $list->mailBox;
        $messageDto->listId = $list->id;
        $messageDto->subject = $subject;
        $messageDto->messageText = $content;
        $messageDto->contentType = $contentType;
        $messageDto->template = $template;
        return $messageDto;
    }

    public function queueEmailMessage($messageDto, array $recipients=null) : \stdClass
    {
        $response = new \stdClass();
        $response->count = 0;
        $response->messageId = 0;
        $response->errorMessage = null;

        $username = TUser::getCurrent()->getUserName();
        /**
         * @var $message EmailMessage
         */
        $message = EmailMessage::Create($messageDto, $username);
        $messagesRepo = new EmailMessagesRepository();
        $message->id = $messagesRepo->insert($message);
        if (empty($message->id)) {
            $response->errorMessage = "Failed to create email message";
            return $response;
        }

        if ($recipients===null) {
            $queueCount = $this->getContactManager()->queueEmailRecipients($message->id, $message->listId);
        }
        else {
            $queueCount = $this->getContactManager()->queueEmailRecipientList($message->id, $recipients);
        }

        if ($queueCount == 0) {
            // no recipients, roll back
            $messagesRepo->delete($message->id);
        }
        $response->count = $queueCount;
        $response->messageId = $message->id;
        $messagesRepo->updateRecipientCount($message->id, $queueCount);

        return $response;
    }

    public function getEmailSubscriberByAccount($accountId) {
        return $this->getContactManager()->getPersonByAccountId($accountId);
    }

    public function getSubscriber($personId)
    {
        return $this->getContactManager()->getPersonById($personId);
    }

    public function updateSubscriber(\Tops\db\IBasicContact $person)
    {
        return $this->getContactManager()->updatePerson($person);
    }

    public function getSubscriberByUid($uid)
    {
        return $this->getContactManager()->getPersonByUid($uid);
    }

    public function getSubcriberByEmailAddress($emailAddress)
    {
        return $this->getContactManager()->getPersonByEmailAddress($emailAddress);
    }

    public function getAllSubscibersByEmail(string $emailAddress)
    {
        return $this->getContactManager()->getAllPersonsByEmail($emailAddress);
    }


}
