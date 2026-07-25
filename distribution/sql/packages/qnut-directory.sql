/*****************************
    PACKAGE: qnut-directory
 ******************************/
/*Table structure for table `qnut_addresses` */
/* Repository: web.root/tq-peanut/pnut/packages/qnut-directory/src/db/model/repository/AddressesRepository.php */
CREATE TABLE `qnut_addresses` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `addressname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `address1` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `address2` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `city` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `state` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `postalcode` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `country` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `phone` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `notes` varchar(2056) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `addresstypeId` int DEFAULT '1',
    `sortkey` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `listingtypeId` int DEFAULT '1',
    `latitude` double DEFAULT NULL,
    `longitude` double DEFAULT NULL,
    `active` tinyint(1) DEFAULT '1',
    `createdby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
    `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
    `changedby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=816 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_addresstypes` */
/* Repository: web.root/tq-peanut/pnut/packages/qnut-directory/src/db/model/repository/AddressesRepository.php */
CREATE TABLE `qnut_addresstypes` (
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
    UNIQUE KEY `uk_addresstypes_code` (`code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_affiliation_roles` */
/* web.root/tq-peanut/pnut/packages/qnut-directory/src/db/DirectoryManager.php */
CREATE TABLE `qnut_affiliation_roles` (
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
    UNIQUE KEY `uk_affiliation_roles_code` (`code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_distribution_lists` */
/* packages/qnut-directory/src/db/model/repository/DistributionListsRepository.php */
CREATE TABLE `qnut_distribution_lists` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `description` varchar(1027) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedby` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    `createdby` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `createdon` datetime DEFAULT NULL,
    `active` tinyint unsigned NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_distribution_members` */
/* web.root/tq-peanut/pnut/packages/qnut-directory/src/db/model/repository/DistributionListsRepository.php */
CREATE TABLE `qnut_distribution_members` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `listId` int unsigned NOT NULL,
    `sourceId` int unsigned NOT NULL,
    `memberId` int unsigned NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1158 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_distribution_sources` */
/* web.root/tq-peanut/pnut/packages/qnut-directory/src/db/model/repository/DistributionSourcesRepository.php */
CREATE TABLE `qnut_distribution_sources` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `description` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedby` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    `createdby` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `createdon` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_email_corrections` */
/* web.root/tq-peanut/pnut/packages/qnut-directory/src/db/model/repository/EmailCorrectionsRepository.php */
CREATE TABLE `qnut_email_corrections` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `address` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `personId` int unsigned DEFAULT NULL,
    `accountId` int unsigned DEFAULT NULL,
    `reportedDate` datetime DEFAULT CURRENT_TIMESTAMP,
    `errorLevel` int NOT NULL,
    `errorMessage` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `retriesLeft` tinyint DEFAULT '0',
    `createdby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
    `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
    `changedby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=769 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_email_subscriptions` */
/* Refernced in:
   web.root/tq-peanut/pnut/packages/qnut-directory/src/db/model/repository/EmailSubscriptionAssociation.php
   web.root/tq-peanut/pnut/packages/qnut-directory/src/db/model/repository/EmailCorrectionsRepository.php
   web.root/tq-peanut/pnut/packages/qnut-directory/src/db/model/repository/PersonsRepository.php
   web.root/tq-peanut/pnut/packages/qnut-directory/src/db/model/repository/QnutSubscriptionsManager.php
 */
CREATE TABLE `qnut_email_subscriptions` (
    `personId` int NOT NULL DEFAULT '0',
    `listId` int NOT NULL DEFAULT '0',
    PRIMARY KEY (`personId`,`listId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_listingtypes` */
/* Repository: web.root/tq-peanut/pnut/packages/qnut-directory/src/db/DirectoryManager.php */
CREATE TABLE `qnut_listingtypes` (
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_notifications_optout` */
/* web.root/tq-peanut/pnut/packages/qnut-directory/src/db/model/repository/PersonsRepository.php */
CREATE TABLE `qnut_notifications_optout` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `uid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `idx_qnut_optout` (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_organizations` */
/* web.root/tq-peanut/pnut/packages/qnut-directory/src/db/model/repository/OrganizationsRepository.php */
CREATE TABLE `qnut_organizations` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `addressId` int DEFAULT NULL,
    `organizationType` int DEFAULT NULL,
    `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `phone` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `fax` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `notes` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `createdby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
    `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
    `changedby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_organizations_code` (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_organizationtypes` */
/* web.root/tq-peanut/pnut/packages/qnut-directory/src/db/model/repository/OrganizationsRepository.php */

CREATE TABLE `qnut_organizationtypes` (
    `id` int NOT NULL,
    `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `createdby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
    `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
    `changedby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_organizationtypes_code` (`code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_person_affiliations` */
/* web.root/tq-peanut/pnut/packages/qnut-directory/src/db/model/repository/PersonsRepository.php */
CREATE TABLE `qnut_person_affiliations` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `personId` int unsigned DEFAULT NULL,
    `organizationId` int unsigned DEFAULT NULL,
    `roleId` int unsigned DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `idx_person_affilations_org_role` (`organizationId`,`roleId`)
) ENGINE=MyISAM AUTO_INCREMENT=4768 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_persons` */
/* web.root/tq-peanut/pnut/packages/qnut-directory/src/db/model/repository/PersonsRepository.php */
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
) ENGINE=MyISAM AUTO_INCREMENT=1958 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_postal_lists` */
/* web.root/tq-peanut/pnut/packages/qnut-directory/src/db/model/repository/PostalSubscriptionAssociation.php
TODO: Refactor to peanut-mailings?
*/
CREATE TABLE `qnut_postal_lists` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `description` varbinary(256) DEFAULT NULL,
    `createdby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
    `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
    `changedby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_postal_lists_code` (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_postal_subscriptions` */
/* web.root/tq-peanut/pnut/packages/qnut-directory/src/db/model/repository/PostalSubscriptionAssociation.php */
CREATE TABLE `qnut_postal_subscriptions` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `addressId` int NOT NULL,
    `listId` int unsigned NOT NULL,
    PRIMARY KEY (`id`),
    KEY `uk_postal_list_addresses` (`listId`,`addressId`)
) ENGINE=MyISAM AUTO_INCREMENT=337 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/** data for lookup tables **/
insert  into `qnut_addresstypes`(`id`,`code`,`name`,`description`,`createdby`,`createdon`,`changedby`,`changedon`,`active`) values
    (0,'unknown','(unknown)',NULL,'system','2017-10-28 07:55:02',NULL,NULL,1),
    (1,'home','Residence',NULL,'system','2017-10-28 07:55:24',NULL,NULL,1),
    (2,'office','Office or business location',NULL,'system','2017-10-28 07:56:29',NULL,NULL,1),
    (3,'worship','Place of worship',NULL,'system','2017-10-28 07:59:19',NULL,NULL,1);

insert  into `qnut_affiliation_roles`(`id`,`code`,`name`,`description`,`createdby`,`createdon`,`changedby`,`changedon`,`active`) values
    (1,'member','Member',NULL,'admin','2019-03-12 18:23:56','admin','2019-03-12 18:23:56',1),
    (2,'attender','Attender',NULL,'admin','2019-03-12 18:23:56','admin','2019-03-12 18:23:56',1),
    (3,'junior','Child of member or attender',NULL,'admin','2019-03-12 18:23:56','admin','2019-03-12 18:23:56',1),
    (4,'former','Former member or attender',NULL,'admin','2019-03-12 18:23:56','admin','2019-03-12 18:23:56',1),
    (5,'sojourning','Member of another meeting',NULL,'admin','2019-03-12 18:23:56','admin','2019-03-12 18:23:56',1),
    (10,'staff','Staff member',NULL,'admin','2019-03-12 18:23:56','admin','2019-03-12 18:23:56',1),
    (11,'board','Board member',NULL,'admin','2019-03-12 18:23:56','admin','2019-03-12 18:23:56',1),
    (12,'contact','Contact',NULL,'admin','2019-03-12 18:23:56','admin','2019-03-12 18:23:56',1);


/*Data for the table `qnut_listingtypes` */

insert  into `qnut_listingtypes`(`id`,`code`,`name`,`description`,`createdby`,`createdon`,`changedby`,`changedon`,`active`) values
    (0,'none','(none)','No listing','system','2017-10-28 07:59:51',NULL,NULL,1),
    (1,'all','All','All listings','system','2017-10-28 08:00:44',NULL,NULL,1),
    (2,'lookup','Lookup','Lookup only','system','2017-10-28 08:01:07',NULL,NULL,1),
    (3,'printed','Printed','Printed directory only','system','2017-10-28 08:02:13',NULL,NULL,1);
/*Data for the table `qnut_organizationtypes` */

insert  into `qnut_organizationtypes`(`id`,`code`,`name`,`description`,`createdby`,`createdon`,`changedby`,`changedon`,`active`) values
    (1,'meeting','Friends Meeting','Friends Meeting or Church','system','2017-11-10 07:01:08',NULL,NULL,1),
    (3,'quarter','Quarterly Meeting','Friends Quarterly Meeting','system','2017-11-10 07:05:25',NULL,NULL,1),
    (2,'yearlymeeting','Yearly Meeting','Friends Yearly Meeting','system','2017-11-10 07:04:49',NULL,NULL,1),
    (4,'friendsorg','Friends Organization','Friends Organization','system','2017-11-10 07:06:13',NULL,NULL,1),
    (5,'worship','Worship Place','Other place of worship','system','2017-11-10 07:07:39',NULL,NULL,1),
    (6,'nonprofit','Non profit','Non-profit organization','system','2017-11-10 07:08:39',NULL,NULL,1),
    (7,'community','Community organization','Community or local social change organizaiton','system','2017-11-10 07:09:11',NULL,NULL,1),
    (8,'business','Business','Businesses and services','system','2017-11-10 07:09:43',NULL,NULL,1),
    (9,'govt','Government','Government Agencies','system','2017-11-10 07:10:21',NULL,NULL,1),
    (10,'other','Other','Not classified','system','2017-11-10 07:10:35',NULL,NULL,1);
