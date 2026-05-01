<?php

namespace Peanut\content\services;

use Peanut\content\db\ContentManager;
use Tops\services\TServiceCommand;

class SaveContentCommand extends TServiceCommand
{

    protected function run()
    {
        $request = $this->getRequest();
        if (empty($request)) {
            $this->addErrorMessage('No request received');
            return;
        }
        $contentId = $request->contentId ?? null;
        if (empty($contentId)) {
            $this->addErrorMessage('No content id received');
            return;
        }
        $content = $request->content ?? null;
        if (empty($content)) {
            $this->addErrorMessage('No content received');
        }
        $final = !empty($request->final);
        $response = (new ContentManager())->saveContent($contentId,$content,$final);
        $this->setReturnValue($response);
    }
}