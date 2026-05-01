<?php

namespace unit;

use Peanut\content\db\ContentManager;
use PHPUnit\Framework\TestCase;

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
        $title = $contentManager->createTitle($authorId, $this->testTitle, $this->testContext, 'test content 1');
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

}
