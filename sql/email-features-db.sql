/**
  REQUIRED TABLES FOR EMAIL FEATURES
    Requires the qnut_persons table in 'directory-features-db,sql' or a similar custom table with
    a personId column such as 'pnut_contacts'in 'nutshell-directory-db,sql'

    Also requires tops_mailboxes in 'peanut-db,sql'
**/

CREATE TABLE `qnut_email_messages` (
       `id` int NOT NULL AUTO_INCREMENT,
       `listId` int NOT NULL,
       `sender` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
       `replyAddress` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
       `subject` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
       `messageText` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
       `contentType` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
       `template` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
       `tags` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
       `recipientCount` int DEFAULT '1',
       `postedDate` datetime NOT NULL,
       `postedBy` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
       `active` tinyint(1) NOT NULL DEFAULT '1',
       PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_email_queue` */

CREATE TABLE `qnut_email_queue` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `mailMessageId` int NOT NULL,
    `personId` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `toAddress` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `toName` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_email_subscriptions` */

CREATE TABLE `qnut_email_subscriptions` (
    `personId` int NOT NULL DEFAULT '0',
    `listId` int NOT NULL DEFAULT '0',
    PRIMARY KEY (`personId`,`listId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `qnut_email_lists` (
        `id` int NOT NULL AUTO_INCREMENT,
        `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
        `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
        `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `mailBox` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `cansubscribe` tinyint(1) NOT NULL DEFAULT '0',
        `adminonly` tinyint(1) NOT NULL DEFAULT '0',
        `createdby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
        `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
        `changedby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `changedon` datetime DEFAULT NULL,
        `active` tinyint(1) NOT NULL DEFAULT '1',
        PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `qnut_email_lists` */

insert  into `qnut_email_lists`(`id`,`code`,`name`,`description`,`mailBox`,`cansubscribe`,`adminonly`,`createdby`,`createdon`,`changedby`,`changedon`,`active`) values
    (1,'devnews','Development News','Bulletin for development team','dev',1,0,'Terry','2024-12-31 15:49:25','Terry','2024-12-31 15:49:25',1),
    (2,'newsletter','Two Quakers News','Newsletter for all','dev',1,0,'Terry','2024-12-31 15:50:09','Terry','2024-12-31 15:50:09',1);
