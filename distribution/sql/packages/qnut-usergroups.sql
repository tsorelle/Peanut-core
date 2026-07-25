/*****************************
    PACKAGE: qnut-usergroups
 ******************************/

/*Table structure for table `qnut_usergroup_members` */
/* web.root/tq-peanut/pnut/packages/qnut-usergroups/src/db/model/repository/UsergroupMembersRepository.php */
CREATE TABLE `qnut_usergroup_members` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `groupid` int unsigned NOT NULL,
    `personid` int unsigned NOT NULL,
    `moderator` tinyint(1) NOT NULL DEFAULT '0',
    `sendEvents` tinyint(1) NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`),
    UNIQUE KEY `idx_group_members` (`groupid`,`personid`)
) ENGINE=MyISAM AUTO_INCREMENT=139 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_usergroups` */
/* web.root/tq-peanut/pnut/packages/qnut-usergroups/src/db/model/repository/UsergroupMembersRepository.php */
CREATE TABLE `qnut_usergroups` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `openmembership` tinyint unsigned NOT NULL DEFAULT '1',
    `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `mailingList` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `createdby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
    `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
    `changedby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
