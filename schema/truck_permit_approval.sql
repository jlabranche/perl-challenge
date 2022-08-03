CREATE TABLE `truck_permit_approval` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `truck_approval` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `truck_approval` (`truck_approval`)
)
