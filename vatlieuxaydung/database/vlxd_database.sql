-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: cuahangvatlieu
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `dondathang`
--

DROP TABLE IF EXISTS `dondathang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dondathang` (
  `ma` char(36) NOT NULL,
  `dia_chi_giao_hang` varchar(255) DEFAULT NULL,
  `ngay_dat` datetime(6) DEFAULT NULL,
  `tong_tien` bigint DEFAULT NULL,
  `trang_thai` bit(1) NOT NULL,
  `ma_kh` char(36) NOT NULL,
  PRIMARY KEY (`ma`),
  KEY `FKp0vv0qefflon5w56xjgtjqhu8` (`ma_kh`),
  CONSTRAINT `FKp0vv0qefflon5w56xjgtjqhu8` FOREIGN KEY (`ma_kh`) REFERENCES `khachhang` (`ma_kh`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dondathang`
--

LOCK TABLES `dondathang` WRITE;
/*!40000 ALTER TABLE `dondathang` DISABLE KEYS */;
INSERT INTO `dondathang` VALUES ('31252f40-73a5-41f4-a517-86f6b978245c','45 Binh bong','2025-01-14 08:17:54.970000',1360000,_binary '\0','e8c8424c-a4f0-4dc6-9863-9adbf879f43d'),('3b117a6b-b4a5-4980-b67b-3952d66e3c43','123 Đường ABC, Quận 1, TP.HCM','2024-12-26 21:00:00.000000',40000000,_binary '','093b0950-bb33-40d7-b900-8f66fba36511'),('5b451361-1cfb-4582-8e25-5adc194dc0c7','123 Nguyen Du, Q4, HCM','2025-01-14 07:37:53.205000',1210000,_binary '\0','e8c8424c-a4f0-4dc6-9863-9adbf879f43d'),('5ebfba66-18e9-4a87-bac5-9aa5895a1a1f','123 Đường ABC, Quận 1, TP.HCM','2024-12-26 21:00:00.000000',40000000,_binary '\0','093b0950-bb33-40d7-b900-8f66fba36511'),('640a2643-bc4c-446c-826f-c7e694f65e65','65 Thanh Phong ','2025-01-14 17:43:52.383000',240000,_binary '','e8c8424c-a4f0-4dc6-9863-9adbf879f43d'),('6fae0a28-78c6-4870-a4e5-5bbd4265f46f','q','2025-01-14 17:53:43.601000',750000,_binary '\0','e8c8424c-a4f0-4dc6-9863-9adbf879f43d'),('7127997f-ca1f-4dc6-820c-0965e141736d','Hoa Mai ','2025-01-14 07:41:49.768000',1800000,_binary '\0','e8c8424c-a4f0-4dc6-9863-9adbf879f43d'),('8a7f26af-2686-4468-a212-abeee227389a','123 Đường ABC, Quận 1, TP.HCM','2025-01-13 05:25:00.000000',40000000,_binary '','e8c8424c-a4f0-4dc6-9863-9adbf879f43d'),('cea5606b-0306-4f72-b9ee-3ebfd65afe98','2 Thank phong','2025-01-20 17:33:35.290000',755000,_binary '\0','e8c8424c-a4f0-4dc6-9863-9adbf879f43d');
/*!40000 ALTER TABLE `dondathang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `khachhang`
--

DROP TABLE IF EXISTS `khachhang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `khachhang` (
  `ma_kh` char(36) NOT NULL,
  `active` bit(1) DEFAULT NULL,
  `dia_chi` varchar(255) DEFAULT NULL,
  `dien_thoai` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `gioi_tinh` varchar(255) DEFAULT NULL,
  `nsinh` date DEFAULT NULL,
  `pass` varchar(255) DEFAULT NULL,
  `ten_kh` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ma_kh`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khachhang`
--

LOCK TABLES `khachhang` WRITE;
/*!40000 ALTER TABLE `khachhang` DISABLE KEYS */;
INSERT INTO `khachhang` VALUES ('093b0950-bb33-40d7-b900-8f66fba36511',_binary '','79 Nguyen cong','09343223','khachHANG3@gmail.com','Nam','2002-01-16','$2a$10$P8tsoomMvNJ4sAleHzsSNulll47mRLPu6NNS9/sd7nlDpUexGWX56','khach hang 3','user3'),('2d27372b-d79c-446b-9b66-177ccc194f0f',_binary '\0','dsfdsfds','0343242','khachhang5@gmail.com','Nam','2003-09-10','$2a$10$73waME8xnmoJarroLM1ixOsVzxnCNe6jOJ9lrOev2rMy.BW8xAPwe','khach hang 5','user5'),('341f56f9-1bf8-4ae0-a0ba-d3a2db91ec2c',_binary '','78/234/ sfos jskf','0932432465','usss@gmail.com','Nữ','2011-01-09','$2a$10$ShR9yPBgjZQf74qoiqieCeKJT7nutj0lRBKvMhj.bGAGqvb4BNB42','Hoa Mai','user10'),('68c90435-c2cc-46ac-9332-08261e761622',_binary '','44 Thanh Mai','03591428','phanh2003@gmail.com','Nam','2002-10-08','$2a$10$naXNP1v3/QUOsupVZWxtpOOsa9tfxGmW16brO5RMiLvOQd8SOE3SO','Phuong Anh','phanh2003'),('77b67ed2-6477-4a7c-b3f3-29107180a585',_binary '','dsfdsfds','0343242','khachhang8@gmail.com','Nam','2003-09-10','$2a$10$TY0YWb6UqGyu2Lish2tdiu3awUQf0TlD4TU9N3Nbw43ADJpfLmcJu','khach hang 8','user8'),('88f3e5e1-4016-4f6b-ae47-7f30ebade5ac',_binary '','dsfdsfds','0343242','khachhang7@gmail.com','Nam','2003-09-10','$2a$10$.jb0GIAO6PAIkoqyLsMjKOGAwgL0X7uc7cGdFzhNK6EYh3reBlac6','khach hang 7','user7'),('99cccbba-b9a4-4d1a-ad61-beb75d47f72f',_binary '','dsfdsfds','0343242','khachhang4@gmail.com','Nam','2003-09-10','$2a$10$Wd.hOpu5n8bH1bvffxfQwOqKDAsRzIuxGTUAItJw0UbdsrqAst8oe','khach hang 4','user4'),('9ca76e27-0cce-4c48-ba07-9c3155cf024d',_binary '','dsfdsfds','0343242','khachhang2@gmail.com','Nam','2003-09-10','$2a$10$WEcEbHw8PAagzbHikMjUP.qeoABzcIIRrZhnrYMshuQNwZJpA3DIm','khach hang 2','user2'),('a4045058-e342-41ef-a2ee-cb01737c1421',_binary '\0','dsfdsfds','0343242','khachhang6@gmail.com','Nam','2003-09-10','$2a$10$Rwrs7EYGBEiFcoJZuq4ub.X9xLr0qz84aYKb6eKqdx/DTPHjURs2W','khach hang 6','user6'),('ce31db20-30d5-4bb3-b773-d362f6db0b7a',_binary '','dsfdsfds','0343242','khachhang11@gmail.com','Nữ','2003-10-09','$2a$10$2q8aG3Ip0SwWWyAh048yN.hGH/DOm3lmIHS0EO8w1mqZoh.bfyeMu','khach hang 11','user11'),('cfae22c2-c1b4-4a7d-8023-449e510d8d57',_binary '','78/234/ sfos jskf','0932432465','usss@gmail.com','Nam','2011-01-09','$2a$10$SU8o/CKpfc9YodVJ0/zKjOWwQxS22sewK0c775EpSumjn/5CIPGRm','Quoc Duong','user9'),('e8c8424c-a4f0-4dc6-9863-9adbf879f43d',_binary '','dsfdsfds','0343242','khachhang1@gmail.com','Nam','2003-09-10','$2a$10$czzJPYNdj/5cj4LV.1k3R.NujFJlJcvpfGWInbsbmPqoS1T5AyiSC','khach hang 1','user1');
/*!40000 ALTER TABLE `khachhang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loaivt`
--

DROP TABLE IF EXISTS `loaivt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loaivt` (
  `ma` char(30) NOT NULL,
  `tenloai` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ma`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loaivt`
--

LOCK TABLES `loaivt` WRITE;
/*!40000 ALTER TABLE `loaivt` DISABLE KEYS */;
INSERT INTO `loaivt` VALUES ('LT001','Xi măng'),('LT002','Gạch'),('LT003','Cát'),('LT004','Sắt thép'),('LT005','Sơn'),('LT009','Thép'),('LT010','Gạch ốp lát'),('LT011','Bê tông'),('LT012','Ống nước');
/*!40000 ALTER TABLE `loaivt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mua`
--

DROP TABLE IF EXISTS `mua`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mua` (
  `ma_don_dat_hang` char(36) NOT NULL,
  `ma_vat_tu` char(30) NOT NULL,
  `gia` bigint DEFAULT NULL,
  `sl` double DEFAULT NULL,
  PRIMARY KEY (`ma_don_dat_hang`,`ma_vat_tu`),
  KEY `mua_vt_idx` (`ma_vat_tu`),
  CONSTRAINT `FKh2euu3dp1uo4my4rtlf035m9t` FOREIGN KEY (`ma_don_dat_hang`) REFERENCES `dondathang` (`ma`),
  CONSTRAINT `mua_vt` FOREIGN KEY (`ma_vat_tu`) REFERENCES `vattu` (`ma`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mua`
--

LOCK TABLES `mua` WRITE;
/*!40000 ALTER TABLE `mua` DISABLE KEYS */;
INSERT INTO `mua` VALUES ('31252f40-73a5-41f4-a517-86f6b978245c','VT003',5000,1),('31252f40-73a5-41f4-a517-86f6b978245c','VT004',1050000,3),('31252f40-73a5-41f4-a517-86f6b978245c','VT016',45000,1),('31252f40-73a5-41f4-a517-86f6b978245c','VT020',260000,2),('3b117a6b-b4a5-4980-b67b-3952d66e3c43','VT001',75000,1),('3b117a6b-b4a5-4980-b67b-3952d66e3c43','VT002',70000,1),('5b451361-1cfb-4582-8e25-5adc194dc0c7','VT006',250000,1),('5b451361-1cfb-4582-8e25-5adc194dc0c7','VT008',960000,3),('640a2643-bc4c-446c-826f-c7e694f65e65','VT005',240000,2),('6fae0a28-78c6-4870-a4e5-5bbd4265f46f','VT006',750000,3),('7127997f-ca1f-4dc6-820c-0965e141736d','VT019',1800000,6),('8a7f26af-2686-4468-a212-abeee227389a','VT001',100000,10),('8a7f26af-2686-4468-a212-abeee227389a','VT005',500000,10),('cea5606b-0306-4f72-b9ee-3ebfd65afe98','VT003',5000,1),('cea5606b-0306-4f72-b9ee-3ebfd65afe98','VT006',750000,3);
/*!40000 ALTER TABLE `mua` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nhan_vien`
--

DROP TABLE IF EXISTS `nhan_vien`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nhan_vien` (
  `ma` char(36) NOT NULL,
  `dia_chi` varchar(255) DEFAULT NULL,
  `dien_thoai` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `gioi_tinh` varchar(255) DEFAULT NULL,
  `is_admin` bit(1) NOT NULL,
  `ngay_sinh` date DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `ten` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ma`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nhan_vien`
--

LOCK TABLES `nhan_vien` WRITE;
/*!40000 ALTER TABLE `nhan_vien` DISABLE KEYS */;
INSERT INTO `nhan_vien` VALUES ('7dbd44a0-65b2-4f6c-b4c6-983b45436844','dcvhi34g','03433468122','khachhang4@gmail.com','Nam',_binary '','2003-09-10','$2a$10$PCpkvsDd8D2MgzPKKxDnHOnqxkkwxfAvKC3EOeQ0n9iKn0B2nZ4Mm','admin1','admin'),('dc874036-d904-4f10-bc67-df6f741f40fb','dcvhi34g','03433468122','admin2@gmail.com','Nữ',_binary '','2003-09-10','$2a$10$GEg77hb5/zVMD73Xm16TO.t4oeHZmJYI3xHrjc5FycIgpaN0K/u7a','admin2','admin2');
/*!40000 ALTER TABLE `nhan_vien` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vattu`
--

DROP TABLE IF EXISTS `vattu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vattu` (
  `ma` char(30) NOT NULL,
  `dongia` double DEFAULT NULL,
  `dvt` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `ten` varchar(255) DEFAULT NULL,
  `loaivt` char(30) DEFAULT NULL,
  PRIMARY KEY (`ma`),
  KEY `FKg9d1dw49l9kixvipedeqibx1` (`loaivt`),
  CONSTRAINT `FKg9d1dw49l9kixvipedeqibx1` FOREIGN KEY (`loaivt`) REFERENCES `loaivt` (`ma`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vattu`
--

LOCK TABLES `vattu` WRITE;
/*!40000 ALTER TABLE `vattu` DISABLE KEYS */;
INSERT INTO `vattu` VALUES ('VT001',75000,'Bao','https://bizweb.dktcdn.net/100/439/638/products/thumb.png?v=1637344494950','Xi măng Hà Tiên','LT001'),('VT002',70000,'Bao','https://vlxdthaohien.com/wp-content/uploads/2019/02/xi-mang-nghi-son-e1550663378187.png','Xi măng Nghi Sơn','LT001'),('VT003',5000,'Viên','https://gachthuanhoa.com/thumbs/550x500x1/upload/product/gach-dinh-8-x-18-dong-nai-637636333106-3754.jpg','Gạch đỏ 2 lỗ','LT002'),('VT004',350000,'Khối','https://sattheplochieuphat.com/wp-content/uploads/2023/12/cach-chon-cat-xay-dung-tot.jpg','Cát xây dựng','LT003'),('VT005',120000,'Cây','https://tonthepvuongquankhoi.com/wp-content/uploads/2023/09/thep-phi-16.jpg','Sắt phi 16','LT004'),('VT006',250000,'Thùng','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaDuz4B6-VXk58QuNAwltPjtZxqu6CncunlA&s','Sơn Dulux ngoại thất','LT005'),('VT007',200000,'Thùng','https://www.jotun.net.vn/image/cache/catalog/san-pham/son-nuoc-noi-that/son-nuoc-noi-that-jotun/essence-de-lau-chui-800x800.jpg','Sơn Jotun nội thất','LT005'),('VT008',320000,'Cuộn','https://sudospaces.com/hoaphat-com-vn/2022/06/thep-cuon-xay-dung-3-large.jpg','Thép cuộn xây dựng','LT004'),('VT009',80000,'Cuộn','https://tonthientan.com.vn/wp-content/uploads/2020/02/thep-ong-kem-phi-21-1.jpg','thép ống phi 21','LT009'),('VT010',150000,'Viên','https://vinabat.com.vn/wp-content/uploads/2023/11/gach-op-lat-viglacera-80x80-8801.jpg','gạch ốp lát viglacera','LT010'),('VT011',200000,'Khối','https://tramtronbetongtuoi.com/wp-content/uploads/be-tong-tuoi-2.gif','Bê tông tươi','LT011'),('VT012',95000,'Bao','https://topmat.vn/images/products/2019/11/01/original/xi-mang-portland-hon-hop-pcb30_1572585294.png','Xi măng Bút Sơn','LT001'),('VT013',85000,'Bao','https://muabanvatlieuxaydung.com/upload/product/15/84/59/xi-mang-holcim-image-20200319131208-676987.jpg','Xi măng Holcim','LT001'),('VT014',100000,'Viên','https://pjm.vn/upload/product/zFIX_1538117317_0ed3c5abc1f1eca1fd4f9b61f4ed705f.jpg','Gạch đỏ 4 lỗ','LT002'),('VT015',120000,'Bao','https://khatra.com.vn/wp-content/uploads/2024/01/F2166.jpg','Gạch bông lát nền','LT002'),('VT016',45000,'Viên','https://phucbao.com/wp-content/uploads/2019/07/gach-60120-thai-lan-612argr_5d217702e7f93.jpeg','Gạch Thái Lan','LT002'),('VT017',220000,'Cây','https://satthepxaydung.vn/wp-content/uploads/2016/03/thephoaphat22.jpg','Thép phi 22','LT004'),('VT018',180000,'Cuộn','https://bkvietnam.vn/wp-content/uploads/2022/01/hot_rolled_steel_sheets.jpg','Thép cuộn cán nóng','LT004'),('VT019',300000,'Cây','https://povina.com.vn/wp-content/uploads/2024/06/image-20221014160041-5.jpeg','Thép thanh xây dựng','LT004'),('VT020',130000,'m','https://nhuadekko.com/wp-content/uploads/2020/11/ong-nhua-upvc-21.jpg','Ống nước 27 hoa sen','LT012'),('VT021',260000,'Cây','https://vinaonesteel.com/wp-content/uploads/2021/01/O%CC%82%CC%81ng-ho%CC%A3%CC%82p_1.jpg','Thép vuông','LT004');
/*!40000 ALTER TABLE `vattu` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-16 21:11:28
