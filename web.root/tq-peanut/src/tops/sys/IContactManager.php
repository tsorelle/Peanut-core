<?php

namespace Tops\sys;

use Tops\db\IBasicContact;

interface IContactManager
{
    public function getPersonById($personId,array $includes = [], array $addressIncludes = []) : IBasicContact | false;
    public function getPersonByUid($uid) : IBasicContact | false;
    public function getPersonByAccountId($accountId) : IBasicContact | false;
    // public function getSubscriptionValues($userId) : \stdClass | false;
    public function getEmailListLookup($includeAdminOnly = false, $translate = false);
    public function getPostalListLookup($translate = false);
    public function receivesNotifications($uid) : bool;
    public function getAddressId($userId) : int;
    public function getPostalSubscriptions($addressId) : array;
    public function getAllByEmail($email) : array;
    public function getContactDefinitions(): array;
    public function queueEmailRecipients($messageId, $listId): int;
    public function updatePerson(IBasicContact $person);

    public function getPersonByEmailAddress($emailAddress);

    public function getAllPersonsByEmail(string $emailAddress): array;
}
