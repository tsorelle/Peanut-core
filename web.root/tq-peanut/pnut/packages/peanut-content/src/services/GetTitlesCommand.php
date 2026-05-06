<?php
namespace Peanut\content\services;

use Peanut\content\db\ContentManager;
use Tops\sys\TUser;

class GetTitlesCommand extends \Tops\services\TServiceCommand
{

    protected function run()
    {
        $request = $this->getRequest();
        $context = $request->context ?? null;
        if (empty($context)) {
            $this->addErrorMessage('No context received');
            return;
        }
        $manager = new ContentManager();

        $authorId = $request->authorId ?? null;
        if (!$authorId) {
            $accountId = TUser::getCurrent()->getId();
            $author = $manager->getAuthorByAccountId($accountId);
            if (!$author) {
                $this->addErrorMessage('No author found');
            }
            $authorId = $author->id;
        }
        $response = new \stdClass();
        $sharedOnly = empty($request->sharedOnly) ? false: true;
        if ($sharedOnly) {
            $response->shared = $manager->getSharedTitlesList($context);
        }
        else {
            $response->titles = $manager->getAuthorTitles($context,$authorId);
            $response->shared = $manager->getSharedTitlesList($context,$authorId);
        }
        $this->setReturnValue($response);
    }
}