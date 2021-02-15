-- ----------------------------
-- 2020/3/30 DATABASE update by lixun2015
-- ----------------------------
set names utf8;
use jol;
ALTER TABLE `contest` ADD COLUMN `user_id` VARCHAR(48) NOT NULL DEFAULT 'admin' AFTER `password`;
ALTER TABLE `contest` ADD COLUMN `isTop`  tinyint(1) NOT NULL DEFAULT 0 AFTER `practice`;
ALTER TABLE `solution` MODIFY COLUMN `pass_rate` DECIMAL(3,2) UNSIGNED NOT NULL DEFAULT '0.00';
ALTER TABLE `printer_code` MODIFY COLUMN `user_id` CHAR(48) NOT NULL;
ALTER TABLE `privilege` MODIFY COLUMN `user_id` CHAR(48) NOT NULL;
ALTER TABLE `solution` MODIFY COLUMN `user_id` CHAR(48) NOT NULL;
ALTER TABLE `problemset` MODIFY COLUMN `index` int(11) NOT NULL AUTO_INCREMENT FIRST ;
ALTER TABLE `hit_log` MODIFY COLUMN `ip` varchar(46) DEFAULT NULL;
ALTER TABLE `loginlog` MODIFY COLUMN `ip` varchar(46) DEFAULT NULL;
ALTER TABLE `online` MODIFY COLUMN `ip` varchar(46) CHARACTER SET utf8 NOT NULL DEFAULT '';
ALTER TABLE `reply` MODIFY COLUMN `ip` varchar(46) DEFAULT NULL;
ALTER TABLE `solution` MODIFY COLUMN `ip` char(46) NOT NULL;
ALTER TABLE `team` MODIFY COLUMN `ip` varchar(46) DEFAULT NULL;
ALTER TABLE `users` MODIFY COLUMN `ip` varchar(46) NOT NULL DEFAULT '';
-- Dump completed on 2019-03-13 17:03:43
-- ----------------------------
-- Table structure for `class_list`
-- ----------------------------
DROP TABLE IF EXISTS `class_list`;
CREATE TABLE `class_list` (
  `class_name` varchar(100) NOT NULL,
  `enrollment_year` smallint(4) NOT NULL,
  PRIMARY KEY (`class_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
-- ----------------------------
-- Dumping data for table class_list
-- ----------------------------
INSERT INTO `class_list` VALUES ('其它', '0');

-- ----------------------------
-- Table structure for `reg_code`
-- ----------------------------
DROP TABLE IF EXISTS `reg_code`;
CREATE TABLE `reg_code` (
  `class_name` varchar(100) NOT NULL,
  `reg_code` varchar(100) NOT NULL,
  `remain_num` smallint(4) NOT NULL,
  PRIMARY KEY (`class_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
-- ----------------------------
-- Dumping data for table reg_code
-- ----------------------------
INSERT INTO `reg_code` VALUES ('其它', '', '0');

-- ----------------------------
-- Table structure for `course`
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `section` varchar(255) NOT NULL,
  `order` int(11) NOT NULL DEFAULT '10000',
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `isProblem` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('1', '入门篇', '0', '0', '0');
INSERT INTO `course` VALUES ('2', '九阴真经', '1', '0', '0');
INSERT INTO `course` VALUES ('3', '九阳神功', '2', '0', '0');
INSERT INTO `course` VALUES ('4', '葵花宝典', '3', '0', '0');
INSERT INTO `course` VALUES ('5', '辟邪剑谱', '4', '0', '0');
INSERT INTO `course` VALUES ('6', '平台操作题', '0', '1', '0');
INSERT INTO `course` VALUES ('7', '输出题入门', '1', '1', '0');
INSERT INTO `course` VALUES ('8', '计算题入门', '2', '1', '0');
INSERT INTO `course` VALUES ('9', '分支结构入门', '3', '1', '0');
INSERT INTO `course` VALUES ('10', '循环结构入门', '4', '1', '0');
INSERT INTO `course` VALUES ('11', '1000', '0', '6', '1');

-- 添加触发器，防止同一用户类似代码提交第二遍时被认定为抄袭
delimiter //
drop trigger if exists simfilter//
create trigger simfilter
before insert on sim
for each row
begin
 declare new_user_id varchar(64);
 declare old_user_id varchar(64);
 select user_id from solution where solution_id=new.s_id into new_user_id;
 select user_id from solution where solution_id=new.sim_s_id into old_user_id;
 if old_user_id=new_user_id then
  set new.s_id=0;
 end if;
end;//
delimiter ;
--
-- Final view structure for view `squid`
--

/*!50001 DROP VIEW IF EXISTS `squid`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `squid` AS select `users`.`user_id` AS `user_id`,`users`.`password` AS `password`,`users`.`solved` AS `solved` from `users` where ((`users`.`solved` > pow(2,(minute(now()) / 8))) or `users`.`user_id` in (select `privilege`.`user_id` AS `user_id` from `privilege` where (`privilege`.`rightstr` = 'source_browser'))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;