<?php

namespace unit;

use Peanut\contacts\db\model\repository\ContactsRepository;
use Peanut\content\db\ContentManager;
use Peanut\content\db\model\repository\ContentRepository;
use PHPUnit\Framework\TestCase;
use Tops\db\TQuery;

class ContentManagerTest extends TestCase
{
    private $testTitle = 'Test Title';
    private $testContext = 'test';
    private $testAccountId = 1;
    private $manager;
    private function getManager() {
        if (!$this->manager) {
            $this->manager = new ContentManager();
        }
        return $this->manager;
    }

    private function clearData() {
        $contentManager = $this->getManager();
        $author = $contentManager->getAuthorByAccountId($this->testAccountId);
        if ($author) {
            $title = $contentManager->getTitle($this->testTitle, $author->id, $this->testContext);
            if ($title) {
                $contentManager->removeContent($title->id);
            }
        }
    }
    public function testContentManager()
    {
        $contentManager = $this->getManager();
        $this->clearData();
        $author = $contentManager->createAuthor(1, 'Test Author');
        $this->assertNotEmpty($author);
        $authorId = $author->id;
        $title = $contentManager->createTitle($authorId, $this->testTitle, $this->testContext, 'test content 1', true);

     //   $title->shared = true;
     //   $contentManager->updateTitle($title);

        $this->assertNotEmpty($title);
        $this->assertEquals($this->testTitle, $title->title);
        $this->assertEquals($this->testContext, $title->context);
        $this->assertEquals($authorId, $title->authorId);
        $this->assertNotEmpty($title->id);
        $contentId = $title->id;

        $version2 = $contentManager->saveContent($contentId, 'test content 2');
        $this->assertNotEmpty($version2);
        $version3 = $contentManager->saveContent($contentId, 'test content 3');
        $this->assertNotEmpty($version3);

        $versions = $contentManager->getContentVersions($contentId);
        $this->assertCount(3, $versions);
        $this->assertEquals('test content 1', $versions[0]->content);
        $this->assertEquals('test content 2', $versions[1]->content);
        $this->assertEquals('test content 3', $versions[2]->content);

        $versions = $contentManager->getContentVersions($contentId);
        $lastVersion = $versions[2];

        $actualVersion = $contentManager->getLatestVersionContent($contentId);
        $this->assertEquals($lastVersion->contentId, $actualVersion->contentId);
        $this->assertEquals($lastVersion->content, $actualVersion->content);
        $final = true;
        $contentManager->saveContent($contentId, 'test content 4', $final);

        $lastVersion = $contentManager->getLatestVersionContent($contentId);
        $this->assertEquals($lastVersion->content, 'test content 4');



    }

    public function testGetTitles() {
        $contentManager = $this->getManager();
        $author = $contentManager->createAuthor(1, 'Test Author');
        $this->assertNotEmpty($author);
        $authorId = $author->id;
        $authorTitles = ['test title 2.1', 'test title 2.2', 'test title 2.3'];
        $sharedTitles = ['test title 3.1', 'test title 3.2', 'test title 3.3'];

        $query = new TQuery();
        $cleanupSql = "DELETE FROM `pnut_content_versions` WHERE contentId IN (SELECT id FROM pnut_content WHERE context='test')";
        $query->execute($cleanupSql);
        $cleanupSql = "DELETE FROM pnut_content WHERE context='test'";
        $query->execute($cleanupSql);

        foreach ($authorTitles as $title) {
            $item = $contentManager->createTitle($author->id, $title, $this->testContext, 'test content 1', false);
            $contentId = $item->id;
            $contentManager->saveContent($contentId, 'test content 2');
            $contentManager->saveContent($contentId, 'test content 3');
        }
        foreach ($sharedTitles as $title) {
            $item = $contentManager->createTitle($author->id, $title, $this->testContext, 'test shared content 1', true);
            $contentId = $item->id;
            $contentManager->saveContent($contentId, 'test shared content 2');
            $contentManager->saveContent($contentId, 'test shared content 3');
        }

        $titles = $contentManager->listTitles($this->testContext, $authorId);
        $this->assertNotEmpty($titles);
        $this->assertNotEmpty($titles->authorTitles);
        $this->assertNotEmpty($titles->sharedTitles);
        $this->assertCount(3, $titles->authorTitles);
        $this->assertCount(3, $titles->sharedTitles);

        $this->assertEquals($authorTitles[0], $titles->authorTitles[0]->title);


    }

    function testEntityRegressions()
    {
        // made change to getEntityCollection.  Testing to be sure the usual calls still work.
        $repo = new ContactsRepository();
        $test = $repo->getEntityCollection('id>?', [1]);
        $this->assertNotEmpty($test);
        $test = $repo->getEntityCollection('id>?', [1],true);
        $this->assertNotEmpty($test);

    }

}
