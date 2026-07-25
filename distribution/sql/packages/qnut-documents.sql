/*****************************
    PACKAGE: qnut-documents
 ******************************/

/*Table structure for table `qnut_document_addendum_types` */
/* web.root/tq-peanut/pnut/packages/qnut-documents/src/db/model/repository/DocumentsRepository.php
   web.root/tq-peanut/pnut/packages/qnut-documents/src/DocumentManager.php
*/
CREATE TABLE `qnut_document_addendum_types` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `createdby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
    `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
    `changedby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_KEYNAME_code` (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_document_committees` */
/* web.root/tq-peanut/pnut/packages/qnut-documents/src/db/model/repository/DocumentsRepository.php */
CREATE TABLE `qnut_document_committees` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `documentId` int unsigned DEFAULT NULL,
    `committeeId` int unsigned DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_docment_committee` (`documentId`,`committeeId`)
) ENGINE=MyISAM AUTO_INCREMENT=1509 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_document_file_types` */
/* web.root/tq-peanut/pnut/packages/qnut-documents/src/db/model/repository/DocumentsRepository.php */
CREATE TABLE `qnut_document_file_types` (
    `id` int unsigned NOT NULL,
    `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `createdby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
    `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
    `changedby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_FILETYPE_code` (`code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_document_status_types` */
/* web.root/tq-peanut/pnut/packages/qnut-documents/src/db/model/repository/DocumentsRepository.php */
CREATE TABLE `qnut_document_status_types` (
    `id` int unsigned NOT NULL,
    `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `createdby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
    `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
    `changedby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_KEYNAME_code` (`code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_document_text_index` */
/* web.root/tq-peanut/pnut/packages/qnut-documents/src/db/model/repository/DocumentsRepository.php */
CREATE TABLE `qnut_document_text_index` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `documentId` int unsigned NOT NULL,
    `text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `author` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `creationDate` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `modificationDate` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `pageCount` int DEFAULT NULL,
    `processedDate` datetime DEFAULT NULL,
    `statusMessage` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1777 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_document_types` */
/* web.root/tq-peanut/pnut/packages/qnut-documents/src/db/model/repository/DocumentsRepository.php */
CREATE TABLE `qnut_document_types` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `createdby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
    `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
    `changedby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_KEYNAME_code` (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_documents` */
/* web.root/tq-peanut/pnut/packages/qnut-documents/src/db/model/repository/DocumentsRepository.php */
CREATE TABLE `qnut_documents` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `filename` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `folder` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `abstract` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `protected` tinyint unsigned NOT NULL DEFAULT '1',
    `publicationDate` date DEFAULT NULL,
    `createdby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
    `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
    `changedby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '1',
    `addendumType` tinyint unsigned DEFAULT NULL,
    `addendumDate` date DEFAULT NULL,
    `addendumComment` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1826 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_usergroup_documents` */
/* web.root/tq-peanut/pnut/packages/qnut-documents/src/db/model/repository/DocumentUsergroupsAssociation.php */
CREATE TABLE `qnut_usergroup_documents` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `groupid` int unsigned NOT NULL,
    `documentid` int unsigned NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `idx_group_document` (`groupid`,`documentid`)
) ENGINE=MyISAM AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `qnut_document_addendum_types` */
insert  into `qnut_document_addendum_types`(`id`,`code`,`name`,`description`,`createdby`,`createdon`,`changedby`,`changedon`,`active`) values
    (1,'newsletter','Newsletter','Monthly newsletter','system','2019-05-14 15:54:21',NULL,NULL,1),
    (2,'minutes','Minutes','Meeting minutes','system','2019-05-14 15:54:32',NULL,NULL,1);

/*Data for the table `qnut_document_file_types` */

insert  into `qnut_document_file_types`(`id`,`code`,`name`,`description`,`createdby`,`createdon`,`changedby`,`changedon`,`active`) values
    (0,'pdf','PDF Document','PDF Readable Document','system','2018-10-03 06:33:31',NULL,NULL,1),
    (2,'doc_','Word Document','Microsoft Word','system','2018-10-03 06:34:32',NULL,NULL,1),
    (3,'xl%','Excel Document ','Microsoft Excel','system','2018-11-10 06:38:38',NULL,NULL,1),
    (4,'csv','CSV Data','Comma seperated value','system','2018-11-10 06:39:15',NULL,NULL,1),
    (5,'txt','Text file','Plain text file','system','2018-11-10 06:39:47',NULL,NULL,1),
    (6,'rtf','Rich Text Document','Rich text format file','system','2018-11-10 06:41:14',NULL,NULL,1);

/*Data for the table `qnut_document_status_types` */

insert  into `qnut_document_status_types`(`id`,`code`,`name`,`description`,`createdby`,`createdon`,`changedby`,`changedon`,`active`) values
    (1,'draft','Draft',NULL,'system','2018-05-24 17:28:37',NULL,NULL,1),
    (2,'proposed','Proposed',NULL,'system','2018-06-29 16:29:01',NULL,NULL,1),
    (3,'approved','Approved',NULL,'system','2018-06-29 16:29:26',NULL,NULL,1),
    (4,'final','Final',NULL,'system','2018-06-29 16:29:54',NULL,NULL,1);

/*Data for the table `qnut_document_types` */

insert  into `qnut_document_types`(`id`,`code`,`name`,`description`,`createdby`,`createdon`,`changedby`,`changedon`,`active`) values
    (6,'minutes','Minutes',NULL,'system','2018-06-29 16:28:17',NULL,NULL,1),
    (7,'report','Report',NULL,'system','2018-07-30 09:52:16',NULL,NULL,1),
    (8,'newsletter','Newsletter',NULL,'system','2018-07-30 09:52:26',NULL,NULL,1),
    (9,'publication','Publication',NULL,'system','2019-02-23 11:00:28',NULL,NULL,1),
    (10,'teaching','Educational',NULL,'system','2019-04-03 06:07:15',NULL,NULL,1);

