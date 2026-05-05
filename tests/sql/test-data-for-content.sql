/*
Clean up the test data from previous tests
*/
DELETE FROM `pnut_content_versions` WHERE contentId IN (105,106,109);
DELETE FROM `pnut_content` WHERE id IN (105,106,109);
/*Data for the table `pnut_content` */
INSERT  INTO `pnut_content`(`id`,`title`,`authorId`,`context`,`shared`,`description`,`createdby`,`createdon`,`changedby`,`changedon`,`active`) VALUES
(105,'Hello World',7,'editor-test',0,'Greetings Earth','admin','2026-05-02 21:54:21','admin','2026-05-02 21:54:21',1),
(106,'Hello Mars',7,'editor-test',0,'Greetings Mars', 'admin','2026-05-02 21:56:58','admin','2026-05-02 21:56:58',1),
(109,'Test Title',8,'test',1,'A Shared Title','admin','2026-05-05 12:04:16','admin','2026-05-05 12:04:16',1);

/*Data for the table `pnut_content_versions` */
INSERT  INTO `pnut_content_versions`(`contentId`,`content`,`createdby`,`createdon`,`changedby`,`changedon`,`active`) VALUES
 (105,'test content 1','admin','2026-05-05 12:05:33','admin',	'2026-05-05 12:05:33',1),
 (105,'test content 2','admin','2026-05-05 12:05:33','admin',	'2026-05-05 12:06:33',1),
 (105,'test content 3','admin','2026-05-05 12:05:33','admin',	'2026-05-05 12:07:33',1),
 (106,'test content 1','admin','2026-05-05 12:05:33','admin',	'2026-05-05 12:09:33',1),
 (106,'test content 2','admin','2026-05-05 12:05:33','admin',	'2026-05-05 13:05:33',1),
 (109,'test content 1','admin','2026-05-05 12:05:33','admin',	'2026-05-05 15:05:33',1),
 (109,'test content 2','admin','2026-05-05 12:05:33','admin',	'2026-05-05 16:05:33',1),
 (109,'test content 3','admin','2026-05-05 12:05:33','admin',	'2026-05-05 17:05:33',1),
 (109,'test content 4','admin','2026-05-05 12:05:33','admin',	'2026-05-05 18:05:33',1);
