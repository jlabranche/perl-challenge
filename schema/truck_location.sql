CREATE TABLE `truck_location` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `truck_id` int(6) NOT NULL,
  `location_description` MEDIUMTEXT NOT NULL,
  `address` varchar(200) NOT NULL,
  `blocklot` varchar(12) DEFAULT NULL,
  `block` varchar(6) DEFAULT NULL,
  `lot` varchar(6) DEFAULT NULL,
  `truck_approval_id` int(2) NOT NULL DEFAULT '0',
  `truck_approval_date` datetime DEFAULT NULL,
  `x` varchar(25) NOT NULL,
  `y` varchar(25) NOT NULL,
  `latitude` varchar(25) NOT NULL,
  `longitude` varchar(25) NOT NULL,
  `location` MEDIUMTEXT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `truck_id` (`truck_id`)
)
