<?php

namespace Peanut\content\services;

use Peanut\content\db\ContentManager;
use Tops\services\TServiceCommand;

class GetLatestContentCommand extends TServiceCommand
{

    protected function run()
    {
        $contentId = $this->getRequest();
        if (empty($contentId)) {
            $this->addErrorMessage('No content id received');
            return;
        }
        $manager = new ContentManager();
        $result = $manager->getLatestVersionContent($contentId);
        $this->setReturnValue($result);
    }
}