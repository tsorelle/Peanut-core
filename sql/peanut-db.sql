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


CREATE TABLE `tops_tokens` (
   `id` int unsigned NOT NULL AUTO_INCREMENT,
   `value` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
   `posted` datetime DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (`id`),
   UNIQUE KEY `tops_tokens_value` (`value`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
