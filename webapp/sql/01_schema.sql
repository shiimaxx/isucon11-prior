USE `isucon2021_prior`;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id`         VARCHAR(255) PRIMARY KEY NOT NULL,
  `email`      VARCHAR(255) NOT NULL DEFAULT '',
  `nickname`   VARCHAR(120) NOT NULL DEFAULT '',
  `staff`      BOOLEAN NOT NULL DEFAULT false,
  `created_at` DATETIME(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;

DROP TABLE IF EXISTS `schedules`;
CREATE TABLE `schedules` (
  `id`         VARCHAR(255) PRIMARY KEY NOT NULL,
  `title`      VARCHAR(255) NOT NULL DEFAULT '',
  `capacity`   INT UNSIGNED NOT NULL DEFAULT 0,
  `reserved`   INT UNSIGNED NOT NULL DEFAULT 0,
  `created_at` DATETIME(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;

DROP TABLE IF EXISTS `reservations`;
CREATE TABLE `reservations` (
  `id`          VARCHAR(255) PRIMARY KEY NOT NULL,
  `schedule_id` VARCHAR(255) NOT NULL,
  `user_id`     VARCHAR(255) NOT NULL,
  `created_at`  DATETIME(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;
ALTER TABLE `reservations` ADD INDEX `idx_schedule_id` (`schedule_id`);
ALTER TABLE `reservations` ADD INDEX `idx_schedule_id_user_id` (`schedule_id`, `user_id`);
CREATE TRIGGER `incr_reserved` AFTER INSERT ON `reservations` FOR EACH ROW UPDATE `schedules` SET `reserved` = `reserved` + 1 WHERE `id` = NEW.`schedule_id`;
