/*****************************
    PACKAGE: qnut-committees
 ******************************/
/*Table structure for table `qnut_committees` */
/* web.root/tq-peanut/pnut/packages/qnut-committees/src/db/model/repository/CommitteesRepository.php */
CREATE TABLE `qnut_committees` (
    `id` int NOT NULL AUTO_INCREMENT,
    `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `organizationId` int unsigned DEFAULT NULL,
    `fulldescription` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `mailbox` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `isStanding` tinyint(1) DEFAULT '1',
    `isLiaison` tinyint(1) DEFAULT '0',
    `membershipRequired` tinyint(1) DEFAULT '0',
    `notes` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `createdby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
    `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
    `changedby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`),
    UNIQUE KEY `committeeNameIndex` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


/*Table structure for table `qnut_committee_members` */
/* web.root/tq-peanut/pnut/packages/qnut-committees/src/db/model/repository/CommitteeMembersRepository.php */
CREATE TABLE `qnut_committee_members` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `committeeId` int unsigned DEFAULT NULL,
    `personId` int unsigned DEFAULT NULL,
    `roleId` int DEFAULT NULL,
    `notes` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `statusId` int DEFAULT NULL,
    `startOfService` date DEFAULT NULL,
    `endOfService` date DEFAULT NULL,
    `dateRelieved` date DEFAULT NULL,
    `createdby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
    `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
    `changedby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=835 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_committee_roles` */
/* web.root/tq-peanut/pnut/packages/qnut-committees/src/db/model/repository/CommitteesRepository.php
   web.root/tq-peanut/pnut/packages/qnut-committees/src/db/model/repository/CommitteeMembersRepository.php
 */
CREATE TABLE `qnut_committee_roles` (
    `id` int NOT NULL DEFAULT '0',
    `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `createdby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
    `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
    `changedby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`),
    KEY `uk_committee_role_code` (`code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_committee_statuses` */
/* web.root/tq-peanut/pnut/packages/qnut-committees/src/db/model/repository/CommitteesRepository.php
   web.root/tq-peanut/pnut/packages/qnut-committees/src/db/model/repository/CommitteeMembersRepository.php
 */
CREATE TABLE `qnut_committee_statuses` (
    `id` int unsigned NOT NULL DEFAULT '0',
    `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `createdby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
    `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
    `changedby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_committee_status_code` (`code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_committee_task_assignments` */
/* web.root/tq-peanut/pnut/packages/qnut-committees/src/db/model/repository/CommitteeTaskAssignmentsRepository.php */
CREATE TABLE `qnut_committee_task_assignments` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `taskId` int DEFAULT NULL,
    `personId` int DEFAULT NULL,
    `taskdate` date DEFAULT NULL,
    `note` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `createdby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
    `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
    `changedby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=242 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_committee_tasks` */
/* web.root/tq-peanut/pnut/packages/qnut-committees/src/db/model/repository/CommitteeTasksRepository.php */
CREATE TABLE `qnut_committee_tasks` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `committeeCode` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `taskName` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `frequency` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `createdby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
    `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
    `changedby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
