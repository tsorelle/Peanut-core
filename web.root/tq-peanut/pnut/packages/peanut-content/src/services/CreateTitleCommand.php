<?php

namespace Peanut\content\services;

use Peanut\content\db\ContentManager;
use Peanut\content\db\model\entity\ContentAuthor;
use Tops\services\TServiceCommand;
use Tops\sys\TUser;

class CreateTitleCommand extends TServiceCommand
{
    protected function run()
    {
        $user = TUser::GetCurrent();
        if (!$user->isAuthenticated()) {
            $this->addErrorMessage('You must be signed in to save content');
            return;
        }
        $request = $this->getRequest();
        $title = $request->title ?? null;
        if (!$title) {
            $this->addErrorMessage('Title is required');
            return;
        }
        $context = $request->context ?? null;
        if (!$context) {
            $this->addErrorMessage('Context is required');
            return;
        }
        $content = $request->content ?? '';
        $content = trim($content);
        if (empty($content)) {
            $this->addErrorMessage('Content is required');
            return;
        }
        $authorId = $request->authorId ?? null;

        $manager = new ContentManager();
        if (empty($authorId)) {
            $author = $manager->createAuthor($user->getId(), $user->getFullName());
            $authorId = $author->id;
        }
        $contentItem = $manager->createTitle($authorId, $title, $context, $content);
        if ($contentItem) {
            $this->addInfoMessage("New title created: {$contentItem->title}");
        }
        $this->setReturnValue($contentItem);
    }
}

