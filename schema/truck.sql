CREATE TABLE `truck` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `applicant` varchar(72) NOT NULL,
  `facility_type` int(2) NOT NULL,
  `cnn` int(10) NOT NULL,
  `truck_permit_id` varchar(11) NOT NULL,
  `food_items` mediumtext,
  `schedule` mediumtext,
  `latitude` varchar(25) NOT NULL,
  `longitude` varchar(25) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `applicant` (`applicant`)
)
