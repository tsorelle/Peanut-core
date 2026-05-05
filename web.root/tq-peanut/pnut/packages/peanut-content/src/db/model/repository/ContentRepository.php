<?php 
namespace Peanut\content\db\model\repository;

use \PDO;
use PDOStatement;
use Tops\db\TDatabase;
use \Tops\db\TEntityRepository;
use Tops\db\TQuery;

class ContentRepository extends \Tops\db\TEntityRepository
{


    protected function getTableName() {
        return 'pnut_content';
    }

    protected function getDatabaseId() {
        return null;
    }

    protected function getClassName() {
        return 'Peanut\content\db\model\entity\ContentItem';
    }

    protected function getFieldDefinitionList()
    {
        return array(
            'id'=>PDO::PARAM_INT,
            'title'=>PDO::PARAM_STR,
            'authorId'=>PDO::PARAM_STR,
            'context'=>PDO::PARAM_STR,
            'description'=>PDO::PARAM_STR,
            'shared'=>PDO::PARAM_BOOL,
            'createdby'=>PDO::PARAM_STR,
            'createdon'=>PDO::PARAM_STR,
            'changedby'=>PDO::PARAM_STR,
            'changedon'=>PDO::PARAM_STR,
            'active'=>PDO::PARAM_STR);
    }

    public function getTitlesListByAuthor($authorId,$context=null) {
        $sql = "SELECT c.`id`,`title`, a.`fullName` AS author, if(shared=0,'No','Yes') as shared, c.`createdon` AS dateCreated ".
            'FROM `pnut_content` c JOIN `pnut_content_authors` a ON c.`authorId` = a.`id` '.
            'WHERE (c.`active` = 1 AND c.authorId = ?';

        $params = [$authorId];
        if ($context) {
            $params[] = $context;
            $sql .= ' AND c.`context` = ?';
        }
        $sql .= ') ORDER BY c.title,c.createdon';

        $stmt =  $this->executeStatement($sql,$params);
        return $stmt->fetchAll(PDO::FETCH_OBJ);
    }
    public function getSharedTitlesList($context=null) {
        $sql = "SELECT c.`id`,`title`, IF(c.`shared` = 1,'Yes','No') AS shared, a.`fullName` AS author, c.`createdon` AS dateCreated ".
            'FROM `pnut_content` c JOIN `pnut_content_authors` a ON c.`authorId` = a.`id` '.
            'WHERE (c.`active` = 1  AND c.`shared` = 1';

        $params = [];
        if ($context) {
            $params[] = $context;
            $sql .= ' AND c.`context` = ?';
        }
        $sql .= ') ORDER BY c.title,c.createdon';
        $stmt =  $this->executeStatement($sql,$params);
        return $stmt->fetchAll(PDO::FETCH_OBJ);
    }

    public function getTitle($title,$authorId,$context) {
        $sql = 'title = ? AND authorId = ? AND context = ?';
        $params = [$title,$authorId,$context];
        return $this->getSingleEntity($sql,$params);
    }

    public function getSharedTitle($title,$context) {
        $sql = 'title = ? AND context = ? AND shared = 1';
        $params = [$title,$context];
        return $this->getSingleEntity($sql,$params);
    }
}