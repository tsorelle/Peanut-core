<?php

namespace Peanut\content\services;

use Peanut\content\db\ContentManager;
use Peanut\content\db\model\repository\ContentVersionsRepository;

class GetContentCommand extends \Tops\services\TServiceCommand
{

    protected function run()
    {
        $request = $this->getRequest();
        if (empty($request)) {
            $this->addErrorMessage('No request received');
        }

        $versionId = $request->versionId ?? null;

        $manager = new ContentManager();
        if (empty($versionId)) {
            $contentId = $request->contentId ?? null;
            if (empty($contentId)) {
                $this->addErrorMessage('No content or version id');
                return;
            }
            $content = $manager->getLatestVersionContent($contentId);
        }
        else {
            $content = $manager->getVersionContent($versionId);
        }


        if (empty($content)) {
            $this->addErrorMessage('No content found');
            return;
        }
        $response = $content;
        $this->setReturnValue($response);
    }
}