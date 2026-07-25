CREATE TABLE `pnut_authentications` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `ip` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `last` datetime DEFAULT CURRENT_TIMESTAMP,
    `attempts` int NOT NULL DEFAULT '1',
    `success` datetime DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

