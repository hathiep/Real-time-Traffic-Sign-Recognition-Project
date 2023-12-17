-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: traffic_signs
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `sign`
--

DROP TABLE IF EXISTS `sign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sign` (
  `id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `des` varchar(45) NOT NULL,
  `warning` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sign`
--

LOCK TABLES `sign` WRITE;
/*!40000 ALTER TABLE `sign` DISABLE KEYS */;
INSERT INTO `sign` VALUES 
(1,'Speed Limit 20km/h','Hãy giữ tốc độ dưới 20km/h','- Không được vượt quá tốc độ cho phép\n- Mức phạt vi phạm từ 100.000 - 200.000 vnđ'),
(2,'Speed Limit 30km/h','Hãy giữ tốc độ dưới 30km/h','- Không được vượt quá tốc độ cho phép\n- Mức phạt vi phạm từ 200.000 - 300.000 vnđ'),
(3,'Speed Limit 50km/h','Hãy giữ tốc độ dưới 50km/h','- Không được vượt quá tốc độ cho phép \n- Mức phạt vi phạm từ 300.000 - 500.000 vnđ'),
(4,'Speed Limit 60km/h','Hãy giữ tốc độ dưới 60km/h','- Không được vượt quá tốc độ cho phép \n- Mức phạt vi phạm từ 500.000 - 900.000 vnđ'),
(5,'Speed Limit 70km/h','Hãy giữ tốc độ dưới 70km/h','- Không được vượt quá tốc độ cho phép \n- Mức phạt vi phạm từ 800.000 - 1000.000 vnđ'),
(6,'Speed Limit 80km/h','Hãy giữ tốc độ dưới 80km/h','- Không được vượt quá tốc độ cho phép \n- Mức phạt vi phạm từ 1.000.000 - 1.200.000 vnđ'),
(7,'End of Speed Limit 80 km/h','Có thể chạy tốc độ trên 80km/h','- Hết giới hạn tốc độ, chú ý các phương tiện khác có thể tăng tốc'),
(8,'Speed Limit 100 km/h','Hãy giữ tốc độ dưới 100km/h','- Không được vượt quá tốc độ cho phép \n- Mức phạt vi phạm từ 1.200.000 - 1.500.000 vnđ'),
(9,'Speed Limit 120 km/h','Hãy giữ tốc độ dưới 120km/h','- Không được vượt quá tốc độ cho phép \n- Mức phạt vi phạm từ 1.500.000 - 2.000.000 vnđ'),
(10,'No passing','Không được phép vượt, hãy đi đúng làn đường','- Vượt trên đoạn đường này rất nguy hiểm, dễ xảy ra tai nạn \n- Mức phạt vi phạm từ 500.000 - 1.000.000 vnđ'),
(11,'No passing for vechiles over 3.5 metric tons','Xe 3.5 tấn không được phép vượt','- Xe lớn vượt rất nguy hiểm, ảnh hưởng đến các phương tiện giao thông khác, chú ý quan sát'),
(12,'Right-of-way at the next intersection','Bạn được ưu tiên tại giao lộ tiếp theo','- Các phương tiện khác phải nhường đường cho các xe đi qua ngã tư từ đường này, chú ý quan sát'),
(13,'Priority road','Bạn được ưu tiên trên đường ưu tiên','- Đây là đường ưu tiên, bạn có quyền ưu tiên khi đi trên đường này so với các phương tiện từ các đường khác'),
(14,'Yield','Chú ý nhường đường cho đối tượng phía trước ','- Cần giảm tốc độ, chú ý quan sát nhường đường cho phương tiện ưu tiên phía trước'),
(15,'Stop','Dừng lại ngay lập tức','- Dừng lại ngay khi gặp biển báo này, phía trước có thể là tai nạn, hoặc đường cấm tạm thời không thể đi \n- Đổi hướng khác hoặc chờ tới khi biển báo hết hiệu lực'),
(16,'No vehicles','Không thể lái xe ở đường này','- Đoạn đường đặt biển cấm không cho phép lưu thông bằng phương tiện cơ giới \n- Bạn có thể đi bộ hoặc chuyển hướng khác'),
(17,'Vehicles over 3.5 metric tons prohibited','Xe trên 3.5 tấn không được đi','- Xe trên 3.5 tấn đi vào đoạn đường này có thể gây nguy hiểm cho các phương tiện khác hoặc gây hư hỏng các cơ sở vật chất\n- Mức phạt vi phạm từ 1.000.000vnđ đến tạm giữ bằng lái xe'),
(18,'No entry','Không được đi vào đoạn đường này','- Phía trước có đường ngược chiều, biển báo cấm không được đi vào đường đó\n- Vi phạm sẽ gây nguy hiểm cho bản thân và các phương tiện khác '),
(19,'General caution','Phía trước có nguy hiểm cần chú ý','- Phía trước có nguy hiểm, bạn cần giảm tốc độ, chú ý quan sát'),
(20,'Dangerous curve to the left','Bên trái có đường cong nguy hiểm','- Phía trước có đường cong bên trái nguy hiểm\n- Chú ý quan sát, đi chậm'),
(21,'Dangerous curve to the right','Bên phải có đường cong nguy hiểm ','- Phía trước có đường cong bên trái nguy hiểm\n- Chú ý quan sát, đi chậm'),
(22,'Double curve','Phía trước có đường cong zig-zag','- Phía trước có đường cong zig-zag nguy hiểm\n- Chú ý quan sát cả 2 hướng, đi chậm'),
(23,'Bumpy road','Phía trước có đường gập ghềnh','- Phía trước có đường gập ghềnh nguy hiểm\n- Chú ý quan sát, đi chậm'),
(24,'Slippery road','Phía trước có đường trơn trượt','- Phía trước có đường trơn trượt nguy hiểm\n- Chú ý quan sát, đi chậm'),
(25,'Road narrows on the right','Phía trước có đường bị thu hẹp bên phải','- Phía trước có đường bị thu hẹp bên phải nguy hiểm\n- Chú ý quan sát, đi chậm'),
(26,'Road work','Đoạn đường đang thi công','- Đoạn đường đang thi công nguy hiểm\n- Chú ý quan sát, đi chậm'),
(27,'Traffic signals','Phía trước có đèn giao thông','- Phía trước có đường giao nhau có đèn tín hiệu\n- Chú ý quan sát, đi theo tín hiệu đèn '),
(28,'Pedestrians','Chú ý đường dành cho người đi bộ','- Phía trước có đường dành cho người đi bộ\n- Chú ý nhường đường hoặc thực hiện theo đèn tín hiệu(nếu có)'),
(29,'Children crossing','Chú ý trẻ em sang đường','- Phía trước có thường có trẻ em sang đường\n- Chú ý giảm tốc độ, nhường đường hoặc thực hiện theo đèn tín hiệu(nếu có)'),
(30,'Bicycles crossing','Chú ý xe đạp sang đường','- Phía trước có thường có xe đạp sang đường\n- Chú ý giảm tốc độ, nhường đường hoặc thực hiện theo đèn tín hiệu(nếu có)'),
(31,'Beware of ice/snow','Đường có băng/tuyết','- Đoạn đường thường có băng/tuyết trơn trượt, nguy hiểm\n- Chú ý quan sát, đi chậm'),
(32,'Wild animals crossing','Đoạn đường có động vật hoang dã qua đường','- Đoạn đường thường có động vật hoang dã, nguy hiểm\n- Chú ý quan sát, đi chậm'),
(33,'End of all speed and passing limits','Kết thúc giới hạn tốc độ và vượt','- Đã hết giới hạn tốc độ trước đó, chú ý các phương tiện tăng tốc và vượt'),
(34,'Turn right ahead','Chỉ được rẽ phải','- Phía trước chỉ được rẽ phải\n- Mức phạt vi phạm nếu đi hướng khác từ 200.000 - 500.000 vnđ'),
(35,'Turn left ahead','Chỉ được rẽ trái','- Phía trước chỉ được rẽ trái\n- Mức phạt vi phạm nếu đi hướng khác từ 200.000 - 500.000 vnđ'),
(36,'Ahead only','Chỉ được đi thẳng','- Phía trước chỉ được đi thẳng\n- Mức phạt vi phạm nếu đi hướng khác từ 200.000 - 500.000 vnđ'),
(37,'Go straight or right','Đi thẳng hoặc rẽ phải','- Phía trước chỉ được đi thẳng hoặc rẽ phải\n- Mức phạt vi phạm nếu đi hướng khác từ 200.000 - 500.000 vnđ'),
(38,'Go straight or left','ĐI thẳng hoặc rẽ trái','- Phía trước chỉ được đi thẳng hoặc rẽ trái\n- Mức phạt vi phạm nếu đi hướng khác từ 200.000 - 500.000 vnđ'),
(39,'Keep right','Đi vào làn bên phải','- Tiếp tục đi hướng/làn bên phải\n- Chú ý quan sát, đi chậm'),
(40,'Keep left','Đi vào làn bên trái','- Tiếp tục đi hướng/làn bên trái\n- Chú ý quan sát, đi chậm'),
(41,'Roundabout mandatory','Phía trước có vòng xuyến','- Phía trước có giao nhau với vòng xuyến\n- Chú ý quan sát, vào ra vòng xuyến đúng hướng'),
(42,'End of no passing','Có thể vượt phía trước','- Đã hết cấm vượt, phía trước là đoạn đường có thể vượt \n- Chú ý các xe phía sau có thể vượt'),
(43,'End of no passing by vechiles over 3.5 ','Xe trên 3.5 tấn có thể vượt','- Xe trên 3.5 tấn có thể vượt\n- Chú ý quan sát, xin/nhường đường');
/*!40000 ALTER TABLE `sign` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-17 11:13:55
