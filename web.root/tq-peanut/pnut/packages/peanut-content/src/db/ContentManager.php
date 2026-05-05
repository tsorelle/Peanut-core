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

    public function getSharedTitle($title, $context) {
        return $this->getContentRepository()->getSharedTitle($title, $context);
    }

  /**
     * @param null $authorId
     * @param $title
     * @param $context
     * @param string $description
     * @param string $content
     * @param bool $shared
     * @return mixed|ContentItem
     */
    public function createTitle(mixed $authorId, string $title, string $context, $description, string $content, bool $shared=false): ContentItem
    {
        $contentRepo = new ContentRepository();
        $contentItem = $contentRepo->getTitle($title, $authorId, $context);
        if (!$contentItem) {
            $contentItem = new ContentItem();
            $contentItem->title = $title;
            $contentItem->description = $description;
            $contentItem->authorId = $authorId;
            $contentItem->context = $context;
            $contentItem->active = 1;
            $contentItem->shared = $shared;
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

    public function updateTitle(ContentItem $contentItem)
    {
        $this->getContentRepository()->update($contentItem);
    }

    public function getContentByVersionId($versionId)
    {
        return $this->getContentVersionsRepository()->get($versionId);
    }

    public function getLatestVersionContent($contentId)
    {
        $version = $this->getContentVersionsRepository()->getLatestVersion($contentId);
        if ($version) {
            return $version->content;
        }
        return '';
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

    public function getVersionList($contentId)
    {
        return $this->getContentVersionsRepository()->getVersionList($contentId);
    }

    public function createAuthor($accountId, $fullName) {
        $author = $this->getAuthorByAccountId($accountId);
        if (!$author) {
            $author = new ContentAuthor();
            $author->accountId = $accountId;
            $author->fullName = $fullName;
            $author->id  = $this->getContentAuthorsRepository()->insert($author);
        }
        return $author;
    }

    public function listTitles(string $context,$authorId=null) : \stdClass {
        $repo = $this->getContentRepository();
        $result = new \stdClass();
        $result->authorTitles = [];
        if ($authorId) {
            $result->authorTitles = $repo->getTitlesListByAuthor($authorId,$context);
        }
        $result->sharedTitles = $repo->getSharedTitlesList($context);
        return $result;
    }

    public function getSharedTitlesList(string $context) : array
    {
        $repo = $this->getContentRepository();
        return $repo->getSharedTitlesList($context);
    }

}