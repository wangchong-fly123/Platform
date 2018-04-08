-- MySQL dump 10.13  Distrib 5.5.56, for Linux (x86_64)
--
-- Host: localhost    Database: enjoymi_sgzj2_website
-- ------------------------------------------------------
-- Server version	5.5.56

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `app_Hero_categories`
--

DROP TABLE IF EXISTS `app_Hero_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_Hero_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `image` varchar(128) DEFAULT NULL,
  `order_num` int(11) DEFAULT NULL,
  `slug` varchar(128) DEFAULT NULL,
  `tree` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `depth` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_Hero_categories`
--

LOCK TABLES `app_Hero_categories` WRITE;
/*!40000 ALTER TABLE `app_Hero_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_Hero_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_Hero_items`
--

DROP TABLE IF EXISTS `app_Hero_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_Hero_items` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(128) NOT NULL,
  `image` varchar(128) DEFAULT NULL,
  `short` varchar(1024) DEFAULT NULL,
  `text` text NOT NULL,
  `slug` varchar(128) DEFAULT NULL,
  `time` int(11) DEFAULT '0',
  `views` int(11) DEFAULT '0',
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_Hero_items`
--

LOCK TABLES `app_Hero_items` WRITE;
/*!40000 ALTER TABLE `app_Hero_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_Hero_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_hero_categories`
--

DROP TABLE IF EXISTS `app_hero_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_hero_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `image` varchar(128) DEFAULT NULL,
  `order_num` int(11) DEFAULT NULL,
  `slug` varchar(128) DEFAULT NULL,
  `tree` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `depth` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_hero_categories`
--

LOCK TABLES `app_hero_categories` WRITE;
/*!40000 ALTER TABLE `app_hero_categories` DISABLE KEYS */;
INSERT INTO `app_hero_categories` VALUES (2,'英雄列表','',1,NULL,2,1,2,0,1);
/*!40000 ALTER TABLE `app_hero_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_hero_items`
--

DROP TABLE IF EXISTS `app_hero_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_hero_items` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `hero_name` varchar(128) NOT NULL,
  `head` varchar(128) DEFAULT NULL,
  `bg_image` varchar(128) DEFAULT NULL,
  `attribute_image` varchar(128) DEFAULT NULL,
  `hero_intro` varchar(1024) DEFAULT NULL,
  `skill_intro` text NOT NULL,
  `slug` varchar(128) DEFAULT NULL,
  `time` int(11) DEFAULT '0',
  `views` int(11) DEFAULT '0',
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_hero_items`
--

LOCK TABLES `app_hero_items` WRITE;
/*!40000 ALTER TABLE `app_hero_items` DISABLE KEYS */;
INSERT INTO `app_hero_items` VALUES (2,2,'诸葛亮','/uploads/hero/wjzhugeliang-941ba84730.png','/uploads/hero/04c2f09ac53.png','/uploads/hero/1-30b907e6cd.png','<ul><li><strong style=\"background-color: initial;\"><strong>绝世军师&mdash;&mdash;诸葛亮</strong></strong></li></ul><ul><li>三<span style=\"background-color: initial;\">国顶级谋士，用兵如神，智多近妖。远可羽扇轻摇，呼风唤雨决胜千里，近可剑指敌首，雷霆霹雳收割大片生命！是战场的中坚力量，敌人最可怕的噩梦！</span></li></ul>','<br><table><tbody>  <tr>   <td>霹雳火：</td>   <td>召唤火柱喷射敌人，造成伤害并附带火焰伤害。</td>  </tr>  <tr>   <td>万箭穿心：</td>   <td>召唤冰锥攻击前方敌人，将其冻住，造成伤害并附带少量冰冻伤害。</td>  </tr>  <tr>   <td>雷霆万钧：</td>   <td>召唤闪电追踪敌人，造成范围性伤害！</td>  </tr>  <tr>   <td>呼风唤雨：</td>   <td>召唤巨大战船撞击前方所有敌军，造成伤害并附带大量冰冻伤害。</td></tr></tbody></table>',NULL,1493024321,0,1),(3,2,'张飞','/uploads/hero/wjzhangfei-86c6f349e4.png','/uploads/hero/b077d3fef0.png','/uploads/hero/1-3eb9d1bde9.png','<ul>\r\n<li><strong><strong>横矛猛将&mdash;&mdash;张飞</strong><br></strong></li><li>五虎上将之二，勇猛刚强、嫉恶如仇，有天崩地裂之力！曾据水断桥，喝退百万曹军，圆眼一旦怒睁，便是敌军魂断矛下之时！<strong></strong></li></ul>','<br><table><tbody>  <tr>   <td>狂风弑：</td>   <td>化身狂风向前横扫目标，对目标造成伤害。</td>  </tr>  <tr>   <td>饿虎扑羊：</td>   <td>一跃而起砸向地面，对范围内所有敌人造成大量伤害。</td>  </tr>  <tr>   <td>神龙摆尾：</td>   <td>化身神龙横冲目标，期间可以对其操控方向。造成大量伤害。</td>  </tr>  <tr>   <td>天崩地裂：</td>   <td>以开山辟地之力轰杀目标，对前方所有敌人造成伤害并附带火焰伤害。</td>  </tr></tbody></table>',NULL,1493024715,0,1),(4,2,'赵云','/uploads/hero/wjzhaoyun-cfc875c206.png','/uploads/hero/1-3afadccd50.png','/uploads/hero/1-d659e7e2e1.png','<ul>\r\n<li><strong>一身是胆&mdash;赵云<br></strong></li><li>古来冲阵扶危主，唯有常山赵子龙！身手敏捷，浑身是胆，银枪一旦刺出，血光必然四起！他的英风锐气，敌军见之，无不胆寒！<strong></strong></li></ul>','<br><table><tbody>  <tr>   <td>大鹏展翅：</td>   <td>用长枪挑起目标并将其从空中砸向地面，造成伤害。</td>  </tr>  <tr>   <td>白鹤亮翅：</td>   <td>连续刺出长枪突破敌阵，造成大量伤害。</td>  </tr>  <tr>   <td>哪吒转轮：</td>   <td>高速旋转长枪形成火轮，击飞敌人并造成大量伤害。</td>  </tr>  <tr>   <td>日月双华：</td>   <td>以气浪形成的残影高速连击目标，造成巨额伤害并附带大量雷电伤害。</td>  </tr></tbody></table>',NULL,1496997698,0,1),(5,2,'马超','/uploads/hero/wjmachao-faa57e54f3.png','/uploads/hero/afb08fd68d.png','/uploads/hero/1-e223bc00b0.png','<ul>\r\n<li><strong style=\"background-color: initial;\">西凉雄狮&mdash;&mdash;马超</strong></li><li>汉末群雄之一，五虎上将之四，狮盔兽带玉面郎，有韩信、英布之勇。行动如风驰电掣，剑气纵横处，光寒十四州！还可号令西凉猛兽.....</li></ul>','<table><tbody>  <tr>   <td>翻云崩：</td>   <td>旋转攻击所碰触的敌人，造成伤害。</td>  </tr>  <tr>   <td>烈火燎原：</td>   <td>向前扫出弧形火焰，造成大量伤害。</td>  </tr>  <tr>   <td>仙人指路：</td>   <td>召唤黑豹冲击前方所有敌人造成大量伤害。</td>  </tr>  <tr>   <td>鹰袭长空：</td>   <td>以气浪形成的残影高速连击目标，造成巨额伤害并附带大量雷电伤害。</td>  </tr></tbody></table>',NULL,1496998142,0,1),(6,2,'关羽','/uploads/hero/wjguanyu-52a028e5f6.png','/uploads/hero/a60152a245.png','/uploads/hero/1-696fe6c73a.png','<ul> <li><strong>青龙圣君&mdash;&mdash;关羽</strong></li><li>马奔赤兔行千里，刀偃青龙出五关，武艺超凡，忠勇无双，跃马百战场，刀下亡魂无数！是当之无愧的五虎上将之首，千古关帝圣君！</li></ul>','<br><table><tbody>  <tr>   <td>飞龙在天：</td>   <td>冲锋追击敌人，并一跃而起将敌人击浮空，造成伤害！</td>  </tr>  <tr>   <td>回风扫叶：</td>   <td>斩出一道刀光，冲击前方敌人，造成大量伤害！</td>  </tr>  <tr>   <td>亢龙有悔：</td>   <td>舞动青龙偃月刀，攻击前方敌人并将其击飞，造成大量伤害！</td>  </tr>  <tr>   <td>狂龙出海：</td>   <td>以力拔山河之势震飞一切阻挡目标，造成巨额伤害并附带火焰伤害。</td>  </tr> </tbody></table><p><strong></strong></p>',NULL,1496998284,0,1),(10,2,'貂蝉','/uploads/hero/wjdiaochan-61b20b83d1.png','/uploads/hero/61993e305a.png','/uploads/hero/1-234075f16a.png','<ul><li><strong style=\"background-color: initial;\">倾城女谍&mdash;&mdash;貂蝉</strong></li></ul><p><strong></strong></p><ul><li>司徒王允义女，有倾城之资，闭月之容，以轻灵身法游走在两方之间，舞动双匕，便能于悄无声息中夺取敌军首级。那满含情意的明眸美目，是最甜蜜的死亡陷阱！</li></ul>','<table>  <tbody><tr>   <td>天女散花：</td>   <td>连续脚踢目标将其击退，并造成伤害。</td>  </tr>  <tr>   <td>飞燕回廊：</td>   <td>高速旋转刀刃，对目标造成伤害并附带少量剧毒伤害。</td>  </tr>  <tr>   <td>织女穿梭：</td>   <td>旋转刀刃将周围敌人打中并击浮空，造成大量伤害。</td>  </tr>  <tr>   <td>翔天蔷薇：</td>   <td>多段连续踢击，将目标踢到空中，造成伤害并附带大量剧毒伤害。</td>  </tr></tbody></table>',NULL,1496999608,0,1),(12,2,'黄忠','/uploads/hero/wjhuangzhong-e7a9d7fcc8.png','/uploads/hero/2-67c65fa569.png','/uploads/hero/1-e92fdcf5b2.png','<ul>\r\n<li><strong style=\"background-color: initial;\">不老神射&mdash;&mdash;黄忠</strong></li></ul><p><strong></strong></p><ul>\r\n<li>五虎上将之五，老当益壮，有百步穿杨之技，万夫不当之勇！曾凭一把赤血刀、一张画雀弓，扬名定军，斩杀夏侯，立下赫赫奇功！</li></ul>','<table>  <tbody><tr>   <td>独劈华山：</td>   <td>将手中的大刀砸地，造成范围伤害。</td>  </tr>  <tr>   <td>野马分鬃：</td>   <td>将手中的大刀扔向空中，刀落下时对地面造成范围伤害。</td>  </tr>  <tr>   <td>追风劈月：</td>   <td>旋转攻击所碰触的敌人，造成大量伤害。</td>  </tr>  <tr>   <td>百步穿杨：</td>   <td>一跃而起，在空中使用乱矢对地面目标造成大量范围伤害。</td>  </tr></tbody></table>',NULL,1496999985,0,1),(11,2,'孙尚香','/uploads/hero/wjsunshangxiang-7363f37748.png','/uploads/hero/099253f93a.png','/uploads/hero/1-e430db04ca.png','<ul><li><strong style=\"background-color: initial;\">巾帼女杰&mdash;&mdash;孙尚香</strong></li></ul><p><strong></strong></p><ul><li>吴侯孙权之妹，皇叔刘备之妻，才捷刚猛，行事磊然有丈夫风！双拐旋转，便能给予敌人秋风扫落叶般的痛击，是真正不让须眉的巾帼女雄！</li></ul>','<table>  <tbody><tr>   <td>直贯穿击：</td>   <td>穿刺目标，顺势将其挑浮空，对目标造成伤害。</td>  </tr>  <tr>   <td>贯耳冲击：</td>   <td>附身冲击目标，期间可以对其操控方向，造成大量伤害。</td>  </tr>  <tr>   <td>回风旋击：</td>   <td>转身攻击，对范围内所有敌人造成伤害。</td>  </tr>  <tr>   <td>如风扫月：</td>   <td>多段连击目标，对前方所有敌人造成大量伤害。</td>  </tr></tbody></table>',NULL,1496999751,0,1),(13,2,'黄芸','/uploads/hero/wjhuangyun-e1b65cdf0f.png','/uploads/hero/73204dd165.png','/uploads/hero/1-ac6130f5a6.png','<ul>\r\n<li><strong style=\"background-color: initial;\">穿杨少女&mdash;&mdash;黄芸</strong></li></ul><p><strong></strong></p><ul>\r\n<li>老将黄忠孙女，天真活泼、古灵精怪，自幼随黄忠习武，继承了其百步穿杨之技、穿云射日之能，轻挽弓弦，箭羽便如流星火矢疾驰而出，直逼要害，转瞬夺命！</li></ul>','<table>  <tbody><tr>   <td>焚心穿箭：</td>   <td>用长枪挑起目标并将其从空中砸向地面，造成伤害。</td>  </tr>  <tr>   <td>穿云射日：</td>   <td>连续刺出长枪突破敌阵，造成大量伤害。</td>  </tr>  <tr>   <td>爆炎火矢：</td>   <td>高速旋转长枪形成火轮，击飞敌人并造成大量伤害。</td>  </tr>  <tr>   <td>后羿射日：</td>   <td>以气浪形成的残影高速连击目标，造成巨额伤害并附带大量雷电伤害。</td>  </tr></tbody></table>',NULL,1497000123,0,1),(14,2,'吕布','/uploads/hero/wjlvbu-721e83a4a4.png','/uploads/hero/1-10cd8648ca.png','/uploads/hero/1-e0346b49c7.png','<ul><li><strong style=\"background-color: initial;\">无双战神&mdash;&mdash;吕布</strong></li></ul><p><strong></strong></p><ul><li>三国第一猛将，手握方天画戟，戟法出神入化，身骑赤兔入战场，马前几无一合之将！真正是天下英雄难敌手，所向披靡世无双！</li></ul>','<table>  <tbody><tr>   <td>晴天霹雳：</td>   <td>一跃而起挥动长戟砸向目标，造成伤害。</td>  </tr>  <tr>   <td>狂龙吼：</td>   <td>向前用力一踏，将范围内目标击浮空后，向前穿刺目标，造成伤害。</td>  </tr>  <tr>   <td>黑龙出洞：</td>   <td>释放体内的洪荒之力，召唤冰阵攻击范围内目标，造成大量伤害。</td>  </tr>  <tr>   <td>天下无双：</td>   <td>使用召唤激光波轰炸目标，造成致命伤害。</td>  </tr></tbody></table>',NULL,1497000281,0,1),(15,2,'吕蒙','/uploads/hero/wjlvmeng-21d5e577bb.png','/uploads/hero/be116ef07b.png','/uploads/hero/1-74bae5794d.png','<ul>\r\n<li><strong style=\"background-color: initial;\">虎威国士&mdash;&mdash;吕蒙</strong></li></ul><p><strong></strong></p><ul>\r\n<li>东吴名将，折节好学，善谋克己，有国士之风，曾白衣摇橹取荆州，谈笑之间获封侯！双钩高举，便能召唤烈火风雷，震动九天，轰灭万军！</li></ul>','<table>  <tbody><tr>   <td>雷动九天：</td>   <td>跃起在空中高速连段目标，造成伤害。</td>  </tr>  <tr>   <td>风雷九转：</td>   <td>舞动双钩，旋转前进攻击目标，造成伤害。</td>  </tr>  <tr>   <td>烈火轰雷：</td>   <td>推出波动轰雷掌，对地面目标，造成伤害。</td>  </tr>  <tr>   <td>雷鸣千里：</td>   <td>江东吕氏族自幼习得的召唤之术，释放后可召唤忍者对目标造成伤害。</td>  </tr></tbody></table>',NULL,1497000354,0,1),(16,2,'陆逊','/uploads/hero/wjluxun-eed65a7d77.png','/uploads/hero/e484c8415d.png','/uploads/hero/1-ac8a75865a.png','<ul>\r\n<li><strong style=\"background-color: initial;\">雄才书生&mdash;&mdash;陆逊</strong></li></ul><p><strong></strong></p><ul>\r\n<li>东吴大都督，文能治国，武能安邦，为肱骨社稷之臣。曾虎帐谈兵，火烧连营，令称雄一世的刘备最后败亡他手！宝剑轻舞如龙，便如疾风蹑影，气冲云霄！</li></ul>','<table>  <tbody><tr>   <td>旋风剑：</td>   <td>高速挥出Z字斩，造成伤害。</td>  </tr>  <tr>   <td>剑气冲霄：</td>   <td>旋转身体，将目标击浮空并在空中对其高速穿刺，造成伤害。</td>  </tr>  <tr>   <td>疾风追剑：</td>   <td>高速追击技能，可以手动控制其移动方向，造成伤害。</td>  </tr>  <tr>   <td>蹑影追风剑：</td>   <td>陆家剑法，唯快不破，切出无数剑影，对目标造成伤害。</td>  </tr></tbody></table>',NULL,1497000525,0,1),(17,2,'夏侯惇','/uploads/hero/wjxiahouchun-027a15e176.png','/uploads/hero/1-8504bf4186.png','/uploads/hero/1-94357cf208.png','<ul><li><strong style=\"background-color: initial;\">独眼雄将&mdash;&mdash;夏侯惇</strong></li><li>曹魏开国元勋，浓眉虎须，勇猛无惧，虽拔矢啖睛枯一目，依旧威烈难挡！ 挥动长柄狼牙棒，便可放出剧毒紫雾，袭风夺命，转瞬灭敌！</li></ul>','<table>  <tbody><tr>   <td>夺命烟：</td>   <td>一跃而起挥动长戟砸向目标，造成伤害。</td>  </tr>  <tr>   <td>袭风刺：</td>   <td>向前用力一踏，将范围内目标击浮空后，向前穿刺目标，造成伤害。</td>  </tr>  <tr>   <td>回旋乾坤：</td>   <td>缩成球状，弹射高速穿刺目标，造成伤害。</td>  </tr>  <tr>   <td>翻天斩：</td>   <td>夏侯族得意枪法，全身舞动旋转枪头。造成伤害。</td>  </tr></tbody></table>',NULL,1497000639,0,1),(18,2,'夏侯渊','/uploads/hero/wjxiahouyuan-e5d7f938c5.png','/uploads/hero/509bf4b5aa.png','/uploads/hero/1-b73fa41904.png','<ul><li><strong style=\"background-color: initial;\">虎步关西&mdash;&mdash;夏侯渊</strong></li><li>魏国名将，夏侯惇族弟，擅长千里奔袭，曾随曹操逐马超、破韩遂、灭宋建、横扫羌氐，虎步关右。大刀劈砍间，便可翻天覆地，回转乾坤，灭敌百万之众！</li></ul>','<table>  <tbody><tr>   <td>秋风扫叶：</td>   <td>使用拖刀法旋转攻击目标，造成一定量伤害。</td>  </tr>  <tr>   <td>横扫千军：</td>   <td>最大限度挥动长刀横扫范围内一切目标，造成大量伤害。</td>  </tr>  <tr>   <td>翻天覆地：</td>   <td>划出3道刀气，对目标造成巨量伤害。</td>  </tr>  <tr>   <td>旋转乾坤：</td>   <td>夏侯一族得意刀法，全身舞动旋转刀锋，造成海量伤害。</td>  </tr></tbody></table>',NULL,1497000781,0,1),(19,2,'张辽','/uploads/hero/wjzhangliao-aa6806eb62.png','/uploads/hero/9950856437.png','/uploads/hero/1-bdf7285138.png','<ul><li><strong style=\"background-color: initial;\">古之召虎&mdash;&mdash;张辽</strong></li><li>五子良将之首，武力过人，娴于韬略，逍遥津之战以八百步兵大破十万吴军，自此威震江东！其刀锋锐无比，刀光一起，便如风卷残云，吞命噬魂，战无不胜！ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</li></ul>','<table>  <tbody><tr>   <td>霸王击鼎：</td>   <td>双手刀夹击目标，造成伤害。</td>  </tr>  <tr>   <td>翻雷滚天：</td>   <td>旋转武器高速连击目标，造成伤害。</td>  </tr>  <tr>   <td>风雷八仙：</td>   <td>扔出双手刀，冲击目标，造成大量伤害。</td>  </tr>  <tr>   <td>风卷残云：</td>   <td>斩出几道劲风，吹击直线目标，造成伤害。</td>  </tr></tbody></table>',NULL,1497000897,0,1),(20,2,'黄盖','/uploads/hero/wjhuanggai-1127c31c59.png','/uploads/hero/13ebb2ee32.png','/uploads/hero/1-c036dc2221.png','<ul><li><strong style=\"background-color: initial;\">苦肉老将&mdash;&mdash;黄盖</strong></li></ul><p><strong></strong></p><ul><li>东吴沙场老将，历任坚、策、权三代，为人严毅，善晓兵机，曾以苦肉诈降计，助东吴获得赤壁大捷。更掌握千万身法，火鞭纵横处，焚尽敌军，灰飞烟灭！<strong></strong></li></ul>','<table>  <tbody><tr>   <td>天师葫：</td>   <td>召唤火葫芦环绕自身，在5秒内攻击一切接近目标，造成伤害。</td>  </tr>  <tr>   <td>火鞭纵横：</td>   <td>扔出火葫芦对直线目标造成爆炸伤害，造成伤害。</td>  </tr>  <tr>   <td>怒火葫芦：</td>   <td>高速旋转擦出火花，并将其引爆，对范围内目标造成大量伤害。</td>  </tr>  <tr>   <td>千万身法：</td>   <td>高速旋转分出火焰分身攻击范围内目标，造成伤害。</td>  </tr></tbody></table>',NULL,1497001036,0,1),(21,2,'曹彰','/uploads/hero/wjcaozhang-dcbda7a1d8.png','/uploads/hero/5122a8477d.png','/uploads/hero/1-8ad25907a5.png','<ul><li><strong style=\"background-color: initial;\">黄须奇儿&mdash;&mdash;曹彰</strong></li></ul><p><strong></strong></p><ul><li>曹操之子，黄须黄发，喜搏猛虎，臂力过人，有大将之风！曾北征乌丸，威震塞外，一杆长枪乱舞，便如猛虎下山，惊破敌胆！<strong></strong></li></ul>','<table>  <tbody><tr>   <td>飞枪踏雪：</td>   <td>用枪挑起目标，将其击浮空，然后将其从空中砸下，造成伤害。</td>  </tr>  <tr>   <td>一掷乾坤：</td>   <td>从空中扔出三把巨枪砸向地面攻击目标，造成伤害。</td>  </tr>  <tr>   <td>枪纵横：</td>   <td>向前方旋转挥动长枪攻击目标，造成伤害。</td>  </tr>  <tr>   <td>枪乱舞：</td>   <td>将目标挑浮空后，在空中用枪高速穿刺目标，并将其击飞，造成伤害。</td>  </tr></tbody></table>',NULL,1497001423,0,1),(22,2,'魏延','/uploads/hero/wjweiyan-02c723d7a1.png','/uploads/hero/9abdc35182.png','/uploads/hero/1-e85133688d.png','<ul><li><strong style=\"background-color: initial;\">反骨狂将&mdash;&mdash;魏延</strong></li></ul><ul><li>独当一方的蜀汉名将，善养士卒，勇猛非常，却性情矜高。曾为刘备镇守汉中多年，进献奇谋，功勋卓著，更习得周易秘法，刀盾合一，杀招无敌！<strong></strong></li></ul>','<table>  <tbody><tr>   <td>刀盾杀法：</td>   <td>刀与盾组合连击，快速斩切使得目标毫无还手之力，造成伤害。</td>  </tr>  <tr>   <td>圆盾杀阵：</td>   <td>扔出手中的盾牌，旋转攻击前方目标，造成伤害。</td>  </tr>  <tr>   <td>雷霆出击：</td>   <td>召唤豹子同自己一起冲击目标，造成伤害。</td>  </tr>  <tr>   <td>连环杀招：</td>   <td>将刀与盾与自己融为一体，攻守俱佳的连击目标，造成伤害。</td>  </tr></tbody></table>',NULL,1497001569,0,1),(23,2,'大乔','/uploads/hero/wjdaqiao-075b56810f.png','/uploads/hero/11-a72d03c63f.png','','<ul>\r\n<li><strong>国色法师&mdash;&mdash;大乔</strong></li><li>孙策之妻，绝色倾城，温柔娴雅，与妹妹小乔并称“江东二乔”。曾随左慈学习道法，素手轻挥便可召来冰雪雷光，灭敌无数！</li></ul>','<p>太清经： &nbsp;&nbsp;强风环绕身体，召唤仙鹤拉起自己洒落大量太清符对范围内目标造成伤害。</p><p>两仪术： &nbsp;&nbsp;使用狂风的力量随机变化成冰系、火系、雷系法术的一种，阻止敌人前进移动并对其造成伤害</p><p>烈风劫： &nbsp;&nbsp;召唤两道龙卷风环绕跟随自身3秒，并对碰触目标造成伤害。</p><p>乾坤无极：将法力积蓄在法杖前端，一次性释放出强力寒光，可以攻击直线全部目标造成伤害。</p>',NULL,1498724817,0,1),(24,2,'甘宁','/uploads/hero/wjganning-2d77d6c589.png','/uploads/hero/fe513d2224.png','','<ul>\r\n<li>锦帆游侠&mdash;&mdash;甘宁</li><li>东吴名将，锦帆江贼，为人粗猛豪爽，善谋好杀，曾率一百轻骑夜袭曹营并全身而退，更身具神鸦之力，可飞击敌军，片甲不留！</li></ul>','<p>门前扫雪：向前一跃，用枪头闪电扫射目标，对其造成伤害！</p><p>飞隼撤羽：向身四周引爆火雷，同时自己高高跃起拔弩扫荡地面目标，造成伤害！</p><p>鹰击爪擒：连续闪电穿刺，最后一刺将矛头飞出，拉起自己靠近目标，造成伤害！</p><p>拉枯折朽：射出抓钩，抓取目标拉近身边，同时用矛高速穿刺目标，造成伤害！</p>',NULL,1498730134,0,1);
/*!40000 ALTER TABLE `app_hero_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_admins`
--

DROP TABLE IF EXISTS `easyii_admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_admins` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` varchar(64) NOT NULL,
  `auth_key` varchar(128) NOT NULL,
  `access_token` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `access_token` (`access_token`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_admins`
--

LOCK TABLES `easyii_admins` WRITE;
/*!40000 ALTER TABLE `easyii_admins` DISABLE KEYS */;
INSERT INTO `easyii_admins` VALUES (1,'admin','c2a1d30daaeb4a9927b5cd429df63459cc7f4f29','pUn61xzY8TXUDEgUdnpDcCnmPD5z6WhN',NULL),(3,'chenzhiyuan','ba062121055879db44d0074e5d71fd07702fb6b3','-erOH-xJpfV5ZlFCVH4zsYBw7idBPPWC',NULL);
/*!40000 ALTER TABLE `easyii_admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_article_categories`
--

DROP TABLE IF EXISTS `easyii_article_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_article_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `image` varchar(128) DEFAULT NULL,
  `order_num` int(11) DEFAULT NULL,
  `slug` varchar(128) DEFAULT NULL,
  `tree` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `depth` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_article_categories`
--

LOCK TABLES `easyii_article_categories` WRITE;
/*!40000 ALTER TABLE `easyii_article_categories` DISABLE KEYS */;
INSERT INTO `easyii_article_categories` VALUES (4,'公告','',2,NULL,4,1,2,0,1),(3,'活动','',1,NULL,3,1,2,0,1),(5,'新闻','',3,NULL,5,1,2,0,1),(6,'游戏攻略','',4,NULL,6,1,6,0,1),(13,'首页最新活动——三张图','',7,NULL,13,1,2,0,1),(12,'玩法','',4,NULL,6,4,5,1,1),(11,'新手','',4,NULL,6,2,3,1,1),(14,'视频','',5,NULL,14,1,6,0,1),(15,'新手','',5,NULL,14,2,3,1,1),(16,'玩法','',5,NULL,14,4,5,1,1),(17,'副页面左侧——三张图','',6,NULL,17,1,2,0,1);
/*!40000 ALTER TABLE `easyii_article_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_article_items`
--

DROP TABLE IF EXISTS `easyii_article_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_article_items` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(128) NOT NULL,
  `image` varchar(128) DEFAULT NULL,
  `short` varchar(1024) DEFAULT NULL,
  `text` text NOT NULL,
  `slug` varchar(128) DEFAULT NULL,
  `time` int(11) DEFAULT '0',
  `views` int(11) DEFAULT '0',
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_article_items`
--

LOCK TABLES `easyii_article_items` WRITE;
/*!40000 ALTER TABLE `easyii_article_items` DISABLE KEYS */;
INSERT INTO `easyii_article_items` VALUES (14,5,'新服【运筹帷幄】火爆开启','','','<p>IGS正版授权手游《三国战纪》<span style=\"line-height: 1.6em; background-color: initial;\">新服【运筹帷幄】5月20日11:00火爆开启！忠于原著，完美还原经典横版街机游戏，让您重温儿时格斗街机梦！</span></p><p><strong>十四大开服活动伴你勇闯三国.</strong></p><p>一、首充送礼</p><p>【活动时间】永久</p><p>【活动内容】活动时间内充值任意金额，即可获得豪华大礼包，赠送武将“诸葛亮”。</p><p>二、尊贵月卡</p><p>【活动时间】永久</p><p>【活动内容】活动时间内充值月卡，可享受连续30天每日登陆送元宝福利，并获得“白马赵云时装“。</p><p>三、VIP专享福利</p><p>【活动时间】永久</p><p>【活动内容】活动时间内充值达到指定vip等级，可享受VIP专享福利，并可以购买VIP礼包，详情请在游戏内查看。</p><p>四、战力竞速赛</p><p>【活动时间】玩家进入游戏7天内</p><p>【活动内容】活动时间内到达指定战力获丰厚奖励。1天内达到可获赠4星武将“马超“。</p><p>五、征战汉中</p><p>【活动时间】玩家进入游戏2天内</p><p>【活动内容】全服前100名通关3-11副本即可获得“黄芸碎片”5个。</p><p>六、征战荆州</p><p>【活动时间】玩家进入游戏3天内</p><p>【活动内容】全服前100名通关4-12副本即可获得“黄芸碎片”5个。</p><p>七、装备进阶</p><p>【活动时间】玩家进入游戏3天内</p><p>【活动内容】全身装备进阶到蓝色获赠“金币”30万。</p><p>八、五虎上将</p><p>【活动时间】玩家进入游戏4天内</p><p>【活动内容】活动时间内招募任意5个武将即可获得“突破石”500个。</p><p>九、宝石闪耀</p><p>【活动时间】玩家进入游戏4天内</p><p>【活动内容】活动时间内全身宝石达到3级赠送“随机4级宝石”一个。</p><p> 十、宝石精华</p><p>【活动时间】玩家进入游戏6天内</p><p>【活动内容】活动时间内全身宝石达到5级赠送“宝石精华”一个，可兑换7级以上宝石。</p><p>十一、战魂之灵</p><p>【活动时间】玩家进入游戏5天内</p><p>【活动内容】活动时间内任意获得4个紫色战魂即可获赠 “战魂经验”800点。</p><p>十二、战魂之火</p><p>【活动时间】玩家进入游戏5天内</p><p>【活动内容】活动时间内任意获得4个橙色战魂即可获赠金色战魂“真龙胆”一个。</p><p>十三、天下第一、决斗之王</p><p>【活动时间】开服7天内</p><p>【活动内容】截止开服第7天22点，战力、决斗场排名前100的玩家可获得对应的丰富奖励，包括“宝石精华”、“战魂碎片”等，可兑换7级以上宝石和橙色战魂、金色战魂喔，快来挑战吧！</p><p>十四、登陆、签到活动</p><p>【活动时间】永久</p><p>【活动内容】活动时间内每日登陆、签到即可领取对应福利奖励。</p>',NULL,1493026020,0,1),(15,5,'新服【对酒当歌】火爆开启','','','<p>\r\n	IGS正版授权手游《三国战纪》新服【对酒当歌】5月25日11:00火爆开启！忠于原著，完美还原经典横版街机游戏，让您重温儿时格斗街机梦！</p><p><strong>\r\n	十四大开服活动伴你勇闯三国.</strong></p><p>\r\n	一、首充送礼</p><p>\r\n	【活动时间】永久</p><p>\r\n	【活动内容】活动时间内充值任意金额，即可获得豪华大礼包，赠送武将“诸葛亮”。</p><p>\r\n	二、尊贵月卡</p><p>\r\n	【活动时间】永久</p><p>\r\n	【活动内容】活动时间内充值月卡，可享受连续30天每日登陆送元宝福利，并获得“白马赵云时装“。</p><p>\r\n	三、VIP专享福利</p><p>\r\n	【活动时间】永久</p><p>\r\n	【活动内容】活动时间内充值达到指定vip等级，可享受VIP专享福利，并可以购买VIP礼包，详情请在游戏内查看。</p><p>\r\n	四、战力竞速赛</p><p>\r\n	【活动时间】玩家进入游戏7天内</p><p>\r\n	【活动内容】活动时间内到达指定战力获丰厚奖励。1天内达到可获赠4星武将“马超“。</p><p>\r\n	五、征战汉中</p><p>\r\n	【活动时间】玩家进入游戏2天内</p><p>\r\n	【活动内容】全服前100名通关3-11副本即可获得“黄芸碎片”5个。</p><p>\r\n	六、征战荆州</p><p>\r\n	【活动时间】玩家进入游戏3天内</p><p>\r\n	【活动内容】全服前100名通关4-12副本即可获得“黄芸碎片”5个。</p><p>\r\n	七、装备进阶</p><p>\r\n	【活动时间】玩家进入游戏3天内</p><p>\r\n	【活动内容】全身装备进阶到蓝色获赠“金币”30万。</p><p>\r\n	八、五虎上将</p><p>\r\n	【活动时间】玩家进入游戏4天内</p><p>\r\n	【活动内容】活动时间内招募任意5个武将即可获得“突破石”500个。</p><p>\r\n	九、宝石闪耀</p><p>\r\n	【活动时间】玩家进入游戏4天内</p><p>\r\n	【活动内容】活动时间内全身宝石达到3级赠送“随机4级宝石”一个。</p><p>\r\n	 十、宝石精华</p><p>\r\n	【活动时间】玩家进入游戏6天内</p><p>\r\n	【活动内容】活动时间内全身宝石达到5级赠送“宝石精华”一个，可兑换7级以上宝石。</p><p>\r\n	十一、战魂之灵</p><p>\r\n	【活动时间】玩家进入游戏5天内</p><p>\r\n	【活动内容】活动时间内任意获得4个紫色战魂即可获赠 “战魂经验”800点。</p><p>\r\n	十二、战魂之火</p><p>\r\n	【活动时间】玩家进入游戏5天内</p><p>\r\n	【活动内容】活动时间内任意获得4个橙色战魂即可获赠金色战魂“真龙胆”一个。</p><p>\r\n	十三、天下第一、决斗之王</p><p>\r\n	【活动时间】开服7天内</p><p>\r\n	【活动内容】截止开服第7天22点，战力、决斗场排名前100的玩家可获得对应的丰富奖励，包括“宝石精华”、“战魂碎片”等，可兑换7级以上宝石和橙色战魂、金色战魂喔，快来挑战吧！</p><p>\r\n	十四、登陆、签到活动</p><p>\r\n	【活动时间】永久</p><p>\r\n	【活动内容】活动时间内每日登陆、签到即可领取对应福利奖励。</p>',NULL,1493026028,0,1),(10,11,'新手开局攻略（一）','','','<p><strong>《三国战纪》开局攻略，新手玩家必看</strong></p><p>《三国战纪》新手入门攻略，希望这篇攻略能够帮助到正在体验这款游戏的玩家。</p><p><strong>一 、等级</strong></p><p>《三国战纪》是一款需要通过体力来进行副本战斗的游戏。玩家可以通过副本战斗获得各种战力提升材料以及人物升级经验。在游戏的初期，等级之间的差距是非常大的。等级越高，游戏开放系统就越多，战力就越高。由于玩家的升级并不会增加体力，小编建议各位玩家尽可能的购买体力来提升等级。小编建议各位英雄可以购买一张至尊卡，在获得250元宝的同时还能每天获得120元宝，并且还能增加体力购买次数，小编觉得还是非常划算的</p><p>由于每日任务所获得的人物经验是固定的，因此体力成为了玩家之间战力、等级拉开差距的唯一方法。</p><p>除了每日购买体力次数，游戏开发商还会经常推出各种活动。玩家可以通过活动推出的折扣商店购买体力(比系统每日购买体力便宜哦)</p><p><strong>二 、探宝系统</strong></p><p>在《三国战纪》中探宝共分为两种</p><p><img src=\"/uploads/article/1-a1332909d2.jpg\" style=\"width: 559px;\"></p><p><v>  <v>  <v>   <v>   <v>   <v>   <v>   <v>   <v>   <v>   <v>   <v>   <v>   <v>     <v>  <v>  </v></v></v></v></v></v></v></v></v></v></v></v></v></v></v></v></p><ul> \r\n<li>1.金币探宝：金币召唤一般会召唤出英雄碎片、低级宝石以及各种材料。</li></ul><ul> \r\n<li>2.元宝探宝：元宝探宝则有机会召唤出各种整卡英雄以及强力道具。购买10次必送英雄整卡并且和金币探宝一样都只需9折。</li></ul><p><strong>三、武将</strong></p><p>武将系统是《三国战纪》里一个重要的系统。玩家可以通过武将系统查看已招募和未招募英雄，提升武将技能等级进行武将的强化培养。</p><ul> \r\n<li>1.武将概述</li></ul><p>《三国战纪》武将众多，玩家可通过元宝探宝、副本掉落、武将碎片合成、系统赠送等多种途径招募武将。</p><p>招募成功后，即可在武将系统的概述切页，查看武将的时装形象、属性数值、生平介绍等信息，对武将进行详细而全面的了解。<v>  </v></p><p><img src=\"/uploads/article/2-70c0370d98.jpg\" style=\"width: 561px;\"></p><p>2.武将技能</p><p>武将的主要技能有4个，各自拥有不同的作用和效果，玩家可通过消耗技能点，来提升技能等级、增加技能伤害，不过其等级上限得受武将等级和主公等级的制约。技能点消耗完后，每隔一段时间将会自动回复，玩家也可花费元宝自行购买。武将第四个技能，为武将的必杀技，在战斗中必须通过攻击敌人收集怒气，使怒气槽充满后，才可点亮技能按钮，释放必杀技。<v>  </v></p><p><img src=\"/uploads/article/3-77606624a5.jpg\" style=\"width: 563px;\"></p><p>超必杀技拥有比必杀技更强大的伤害威力，而其触发条件也同样需要怒气的收集。玩家每充满一次怒气槽，即可点燃一个怒气格，当三格怒气全部点燃后，玩家即可通过点击头像按钮+必杀技按钮，来释放武将体内的洪荒之力，使其放出超必杀大招，瞬间群秒敌军，获得战斗胜利!</p><p><img src=\"/uploads/article/4-8222bdeed0.jpg\" style=\"width: 560px;\"></p><p><v>  </v></p><ul> \r\n<li>3.武将升星</li></ul><p>　武将升星是增强武将实力的重要途径，玩家可通过消耗武将碎片，来提升武将星级，进而大幅度提升武将的各项属性。当武将碎片耗完时，玩家可通过精英副本掉落、探宝、古董商店兑换、竞技商店兑换等途径获得。<v>  </v></p><p><img src=\"/uploads/article/5-cd7893607c.jpg\" style=\"width: 562px;\"></p><p><strong>四 、养成</strong></p><p>养成系统是玩家提升战力的一个重要途径。</p><ul> \r\n<li>1.装备</li></ul><p>主线副本通关2-4之后系统会赠送每位玩家6件装备，装备随着玩家主线副本的通关逐一解锁。玩家可通过扫荡普通副本获得装备进阶升级材料。</p><p><img src=\"/uploads/article/6-11390aca9a.jpg\" style=\"width: 564px;\"></p><p><v>  </v></p><p>通关精英副本或宝石兑换来获得各属性宝石以提升战力</p><p><img src=\"/uploads/article/7-1266c98817.jpg\" style=\"width: 564px;\"></p><p><v>  </v></p><ul> \r\n<li>2.饰品</li></ul><p>饰品系统是《三国战纪》游戏的一大特色，玩家可组队通关战役副本来获得各种饰品以及精炼石。</p><p><img src=\"/uploads/article/8-bd8d4be3ba.jpg\" style=\"width: 565px;\"></p><p><v>  </v></p><p>蓝色及以上品质饰品具有缘分功能，玩家可将超出饰品栏位并具有缘分的饰品放入缘分阁来提升战斗力。饰品缘分之间的搭配需要玩家自行摸索搭配哦</p><p><img src=\"/uploads/article/9-26444dd19b.jpg\" style=\"width: 564px;\"></p><p>玩家也可通过花费金币或元宝来锻造自己所需饰品。这种获得方式需要一定的时间等待锻造完毕，各位玩家请耐心等待哦</p><p><img src=\"/uploads/article/10-85488b5e81.jpg\" style=\"width: 561px;\"></p>',NULL,1492764547,0,1),(11,11,'新手开局攻略（二）','','','<p><strong>五、挑战副本</strong></p><p>通关主线副本3-2之后，会开启游戏特色玩法“挑战副本”。</p><p>挑战副本共分四种：藏宝阁、过关斩将、勇者战场、单骑救主</p><ul> <li>1.藏宝阁：玩家达到12级后开启藏宝阁系统，通关藏宝阁可获得大量金币</li></ul><ul> <li>2.过关斩将：玩家可任选5名武将齐心协力通过10关过关斩将，可获得大量金币和突破石</li></ul><ul> <li>3.勇者战场：通关勇者战场可获得大量经验</li></ul><ul> <li>4.单骑救主：玩家在单骑救主副本中救下阿斗可获得不同的战魂</li></ul><p><img src=\"/uploads/article/12-6e5b0ac3ad.jpg\" style=\"width: 557px;\"></p><p><strong>六 、竞技</strong></p><p>竞技系统是《三国战纪》的核心玩法，玩家在通关2-11之后可开启该系统。竞技系统共分为：排位赛、决斗场、积分赛</p><ul> <li>1.排位赛</li></ul><p>排位赛是周赛机制，共有青铜、白银、黄金、白金、钻石、王者个6个段位，段位越高，周奖励月份福。玩家可任选3名武将进行跨服PK让你挥洒连招走位，战遍天下英豪</p><p><img src=\"/uploads/article/13-f49ba6ea5c.jpg\" style=\"width: 557px;\"></p><ul> <li>2.决斗场</li></ul><p>决斗场实行3V3自动pk，玩家不可手动操作。战斗胜利后，玩家排名会提升。排名奖励会在每晚21.00通过邮件发放给各位玩家</p><p><img src=\"/uploads/article/14-b506f02280.jpg\" style=\"width: 557px;\"></p><ul> <li>3.积分赛</li></ul><p>每晚19.30-20.30只要是青铜3分段及以上玩家均可参加比赛。每位玩家初级积分均为0分，胜一场加10分，负一场扣10分，扣到30分后不会扣分。比赛结束后，系统会根据积分发放邮件奖励</p><p><img src=\"/uploads/article/15-68968c1e20.jpg\" style=\"width: 556px;\"></p>',NULL,1492764535,0,1),(12,12,'《三国战纪》VIP特权介绍','','','<p><strong style=\"background-color: initial;\">特权0</strong></p><p>1.可在战斗中使用托管功能</p><p>2.每天可购买2次体力</p><p>3.每天可购买8次金币</p><p>4.每天可在决斗场购买1次额外的挑战次数</p><p>5.每天可在战役副本购买1次额外的挑战次数</p><p><strong style=\"background-color: initial;\">特权1</strong></p><p>累计充值60元宝可升级至特权1</p><p>1.可在普通副本中使用扫荡功能</p><p>2.每天可以购买3次体力</p><p>3.每天可购买9次金币</p><p>4.每天可购买1次技能点</p><p>5.每天可在决斗场购买1次额外的挑战次数</p><p>6.每天可在战役副本购买1次额外的挑战次数</p><p>7.每天可在单骑救主购买1次额外的挑战次数</p><p>8.包含特权0所有特权</p><p><strong style=\"background-color: initial;\">特权2</strong></p><p>累计充值180元宝可升级至特权2</p><p>1.决斗场挑战无冷却时间</p><p>2.每月可补签1次</p><p>3.每天可以购买3次体力</p><p>4.每天可购买10次金币</p><p>5.每天可购买2次技能点</p><p>6.每天可在决斗场购买2次额外的挑战次数</p><p>7.每天可在战役副本购买1次额外的挑战次数</p><p>8.每天可在单骑救主购买1次额外的挑战次数</p><p>9.包含特权0-特权1所有特权</p><p><strong style=\"background-color: initial;\">特权3</strong></p><p>累计充值300元宝可升级至特权3</p><p>1.每天21点可领取额外体力</p><p>2.每月可补签2次</p><p>3.每天可以购买3次体力</p><p>4.每天可购买11次金币</p><p>5.每天可购买3次技能点</p><p>6.每天可在决斗场购买3次额外的挑战次数</p><p>7.每天可在战役副本购买1次额外的挑战次数</p><p>8.每天可在单骑救主购买1次额外的挑战次数</p><p>9.包含特权0-特权2所有特权</p><p><strong style=\"background-color: initial;\">特权4</strong></p><p>累计充值500元宝可升级至特权4</p><p>1.永久开启自动升星功能</p><p>2.每月可补签3次</p><p>3.每天可以购买4次体力</p><p>4.每天可购买12次金币</p><p>5.每天可购买3次技能点</p><p>6.每天可在决斗场购买4次额外的挑战次数</p><p>7.每天可在战役副本购买2次额外的挑战次数</p><p>8.每天可在单骑救主购买1次额外的挑战次数</p><p>9.包含特权0-特权3所有特权</p><p><strong style=\"background-color: initial;\">特权5</strong></p><p>累计充值1000元宝可升级至特权5</p><p>1.可在精英副本中使用扫荡功能</p><p>2.每月可补签4次</p><p>3.普通副本和精英副本都可重置1次</p><p>4.每天可以购买4次体力</p><p>5.每天可购买13次金币</p><p>6.每天可购买4次技能点</p><p>7.每天可在决斗场购买5次额外的挑战次数</p><p>8.每天可在战役副本购买2次额外的挑战次数</p><p>9.每天可在单骑救主购买1次额外的挑战次数</p><p>10.藏宝阁、勇者战场、单骑救主开启一键扫荡</p><p>11.包含特权0-特权4所有特权</p><p><strong style=\"background-color: initial;\">特权6</strong></p><p>累计充值2000元宝可升级至特权6</p><p>1.每月可补签5次</p><p>2.普通副本和精英副本都可重置1次</p><p>3.每天可以购买4次体力</p><p>4.每天可购买14次金币</p><p>5.每天可购买4次技能点</p><p>6.每天可在决斗场购买5次额外的挑战次数</p><p>7.每天可在战役副本购买2次额外的挑战次数</p><p>8.每天可在单骑救主购买1次额外的挑战次数</p><p>9.藏宝阁、勇者战场、单骑救主开启一键扫荡</p><p>10.包含特权0-特权5所有特权</p><p><strong style=\"background-color: initial;\">特权7</strong></p><p>累计充值3000元宝可升级至特权7</p><p>1.每月可补签6次</p><p>2.普通副本和精英副本都可重置2次</p><p>3.每天可以购买5次体力</p><p>4.每天可购买15次金币</p><p>5.每天可购买5次技能点</p><p>6.每天可在决斗场购买5次额外的挑战次数</p><p>7.每天可在战役副本购买2次额外的挑战次数</p><p>8.每天可在单骑救主购买1次额外的挑战次数</p><p>9.藏宝阁、勇者战场、单骑救主开启一键扫荡</p><p>10.包含特权0-特权6所有特权</p><p><strong style=\"background-color: initial;\">特权8</strong></p><p>累计充值5000元宝可升级至特权8</p><p>1.永久开启西域商队</p><p>2.每月可补签7次</p><p>3.普通副本和精英副本都可重置2次</p><p>4.每天可以购买5次体力</p><p>5.每天可购买16次金币</p><p>6.每天可购买5次技能点</p><p>7.每天可在决斗场购买5次额外的挑战次数</p><p>8.每天可在战役副本购买2次额外的挑战次数</p><p>9.每天可在单骑救主购买1次额外的挑战次数</p><p>10.藏宝阁、勇者战场、单骑救主开启一键扫荡</p><p>11.包含特权0-特权7所有特权</p><p><strong style=\"background-color: initial;\">特权9</strong></p><p>累计充值7000元宝可升级至特权9</p><p>1. 每月可补签8次</p><p>2. 普通副本和精英副本都可重置3次</p><p>3. 每天可以购买5次体力</p><p>4. 每天可购买17次金币</p><p>5. 每天可购买5次技能点</p><p>6. 每天可在决斗场购买5次额外的挑战次数</p><p>7. 每天可在战役副本购买2次额外的挑战次数</p><p>8. 每天可在单骑救主购买1次额外的挑战次数</p><p>9. 藏宝阁、勇者战场、单骑救主开启一键扫荡</p><p>10. 包含特权0-特权8所有特权</p><p><strong>特权10</strong></p><p>累计充值10000元宝可升级至特权10</p><p>1. 每月可补签9次</p><p>2. 普通副本和精英副本都可重置3次</p><p>3. 每天可以购买5次体力</p><p>4. 每天可购买18次金币</p><p>5. 每天可购买5次技能点</p><p>6. 每天可在决斗场购买5次额外的挑战次数</p><p>7. 每天可在战役副本购买2次额外的挑战次数</p><p>8. 每天可在单骑救主购买1次额外的挑战次数</p><p>9. 藏宝阁、勇者战场、单骑救主开启一键扫荡</p><p>10. 包含特权0-特权9所有特权</p><p><strong>特权11</strong></p><p>累计充值20000元宝可升级至特权11</p><p>1. 每月可补签10次</p><p>2. 普通副本和精英副本都可重置4次</p><p>3. 每天可以购买5次体力</p><p>4. 每天可购买19次金币</p><p>5. 每天可购买5次技能点</p><p>6. 每天可在决斗场购买5次额外的挑战次数</p><p>7. 每天可在战役副本购买2次额外的挑战次数</p><p>8. 每天可在单骑救主购买1次额外的挑战次数</p><p>9. 藏宝阁、勇者战场、单骑救主开启一键扫荡</p><p>10. 包含特权0-特权10所有特权</p><p><strong>特权12</strong></p><p>累计充值40000元宝可升级至特权12</p><p>1. 每月可补签11次</p><p>2. 普通副本和精英副本都可重置4次</p><p>3. 每天可以购买5次体力</p><p>4. 每天可购买20次金币</p><p>5. 每天可购买5次技能点</p><p>6. 每天可在决斗场购买5次额外的挑战次数</p><p>7. 每天可在战役副本购买2次额外的挑战次数</p><p>8. 每天可在单骑救主购买1次额外的挑战次数</p><p>9. 藏宝阁、勇者战场、单骑救主开启一键扫荡</p><p>10. 包含特权0-特权11所有特权</p>','vip',1492764560,0,1),(13,12,'《三国战纪》之终极神兵打造全解','','','<p>《三国战纪》中，装备分为6个部位，分别是：武器、护腕、头盔、衣服、裤子、鞋子。不同部位的装备拥有不同的属性加成， 穿戴后，其属性将添加到 拥有的所有武将身上，从而提高 队伍的整体实力。</p><p><strong>装备强化</strong></p><p>　　 第一次通关普通1-4副本后，便可获得强化装备的能力，使装备属性得到大幅提升。</p><p>　　装备强化拥有等级上限，其上限与 等级和装备品质有关。若想突破限制进一步强化，必须先提升主公等级以及进阶装备。</p><p>　　此外，强化装备需要消耗金币，可通过任务系统、藏宝阁、普通副本、精英副本等途径，迅速获得大量金币，以满足装备强化所需。</p><p><img src=\"/uploads/article/16-8596d0eb21.jpg\" style=\"width: 537px;\"></p><p>（装备强化界面）</p><p><strong>装备进阶</strong></p><p>　　《三国战纪》中，装备品质共分为普通、优秀、精良、史诗、传说、至尊、卓越、绝世、不朽、神器10种。每20级可进阶一次装备，来提升装备的品质，获得大幅属性成长和更高的强化等级上限。</p><p>　　装备进阶需要消耗装备原石， 可通过普通副本掉落获得，此外还通过低阶原石或元宝来直接合成高阶原石。</p><p><img src=\"/uploads/article/17-b537c348ce.jpg\" style=\"width: 541px;\"></p><p>（装备进阶界面）</p><p><img src=\"/uploads/article/18-3956749db8.jpg\" style=\"width: 542px;\"></p><p>（装备升星）</p><p><strong>宝石镶嵌</strong></p><p>　　宝石共分为红宝石、蓝宝石、绿宝石、紫宝石、青宝石、黄宝石、月光石、金刚石、黑曜石9种，分别对应不同的属性。可通过在装备上镶嵌不同宝石，来获得更多的加成属性，直接提升装备的战斗实力。</p><p>　　每件装备可镶嵌2颗宝石，且同类宝石只能镶嵌一颗。镶嵌后可对宝石进行升级，来持续提升宝石所拥有的属性。</p><p>　　升级需要消耗金币和高一级的宝石，玩家可通过精英副本掉落、探宝等途径来获取宝石，也可通过宝石合成的手段，将3个同级宝石合成为一个更高级的宝石。</p><p><img src=\"/uploads/article/19-ce00543b20.jpg\" style=\"width: 555px;\"></p><p>（装备宝石界面）</p><p><img src=\"/uploads/article/20-7512b73051.jpg\" style=\"width: 557px;\"></p><p>（宝石合成）</p>',NULL,1492764566,0,1),(16,4,'新服【对酒当歌】火爆开启','','','<p>IGS正版授权手游《三国战纪》新服【对酒当歌】5月25日11:00火爆开启！忠于原著，完美还原经典横版街机游戏，让您重温儿时格斗街机梦！</p><p><strong>十四大开服活动伴你勇闯三国.</strong></p><p>一、首充送礼</p><p>【活动时间】永久</p><p>【活动内容】活动时间内充值任意金额，即可获得豪华大礼包，赠送武将“诸葛亮”。</p><p>二、尊贵月卡</p><p>【活动时间】永久</p><p>【活动内容】活动时间内充值月卡，可享受连续30天每日登陆送元宝福利，并获得“白马赵云时装“。</p><p>三、VIP专享福利</p><p>【活动时间】永久</p><p>【活动内容】活动时间内充值达到指定vip等级，可享受VIP专享福利，并可以购买VIP礼包，详情请在游戏内查看。</p><p>四、战力竞速赛</p><p>【活动时间】玩家进入游戏7天内</p><p>【活动内容】活动时间内到达指定战力获丰厚奖励。1天内达到可获赠4星武将“马超“。</p><p>五、征战汉中</p><p>【活动时间】玩家进入游戏2天内</p><p>【活动内容】全服前100名通关3-11副本即可获得“黄芸碎片”5个。</p><p>六、征战荆州</p><p>【活动时间】玩家进入游戏3天内</p><p>【活动内容】全服前100名通关4-12副本即可获得“黄芸碎片”5个。</p><p>七、装备进阶</p><p>【活动时间】玩家进入游戏3天内</p><p>【活动内容】全身装备进阶到蓝色获赠“金币”30万。</p><p>八、五虎上将</p><p>【活动时间】玩家进入游戏4天内</p><p>【活动内容】活动时间内招募任意5个武将即可获得“突破石”500个。</p><p>九、宝石闪耀</p><p>【活动时间】玩家进入游戏4天内</p><p>【活动内容】活动时间内全身宝石达到3级赠送“随机4级宝石”一个。</p><p> 十、宝石精华</p><p>【活动时间】玩家进入游戏6天内</p><p>【活动内容】活动时间内全身宝石达到5级赠送“宝石精华”一个，可兑换7级以上宝石。</p><p>十一、战魂之灵</p><p>【活动时间】玩家进入游戏5天内</p><p>【活动内容】活动时间内任意获得4个紫色战魂即可获赠 “战魂经验”800点。</p><p>十二、战魂之火</p><p>【活动时间】玩家进入游戏5天内</p><p>【活动内容】活动时间内任意获得4个橙色战魂即可获赠金色战魂“真龙胆”一个。</p><p>十三、天下第一、决斗之王</p><p>【活动时间】开服7天内</p><p>【活动内容】截止开服第7天22点，战力、决斗场排名前100的玩家可获得对应的丰富奖励，包括“宝石精华”、“战魂碎片”等，可兑换7级以上宝石和橙色战魂、金色战魂喔，快来挑战吧！</p><p>十四、登陆、签到活动</p><p>【活动时间】永久</p><p>【活动内容】活动时间内每日登陆、签到即可领取对应福利奖励。</p>',NULL,1493026054,0,1),(17,4,'新服【运筹帷幄】火爆开启','','','<p>IGS正版授权手游《三国战纪》<span style=\"line-height: 1.6em; background-color: initial;\">新服【运筹帷幄】5月20日11:00火爆开启！忠于原著，完美还原经典横版街机游戏，让您重温儿时格斗街机梦！</span></p><p><strong>十四大开服活动伴你勇闯三国.</strong></p><p>一、首充送礼</p><p>【活动时间】永久</p><p>【活动内容】活动时间内充值任意金额，即可获得豪华大礼包，赠送武将“诸葛亮”。</p><p>二、尊贵月卡</p><p>【活动时间】永久</p><p>【活动内容】活动时间内充值月卡，可享受连续30天每日登陆送元宝福利，并获得“白马赵云时装“。</p><p>三、VIP专享福利</p><p>【活动时间】永久</p><p>【活动内容】活动时间内充值达到指定vip等级，可享受VIP专享福利，并可以购买VIP礼包，详情请在游戏内查看。</p><p>四、战力竞速赛</p><p>【活动时间】玩家进入游戏7天内</p><p>【活动内容】活动时间内到达指定战力获丰厚奖励。1天内达到可获赠4星武将“马超“。</p><p>五、征战汉中</p><p>【活动时间】玩家进入游戏2天内</p><p>【活动内容】全服前100名通关3-11副本即可获得“黄芸碎片”5个。</p><p>六、征战荆州</p><p>【活动时间】玩家进入游戏3天内</p><p>【活动内容】全服前100名通关4-12副本即可获得“黄芸碎片”5个。</p><p>七、装备进阶</p><p>【活动时间】玩家进入游戏3天内</p><p>【活动内容】全身装备进阶到蓝色获赠“金币”30万。</p><p>八、五虎上将</p><p>【活动时间】玩家进入游戏4天内</p><p>【活动内容】活动时间内招募任意5个武将即可获得“突破石”500个。</p><p>九、宝石闪耀</p><p>【活动时间】玩家进入游戏4天内</p><p>【活动内容】活动时间内全身宝石达到3级赠送“随机4级宝石”一个。</p><p> 十、宝石精华</p><p>【活动时间】玩家进入游戏6天内</p><p>【活动内容】活动时间内全身宝石达到5级赠送“宝石精华”一个，可兑换7级以上宝石。</p><p>十一、战魂之灵</p><p>【活动时间】玩家进入游戏5天内</p><p>【活动内容】活动时间内任意获得4个紫色战魂即可获赠 “战魂经验”800点。</p><p>十二、战魂之火</p><p>【活动时间】玩家进入游戏5天内</p><p>【活动内容】活动时间内任意获得4个橙色战魂即可获赠金色战魂“真龙胆”一个。</p><p>十三、天下第一、决斗之王</p><p>【活动时间】开服7天内</p><p>【活动内容】截止开服第7天22点，战力、决斗场排名前100的玩家可获得对应的丰富奖励，包括“宝石精华”、“战魂碎片”等，可兑换7级以上宝石和橙色战魂、金色战魂喔，快来挑战吧！</p><p>十四、登陆、签到活动</p><p>【活动时间】永久</p><p>【活动内容】活动时间内每日登陆、签到即可领取对应福利奖励。</p>',NULL,1493026044,0,1),(18,3,'初夏感恩季系列活动第二期','','','<p><strong style=\"background-color: initial;\">活动一：累充送好礼第一轮</strong></p><p>活动时间：5月12日-5月14日</p><p>活动范围：除新区外所有区服</p><p>活动规则：活动期间内，游戏内进行累积充值即可参加。</p><p>活动奖励：累计充值达到指定要求即可获得宝石碎片以及金币奖励。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p><strong>活动二：累充送好礼第二轮</strong></p><p>活动时间：5月15日-5月18日</p><p>活动范围：除新区外所有区服</p><p>活动规则：活动期间内，游戏内进行累积充值即可参加。</p><p>活动奖励：累计充值达到指定要求即可获得升星石以及进阶石奖励。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p><strong>活动三：战场精英</strong></p><p>活动时间：5月12日-5月14日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：通关精英副本达到指定次数可获得相应金币奖励。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。。</p><p><strong>活动四：争分夺位</strong></p><p>活动时间：5月12日-5月14日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：积分赛胜利达到指定次数可获得相应升星石奖励。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p><strong>活动五：折扣商店-皇冠武将主题</strong></p><p>活动时间：5月12日-5月14日</p><p>活动范围：除新服外老服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>领取方式：进入游戏后，点击“活动”打开折扣商店购买超值4星、5星以及皇冠武将碎片等超值道具。</p><p><strong>活动六：三国战纪-字卡活动</strong></p><p>活动时间：5月15日-5月18日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：活动期间内，在精英副本、决斗场、过关斩将等玩法奖励中会额外掉落节日字卡道具。节日字卡道具可在节日兑换中兑换各类珍贵物品。</p><p>在字卡活动限时商店中，可通过购买物品额外获得免费的“欢乐券”，“欢乐券”可在欢乐送活动中获得珍贵道具。</p><p>领取方式：进入游戏后，点击“活动”界面查看活动面板进行操作。</p><p><strong>活动七：欢乐送-无双关羽</strong></p><p>活动时间：5月15日-5月18日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：使用欢乐券进行抽奖可获得珍贵道具，每抽一次获得30积分，达到指定积分可获得积分奖励</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行操作。</p><p><strong>活动八：充值返利</strong></p><p>活动时间：5月15日-5月18日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：充值任意一档金额就可获得10%元宝返利一次。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p>备注：</p><p>1、本次活动详细信息请进入游戏进行查询。</p><p>2、本次活动最终解释权归《三国战纪》运营团队所有。</p>',NULL,1493026082,0,1),(19,3,'初夏感恩季系列活动第三期','','','<p><strong style=\"background-color: initial;\">活动一：累充送好礼第一轮</strong></p><p>活动时间：5月19日-5月21日</p><p>活动范围：除新区外所有区服</p><p>活动规则：活动期间内，游戏内进行累积充值即可参加。</p><p>活动奖励：累计充值达到指定要求即可获得觉醒丹奖励。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p><strong>活动二：累充送好礼第二轮</strong></p><p>活动时间：5月22日-5月25日</p><p>活动范围：除新区外所有区服</p><p>活动规则：活动期间内，游戏内进行累积充值即可参加。</p><p>活动奖励：累计充值达到指定要求即可获得金币以及皇冠武将碎片奖励。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p><strong>活动三：三国战纪-字卡活动</strong></p><p>活动时间：5月19日-5月21日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：活动期间内，在精英副本、决斗场、过关斩将等玩法奖励中会额外掉落节日字卡道具。节日字卡道具可在节日兑换中兑换各类珍贵物品。</p><p>在字卡活动限时商店中，可通过购买物品额外获得免费的“欢乐券”，“欢乐券”可在欢乐送活动中获得珍贵道具。</p><p>领取方式：进入游戏后，点击“活动”界面查看活动面板进行操作。</p><p><strong>活动四：欢乐送-大乔</strong></p><p>活动时间：5月19日-5月21日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：使用欢乐券进行抽奖可获得珍贵道具，每抽一次获得30积分，达到指定积分可获得积分奖励</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行操作。</p><p><strong>活动五：充值排行榜</strong></p><p>活动时间：5月19日-5月21日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：活动充值排名达到要求，即可领取相应的排行奖励，奖励大量皇冠武将碎片。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p><strong>活动六：战场精英</strong></p><p>活动时间：5月22日-5月25日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：通关精英副本达到指定次数可获得相应金币奖励。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p><strong>活动七：过关斩将</strong></p><p>活动时间：5月22日-5月25日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：过关斩将胜利次数达到指定次数可获得相应斩将币奖励。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p><strong>活动八：团购商店-吕布主题</strong></p><p>活动时间：5月22日-5月25日</p><p>活动范围：除新服外老服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：活动期间内，参与团购抢购吕布碎片等超值道具，按照最终折扣进行元宝返还，邮件发送，每花费1元宝获得1积分，到达一定积分可以领取积分奖励。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p>备注：</p><p>1、本次活动详细信息请进入游戏进行查询。</p><p>2、本次活动最终解释权归《三国战纪》运营团队所有。</p>',NULL,1493026091,0,1),(20,13,'3','/uploads/article/213-187-1-97a37f19c2.jpg','/site/article/38','<p>1</p>','3',1493352109,0,1),(21,13,'1','/uploads/article/213-187-2-0488c9f982.jpg','/site/article/37','<p>1</p>','1',1493362060,0,1),(22,13,'2','/uploads/article/213-187-1-78d1115d6b.jpg','/site/article/42','<p>1</p>','2',1493362026,0,1),(24,15,'《三国战纪》视频','','<iframe height=93 width=200 src=\'http://player.youku.com/embed/XMjczMzc1NjQwMA==\' frameborder=0 \'allowfullscreen\'></iframe>','<p>1</p>',NULL,1493366876,0,1),(39,3,'周年庆活动加码-送京东E卡！！！','','','<p> &nbsp; &nbsp; &nbsp; &nbsp;周年庆活动上线以来，受到各位玩家的大力追捧，为了答谢各位玩家对《三国战纪》手游一直以来的支持和理解，在欢乐送与充值排名活动内增加京东E卡活动，回馈各位亲哦！</p><p>【活动服务器】：全区全服</p><p>【活动时间】：第一期：6月16日0点-6月18日24点</p><p>             第二期：6月24日0点-6月26日24点</p><p>【活动内容】：</p><p>6月16日-6月18日单服欢乐颂积分（大于50000分）第一名的玩家中将随机抽取10名玩家，可获得京东E卡（100元）×1张奖励；</p><p>6月24日-6月26日单服充值排名（大于5000元）第一名的玩家中将随机抽取10名玩家，可获得京东E卡（100元）×1张奖励；</p><p>【活动奖励】：京东E卡（100元）×20张</p><p>【活动规则】：</p><p>1.两期活动单服排名第一的玩家中分别随机抽取10名玩家，将在原有活动奖励基础上获得价值100元的京东E卡一张；</p><p>2.欢乐送活动积分相同的玩家，则根据先到达要求的先后时间来进行排列；</p><p>3.获奖名单会在活动结束后三个工作日内放发在游戏登录界面、官方Q群等，并以邮件的方式发放京东虚拟卡100元序列号*1至获奖的玩家邮件信箱内；</p><p>4.本期活动与周年庆活动奖励可重复领取；</p><p>5.以上活动的最终解释权归官方所有；</p><p style=\"text-align: right;\">《三国战纪》运营团队</p><p style=\"text-align: right;\">2017年6月19日</p>','e',1497873388,0,1),(26,16,'《三国战纪》视频','','<iframe height=93 width=200 src=\'http://player.youku.com/embed/XMjczMzc1NjQwMA==\' frameborder=0 \'allowfullscreen\'></iframe>','<p>1</p>',NULL,1493366905,0,1),(29,17,'3','/uploads/article/330-140-2-5b75e62ad5.jpg','/site/article/37','<p>3</p>','3-2',1493695609,0,1),(28,17,'2','/uploads/article/330-140-1-6804b9a90a.jpg','/site/article/38','<p>1</p>','2-7',1493695595,0,1),(27,17,'1','/uploads/article/330-140-1-bcf03bdf6d.jpg','/site/article/42','<p>1</p>','1-7',1493695587,0,1),(30,4,'新服【神机妙算】火爆开启','','','<p>&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;IGS正版授权手游《三国战纪》新服【神机妙算】6月2日11:00火爆开启！忠于原著，完美还原经典横版街机游戏，让您重温儿时格斗街机梦！</p><p><strong>十四大开服活动伴你勇闯三国.</strong></p><p>一、首充送礼</p><p>【活动时间】永久</p><p>【活动内容】活动时间内充值任意金额，即可获得豪华大礼包，赠送武将“诸葛亮”。</p><p>二、尊贵月卡</p><p>【活动时间】永久</p><p>【活动内容】活动时间内充值月卡，可享受连续30天每日登陆送元宝福利，并获得“白马赵云时装“。</p><p>三、VIP专享福利</p><p>【活动时间】永久</p><p>【活动内容】活动时间内充值达到指定vip等级，可享受VIP专享福利，并可以购买VIP礼包，详情请在游戏内查看。</p><p>四、战力竞速赛</p><p>【活动时间】玩家进入游戏7天内</p><p>【活动内容】活动时间内到达指定战力获丰厚奖励。1天内达到可获赠4星武将“马超“。</p><p>五、征战汉中</p><p>【活动时间】玩家进入游戏2天内</p><p>【活动内容】全服前100名通关3-11副本即可获得“黄芸碎片”5个。</p><p>六、征战荆州</p><p>【活动时间】玩家进入游戏3天内</p><p>【活动内容】全服前100名通关4-12副本即可获得“黄芸碎片”5个。</p><p>七、装备进阶</p><p>【活动时间】玩家进入游戏3天内</p><p>【活动内容】全身装备进阶到蓝色获赠“金币”30万。</p><p>八、五虎上将</p><p>【活动时间】玩家进入游戏4天内</p><p>【活动内容】活动时间内招募任意5个武将即可获得“突破石”500个。</p><p>九、宝石闪耀</p><p>【活动时间】玩家进入游戏4天内</p><p>【活动内容】活动时间内全身宝石达到3级赠送“随机4级宝石”一个。</p><p>十、宝石精华</p><p>【活动时间】玩家进入游戏6天内</p><p>【活动内容】活动时间内全身宝石达到5级赠送“宝石精华”一个，可兑换7级以上宝石。</p><p>十一、战魂之灵</p><p>【活动时间】玩家进入游戏5天内</p><p>【活动内容】活动时间内任意获得4个紫色战魂即可获赠 “战魂经验”800点。</p><p>十二、战魂之火</p><p>【活动时间】玩家进入游戏5天内</p><p>【活动内容】活动时间内任意获得4个橙色战魂即可获赠金色战魂“真龙胆”一个。</p><p>十三、天下第一、决斗之王</p><p>【活动时间】开服7天内</p><p>【活动内容】截止开服第7天22点，战力、决斗场排名前100的玩家可获得对应的丰富奖励，包括“宝石精华”、“战魂碎片”等，可兑换7级以上宝石和橙色战魂、金色战魂喔，快来挑战吧！</p><p>十四、登陆、签到活动</p><p>【活动时间】永久</p><p>【活动内容】活动时间内每日登陆、签到即可领取对应福利奖励。</p>',NULL,1496730668,0,1),(31,4,'​新服【国色流离】火爆开启','','','<p>&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;IGS正版授权手游《三国战纪》新服【国色流离】6月4日11:00火爆开启！忠于原著，完美还原经典横版街机游戏，让您重温儿时格斗街机梦！</p><p><strong>十四大开服活动伴你勇闯三国.</strong></p><p>一、首充送礼</p><p>【活动时间】永久</p><p>【活动内容】活动时间内充值任意金额，即可获得豪华大礼包，赠送武将“诸葛亮”。</p><p>二、尊贵月卡</p><p>【活动时间】永久</p><p>【活动内容】活动时间内充值月卡，可享受连续30天每日登陆送元宝福利，并获得“白马赵云时装“。</p><p>三、VIP专享福利</p><p>【活动时间】永久</p><p>【活动内容】活动时间内充值达到指定vip等级，可享受VIP专享福利，并可以购买VIP礼包，详情请在游戏内查看。</p><p>四、战力竞速赛</p><p>【活动时间】玩家进入游戏7天内</p><p>【活动内容】活动时间内到达指定战力获丰厚奖励。1天内达到可获赠4星武将“马超“。</p><p>五、征战汉中</p><p>【活动时间】玩家进入游戏2天内</p><p>【活动内容】全服前100名通关3-11副本即可获得“黄芸碎片”5个。</p><p>六、征战荆州</p><p>【活动时间】玩家进入游戏3天内</p><p>【活动内容】全服前100名通关4-12副本即可获得“黄芸碎片”5个。</p><p>七、装备进阶</p><p>【活动时间】玩家进入游戏3天内</p><p>【活动内容】全身装备进阶到蓝色获赠“金币”30万。</p><p>八、五虎上将</p><p>【活动时间】玩家进入游戏4天内</p><p>【活动内容】活动时间内招募任意5个武将即可获得“突破石”500个。</p><p>九、宝石闪耀</p><p>【活动时间】玩家进入游戏4天内</p><p>【活动内容】活动时间内全身宝石达到3级赠送“随机4级宝石”一个。</p><p>十、宝石精华</p><p>【活动时间】玩家进入游戏6天内</p><p>【活动内容】活动时间内全身宝石达到5级赠送“宝石精华”一个，可兑换7级以上宝石。</p><p>十一、战魂之灵</p><p>【活动时间】玩家进入游戏5天内</p><p>【活动内容】活动时间内任意获得4个紫色战魂即可获赠 “战魂经验”800点。</p><p>十二、战魂之火</p><p>【活动时间】玩家进入游戏5天内</p><p>【活动内容】活动时间内任意获得4个橙色战魂即可获赠金色战魂“真龙胆”一个。</p><p>十三、天下第一、决斗之王</p><p>【活动时间】开服7天内</p><p>【活动内容】截止开服第7天22点，战力、决斗场排名前100的玩家可获得对应的丰富奖励，包括“宝石精华”、“战魂碎片”等，可兑换7级以上宝石和橙色战魂、金色战魂喔，快来挑战吧！</p><p>十四、登陆、签到活动</p><p>【活动时间】永久</p><p>【活动内容】活动时间内每日登陆、签到即可领取对应福利奖励。</p>',NULL,1496730709,0,1),(32,4,'​新服【河清海晏】火爆开启','','','<p>&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;IGS正版授权手游《三国战纪》新服【河清海晏】6月6日11:00火爆开启！忠于原著，完美还原经典横版街机游戏，让您重温儿时格斗街机梦！</p><p><strong>十四大开服活动伴你勇闯三国.</strong></p><p>一、首充送礼</p><p>【活动时间】永久</p><p>【活动内容】活动时间内充值任意金额，即可获得豪华大礼包，赠送武将“诸葛亮”。</p><p>二、尊贵月卡</p><p>【活动时间】永久</p><p>【活动内容】活动时间内充值月卡，可享受连续30天每日登陆送元宝福利，并获得“白马赵云时装“。</p><p>三、VIP专享福利</p><p>【活动时间】永久</p><p>【活动内容】活动时间内充值达到指定vip等级，可享受VIP专享福利，并可以购买VIP礼包，详情请在游戏内查看。</p><p>四、战力竞速赛</p><p>【活动时间】玩家进入游戏7天内</p><p>【活动内容】活动时间内到达指定战力获丰厚奖励。1天内达到可获赠4星武将“马超“。</p><p>五、征战汉中</p><p>【活动时间】玩家进入游戏2天内</p><p>【活动内容】全服前100名通关3-11副本即可获得“黄芸碎片”5个。</p><p>六、征战荆州</p><p>【活动时间】玩家进入游戏3天内</p><p>【活动内容】全服前100名通关4-12副本即可获得“黄芸碎片”5个。</p><p>七、装备进阶</p><p>【活动时间】玩家进入游戏3天内</p><p>【活动内容】全身装备进阶到蓝色获赠“金币”30万。</p><p>八、五虎上将</p><p>【活动时间】玩家进入游戏4天内</p><p>【活动内容】活动时间内招募任意5个武将即可获得“突破石”500个。</p><p>九、宝石闪耀</p><p>【活动时间】玩家进入游戏4天内</p><p>【活动内容】活动时间内全身宝石达到3级赠送“随机4级宝石”一个。</p><p>十、宝石精华</p><p>【活动时间】玩家进入游戏6天内</p><p>【活动内容】活动时间内全身宝石达到5级赠送“宝石精华”一个，可兑换7级以上宝石。</p><p>十一、战魂之灵</p><p>【活动时间】玩家进入游戏5天内</p><p>【活动内容】活动时间内任意获得4个紫色战魂即可获赠 “战魂经验”800点。</p><p>十二、战魂之火</p><p>【活动时间】玩家进入游戏5天内</p><p>【活动内容】活动时间内任意获得4个橙色战魂即可获赠金色战魂“真龙胆”一个。</p><p>十三、天下第一、决斗之王</p><p>【活动时间】开服7天内</p><p>【活动内容】截止开服第7天22点，战力、决斗场排名前100的玩家可获得对应的丰富奖励，包括“宝石精华”、“战魂碎片”等，可兑换7级以上宝石和橙色战魂、金色战魂喔，快来挑战吧！</p><p>十四、登陆、签到活动</p><p>【活动时间】永久</p><p>【活动内容】活动时间内每日登陆、签到即可领取对应福利奖励。</p>',NULL,1496730770,0,1),(33,3,'粽叶飘香 喜迎端午','','','<p><strong style=\"background-color: initial;\">活动一：喜迎端午送好礼第一轮</strong></p><p><strong></strong></p><p>活动时间：5月26日-5月28日</p><p>活动范围：除新区外所有区服</p><p>活动规则：活动期间内，游戏内进行累积充值即可参加。</p><p>活动奖励：累计充值达到指定要求即可获得宝石碎片、宝石精华奖励。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p><strong>活动二：喜迎端午送好礼第二轮</strong></p><p>活动时间：5月29日-6月1日</p><p>活动范围：除新区外所有区服</p><p>活动规则：活动期间内，游戏内进行累积充值即可参加。</p><p>活动奖励：累计充值达到指定要求即可获得初级、中级以及高级升星石奖励。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p><strong>活动三：团购商店-大乔主题</strong></p><p>活动时间：5月26日-5月28日</p><p>活动范围：除新区外所有区服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：活动期间内，参与团购抢购大乔碎片等超值道具，按照最终折扣进行元宝返还，邮件发送，每花费1元宝获得1积分，到达一定积分可以领取积分奖励。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p><strong>活动四：三国战纪-字卡系列活动第一轮</strong></p><p>活动时间：5月26日-5月28日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：活动期间内，在精英副本、决斗场、过关斩将等玩法奖励中会额外掉落节日字卡道具。节日字卡道具可在节日兑换中兑换各类珍贵物品。</p><p>在字卡活动限时商店中，可通过购买物品额外获得免费的“欢乐券”，“欢乐券”可在欢乐送活动中获得珍贵道具。</p><p>领取方式：进入游戏后，点击“活动”界面查看活动面板进行操作。</p><p><strong>活动五：三国战纪-字卡系列活动第二轮</strong></p><p>活动时间：5月29日-6月1日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：活动期间内，在精英副本、决斗场、过关斩将等玩法奖励中会额外掉落节日字卡道具。节日字卡道具可在节日兑换中兑换各类珍贵物品。</p><p>在字卡活动限时商店中，可通过购买物品额外获得免费的“欢乐券”，“欢乐券”可在欢乐送活动中获得珍贵道具。</p><p>领取方式：进入游戏后，点击“活动”界面查看活动面板进行操作。</p><p><strong>活动六：欢乐送第一轮-无双赵云</strong></p><p>活动时间：5月26日-5月28日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：使用欢乐券进行抽奖可获得珍贵道具-无双赵云碎片，每抽一次获得30积分，达到指定积分可获得积分奖励</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行操作。</p><p><strong>活动七：欢乐送第二轮-司马懿</strong></p><p>活动时间：5月29日-6月1日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：使用欢乐券进行抽奖可获得珍贵道具-司马懿碎片，每抽一次获得30积分，达到指定积分可获得积分奖励</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行操作。</p><p><strong>活动八：充值排行榜</strong></p><p>活动时间：5月29日-6月1日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：活动充值排名达到要求，即可领取相应的排行奖励，奖励大量皇冠武将碎片。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p><strong>活动九：充值返利第一轮</strong></p><p>活动时间：5月27日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：充值任意一档金额就可获得20%元宝返利一次。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p><strong>活动十：充值返利第二轮</strong></p><p>活动时间：5月28日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：充值任意一档金额就可获得20%元宝返利一次。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p><strong>活动十一：充值返利第三轮</strong></p><p>活动时间：5月30日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：充值任意一档金额就可获得20%元宝返利一次。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p>备注：</p><p>1、本次活动详细信息请进入游戏进行查询。</p><p>2、本次活动最终解释权归《三国战纪》运营团队所有。</p>',NULL,1496890701,0,1),(34,3,'初夏感恩季系列活动第四期','','','<p><strong style=\"background-color: initial;\">活动一：累充送好礼第一轮</strong></p><p><strong></strong></p><p>活动时间：6月2日-6月4日</p><p>活动范围：除新区外所有区服</p><p>活动规则：活动期间内，游戏内进行累积充值即可参加。</p><p>活动奖励：累计充值达到指定要求即可获得觉醒丹、金币奖励。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p><strong>活动二：累充送好礼第二轮</strong></p><p>活动时间：6月5日-6月8日</p><p>活动范围：除新区外所有区服</p><p>活动规则：活动期间内，游戏内进行累积充值即可参加。</p><p>活动奖励：累计充值达到指定要求即可获得皇冠武将碎片以及突破石奖励。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p><strong>活动三：噩梦剑影</strong></p><p>活动时间：6月2日-6月4日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：通关噩梦副本达到指定次数可获得相应觉醒丹奖励。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p><strong>活动四：寻宝点将</strong></p><p>活动时间：6月2日-6月4日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：探宝次数达到指定次数可获得相应金龙令奖励。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p><strong>活动五：折扣商店-饰品主题</strong></p><p>活动时间：6月2日-6月4日</p><p>活动范围：除新服外老服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>领取方式：进入游戏后，点击“活动”打开折扣商店购买超值金饰任选碎片、中级升星石等超值道具。</p><p><strong>活动六：战场精英</strong></p><p>活动时间：6月5日-6月8日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：通关精英副本达到指定次数可获得相应金币奖励。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。。</p><p><strong>活动七：过关斩将</strong></p><p>活动时间：6月5日-6月8日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：过关斩将胜利达到指定次数可获得相应突破石奖励。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p><strong>活动八：折扣商店-宝石战魂主题</strong></p><p>活动时间：6月5日-6月8日</p><p>活动范围：除新服外老服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>领取方式：进入游戏后，点击“活动”打开折扣商店购买超值宝石精华、战魂碎片等超值道具。</p><p>备注：</p><p>1、本次活动详细信息请进入游戏进行查询。</p><p>2、本次活动最终解释权归《三国战纪》运营团队所有。</p>',NULL,1496890785,0,1),(35,4,'新服【三足鼎立】火爆开启','','','<p>\r\n	IGS正版授权手游《三国战纪》\r\n	新服【三足鼎立】6月8日11:00火爆开启！忠于原著，完美还原经典横版街机游戏，让您重温儿时格斗街机梦！</p><p>\r\n	<strong>十四大开服活动伴你勇闯三国.</strong></p><p>\r\n	一、首充送礼</p><p>\r\n	【活动时间】永久</p><p>\r\n	【活动内容】活动时间内充值任意金额，即可获得豪华大礼包，赠送武将“诸葛亮”。</p><p>\r\n	二、尊贵月卡</p><p>\r\n	【活动时间】永久</p><p>\r\n	【活动内容】活动时间内充值月卡，可享受连续30天每日登陆送元宝福利，并获得“白马赵云时装“。</p><p>\r\n	三、VIP专享福利</p><p>\r\n	【活动时间】永久</p><p>\r\n	【活动内容】活动时间内充值达到指定vip等级，可享受VIP专享福利，并可以购买VIP礼包，详情请在游戏内查看。</p><p>\r\n	四、战力竞速赛</p><p>\r\n	【活动时间】玩家进入游戏7天内</p><p>\r\n	【活动内容】活动时间内到达指定战力获丰厚奖励。1天内达到可获赠4星武将“马超“。</p><p>\r\n	五、征战汉中</p><p>\r\n	【活动时间】玩家进入游戏2天内</p><p>\r\n	【活动内容】全服前100名通关3-11副本即可获得“黄芸碎片”5个。</p><p>\r\n	六、征战荆州</p><p>\r\n	【活动时间】玩家进入游戏3天内</p><p>\r\n	【活动内容】全服前100名通关4-12副本即可获得“黄芸碎片”5个。</p><p>\r\n	七、装备进阶</p><p>\r\n	【活动时间】玩家进入游戏3天内</p><p>\r\n	【活动内容】全身装备进阶到蓝色获赠“金币”30万。</p><p>\r\n	八、五虎上将</p><p>\r\n	【活动时间】玩家进入游戏4天内</p><p>\r\n	【活动内容】活动时间内招募任意5个武将即可获得“突破石”500个。</p><p>\r\n	九、宝石闪耀</p><p>\r\n	【活动时间】玩家进入游戏4天内</p><p>\r\n	【活动内容】活动时间内全身宝石达到3级赠送“随机4级宝石”一个。</p><p>\r\n	十、宝石精华</p><p>\r\n	【活动时间】玩家进入游戏6天内</p><p>\r\n	【活动内容】活动时间内全身宝石达到5级赠送“宝石精华”一个，可兑换7级以上宝石。</p><p>\r\n	十一、战魂之灵</p><p>\r\n	【活动时间】玩家进入游戏5天内</p><p>\r\n	【活动内容】活动时间内任意获得4个紫色战魂即可获赠 “战魂经验”800点。</p><p>\r\n	十二、战魂之火</p><p>\r\n	【活动时间】玩家进入游戏5天内</p><p>\r\n	【活动内容】活动时间内任意获得4个橙色战魂即可获赠金色战魂“真龙胆”一个。</p><p>\r\n	十三、天下第一、决斗之王</p><p>\r\n	【活动时间】开服7天内</p><p>\r\n	【活动内容】截止开服第7天22点，战力、决斗场排名前100的玩家可获得对应的丰富奖励，包括“宝石精华”、“战魂碎片”等，可兑换7级以上宝石和橙色战魂、金色战魂喔，快来挑战吧！</p><p>\r\n	十四、登陆、签到活动</p><p>\r\n	【活动时间】永久</p><p>\r\n	【活动内容】活动时间内每日登陆、签到即可领取对应福利奖励。</p>',NULL,1496890937,0,1),(36,4,'新服【鹰视狼顾】火爆开启','/uploads/article/213-187-ed8e2dfc01.png','','<p>\r\n	IGS正版授权手游《三国战纪》\r\n	新服【鹰视狼顾】6月18日11:00火爆开启！忠于原著，完美还原经典横版街机游戏，让您重温儿时格斗街机梦！\r\n</p>\r\n<p>\r\n	<strong>十四大开服活动伴你勇闯三国.</strong>\r\n</p>\r\n<p>\r\n	一、首充送礼\r\n</p>\r\n<p>\r\n	【活动时间】永久\r\n</p>\r\n<p>\r\n	【活动内容】活动时间内充值任意金额，即可获得豪华大礼包，赠送武将“诸葛亮”。\r\n</p>\r\n<p>\r\n	二、尊贵月卡\r\n</p>\r\n<p>\r\n	【活动时间】永久\r\n</p>\r\n<p>\r\n	【活动内容】活动时间内充值月卡，可享受连续30天每日登陆送元宝福利，并获得“白马赵云时装“。\r\n</p>\r\n<p>\r\n	三、VIP专享福利\r\n</p>\r\n<p>\r\n	【活动时间】永久\r\n</p>\r\n<p>\r\n	【活动内容】活动时间内充值达到指定vip等级，可享受VIP专享福利，并可以购买VIP礼包，详情请在游戏内查看。\r\n</p>\r\n<p>\r\n	四、战力竞速赛\r\n</p>\r\n<p>\r\n	【活动时间】玩家进入游戏7天内\r\n</p>\r\n<p>\r\n	【活动内容】活动时间内到达指定战力获丰厚奖励。1天内达到可获赠4星武将“马超“。\r\n</p>\r\n<p>\r\n	五、征战汉中\r\n</p>\r\n<p>\r\n	【活动时间】玩家进入游戏2天内\r\n</p>\r\n<p>\r\n	【活动内容】全服前100名通关3-11副本即可获得“黄芸碎片”5个。\r\n</p>\r\n<p>\r\n	六、征战荆州\r\n</p>\r\n<p>\r\n	【活动时间】玩家进入游戏3天内\r\n</p>\r\n<p>\r\n	【活动内容】全服前100名通关4-12副本即可获得“黄芸碎片”5个。\r\n</p>\r\n<p>\r\n	七、装备进阶\r\n</p>\r\n<p>\r\n	【活动时间】玩家进入游戏3天内\r\n</p>\r\n<p>\r\n	【活动内容】全身装备进阶到蓝色获赠“金币”30万。\r\n</p>\r\n<p>\r\n	八、五虎上将\r\n</p>\r\n<p>\r\n	【活动时间】玩家进入游戏4天内\r\n</p>\r\n<p>\r\n	【活动内容】活动时间内招募任意5个武将即可获得“突破石”500个。\r\n</p>\r\n<p>\r\n	九、宝石闪耀\r\n</p>\r\n<p>\r\n	【活动时间】玩家进入游戏4天内\r\n</p>\r\n<p>\r\n	【活动内容】活动时间内全身宝石达到3级赠送“随机4级宝石”一个。\r\n</p>\r\n<p>\r\n	十、宝石精华\r\n</p>\r\n<p>\r\n	【活动时间】玩家进入游戏6天内\r\n</p>\r\n<p>\r\n	【活动内容】活动时间内全身宝石达到5级赠送“宝石精华”一个，可兑换7级以上宝石。\r\n</p>\r\n<p>\r\n	十一、战魂之灵\r\n</p>\r\n<p>\r\n	【活动时间】玩家进入游戏5天内\r\n</p>\r\n<p>\r\n	【活动内容】活动时间内任意获得4个紫色战魂即可获赠 “战魂经验”800点。\r\n</p>\r\n<p>\r\n	十二、战魂之火\r\n</p>\r\n<p>\r\n	【活动时间】玩家进入游戏5天内\r\n</p>\r\n<p>\r\n	【活动内容】活动时间内任意获得4个橙色战魂即可获赠金色战魂“真龙胆”一个。\r\n</p>\r\n<p>\r\n	十三、天下第一、决斗之王\r\n</p>\r\n<p>\r\n	【活动时间】开服7天内\r\n</p>\r\n<p>\r\n	【活动内容】截止开服第7天22点，战力、决斗场排名前100的玩家可获得对应的丰富奖励，包括“宝石精华”、“战魂碎片”等，可兑换7级以上宝石和橙色战魂、金色战魂喔，快来挑战吧！\r\n</p>\r\n<p>\r\n	十四、登陆、签到活动\r\n</p>\r\n<p>\r\n	【活动时间】永久\r\n</p>\r\n<p>\r\n	【活动内容】活动时间内每日登陆、签到即可领取对应福利奖励。\r\n</p>',NULL,1497591844,0,1),(37,3,'《三国战纪》周年庆典','','','<p><strong style=\"background-color: initial;\">周年庆每天登陆领好礼</strong></p><p>活动时间：6月16日-6月25日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，每天登陆游戏即可参与。</p><p>活动奖励：登陆游戏即可获得元宝、金币、突破石等道具奖励。</p><p>参与方式：进入游戏后，点击“活动”打开活动界面进行参与。</p><p><strong><br></strong></p><p><strong>喜迎周年送好礼第一轮</strong></p><p><strong>活动一：周年充值送大礼第一波</strong></p><p>活动时间：6月16日-6月18日</p><p>活动范围：除新区外所有区服</p><p>活动规则：活动期间内，游戏内进行累积充值即可参加。</p><p>活动奖励：累计充值达到指定要求即可获得皇冠武将宝箱等奖励。</p><p>参与方式：进入游戏后，点击“活动”打开活动界面进行参与。</p><p><strong>活动二：周年庆字卡活动第一波</strong></p><p>活动时间：6月16日-6月18日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。</p><p>活动奖励：</p><ul> <li>l活动期间内，在精英副本、决斗场、过关斩将等玩法奖励中会额外掉落节日字卡道具。节日字卡道具可在节日兑换中兑换各类珍贵物品。</li></ul><ul> <li>l另有普通副本、战魂觉醒等任务，可获得字卡包、金币、进阶石等奖励</li></ul><ul> <li>l在字卡活动限时商店中，可通过购买物品额外获得免费的“欢乐券”，“欢乐券”可在欢乐送活动中获得珍贵道具。</li></ul><p>参与方式：进入游戏后，点击“活动”界面查看活动面板进行操作。</p><p><strong>活动三：团购商店-大乔主题</strong></p><p>活动时间：6月16日-6月18日</p><p>活动范围：除新区外所有区服</p><p>活动规则：活动期间内，20级以上玩家可参加。</p><p>活动奖励：活动期间内，参与团购抢购大乔碎片等超值道具，按照最终折扣进行元宝返还，邮件发送，每花费1元宝获得1积分，到达一定积分可以参与积分奖励。</p><p>参与方式：进入游戏后，点击“活动”打开活动界面进行参与。</p><p><strong>活动四：欢乐送第一轮-无双关羽</strong></p><p>活动时间：6月16日-6月18日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。</p><p>活动奖励：</p><ul> <li>l使用欢乐券进行抽奖可获得珍贵道具-无双关羽碎片，每抽一次获得30积分，达到指定积分可获得积分奖励</li></ul><ul> <li>l排名第一且积分超过50000分的玩家即可获得“勇冠三军大礼包”更有可能参加本期周年庆的定制大礼包活动；</li></ul><p>参与方式：进入游戏后，点击“活动”打开活动界面进行操作。</p><p><strong>活动五：战役产出翻双倍</strong></p><p>活动时间：6月16日-6月18日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。</p><p>活动奖励：战役副本内所有的产出翻倍；</p><p><strong></strong></p><p><strong><br></strong></p><p><strong>喜迎周年送好礼第二轮</strong></p><p><strong>活动一：周年充值送大礼第二波</strong></p><p>活动时间：6月19日-6月22日</p><p>活动范围：除新区外所有区服</p><p>活动规则：活动期间内，游戏内进行累积充值即可参加。</p><p>活动奖励：累计充值达到指定要求即可获得宝石精华等奖励。</p><p>参与方式：进入游戏后，点击“活动”打开活动界面进行参与。</p><p><strong>活动二：周年庆字卡活动第二波</strong></p><p>活动时间：6月19日-6月22日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。</p><p>活动奖励：</p><ul> <li>l活动期间内，在精英副本、决斗场、过关斩将等玩法奖励中会额外掉落节日字卡道具。节日字卡道具可在节日兑换中兑换各类珍贵物品。</li></ul><ul> <li>l另有精英副本、过关斩将等任务，可获得字卡包、突破石、斩将币等奖励</li></ul><ul> <li>l在字卡活动限时商店中，可通过购买物品额外获得免费的“欢乐券”，“欢乐券”可在欢乐送活动中获得珍贵道具。</li></ul><p>参与方式：进入游戏后，点击“活动”界面查看活动面板进行操作。</p><p><strong>活动三：欢乐送第二轮-吕布</strong></p><p>活动时间：6月19日-6月22日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。</p><p>活动奖励：使用欢乐券进行抽奖可获得珍贵道具-吕布碎片，每抽一次获得30积分，达到指定积分可获得积分奖励</p><p>参与方式：进入游戏后，点击“活动”打开活动界面进行操作。</p><p><strong>活动四：噩梦产出翻双倍</strong></p><p>活动时间：6月19日-6月22日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。</p><p>活动奖励：噩梦副本内所有的产出翻倍；</p><p><strong><br></strong></p><p><strong>喜迎周年送好礼第三轮</strong></p><p><strong>活动一：周年充值送大礼第三波</strong></p><p>活动时间：6月23日-6月25日</p><p>活动范围：除新区外所有区服</p><p>活动规则：活动期间内，游戏内进行累积充值即可参加。</p><p>活动奖励：累计充值达到指定要求即可获得高级升星石等奖励。</p><p>参与方式：进入游戏后，点击“活动”打开活动界面进行参与。</p><p><strong></strong></p><p><strong>活动二：充值排行获大奖</strong></p><p>活动时间：6月23日-6月25日</p><p>活动范围：除新区外所有区服</p><p>活动规则：活动期间内，游戏内进行累积充值即可参加。</p><p>活动奖励：</p><ul> <li>l累计充值达到指定要求即可获得皇冠武将宝箱的奖励。</li></ul><ul> <li>l排名第一且充值金额超过5000元的玩家即可获得“勇冠三军大礼包”，更有可能参加本期周年庆的定制大礼包活动；</li></ul><p>参与方式：进入游戏后，点击“活动”打开活动界面进行参与。</p><p><strong></strong></p><p><strong>活动三：周年庆字卡活动第三波</strong></p><p>活动时间：6月23日-6月25日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。</p><p>活动奖励：</p><ul> <li>l活动期间内，在精英副本、决斗场、过关斩将等玩法奖励中会额外掉落节日字卡道具。节日字卡道具可在节日兑换中兑换各类珍贵物品。</li></ul><ul> <li>l另有噩梦副本、探宝等任务，可获得字卡包、突破石、金龙令等奖励</li></ul><ul> <li>l在字卡活动限时商店中，可通过购买物品额外获得免费的“欢乐券”，“欢乐券”可在欢乐送活动中获得珍贵道具。</li></ul><p>参与方式：进入游戏后，点击“活动”界面查看活动面板进行操作。</p><p><strong>活动四：团购商店-司马懿主题</strong></p><p>活动时间：6月23日-6月25日</p><p>活动范围：除新区外所有区服</p><p>活动规则：活动期间内，20级以上玩家可参加。</p><p>活动奖励：活动期间内，参与团购抢购司马懿碎片等超值道具，按照最终折扣进行元宝返还，邮件发送，每花费1元宝获得1积分，到达一定积分可以参与积分奖励。</p><p>参与方式：进入游戏后，点击“活动”打开活动界面进行参与。</p><p><strong>活动五：欢乐送第三轮-无双赵云宝箱</strong></p><p>活动时间：6月23日-6月25日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。</p><p>活动奖励：使用欢乐券进行抽奖可获得珍贵武将-无双赵云，每抽一次获得30积分，达到指定积分可获得积分奖励</p><p>参与方式：进入游戏后，点击“活动”打开活动界面进行操作。</p><p><strong>活动六：过关斩将产出翻双倍</strong></p><p>活动时间：6月23日-6月25日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。</p><p>活动奖励：过关斩将副本内所有的产出翻倍；</p><p>备注：</p><p>1、本次活动详细信息请进入游戏进行查询。</p><p>2、本次活动最终解释权归官方所有。</p>',NULL,1497592390,0,1),(38,3,'周年大返利，私人订制大礼包！','','','<p>《三国战纪》已经上线一周年啦！我们从无到有，从一个平台发展到多个平台。每一次的版本更新，都与一直支持我们的忠实玩家提供的宝贵建议密不可分，再次诚心感谢一直支持追随《三国战纪》的玩家们。相信在未来的日子中，《三国战纪》会在众多玩家的陪伴之下越来越好，为了庆祝上线一周年，官方精心策划推出“周年庆活动”来回馈玩家，畅游指尖世界，赢取诱人实物豪礼，诚邀你与我们同庆这特殊的日子！</p><p><strong>【活动服务器】</strong>：全区全服</p><p><strong>【活动时间】</strong>：第一期：6月16日0点-6月18日24点</p><p>第二期：6月24日0点-6月26日24点</p><p><strong>【活动内容】：</strong></p><p>6月16日-6月18日单服欢乐颂积分（大于50000分）第一名的玩家，以及全区全服总排名的前32名玩家，均可获得活动奖励；</p><p>6月24日-6月26日单服充值排名（大于5000元）第一名的玩家，以及全区全服总排名的前32名玩家，均可获得活动奖励；</p><p><strong>【活动奖励】</strong>：周年庆大礼包、勇冠三军大礼包、小鸡手柄、游戏抱枕、雨伞、鼠标垫；</p><p>勇冠三军大礼包：元宝*5000、金币*5000000、突破石*1000、精炼石*1000</p><p>周年庆大礼包：内容由玩家定制</p><p><strong>【活动规则】：</strong></p><ul> <li>1.单服排名第一玩家将在原有活动奖励基础上获得价值10000元宝的“勇冠三军大礼包”，奖品将在获奖名单公布后三个工作日内发放至游戏内邮箱；</li></ul><ul> <li>2.欢乐颂活动积分或充值活动金额相同的玩家，则根据先到达要求的先后时间来进行排列；</li></ul><ul> <li>3.获奖名单会在活动结束后三个工作日内放发在游戏登录界面、官方Q群等，并邮件告知获得资格的32名玩家（将不获得勇冠三军大礼包），获得邮件后，请联系客服QQ：2881691106（客服工作时间：周一至周五的9:30-18:30）；如获奖名单公布后的48小时未联系客服将被取消活动资格；</li></ul><ul> <li>4.联系客服的时候，每位玩家可随机挑选一个独立的号码（1-16区间），按照联系客服的时间，先到先选择号码，如号码被之前的玩家选择，则需选择其他号码，每个号码可重复一次；</li></ul><ul> <li>5.我们将根据6月25日（第一期）7月2日（第二期）开启的双色球蓝球的号码确定您的活动奖品的比例：</li></ul><ul> <li>1)例如蓝球为5，则号码为5的两名玩家将会获得小鸡游戏手柄一部、游戏抱枕一个，以及本次活动期间内充值金额的50%的返还的周年庆大礼包一个，客服将提供道具及价格列表，由玩家自由选定所需的道具（价值不可超过本次活动期间内充值金额的50%），</li></ul><ul> <li>2)如果本期号码为单数，则号码为单数的玩家将会获得：30%返还的周年庆大礼包一个+实物奖励随机一个；号码为双数的玩家将会获得：10%返还周年庆大礼包一个+实物奖励随机一个；</li></ul><ul> <li>3)如果本期号码为双数，则号码为双数的玩家将会获得：30%返还的周年庆大礼包一个+实物奖励随机一个；号码为单数的玩家将会获得：10%返还的周年庆大礼包一个+实物奖励随机一个；</li></ul><ul> <li>4)特等奖与其他奖项不可同时领取</li></ul><ul> <li>6.活动奖励将会在确定获奖名单及内容后，三个工作日发出，实物奖励将会快递发出，依照地区远近收取时间将会不同；</li></ul><ul> <li>7.两期活动玩家可重复参加，两期活动奖励可重复领取；</li></ul><ul> <li>8.以上活动的最终解释权归官方所有；</li></ul><p>《三国战纪》运营团队</p><p>2017年6月13日</p>',NULL,1497593553,0,1),(40,4,'新服【虎踞龙盘】火爆开启','','IGS正版授权手游《三国战纪》新服【虎踞龙盘】6月18日11:00火爆开启！','<p>&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;IGS正版授权手游《三国战纪》新服【虎踞龙盘】6月18日11:00火爆开启！忠于原著，完美还原经典横版街机游戏，让您重温儿时格斗街机梦！</p><p>十四大开服活动伴你勇闯三国.</p><p>一、首充送礼</p><p>【活动时间】永久</p><p>【活动内容】活动时间内充值任意金额，即可获得豪华大礼包，赠送武将“诸葛亮”。</p><p>二、尊贵月卡</p><p>【活动时间】永久</p><p>【活动内容】活动时间内充值月卡，可享受连续30天每日登陆送元宝福利，并获得“白马赵云时装“。</p><p>三、VIP专享福利</p><p>【活动时间】永久</p><p>【活动内容】活动时间内充值达到指定vip等级，可享受VIP专享福利，并可以购买VIP礼包，详情请在游戏内查看。</p><p>四、战力竞速赛</p><p>【活动时间】玩家进入游戏7天内</p><p>【活动内容】活动时间内到达指定战力获丰厚奖励。1天内达到可获赠4星武将“马超“。</p><p>五、征战汉中</p><p>【活动时间】玩家进入游戏2天内</p><p>【活动内容】全服前100名通关3-11副本即可获得“黄芸碎片”5个。</p><p>六、征战荆州</p><p>【活动时间】玩家进入游戏3天内</p><p>【活动内容】全服前100名通关4-12副本即可获得“黄芸碎片”5个。</p><p>七、装备进阶</p><p>【活动时间】玩家进入游戏3天内</p><p>【活动内容】全身装备进阶到蓝色获赠“金币”30万。</p><p>八、五虎上将</p><p>【活动时间】玩家进入游戏4天内</p><p>【活动内容】活动时间内招募任意5个武将即可获得“突破石”500个。</p><p>九、宝石闪耀</p><p>【活动时间】玩家进入游戏4天内</p><p>【活动内容】活动时间内全身宝石达到3级赠送“随机4级宝石”一个。</p><p> 十、宝石精华</p><p>【活动时间】玩家进入游戏6天内</p><p>【活动内容】活动时间内全身宝石达到5级赠送“宝石精华”一个，可兑换7级以上宝石。</p><p>十一、战魂之灵</p><p>【活动时间】玩家进入游戏5天内</p><p>【活动内容】活动时间内任意获得4个紫色战魂即可获赠 “战魂经验”800点。</p><p>十二、战魂之火</p><p>【活动时间】玩家进入游戏5天内</p><p>【活动内容】活动时间内任意获得4个橙色战魂即可获赠金色战魂“真龙胆”一个。</p><p>十三、天下第一、决斗之王</p><p>【活动时间】开服7天内</p><p>【活动内容】截止开服第7天22点，战力、决斗场排名前100的玩家可获得对应的丰富奖励，包括“宝石精华”、“战魂碎片”等，可兑换7级以上宝石和橙色战魂、金色战魂喔，快来挑战吧！</p><p>十四、登陆、签到活动</p><p>【活动时间】永久</p><p>【活动内容】活动时间内每日登陆、签到即可领取对应福利奖励。</p>',NULL,1497874034,0,1),(41,4,'《三国战纪》极限竞技版封测活动','','IGS正版授权动作手游《三国战纪》极限竞技版删档封测6月22日11时热血开启！','<p>IGS正版授权动作手游《三国战纪》极限竞技版删档封测6月22日11时热血开启！</p><p>极限竞技版在《三国战纪》的基础上，增加了武将图鉴、神翼系统、秘境探险、等新内容，更有全新的军团战PVP，梦回曾经一起经历的热血回忆，重温经典，等你来战！</p><p>【封测时间】2017年6月22日11:00-7月2日11:00</p><p><strong></strong></p><p><strong style=\"background-color: initial;\">活动一：你提我改赢奖励，京东E卡等你来拿</strong></p><p>【活动时间】2017年6月22日-7月2日</p><p>【活动内容】</p><p>活动期间内，通过官方QQ群内的客服反馈游戏BUG或提供建议，即有机会获得官方为您准备的京东E卡或《三国战纪》游戏礼包奖励！</p><p>官方玩家QQ群：643984889</p><p>【活动规则】</p><p>1.  活动期间内相同BUG第一位提交的玩家，将可以获得活动奖励：《三国战纪》礼包码。</p><p>2.  玩家在活动过程中可以对游戏提出任何宝贵意见，官方会收集所有玩家给予的建议仔细查阅，并将从中选出40份可能会被采纳的建议，给予玩家京东E卡（100元）+《三国战纪》大礼包奖励；</p><p>3.  为保证您可以正常获得奖励，在提交过程中，都需要在您提交的内容下方注明：（信息提交无法更改） </p><p>三国战纪手游角色昵称（如无，可以不填写）：</p><p>三国战纪手游角色ID（如无，可以不填写）：</p><p>联系方式：个人QQ（必填）</p><p>【奖励内容】</p><ul> \r\n<li>1、京东E卡（100元）*40份</li></ul><ul> \r\n<li>2、《三国战纪》大礼包（元宝*500，高级升星石*50，体力*200）</li></ul><p>【领取方式】</p><p>1.  奖励名单及领取信息请关注QQ群内公告；</p><p>2.  奖励物品会在活动结束后7个工作日内，发放至用户个人QQ，请注意查收。</p><p><strong><br></strong></p><p><strong>活动二：天天登陆送元宝，领VIP经验</strong></p><p>删档封测期间，每天赠送10000元宝、相应的VIP经验，让你更多的体验游戏！</p><table>  <tbody><tr>   <td><strong>天数</strong></td>   <td><strong>元宝</strong></td>   <td><strong>VIP</strong><strong>经验</strong></td>  </tr>  <tr>   <td><strong>第1天</strong></td>   <td><strong>10000</strong></td>   <td><strong>5000</strong></td>  </tr>  <tr>   <td><strong>第2天</strong></td>   <td><strong>10000</strong></td>   <td><strong>5000</strong></td>  </tr>  <tr>   <td><strong>第3天</strong></td>   <td><strong>10000</strong></td>   <td><strong>10000</strong></td>  </tr>  <tr>   <td><strong>第4天</strong></td>   <td><strong>10000</strong></td>   <td><strong>20000</strong></td>  </tr>  <tr>   <td><strong>第5天</strong></td>   <td><strong>10000</strong></td>   <td><strong>20000</strong></td>  </tr>  <tr>   <td><strong>第6天</strong></td>   <td><strong>10000</strong></td>   <td><strong>40000</strong></td>  </tr>  <tr>   <td><strong>第7天</strong></td>   <td><strong>10000</strong></td>   <td><strong>100000</strong></td>  </tr>  <tr>   <td><strong>第8天</strong></td>   <td><strong>10000</strong></td>   <td>　</td>  </tr>  <tr>   <td><strong>第9天</strong></td>   <td><strong>10000</strong></td>   <td>　</td>  </tr>  <tr>   <td><strong>第10天</strong></td>   <td><strong>10000</strong></td>   <td>　</td>  </tr> </tbody></table><p><strong><br></strong></p><p><strong>活动三：十大福利活动等你来</strong></p><p>一、战力竞赛 </p><p>【活动时间】玩家进入游戏7天内 </p><p>【活动内容】活动时间内到达指定战力获丰厚奖励。1天内达到可获赠4星武将“马超“，2天内达到可获赠“突破石”300个，5天内达到可获赠“金币”30万，7天内达到可获赠“赵云碎片”10个。 </p><p>二、征战汉中 </p><p>【活动时间】玩家进入游戏2天内</p><p>【活动内容】全服前100名通关3-3“溃败曹彰”副本即可获得“黄芸碎片”10个。 </p><p>三、征战荆州 </p><p>【活动时间】玩家进入游戏3天内 </p><p>【活动内容】全服前100名通关4-12“逃离荆州”副本即可获得“突破石”200个。 </p><p>四、装备进阶 </p><p>【活动时间】玩家进入游戏3天内 </p><p>【活动内容】全身装备进阶到蓝色获赠“金币”30万。 </p><p>五、宝石闪耀 </p><p>【活动时间】玩家进入游戏4天内 </p><p>【活动内容】活动时间内全身宝石达到2级赠送“随机4级宝石”一个。</p><p>六、宝石精华 </p><p>【活动时间】玩家进入游戏6天内 </p><p>【活动内容】活动时间内全身宝石达到5级赠送“宝石精华”一个，可兑换7级以上宝石。 </p><p>七、战魂之灵 </p><p>【活动时间】玩家进入游戏5天内 </p><p>【活动内容】活动时间内任意获得4个蓝色及以上品质战魂即可获赠 “战魂经验”800点。 </p><p>八、战魂之火 </p><p>【活动时间】玩家进入游戏5天内 </p><p>【活动内容】活动时间内任意获得4个紫色及以上品质战魂即可获赠金色战魂“真龙胆”一个。 </p><p>九、天下第一、决斗之王 </p><p>【活动时间】开服7天内 </p><p>【活动内容】截止开服第7天22点，战力、决斗场排名前100的玩家可获得对应的丰富奖励，包括“战魂经验”、“金色随机战魂”等，快来挑战吧！ </p><p>十、登陆、签到活动 </p><p>【活动时间】公测期间 </p><p>【活动内容】活动时间内每日登陆、签到即可领取对应福利奖励。&nbsp;</p>',NULL,1498186137,0,1),(42,3,'盛夏感恩季系列活动第一期','','春夏秋冬，一年四季轮回，转眼又要到炎热的夏季了。吃吃冰镇西瓜，玩玩《三国战纪》，夫复何求！','<p><strong style=\"background-color: initial;\">活动一：累充送好礼第一轮</strong></p><p><strong></strong></p><p>活动时间：6月30日-7月2日</p><p>活动范围：除新区外所有区服</p><p>活动规则：活动期间内，游戏内进行累积充值即可参加。</p><p>活动奖励：累计充值达到指定要求即可获得升星石、进阶石奖励。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p><strong>活动二：累充送好礼第二轮</strong></p><p>活动时间：7月3日-7月6日</p><p>活动范围：除新区外所有区服</p><p>活动规则：活动期间内，游戏内进行累积充值即可参加。</p><p>活动奖励：累计充值达到指定要求即可获得觉醒丹、金币奖励。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p><strong>活动三：噩梦剑影</strong></p><p>活动时间：6月30日-7月2日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：通关噩梦副本达到指定次数可获得相应觉醒丹奖励。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p><strong>活动四：王者霸业</strong></p><p>活动时间：6月30日-7月2日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：排位赛胜利次数达到指定次数可获得战魂经验的奖励。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p><strong>活动五：折扣商店-饰品主题</strong></p><p>活动时间：6月30日-7月2日</p><p>活动范围：除新服外老服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>领取方式：进入游戏后，点击“活动”打开折扣商店购买超值紫色符石碎片、枭狼任选宝箱等超值道具。</p><p><strong>活动六：金戈铁马</strong><strong></strong></p><p>活动时间：6月30日-7月2日</p><p>活动范围：全区全服</p><p>活动奖励：活动期间内，20级以上的玩家在普通副本中的材料片产出翻倍</p><p><strong>活动七：冲锋陷阵</strong></p><p>活动时间：7月3日-7月6日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：通关普通副本达到指定次数可获得相应进阶石奖励。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。。</p><p><strong>活动八：魂战天下</strong></p><p>活动时间：7月3日-7月6日</p><p>活动范围：全区全服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>活动奖励：战魂觉醒达到指定次数可获得相应金币的奖励。</p><p>领取方式：进入游戏后，点击“活动”打开活动界面进行领取。</p><p><strong>活动九：折扣商店-符文主题</strong></p><p>活动时间：7月3日-7月6日</p><p>活动范围：除新服外老服</p><p>活动规则：活动期间内，20级以上玩家可参加。 </p><p>领取方式：进入游戏后，点击“活动”打开折扣商店购买任选符石碎片、升星石等超值道具。</p><p>备注：</p><p>1、本次活动详细信息请进入游戏进行查询。</p><p>2、本次活动最终解释权归《三国战纪》运营团队所有。</p><p style=\"text-align: right;\">《三国战纪》运营团队</p><p style=\"text-align: right;\">2017年6月29日</p>',NULL,1498715741,0,1);
/*!40000 ALTER TABLE `easyii_article_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_carousel`
--

DROP TABLE IF EXISTS `easyii_carousel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_carousel` (
  `carousel_id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(128) NOT NULL,
  `link` varchar(255) NOT NULL,
  `title` varchar(128) DEFAULT NULL,
  `text` text,
  `order_num` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`carousel_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_carousel`
--

LOCK TABLES `easyii_carousel` WRITE;
/*!40000 ALTER TABLE `easyii_carousel` DISABLE KEYS */;
/*!40000 ALTER TABLE `easyii_carousel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_catalog_categories`
--

DROP TABLE IF EXISTS `easyii_catalog_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_catalog_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `image` varchar(128) DEFAULT NULL,
  `fields` text NOT NULL,
  `slug` varchar(128) DEFAULT NULL,
  `tree` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `depth` int(11) DEFAULT NULL,
  `order_num` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_catalog_categories`
--

LOCK TABLES `easyii_catalog_categories` WRITE;
/*!40000 ALTER TABLE `easyii_catalog_categories` DISABLE KEYS */;
INSERT INTO `easyii_catalog_categories` VALUES (1,'游戏攻略','','[]',NULL,1,1,2,0,1,1);
/*!40000 ALTER TABLE `easyii_catalog_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_catalog_item_data`
--

DROP TABLE IF EXISTS `easyii_catalog_item_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_catalog_item_data` (
  `data_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) DEFAULT NULL,
  `name` varchar(128) NOT NULL,
  `value` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`data_id`),
  KEY `item_id_name` (`item_id`,`name`),
  KEY `value` (`value`(300))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_catalog_item_data`
--

LOCK TABLES `easyii_catalog_item_data` WRITE;
/*!40000 ALTER TABLE `easyii_catalog_item_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `easyii_catalog_item_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_catalog_items`
--

DROP TABLE IF EXISTS `easyii_catalog_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_catalog_items` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(128) NOT NULL,
  `description` text,
  `available` int(11) DEFAULT '1',
  `price` float DEFAULT '0',
  `discount` int(11) DEFAULT '0',
  `data` text NOT NULL,
  `image` varchar(128) DEFAULT NULL,
  `slug` varchar(128) DEFAULT NULL,
  `time` int(11) DEFAULT '0',
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_catalog_items`
--

LOCK TABLES `easyii_catalog_items` WRITE;
/*!40000 ALTER TABLE `easyii_catalog_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `easyii_catalog_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_faq`
--

DROP TABLE IF EXISTS `easyii_faq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_faq` (
  `faq_id` int(11) NOT NULL AUTO_INCREMENT,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `order_num` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`faq_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_faq`
--

LOCK TABLES `easyii_faq` WRITE;
/*!40000 ALTER TABLE `easyii_faq` DISABLE KEYS */;
/*!40000 ALTER TABLE `easyii_faq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_feedback`
--

DROP TABLE IF EXISTS `easyii_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_feedback` (
  `feedback_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `email` varchar(128) NOT NULL,
  `phone` varchar(64) DEFAULT NULL,
  `title` varchar(128) DEFAULT NULL,
  `text` text NOT NULL,
  `answer_subject` varchar(128) DEFAULT NULL,
  `answer_text` text,
  `time` int(11) DEFAULT '0',
  `ip` varchar(16) NOT NULL,
  `status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`feedback_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_feedback`
--

LOCK TABLES `easyii_feedback` WRITE;
/*!40000 ALTER TABLE `easyii_feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `easyii_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_files`
--

DROP TABLE IF EXISTS `easyii_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_files` (
  `file_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `file` varchar(255) NOT NULL,
  `size` int(11) NOT NULL,
  `slug` varchar(128) DEFAULT NULL,
  `downloads` int(11) DEFAULT '0',
  `time` int(11) DEFAULT '0',
  `order_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`file_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_files`
--

LOCK TABLES `easyii_files` WRITE;
/*!40000 ALTER TABLE `easyii_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `easyii_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_gallery_categories`
--

DROP TABLE IF EXISTS `easyii_gallery_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_gallery_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `image` varchar(128) DEFAULT NULL,
  `slug` varchar(128) DEFAULT NULL,
  `tree` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `depth` int(11) DEFAULT NULL,
  `order_num` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_gallery_categories`
--

LOCK TABLES `easyii_gallery_categories` WRITE;
/*!40000 ALTER TABLE `easyii_gallery_categories` DISABLE KEYS */;
INSERT INTO `easyii_gallery_categories` VALUES (3,'pc首页-游戏特色三张banner','','pc-banner',3,1,2,0,2,1),(2,'pc首页-英雄介绍 亮点抢先看 三张图','','pc',2,1,2,0,1,1),(4,'mobile-滚动图','','mobile',4,1,2,0,3,1);
/*!40000 ALTER TABLE `easyii_gallery_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_guestbook`
--

DROP TABLE IF EXISTS `easyii_guestbook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_guestbook` (
  `guestbook_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `title` varchar(128) DEFAULT NULL,
  `text` text NOT NULL,
  `answer` text,
  `email` varchar(128) DEFAULT NULL,
  `time` int(11) DEFAULT '0',
  `ip` varchar(16) NOT NULL,
  `new` tinyint(1) DEFAULT '0',
  `status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`guestbook_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_guestbook`
--

LOCK TABLES `easyii_guestbook` WRITE;
/*!40000 ALTER TABLE `easyii_guestbook` DISABLE KEYS */;
/*!40000 ALTER TABLE `easyii_guestbook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_loginform`
--

DROP TABLE IF EXISTS `easyii_loginform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_loginform` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL,
  `ip` varchar(16) NOT NULL,
  `user_agent` varchar(1024) NOT NULL,
  `time` int(11) DEFAULT '0',
  `success` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`log_id`)
) ENGINE=MyISAM AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_loginform`
--

LOCK TABLES `easyii_loginform` WRITE;
/*!40000 ALTER TABLE `easyii_loginform` DISABLE KEYS */;
INSERT INTO `easyii_loginform` VALUES (1,'root','******','116.226.84.187','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36',1492404932,1),(2,'root','root','116.226.84.187','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36',1492406128,0),(3,'root','admin','116.226.84.187','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36',1492406134,0),(4,'root','root','116.226.84.187','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36',1492406137,0),(5,'root','******','116.226.84.187','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36',1492406187,1),(6,'admin','******','116.226.84.187','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36',1492406211,1),(7,'admin','******','116.226.84.187','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36',1492406247,1),(8,'root','******','116.226.84.187','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36',1492416153,1),(9,'admin','******','116.226.84.187','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36',1492416182,1),(10,'admin','******','116.226.84.187','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36',1492416735,1),(11,'admin','******','116.226.84.187','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36',1492759084,1),(12,'root','******','116.226.84.187','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36',1492759107,1),(13,'admin','******','116.226.84.187','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36',1492760782,1),(14,'admin','******','116.226.84.187','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36',1492761120,1),(15,'root','******','116.226.84.187','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36',1492767061,1),(16,'root','csm_admin','116.226.84.187','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36',1493003795,0),(17,'root','******','116.226.84.187','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36',1493003799,1),(18,'root','******','116.226.84.187','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36',1493351180,1),(19,'root','******','116.226.84.187','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36',1493695488,1),(20,'root','******','116.226.84.187','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36',1493805244,1),(21,'admin','******','116.226.84.187','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36',1493868929,1),(22,'admin','******','180.168.36.210','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/7.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.3; .NET4.0C; .NET4.0E)',1493870233,1),(23,'admin','******','180.168.36.210','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Maxthon/5.0.2.1000 Chrome/47.0.2526.73 Safari/537.36',1493870796,1),(24,'admin','******','223.104.5.194','Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Mobile/14E304 QQ/6.7.1.416 V1_IPH_SQ_6.7.1_1_APP_A Pixel/1080 Core/UIWebView NetType/4G QBWebViewType/1',1493873977,1),(25,'admin','******','180.168.36.210','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/7.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.3; .NET4.0C; .NET4.0E)',1493878599,1),(26,'root','******','116.226.84.187','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36',1494490304,1),(27,'root','******','116.226.179.33','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',1495009562,1),(28,'admin','******','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',1495597390,1),(29,'admin','******','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko',1495598129,1),(30,'admin','******','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Maxthon/5.0.2.1000 Chrome/47.0.2526.73 Safari/537.36',1495598496,1),(31,'admin','******','112.65.46.8','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/7.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.3; .NET4.0C; .NET4.0E)',1495680373,1),(32,'admin','******','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.122 Safari/537.36 SE 2.X MetaSr 1.0',1495680471,1),(33,'admin','******','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',1495694432,1),(34,'admin','******','116.226.179.33','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',1495694992,1),(35,'admin','******','116.226.179.33','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',1495695033,1),(36,'root','cms_root','116.226.179.33','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',1495695063,0),(37,'root','csm_admin','116.226.179.33','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',1495695069,0),(38,'cms_root','admin','116.226.179.33','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',1495695094,0),(39,'root','******','116.226.179.33','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',1495695103,1),(40,'admin','******','116.226.179.33','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',1495695373,1),(41,'root','******','116.226.179.33','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',1495695418,1),(42,'admin','******','116.226.179.33','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',1495695868,1),(43,'admin','******','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',1495696605,1),(44,'admin','******','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',1495696719,1),(45,'jiajianjun','******','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',1495696735,1),(46,'jiajianjun','Jiajianjun6!@#','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',1495696759,0),(47,'admin','******','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',1495696766,1),(48,'admin','******','112.65.46.8','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/7.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.3; .NET4.0C; .NET4.0E)',1495701333,1),(49,'admin','******','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',1495768650,1),(50,'chenzhiyuan','******','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',1496398919,1),(51,'root','******','116.226.84.187','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',1496399165,1),(52,'admin','admin','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Maxthon/5.0.2.1000 Chrome/47.0.2526.73 Safari/537.36',1496726314,0),(53,'chenzhiyuan','11111111','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Maxthon/5.0.2.1000 Chrome/47.0.2526.73 Safari/537.36',1496726321,0),(54,'chenzhiyuan','11111111','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Maxthon/5.0.2.1000 Chrome/47.0.2526.73 Safari/537.36',1496726323,0),(55,'chenzhiyuan','******','112.65.46.8','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/7.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.3; .NET4.0C; .NET4.0E)',1496726559,1),(56,'chenzhiyuan','chenzhiyuan','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Maxthon/5.0.2.1000 Chrome/47.0.2526.73 Safari/537.36',1496726565,0),(57,'chenzhiyuan','chenzhiyuan','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Maxthon/5.0.2.1000 Chrome/47.0.2526.73 Safari/537.36',1496726567,0),(58,'chenzhiyuan','******','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Maxthon/5.0.2.1000 Chrome/47.0.2526.73 Safari/537.36',1496726576,1),(59,'chenzhiyuan','chenzhiyuan','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Maxthon/5.0.2.1000 Chrome/47.0.2526.73 Safari/537.36',1496727201,0),(60,'chenzhiyuan','chenzhiyuan','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Maxthon/5.0.2.1000 Chrome/47.0.2526.73 Safari/537.36',1496727203,0),(61,'chenzhiyuan','chenzhiyuan','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Maxthon/5.0.2.1000 Chrome/47.0.2526.73 Safari/537.36',1496727210,0),(62,'chenzhiyuan','chenzhiyuan','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Maxthon/5.0.2.1000 Chrome/47.0.2526.73 Safari/537.36',1496727212,0),(63,'chenzhiyuan','chenzhiyuan','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Maxthon/5.0.2.1000 Chrome/47.0.2526.73 Safari/537.36',1496727213,0),(64,'chenzhiyuan','chenzhiyuan','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Maxthon/5.0.2.1000 Chrome/47.0.2526.73 Safari/537.36',1496727214,0),(65,'chenzhiyuan','chenzhiyuan','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Maxthon/5.0.2.1000 Chrome/47.0.2526.73 Safari/537.36',1496727828,0),(66,'chenzhiyuan','chenzhiyuan','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Maxthon/5.0.2.1000 Chrome/47.0.2526.73 Safari/537.36',1496728194,0),(67,'chenzhiyuan','******','112.65.46.8','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/7.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.3; .NET4.0C; .NET4.0E)',1496728414,1),(68,'chenzhiyuan','******','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',1496728490,1),(69,'chenzhiyuan','******','112.65.46.8','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/7.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.3; .NET4.0C; .NET4.0E)',1496890365,1),(70,'chenzhiyuan','******','112.65.46.8','Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/7.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.3; .NET4.0C; .NET4.0E)',1496890621,1),(71,'chenzhiyuan','******','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.221 Safari/537.36 SE 2.X MetaSr 1.0',1496890670,1),(72,'admin','123456','116.226.179.33','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',1496909772,0),(73,'admin','admin','116.226.179.33','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',1496909775,0),(74,'admin','admin123456','116.226.179.33','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',1496909788,0),(75,'chenzhiyuan','******','116.226.179.33','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',1496910370,1),(76,'chenzhiyuan','******','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',1497249413,1),(77,'chenzhiyuan','******','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',1497359046,1),(78,'chenzhiyuan','******','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',1497576096,1),(79,'chenzhiyuan','******','116.226.179.33','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',1497593422,1),(80,'chenzhiyuan','******','116.226.179.33','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',1497607192,1),(81,'chenzhiyuan','******','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',1497854395,1),(82,'chenzhiyuan',' chenzhiyuan123456','116.226.116.47','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',1497867972,0),(83,'chenzhiyuan','******','116.226.116.47','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',1497867976,1),(84,'chenzhiyuan','******','116.226.84.187','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',1498102112,1),(85,'chenzhiyuan','chenzhiyuan12345+6','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Maxthon/5.0.2.1000 Chrome/47.0.2526.73 Safari/537.36',1498119748,0),(86,'chenzhiyuan','******','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Maxthon/5.0.2.1000 Chrome/47.0.2526.73 Safari/537.36',1498119756,1),(87,'chenzhiyuan','******','180.168.62.234','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36',1498275703,1),(88,'chenzhiyuan','******','112.65.46.8','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Maxthon/5.0.2.1000 Chrome/47.0.2526.73 Safari/537.36',1498713947,1);
/*!40000 ALTER TABLE `easyii_loginform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_migration`
--

DROP TABLE IF EXISTS `easyii_migration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_migration` (
  `version` varchar(180) COLLATE utf8_bin NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_migration`
--

LOCK TABLES `easyii_migration` WRITE;
/*!40000 ALTER TABLE `easyii_migration` DISABLE KEYS */;
INSERT INTO `easyii_migration` VALUES ('m000000_000000_base',1492404931),('m000000_000000_install',1492404931);
/*!40000 ALTER TABLE `easyii_migration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_modules`
--

DROP TABLE IF EXISTS `easyii_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_modules` (
  `module_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `class` varchar(128) NOT NULL,
  `title` varchar(128) NOT NULL,
  `icon` varchar(32) NOT NULL,
  `settings` text NOT NULL,
  `notice` int(11) DEFAULT '0',
  `order_num` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`module_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_modules`
--

LOCK TABLES `easyii_modules` WRITE;
/*!40000 ALTER TABLE `easyii_modules` DISABLE KEYS */;
INSERT INTO `easyii_modules` VALUES (1,'article','yii\\easyii\\modules\\article\\ArticleModule','Articles','pencil','{\"categoryThumb\":true,\"articleThumb\":true,\"enablePhotos\":true,\"enableShort\":true,\"shortMaxLength\":255,\"enableTags\":true,\"itemsInFolder\":false}',0,65,1),(2,'carousel','yii\\easyii\\modules\\carousel\\CarouselModule','Carousel','picture','{\"enableTitle\":true,\"enableText\":true}',0,40,0),(3,'catalog','yii\\easyii\\modules\\catalog\\CatalogModule','Catalog','list-alt','{\"categoryThumb\":true,\"itemsInFolder\":false,\"itemThumb\":true,\"itemPhotos\":true,\"itemDescription\":true,\"itemSale\":true}',0,100,0),(4,'faq','yii\\easyii\\modules\\faq\\FaqModule','FAQ','question-sign','[]',0,45,0),(5,'feedback','yii\\easyii\\modules\\feedback\\FeedbackModule','Feedback','earphone','{\"mailAdminOnNewFeedback\":true,\"subjectOnNewFeedback\":\"New feedback\",\"templateOnNewFeedback\":\"@easyii\\/modules\\/feedback\\/mail\\/en\\/new_feedback\",\"answerTemplate\":\"@easyii\\/modules\\/feedback\\/mail\\/en\\/answer\",\"answerSubject\":\"Answer on your feedback message\",\"answerHeader\":\"Hello,\",\"answerFooter\":\"Best regards.\",\"enableTitle\":false,\"enablePhone\":true,\"enableCaptcha\":false}',0,60,0),(6,'file','yii\\easyii\\modules\\file\\FileModule','Files','floppy-disk','[]',0,30,0),(7,'gallery','yii\\easyii\\modules\\gallery\\GalleryModule','Photo Gallery','camera','{\"categoryThumb\":true,\"itemsInFolder\":false}',0,90,1),(8,'guestbook','yii\\easyii\\modules\\guestbook\\GuestbookModule','Guestbook','book','{\"enableTitle\":false,\"enableEmail\":true,\"preModerate\":false,\"enableCaptcha\":false,\"mailAdminOnNewPost\":true,\"subjectOnNewPost\":\"New message in the guestbook.\",\"templateOnNewPost\":\"@easyii\\/modules\\/guestbook\\/mail\\/en\\/new_post\",\"frontendGuestbookRoute\":\"\\/guestbook\",\"subjectNotifyUser\":\"Your post in the guestbook answered\",\"templateNotifyUser\":\"@easyii\\/modules\\/guestbook\\/mail\\/en\\/notify_user\"}',0,80,0),(9,'news','yii\\easyii\\modules\\news\\NewsModule','News','bullhorn','{\"enableThumb\":true,\"enablePhotos\":true,\"enableShort\":true,\"shortMaxLength\":256,\"enableTags\":true}',0,70,0),(10,'page','yii\\easyii\\modules\\page\\PageModule','Pages','file','[]',0,50,0),(11,'shopcart','yii\\easyii\\modules\\shopcart\\ShopcartModule','Orders','shopping-cart','{\"mailAdminOnNewOrder\":true,\"subjectOnNewOrder\":\"New order\",\"templateOnNewOrder\":\"@easyii\\/modules\\/shopcart\\/mail\\/en\\/new_order\",\"subjectNotifyUser\":\"Your order status changed\",\"templateNotifyUser\":\"@easyii\\/modules\\/shopcart\\/mail\\/en\\/notify_user\",\"frontendShopcartRoute\":\"\\/shopcart\\/order\",\"enablePhone\":true,\"enableEmail\":true}',0,120,0),(12,'subscribe','yii\\easyii\\modules\\subscribe\\SubscribeModule','E-mail subscribe','envelope','[]',0,10,0),(13,'text','yii\\easyii\\modules\\text\\TextModule','Text blocks','font','[]',0,20,0),(14,'hero','app\\modules\\hero\\HeroModule','hero','pencil','{\"categoryThumb\":true,\"articleThumb\":true,\"enablePhotos\":true,\"enableShort\":true,\"shortMaxLength\":\"255\",\"enableTags\":true,\"itemsInFolder\":false}',0,121,1);
/*!40000 ALTER TABLE `easyii_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_news`
--

DROP TABLE IF EXISTS `easyii_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_news` (
  `news_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `image` varchar(128) DEFAULT NULL,
  `short` varchar(1024) DEFAULT NULL,
  `text` text NOT NULL,
  `slug` varchar(128) DEFAULT NULL,
  `time` int(11) DEFAULT '0',
  `views` int(11) DEFAULT '0',
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`news_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_news`
--

LOCK TABLES `easyii_news` WRITE;
/*!40000 ALTER TABLE `easyii_news` DISABLE KEYS */;
/*!40000 ALTER TABLE `easyii_news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_pages`
--

DROP TABLE IF EXISTS `easyii_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_pages` (
  `page_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `text` text NOT NULL,
  `slug` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`page_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_pages`
--

LOCK TABLES `easyii_pages` WRITE;
/*!40000 ALTER TABLE `easyii_pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `easyii_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_photos`
--

DROP TABLE IF EXISTS `easyii_photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_photos` (
  `photo_id` int(11) NOT NULL AUTO_INCREMENT,
  `class` varchar(128) NOT NULL,
  `item_id` int(11) NOT NULL,
  `image` varchar(128) NOT NULL,
  `description` varchar(1024) NOT NULL,
  `order_num` int(11) NOT NULL,
  PRIMARY KEY (`photo_id`),
  KEY `model_item` (`class`,`item_id`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_photos`
--

LOCK TABLES `easyii_photos` WRITE;
/*!40000 ALTER TABLE `easyii_photos` DISABLE KEYS */;
INSERT INTO `easyii_photos` VALUES (21,'yii\\easyii\\modules\\gallery\\models\\Category',2,'/uploads/photos/330-230-b8538271e9.jpg','周年庆典，加码了！！！|/site/article/39',18),(19,'yii\\easyii\\modules\\gallery\\models\\Category',2,'/uploads/photos/330-230-f5d05d49b1.jpg','周年庆典，错过 再等一年|/site/article/37',16),(31,'yii\\easyii\\modules\\gallery\\models\\Category',3,'/uploads/photos/1-4948379f71.jpg','',29),(16,'yii\\easyii\\modules\\gallery\\models\\Category',2,'/uploads/photos/330-230-1d873c52a3.jpg','/site/hero/22',13),(20,'yii\\easyii\\modules\\gallery\\models\\Category',2,'/uploads/photos/330-230-bcb0a5ead4.jpg','周年庆典，私人订制|/site/article/38',17),(32,'yii\\easyii\\modules\\gallery\\models\\Category',3,'/uploads/photos/2-f196ccccdf.jpg','',30),(33,'yii\\easyii\\modules\\gallery\\models\\Category',3,'/uploads/photos/3-8264318b0e.jpg','',28),(34,'yii\\easyii\\modules\\gallery\\models\\Category',4,'/uploads/photos/640-420-fbebf375ed.jpg','/mobile/article/42',31),(35,'yii\\easyii\\modules\\gallery\\models\\Category',2,'/uploads/photos/330-230-5050d65667.jpg','盛夏感恩季系列活动第一期|/site/article/42',32),(28,'yii\\easyii\\modules\\gallery\\models\\Category',4,'/uploads/photos/640-420-1-5327fd7b6c.jpg','/mobilearticle/37',25),(29,'yii\\easyii\\modules\\gallery\\models\\Category',4,'/uploads/photos/640-420-1b64b42687.jpg','/mobile/article/38',26),(30,'yii\\easyii\\modules\\gallery\\models\\Category',4,'/uploads/photos/640-420-206d00696f.jpg','/mobile/article/41',27);
/*!40000 ALTER TABLE `easyii_photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_seotext`
--

DROP TABLE IF EXISTS `easyii_seotext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_seotext` (
  `seotext_id` int(11) NOT NULL AUTO_INCREMENT,
  `class` varchar(128) NOT NULL,
  `item_id` int(11) NOT NULL,
  `h1` varchar(128) DEFAULT NULL,
  `title` varchar(128) DEFAULT NULL,
  `keywords` varchar(128) DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`seotext_id`),
  UNIQUE KEY `model_item` (`class`,`item_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_seotext`
--

LOCK TABLES `easyii_seotext` WRITE;
/*!40000 ALTER TABLE `easyii_seotext` DISABLE KEYS */;
/*!40000 ALTER TABLE `easyii_seotext` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_settings`
--

DROP TABLE IF EXISTS `easyii_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_settings` (
  `setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `title` varchar(128) NOT NULL,
  `value` varchar(1024) NOT NULL,
  `visibility` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`setting_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_settings`
--

LOCK TABLES `easyii_settings` WRITE;
/*!40000 ALTER TABLE `easyii_settings` DISABLE KEYS */;
INSERT INTO `easyii_settings` VALUES (1,'easyii_version','EasyiiCMS version','0.9',0),(2,'recaptcha_key','ReCaptcha key','',1),(3,'password_salt','Password salt','sHyZxS8nvziMQJl4IYOQw6SkotNDhxyw',0),(4,'root_auth_key','Root authorization key','IzVdRN4pj8mHyGBoNk9igWwQmmzmTDMn',0),(5,'root_password','Root password','74ac32d6d53b67280d84d547ba8e0b28fefb3a2d',1),(6,'auth_time','Auth time','86400',1),(7,'robot_email','Robot E-mail','cms@cms.com',1),(8,'admin_email','Admin E-mail','cms@cms.com',2),(9,'recaptcha_secret','ReCaptcha secret','',1),(10,'toolbar_position','Frontend toolbar position (\"top\" or \"bottom\")','top',1);
/*!40000 ALTER TABLE `easyii_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_shopcart_goods`
--

DROP TABLE IF EXISTS `easyii_shopcart_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_shopcart_goods` (
  `good_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `options` varchar(255) NOT NULL,
  `price` float DEFAULT '0',
  `discount` int(11) DEFAULT '0',
  PRIMARY KEY (`good_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_shopcart_goods`
--

LOCK TABLES `easyii_shopcart_goods` WRITE;
/*!40000 ALTER TABLE `easyii_shopcart_goods` DISABLE KEYS */;
/*!40000 ALTER TABLE `easyii_shopcart_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_shopcart_orders`
--

DROP TABLE IF EXISTS `easyii_shopcart_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_shopcart_orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone` varchar(64) NOT NULL,
  `email` varchar(128) NOT NULL,
  `comment` varchar(1024) NOT NULL,
  `remark` varchar(1024) NOT NULL,
  `access_token` varchar(32) NOT NULL,
  `ip` varchar(16) NOT NULL,
  `time` int(11) DEFAULT '0',
  `new` tinyint(1) DEFAULT '0',
  `status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`order_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_shopcart_orders`
--

LOCK TABLES `easyii_shopcart_orders` WRITE;
/*!40000 ALTER TABLE `easyii_shopcart_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `easyii_shopcart_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_subscribe_history`
--

DROP TABLE IF EXISTS `easyii_subscribe_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_subscribe_history` (
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(128) NOT NULL,
  `body` text NOT NULL,
  `sent` int(11) DEFAULT '0',
  `time` int(11) DEFAULT '0',
  PRIMARY KEY (`history_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_subscribe_history`
--

LOCK TABLES `easyii_subscribe_history` WRITE;
/*!40000 ALTER TABLE `easyii_subscribe_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `easyii_subscribe_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_subscribe_subscribers`
--

DROP TABLE IF EXISTS `easyii_subscribe_subscribers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_subscribe_subscribers` (
  `subscriber_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(128) NOT NULL,
  `ip` varchar(16) NOT NULL,
  `time` int(11) DEFAULT '0',
  PRIMARY KEY (`subscriber_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_subscribe_subscribers`
--

LOCK TABLES `easyii_subscribe_subscribers` WRITE;
/*!40000 ALTER TABLE `easyii_subscribe_subscribers` DISABLE KEYS */;
/*!40000 ALTER TABLE `easyii_subscribe_subscribers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_tags`
--

DROP TABLE IF EXISTS `easyii_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_tags` (
  `tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `frequency` int(11) DEFAULT '0',
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_tags`
--

LOCK TABLES `easyii_tags` WRITE;
/*!40000 ALTER TABLE `easyii_tags` DISABLE KEYS */;
INSERT INTO `easyii_tags` VALUES (2,'新闻-三国战纪-官方网站-欢动游戏-官方正版格斗手游',2),(3,'公告-三国战纪-官方网站-欢动游戏-官方正版格斗手游',2),(4,'活动-三国战纪-官方网站-欢动游戏-官方正版格斗手游',2);
/*!40000 ALTER TABLE `easyii_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_tags_assign`
--

DROP TABLE IF EXISTS `easyii_tags_assign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_tags_assign` (
  `class` varchar(128) NOT NULL,
  `item_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  KEY `class` (`class`),
  KEY `item_tag` (`item_id`,`tag_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_tags_assign`
--

LOCK TABLES `easyii_tags_assign` WRITE;
/*!40000 ALTER TABLE `easyii_tags_assign` DISABLE KEYS */;
INSERT INTO `easyii_tags_assign` VALUES ('yii\\easyii\\modules\\article\\models\\Item',15,2),('yii\\easyii\\modules\\article\\models\\Item',14,2),('yii\\easyii\\modules\\article\\models\\Item',17,3),('yii\\easyii\\modules\\article\\models\\Item',16,3),('yii\\easyii\\modules\\article\\models\\Item',19,4),('yii\\easyii\\modules\\article\\models\\Item',18,4);
/*!40000 ALTER TABLE `easyii_tags_assign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easyii_texts`
--

DROP TABLE IF EXISTS `easyii_texts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easyii_texts` (
  `text_id` int(11) NOT NULL AUTO_INCREMENT,
  `text` text NOT NULL,
  `slug` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`text_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easyii_texts`
--

LOCK TABLES `easyii_texts` WRITE;
/*!40000 ALTER TABLE `easyii_texts` DISABLE KEYS */;
/*!40000 ALTER TABLE `easyii_texts` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-30 18:36:10
