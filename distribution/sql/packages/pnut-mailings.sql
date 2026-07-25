/*****************************
    PACKAGE: pnut-mailings
 ******************************/

/*Table structure for table `qnut_email_contacts` */
/* web.root/packages/knockout_view/pnut/packages/peanut-mailings/src/db/model/repository/EmailContactsRepository.php */
CREATE TABLE `qnut_email_contacts` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `email` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `description` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



/*Table structure for table `qnut_email_lists` */
/* web.root/packages/knockout_view/pnut/packages/peanut-mailings */
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
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_email_messages` */
/* web.root/tq-peanut/pnut/packages/peanut-mailings/src/db/model/repository/EmailMessagesRepository.php */
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
) ENGINE=InnoDB AUTO_INCREMENT=1319 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_email_queue` */
/*
web.root/tq-peanut/pnut/packages/peanut-mailings/src/db/model/repository/EmailMessagesRepository.php
Also referenced: web.root/tq-peanut/pnut/packages/peanut-mailings/src/db/model/repository/EmailMessagesRepository.php
*/
CREATE TABLE `qnut_email_queue` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `mailMessageId` int NOT NULL,
    `personId` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `toAddress` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `toName` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=264012 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


