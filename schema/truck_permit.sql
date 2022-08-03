CREATE TABLE `truck_permit` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `truck_id` int(6) NOT NULL,
  `permit` varchar(11) NOT NULL,
  `truck_permit_approval_id` int(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `truck_id` (`truck_id`)
)
