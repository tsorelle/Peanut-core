<?php
/**
 * Created by /tools/create-model.php
 * Time:  2022-05-11 14:51:59
 */

namespace Peanut\contacts\db\model\entity;

use Tops\db\IBasicContact;

class Contact  extends \Tops\db\TimeStampedEntity implements IBasicContact
{
    public $id;
    public $fullname;
    public $email;
    public $phone;
    public $listingtypeId;
    public $sortkey;
    public $notes;
    public $uid;
    public $accountId;
    public $active;

    public function getEmail(): string
    {
        return $this->email;
    }

    public function getFullName(): string
    {
        return $this->fullname;
    }

    public function getAccountId(): int | null
    {
        return $this->accountId;
    }

    public function getId(): int | null | false
    {
        return $this->id;
    }

    public function getUid(): string
    {
        return $this->uid;
    }

    public function setFullName(string $fullName): void
    {
        $this->fullname = $fullName;
    }

    public function setEmail(string $email): void
    {
        $this->email = $email;
    }
}
