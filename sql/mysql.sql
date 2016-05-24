DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` INTEGER UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `user_id` INTEGER UNSIGNED NOT NULL,
  `text` TEXT NOT NULL,
  `mention` INTEGER,
  `deleted` TINYINT DEFAULT 0,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
