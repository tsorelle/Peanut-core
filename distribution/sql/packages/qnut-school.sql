/*****************************
    PACKAGE: qnut-school
 ******************************/



/*Table structure for table `qnut_fds_helpers` */
/* web.root/tq-peanut/pnut/packages/qnut-school/src/db/model/repository/FdsHelpersRepository.php */
CREATE TABLE `qnut_fds_helpers` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `personId` int DEFAULT NULL,
    `helperTypeId` int DEFAULT NULL,
    `backgroundCheck` date DEFAULT NULL,
    `safetyTraining` date DEFAULT NULL,
    `notes` text COLLATE utf8mb4_unicode_ci,
    `createdby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'system',
    `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
    `changedby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_fds_helpertypes` */
/* web.root/tq-peanut/pnut/packages/qnut-school/src/db/FdsDataManager.php */
CREATE TABLE `qnut_fds_helpertypes` (
    `id` int unsigned NOT NULL,
    `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `createdby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
    `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
    `changedby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_listingtypes` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_fds_kids` */
/* web.root/tq-peanut/pnut/packages/qnut-school/src/db/model/repository/FdsKidsRepository.php */
CREATE TABLE `qnut_fds_kids` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `firstName` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `lastName` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `birthdate` date DEFAULT NULL,
    `notes` text COLLATE utf8mb4_unicode_ci,
    `createdby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'system',
    `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
    `changedby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_fds_relations` */
/* web.root/tq-peanut/pnut/packages/qnut-school/src/db/model/repository/FdsRelationsRepository.php */
CREATE TABLE `qnut_fds_relations` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `kidId` int DEFAULT NULL,
    `personId` int DEFAULT NULL,
    `relationTypeId` int DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

/*Table structure for table `qnut_fds_relationtypes` */
/* web.root/tq-peanut/pnut/packages/qnut-school/src/db/model/repository/FdsRelationsRepository.php */
CREATE TABLE `qnut_fds_relationtypes` (
    `id` int unsigned NOT NULL,
    `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `createdby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
    `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
    `changedby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_listingtypes` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `qnut_fds_helpertypes` */

insert  into `qnut_fds_helpertypes`(`id`,`code`,`name`,`description`,`createdby`,`createdon`,`changedby`,`changedon`,`active`) values
    (1,'teacher','Teacher','Teacher','system','2026-05-16 11:43:32',NULL,NULL,1),
    (2,'care','Childcare Worker','Childcare Worker','system','2026-05-16 11:44:18',NULL,NULL,1),
    (3,'volunteer','Volunter','FDS Volunteer','system','2026-05-16 11:44:58',NULL,NULL,1),
    (4,'committee','Committee Member','FDS Committee Member','system','2026-05-18 14:30:39',NULL,NULL,1);

/*Data for the table `qnut_fds_relationtypes` */

insert  into `qnut_fds_relationtypes`(`id`,`code`,`name`,`description`,`createdby`,`createdon`,`changedby`,`changedon`,`active`) values
    (1,'parent','Parent','Parent','system','2026-05-16 12:07:33',NULL,NULL,1),
    (2,'relative','Relative','Relative','system','2026-05-16 12:08:08',NULL,NULL,1),
    (3,'friend','Family Friend','Family Friend','system','2026-05-16 12:08:30',NULL,NULL,1),
    (4,'grand','Grandparent','Grandparent','system','2026-05-16 12:09:17',NULL,NULL,1),
    (99,'other ','Other','Other (see notes)','system','2026-05-20 08:41:44',NULL,NULL,1);
