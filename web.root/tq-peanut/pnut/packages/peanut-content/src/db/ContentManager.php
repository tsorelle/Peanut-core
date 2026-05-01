<?php
namespace Peanut\content\db;


use Peanut\content\db\model\entity\ContentAuthor;
use Peanut\content\db\model\entity\ContentItem;
use Peanut\content\db\model\entity\ContentVersion;
use Peanut\content\db\model\repository\ContentAuthorsRepository;
use Peanut\content\db\model\repository\ContentRepository;
use Peanut\content\db\model\repository\ContentVersionsRepository;
use Tops\db\TQuery;
use Tops\sys\TUser;

class ContentManager
{
    private ContentRepository $contentRepository;

    public function getVersionContent($versionId)
    {
        return $this->getContentVersionsRepository()->get($versionId);
    }

    public function getAuthorByAccountId(int $accountId)
    {
        return $this->getContentAuthorsRepository()->getAuthorByAccountId($accountId);
    }

    public function saveContent(int $contentId, string $content, bool $final = false)
    {
        $version = new ContentVersion();
        $version->contentId = $contentId;
        $version->content = $content;
        $repository = $this->getContentVersionsRepository();
        if ($final) {
            $repository->removeVersions($contentId);
        }
        return $repository->insert($version);
    }

    private function getContentRepository() : ContentRepository {
        if (!isset($this->contentRepository)) {
            $this->contentRepository = new ContentRepository();
        }
        return $this->contentRepository;
    }

    private ContentVersionsRepository $contentVersionsRepository;

    public function getContentByContentId($contentId)
    {
        return $this->getContentVersionsRepository()->getLatestVersion($contentId);
    }

    private function getContentVersionsRepository() : ContentVersionsRepository {
        if (!isset($this->contentVersionsRepository)) {
            $this->contentVersionsRepository = new ContentVersionsRepository();
        }
        return $this->contentVersionsRepository;
    }

    private ContentAuthorsRepository $contentAuthorsRepository;
    private function getContentAuthorsRepository() : ContentAuthorsRepository {
        if (!isset($this->contentAuthorsRepository)) {
            $this->contentAuthorsRepository = new ContentAuthorsRepository();
        }
        return $this->contentAuthorsRepository;
    }

    public function getTitle($title, $authorId, $context) {
        return $this->getContentRepository()->getTitle($title, $authorId, $context);
    }



  /**
     * @param null $authorId
     * @param $title
     * @param $context
     * @param string $content
     * @return mixed|ContentItem
     */
    public function createTitle(mixed $authorId, string $title, string $context, string $content): ContentItem
    {
        $contentRepo = new ContentRepository();
        $contentItem = $contentRepo->getTitle($title, $authorId, $context);
        if (!$contentItem) {
            $contentItem = new ContentItem();
            $contentItem->title = $title;
            $contentItem->authorId = $authorId;
            $contentItem->context = $context;
            $contentItem->active = 1;
            $contentId = $contentRepo->insert($contentItem);
            $contentItem->id = $contentId;

        }
        $versionsRepo = new ContentVersionsRepository();
        $version = new ContentVersion();
        $version->contentId = $contentItem->id;
        $version->content = $content;
        $versionsRepo->insert($version);

        return $contentItem;
    }

    public function getContentByVersionId($versionId)
    {
        return $this->getContentVersionsRepository()->get($versionId);
    }

    public function getLatestVersionContent($contentId)
    {
        return $this->getContentVersionsRepository()->getLatestVersion($contentId);
    }

    public function removeContent($contentId)
    {
        $query = new TQuery();
        $query->execute("DELETE FROM pnut_content_versions WHERE contentId = ?",[ $contentId]);
        $query->execute("DELETE FROM pnut_content WHERE id = ?", [$contentId]);
        $this->getContentRepository()->delete($contentId);
    }

    public function getContentVersions($contentId)
    {
        return $this->getContentVersionsRepository()->getVersionsByContentId($contentId);
    }

    public function createAuthor($accountId, $fullName) {
        $author = $this->getAuthorByAccountId($accountId);
        if (!$author) {
            $author = new ContentAuthor();
            $author->accountId = $accountId;
            $author->fullName = $fullName;
            return $this->getContentAuthorsRepository()->insert($author);
        }
        return $author;
    }

}