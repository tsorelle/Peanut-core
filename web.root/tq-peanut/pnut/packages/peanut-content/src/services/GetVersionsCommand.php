<?php

namespace Peanut\content\services;

use Peanut\content\db\ContentManager;
use Peanut\content\db\model\repository\ContentVersionsRepository;
use Tops\services\TServiceCommand;

class GetVersionsCommand extends TServiceCommand
{

    protected function run()
    {
        $request = $this->getRequest();
        if (empty($request)) {
            $this->addErrorMessage('No request received');
            return;
        }
        $versionsRepo = new ContentVersionsRepository();
        $response = (new ContentManager())->getContentVersions($request);

        $this->setReturnValue($response);
    }
}