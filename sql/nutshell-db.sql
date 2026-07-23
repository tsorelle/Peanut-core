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

/* Test Data */
insert  into `pnut_contacts`(`id`,`fullname`,`email`,`phone`,`listingtypeId`,`sortkey`,`notes`,`uid`,`accountId`,`createdby`,`createdon`,`changedby`,`changedon`,`active`) values
   (207,'Terry SoRelle','twoquakedev@outlook.com','',NULL,'sorelle','','23aa63a4-d5ee-4cd7-8bf8-d14f6c35a342',126,'admin','2024-12-31 17:28:10','admin','2024-12-31 17:28:10',1),
   (209,'Elizabeth Yeats','liz.yeats@outlook.com','',NULL,'yeats','','03c1eff2-3583-4696-aa49-b9285c4a563f',0,'admin','2024-12-31 17:51:36','admin','2024-12-31 17:51:36',1);

/*Data for the table `pnut_roles` */
insert  into `pnut_roles`(`id`,`name`,`description`,`createdby`,`createdon`,`changedby`,`changedon`,`active`) values
  (1,'administrator','Full control on website','unknown','2022-05-13 06:57:06',NULL,NULL,1),
  (2,'manager','Has limited administrative permissions','unknown','2022-05-13 06:57:06',NULL,NULL,1),
  (3,'member','Has membership permissions','unknown','2022-05-13 06:57:06',NULL,NULL,1);

