CREATE TABLE `facility_type` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `facility_type` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `facility_type` (`facility_type`)
)
