/* 
Create test database for Peanut
Assumes empty database 
*/
CREATE TABLE `tops_mailboxes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mailboxcode` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `address` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `displaytext` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unknown',
  `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
  `changedby` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `changedon` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `public` tinyint(1) NOT NULL DEFAULT '1',
  `published` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `boxIndex` (`mailboxcode`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `tops_permissions` */

CREATE TABLE `tops_permissions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `permissionName` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_permissions_name` (`permissionName`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `tops_process_log` */

CREATE TABLE `tops_process_log` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `processCode` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `posted` datetime DEFAULT NULL,
  `event` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `messageType` int DEFAULT NULL,
  `message` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `detail` mediumtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `tops_processes` */

CREATE TABLE `tops_processes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paused` datetime DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `tops_rolepermissions` */

CREATE TABLE `tops_rolepermissions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `permissionId` int DEFAULT NULL,
  `roleName` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissionRoleIdx` (`permissionId`,`roleName`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `tops_tasklog` */

CREATE TABLE `tops_tasklog` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `time` datetime DEFAULT NULL,
  `type` int unsigned DEFAULT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `taskname` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `tops_taskqueue` */

CREATE TABLE `tops_taskqueue` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `frequency` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '24 Hours',
  `intervalType` tinyint DEFAULT '1',
  `taskname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `namespace` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `startdate` date DEFAULT NULL,
  `enddate` date DEFAULT NULL,
  `inputs` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comments` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `active` tinyint DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `pnut_authentications` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last` datetime DEFAULT CURRENT_TIMESTAMP,
  `attempts` int NOT NULL DEFAULT '1',
  `success` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `pnut_contacts` */

CREATE TABLE `pnut_contacts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `fullname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `listingtypeId` int unsigned DEFAULT '1',
  `sortkey` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `uid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `accountId` int unsigned DEFAULT NULL,
  `createdby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
  `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
  `changedby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `changedon` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_id_pnut_person` (`uid`),
  KEY `PersonNames` (`fullname`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `pnut_content` */

CREATE TABLE `pnut_content` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `format` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'html',
  `content` mediumtext COLLATE utf8mb4_unicode_ci,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unknown',
  `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
  `changedby` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `changedon` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `pnut_entity_template` */

CREATE TABLE `pnut_entity_template` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `createdby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
  `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
  `changedby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `changedon` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `pnut_roles` */

CREATE TABLE `pnut_roles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unknown',
  `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
  `changedby` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `changedon` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `pnut_userprofiles` */

CREATE TABLE `pnut_userprofiles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `fullname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `listingtypeId` int unsigned DEFAULT '1',
  `sortkey` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `uid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `accountId` int unsigned DEFAULT NULL,
  `createdby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
  `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
  `changedby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `changedon` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_id_pnut_person` (`uid`),
  KEY `PersonNames` (`fullname`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `pnut_userroles` */

CREATE TABLE `pnut_userroles` (
  `userId` int unsigned NOT NULL,
  `roleId` int unsigned NOT NULL
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `pnut_users` */

CREATE TABLE `pnut_users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint unsigned NOT NULL DEFAULT '1',
  `createdby` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unknown',
  `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
  `changedby` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `changedon` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name` (`username`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `pnut_usersessions` */

CREATE TABLE `pnut_usersessions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `sessionid` varchar(255) NOT NULL,
  `userId` int unsigned NOT NULL,
  `signedin` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_session_id` (`sessionid`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;


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

/*Table structure for table `qnut_email_messages` */

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

/*Table structure for table `qnut_listingtypes` */

CREATE TABLE `qnut_listingtypes` (
  `id` int unsigned NOT NULL,
  `code` varchar(32) NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  `description` varchar(256) DEFAULT NULL,
  `createdby` varchar(64) NOT NULL DEFAULT 'system',
  `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
  `changedby` varchar(64) DEFAULT NULL,
  `changedon` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_listingtypes` (`code`)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

/*Table structure for table `qnut_persons` */

CREATE TABLE `qnut_persons` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `middlename` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fullname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `addressId` int unsigned DEFAULT NULL,
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone2` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateofbirth` date DEFAULT NULL,
  `junior` tinyint(1) DEFAULT '0',
  `deceased` date DEFAULT NULL,
  `listingtypeId` int unsigned DEFAULT '1',
  `sortkey` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `createdby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
  `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
  `changedby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `changedon` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `uid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `accountId` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_id_qnut_person` (`uid`),
  KEY `PersonNames` (`fullname`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tops_tokens` (
   `id` int unsigned NOT NULL AUTO_INCREMENT,
   `value` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
   `posted` datetime DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (`id`),
   UNIQUE KEY `tops_tokens_value` (`value`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


/* Test Data */


insert  into `pnut_contacts`(`id`,`fullname`,`email`,`phone`,`listingtypeId`,`sortkey`,`notes`,`uid`,`accountId`,`createdby`,`createdon`,`changedby`,`changedon`,`active`) values 
(207,'Terry SoRelle','twoquakedev@outlook.com','',NULL,'sorelle','','23aa63a4-d5ee-4cd7-8bf8-d14f6c35a342',126,'admin','2024-12-31 17:28:10','admin','2024-12-31 17:28:10',1),
(208,'Marc Talbot','marc@ultimatetalbot.com','',NULL,'Talbot, Marc','Github collaborator','9af23d2d-d25a-458c-a376-ee62cbe1a8ef',128,'admin','2024-12-31 17:40:46','admin','2024-12-31 17:49:56',1),
(209,'Elizabeth Yeats','liz.yeats@outlook.com','',NULL,'yeats','','03c1eff2-3583-4696-aa49-b9285c4a563f',0,'admin','2024-12-31 17:51:36','admin','2024-12-31 17:51:36',1);

/*Data for the table `pnut_roles` */

insert  into `pnut_roles`(`id`,`name`,`description`,`createdby`,`createdon`,`changedby`,`changedon`,`active`) values 
(25,'administrator','Full control on website','unknown','2022-05-13 06:57:06',NULL,NULL,1),
(26,'manager','Has limited administrative permissions','unknown','2022-05-13 06:57:06',NULL,NULL,1),
(27,'member','Has membership permissions','unknown','2022-05-13 06:57:06',NULL,NULL,1);

/*Data for the table `pnut_userroles` */

insert  into `pnut_userroles`(`userId`,`roleId`) values 
(126,25),
(127,25),
(128,26);

/*Data for the table `pnut_users` */

insert  into `pnut_users`(`id`,`username`,`password`,`active`,`createdby`,`createdon`,`changedby`,`changedon`) values 
(1,'admin','$2y$10$35hp4TKy/wnUTjdEsjU7ZeM48mfz3IWQSm/elydQvHIZ0IUeqe5wy',1,'system','2022-05-13 06:48:49','admin','2022-05-21 14:49:46'),
(122,'terry.sorelle','$2y$10$WvoPkSom7NnF.EuR/.tRJeuv2rBbWuHTaU04s3LIp0z8YFpAm8fCi',1,'system','2022-05-23 16:34:55','admin','2022-05-23 20:15:50'),
(126,'Terry','$2y$10$rRyrizDonMunbBbQ.JjsBOMxzLv2U2E09clYGEwYsQN6h0PbMu2sq',1,'system','2022-09-27 07:13:59','admin','2022-09-27 07:15:32'),
(127,'singer','$2y$10$tE8T/aHKQYLvgldv/rlxGeplbuxkjvwg41cf6JFqZr4PtMRiS/A92',1,'system','2024-11-11 15:31:48','system','2024-11-11 15:31:48'),
(128,'metalbot','$2y$10$uDLvT5WFz6RVV31B8EO1xutHklLrkHS6a50Fh.3If.MzDUGE8gXby',1,'system','2024-12-31 17:49:56','system','2024-12-31 17:49:56');

/*Data for the table `qnut_email_lists` */

insert  into `qnut_email_lists`(`id`,`code`,`name`,`description`,`mailBox`,`cansubscribe`,`adminonly`,`createdby`,`createdon`,`changedby`,`changedon`,`active`) values 
(1,'devnews','Development News','Bulletin for development team','dev',1,0,'Terry','2024-12-31 15:49:25','Terry','2024-12-31 15:49:25',1),
(2,'newsletter','Two Quakers News','Newsletter for all','dev',1,0,'Terry','2024-12-31 15:50:09','Terry','2024-12-31 15:50:09',1);

/*Data for the table `qnut_email_subscriptions` */

insert  into `qnut_email_subscriptions`(`personId`,`listId`) values 
(207,1),
(207,2),
(208,1),
(208,2),
(209,2);

/*Data for the table `qnut_listingtypes` */

insert  into `qnut_listingtypes`(`id`,`code`,`name`,`description`,`createdby`,`createdon`,`changedby`,`changedon`,`active`) values 
(0,'none','(none)','No listing','system','2017-10-28 07:59:51',NULL,NULL,1),
(1,'all','All','All listings','system','2017-10-28 08:00:44',NULL,NULL,1),
(2,'lookup','Lookup','Lookup only','system','2017-10-28 08:01:07',NULL,NULL,1),
(3,'printed','Printed','Printed directory only','system','2017-10-28 08:02:13',NULL,NULL,1);

/*Data for the table `qnut_persons` */

/*Data for the table `tops_mailboxes` */

insert  into `tops_mailboxes`(`id`,`mailboxcode`,`address`,`displaytext`,`description`,`createdby`,`createdon`,`changedby`,`changedon`,`active`,`public`,`published`) values 
(1,'admin','terry.sorelle@outlook.com','Site Administrator','Web site administrator','Terry','2024-12-29 14:42:35','Terry','2024-12-29 14:42:35',1,1,0),
(2,'dev','twoquakedev@outlook.com','Development','Feature requests, questions and bug reports','Terry','2024-12-29 14:43:39','Terry','2025-01-01 13:35:35',1,0,0),
(3,'contact-form','twoquakedev@outlook.com','Peanut Website','For contact form return address','Terry','2024-12-29 15:13:54','Terry','2024-12-29 15:13:54',1,0,0),
(4,'support','twoquakedev@outlook.com','Website Support','Support address','Terry','2026-04-16 07:16:10','Terry', '2024-12-29 15:13:54',1,0,0);

/*Data for the table `tops_processes` */

insert  into `tops_processes`(`id`,`code`,`name`,`description`,`paused`,`enabled`) values 
(2,'email-queue-send','Send email','Process outgoing email in queue',NULL,NULL);

/*Data for the table `tops_taskqueue` */

insert  into `tops_taskqueue`(`id`,`frequency`,`intervalType`,`taskname`,`namespace`,`startdate`,`enddate`,`inputs`,`comments`,`active`) values 
(102,'1 minutes',2,'processMessageQueue','Peanut\\PeanutMailings','2025-01-01',NULL,'','',1);
