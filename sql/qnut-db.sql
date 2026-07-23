

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

/*Data for the table `qnut_listingtypes` */
insert  into `qnut_listingtypes`(`id`,`code`,`name`,`description`,`createdby`,`createdon`,`changedby`,`changedon`,`active`) values
    (0,'none','(none)','No listing','system','2017-10-28 07:59:51',NULL,NULL,1),
    (1,'all','All','All listings','system','2017-10-28 08:00:44',NULL,NULL,1),
    (2,'lookup','Lookup','Lookup only','system','2017-10-28 08:01:07',NULL,NULL,1),
    (3,'printed','Printed','Printed directory only','system','2017-10-28 08:02:13',NULL,NULL,1);
