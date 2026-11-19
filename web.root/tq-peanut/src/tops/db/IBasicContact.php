<?php

namespace Tops\db;

interface IBasicContact
{
    public function getEmail() : string;
    public function getFullName() : string;
    public function getAccountId() : int | null;
    public function getId() : int | null | false;
    public function getUid() : string;

    public function setFullName(string $fullName) : void;
    public function setEmail(string $email) : void;
}
