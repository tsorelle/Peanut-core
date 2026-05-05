<?php
namespace Peanut\content\services;
use Peanut\content\db\ContentAuthorsRepository;
use Peanut\content\db\ContentManager;
use Peanut\content\db\model\repository\ContentRepository;
use Tops\sys\TUser;

class GetTitlesCommand extends \Tops\services\TServiceCommand
{

    protected function run()
    {
        $request = $this->getRequest();
        $context = $request->context ?? null;
        $authorId = $request->authorId ?? null;
        $sharedOnly = empty($request->sharedOnly) ?? true;
        $manager = new ContentManager();
        if ($sharedOnly) {
            $list = $manager->getSharedTitlesList($context);
        }
        if (!$authorId) {
            $accountId = TUser::getCurrent()->getId();
            $author = $manager->getAuthorByAccountId($accountId);
            if (!$author) {
                $this->addErrorMessage('No author found');
            }
            $authorId = $author->id;
        }


        $list = $manager->getTitlesList($authorId,$context);
        if (empty($authorId)) {
            $author = $manager->getAuthorByAccountId(TUser::getCurrent()->getId());
        }
        $repository = new ContentRepository();

        $titles = $r($authorId,$context);
        $this->setReturnValue($titles);
    }
}