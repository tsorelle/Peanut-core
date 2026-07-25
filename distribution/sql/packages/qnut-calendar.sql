/*****************************
    PACKAGE: qnut-calendar
 ******************************/
/*Table structure for table `qnut_calendar_event_committees` */
/* web.root/tq-peanut/pnut/packages/qnut-calendar/src/db/model/repository/CalendarEventsRepository.php*/
CREATE TABLE `qnut_calendar_event_committees` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `eventId` int DEFAULT NULL,
    `committeeId` int DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_event_committee` (`eventId`,`committeeId`)
) ENGINE=MyISAM AUTO_INCREMENT=240 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_calendar_event_resources` */
/* web.root/tq-peanut/pnut/packages/qnut-calendar/src/db/model/repository/CalendarResourceAssociation.php */
CREATE TABLE `qnut_calendar_event_resources` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `eventId` int unsigned NOT NULL,
    `resourceId` int unsigned NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_event_resource` (`eventId`,`resourceId`)
) ENGINE=MyISAM AUTO_INCREMENT=564 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_calendar_event_types` */
/* web.root/tq-peanut/pnut/packages/qnut-calendar/src/db/model/repository/CalendarEventTypesRepository.php */
CREATE TABLE `qnut_calendar_event_types` (
    `id` int unsigned NOT NULL DEFAULT '0',
    `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `public` tinyint unsigned NOT NULL DEFAULT '0',
    `backgroundColor` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `borderColor` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `textColor` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `createdby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
    `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
    `changedby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_calendar_event_type_code` (`code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_calendar_events` */
/* web.root/tq-peanut/pnut/packages/qnut-calendar/src/db/model/repository/CalendarEventsRepository.php */
CREATE TABLE `qnut_calendar_events` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `start` datetime NOT NULL,
    `end` datetime DEFAULT NULL,
    `allDay` tinyint(1) NOT NULL DEFAULT '0',
    `location` varchar(258) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `eventTypeId` int DEFAULT NULL,
    `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `notes` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `recurPattern` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `recurEnd` date DEFAULT NULL,
    `recurId` int DEFAULT NULL,
    `recurInstance` date DEFAULT NULL,
    `createdby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
    `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
    `changedby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=530 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_notification_subscriptions` */
/* web.root/tq-peanut/pnut/packages/qnut-calendar/src/db/model/repository/NotificationSubscriptionsRepository.php */
CREATE TABLE `qnut_notification_subscriptions` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `notificationTypeId` int unsigned NOT NULL,
    `itemId` int unsigned NOT NULL,
    `personId` int unsigned NOT NULL,
    `leadDays` int unsigned NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`),
    KEY `uk_notification_subscription` (`notificationTypeId`,`itemId`,`personId`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_notification_types` */
/* web.root/tq-peanut/pnut/packages/qnut-calendar/src/db/model/repository/NotificationSubscriptionsRepository.php */
CREATE TABLE `qnut_notification_types` (
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
    UNIQUE KEY `uk_resource_type_code` (`code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_resources` */
/* web.root/tq-peanut/pnut/packages/qnut-calendar/src/db/model/repository/CalendarResourceAssociation.php */
CREATE TABLE `qnut_resources` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `resourceTypeId` int unsigned NOT NULL DEFAULT '1',
    `createdby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
    `createdon` datetime DEFAULT CURRENT_TIMESTAMP,
    `changedby` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `changedon` datetime DEFAULT NULL,
    `active` tinyint(1) NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_committee_status_code` (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `qnut_usergroup_events` */
/* web.root/tq-peanut/pnut/packages/qnut-calendar/src/db/model/repository/CalendarUsergroupsAssociation.php */
CREATE TABLE `qnut_usergroup_events` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `groupid` int unsigned NOT NULL,
    `eventid` int unsigned NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `idx_group_events` (`groupid`,`eventid`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `qnut_calendar_event_types` */

insert  into `qnut_calendar_event_types`(`id`,`code`,`name`,`description`,`public`,`backgroundColor`,`borderColor`,`textColor`,`createdby`,`createdon`,`changedby`,`changedon`,`active`) values
    (1,'public','Public','Public events',1,'#E0F7FF','#87e1ff','#000000','system','2018-02-02 06:59:20',NULL,NULL,1),
    (2,'private','Private','Private events',0,'#E9F6E9','#8FC78F','#000000','system','2018-02-02 06:59:49',NULL,NULL,1),
    (3,'outside','Outside','Events for outside group',0,'#E3D1B5','#BD924C','#000000','system','2018-02-02 07:00:18',NULL,NULL,1),
    (4,'reservation','Reservation','Resource or room reservations',0,'#CCCCCC','#FF85A9','#000000','system','2018-02-02 07:01:50',NULL,NULL,1),
    (0,'service','Service opportunity','Service opportunities',1,'#FFF0F4','#FF85A9','#000000','system','2018-02-02 10:28:17',NULL,NULL,1);

/*Data for the table `qnut_notification_types` */

insert  into `qnut_notification_types`(`id`,`code`,`name`,`description`,`createdby`,`createdon`,`changedby`,`changedon`,`active`) values
    (1,'calendar','Calendar events','Notify when calendar event occurs','system','2018-02-09 05:43:27',NULL,NULL,1),
    (2,'committee-event','Committee Event','Notify when new comittee event posted','system','2018-02-09 05:44:44',NULL,NULL,1);
/*Data for the table `qnut_resources` */

insert  into `qnut_resources`(`id`,`code`,`name`,`description`,`resourceTypeId`,`createdby`,`createdon`,`changedby`,`changedon`,`active`) values
    (1,'worship-room','Worship room','Meeting house worship room',1,'system','2018-02-02 10:39:03',NULL,NULL,1),
    (2,'social-hall','Social hall','Social hall at meeting house',1,'system','2018-02-02 10:39:37',NULL,NULL,1),
    (3,'library','Library','Library (shelves and computer area)',1,'system','2018-02-02 10:39:58',NULL,NULL,1),
    (12,'office','Office','Office (in library room)',1,'system','2019-04-12 08:41:18',NULL,NULL,1),
    (13,'zoom','Video Conference','Reserve time for Zoom Meeting',1,'system','2020-03-19 08:26:48',NULL,NULL,1);
