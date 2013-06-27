/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50155
Source Host           : localhost:3306
Source Database       : house_rent

Target Server Type    : MYSQL
Target Server Version : 50155
File Encoding         : 65001

Date: 2013-05-22 00:21:02
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `activateCode` varchar(255) DEFAULT NULL,
  `codeEffectTime` datetime DEFAULT NULL,
  `activeTime` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT '0' COMMENT '用户默认状态为0，激活状态为1',
  `createTime` datetime DEFAULT NULL,
  `invitor` bigint(20) DEFAULT NULL,
  `realName` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `identifyNum` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO user VALUES ('56', 'xiaozhujun', 'e10adc3949ba59abbe56e057f20f883e', '346012526@qq.com', null, null, '2013-05-13 09:02:58', '1', '2013-05-13 01:45:44', null, null, '18211177261', null);

-- ----------------------------
-- Table structure for `user_invitation_code`
-- ----------------------------
DROP TABLE IF EXISTS `user_invitation_code`;
CREATE TABLE `user_invitation_code` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL,
  `invitationCode` varchar(255) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `codeEffectTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_invitation_code
-- ----------------------------
INSERT INTO user_invitation_code VALUES ('1', '56', 'a75ad313aa9fe8754974a8ddceb7a9d8', '2013-05-14 11:15:34', '2013-05-17 11:15:34');
INSERT INTO user_invitation_code VALUES ('2', null, 'f9a5095311a518c88ae14a1c394a828e', '2013-05-14 11:17:20', '2013-05-17 11:17:20');
INSERT INTO user_invitation_code VALUES ('3', null, '2ea76b5b73c50642099b594c6d0d83aa', '2013-05-14 11:19:19', '2013-05-17 11:19:19');
INSERT INTO user_invitation_code VALUES ('4', null, 'ddba00b6255a95ece07fd7e0261de792', '2013-05-14 11:21:50', '2013-05-17 11:21:50');
INSERT INTO user_invitation_code VALUES ('5', '56', '559f5db94baa13b51ef8a623c72065ad', '2013-05-14 11:23:13', '2013-05-17 11:23:13');
INSERT INTO user_invitation_code VALUES ('6', '56', '235cc069f144a37fda0d4333f7277793', '2013-05-19 16:41:56', '2013-05-22 16:41:56');

DROP TABLE IF EXISTS `friend_apply`;
CREATE TABLE `friend_apply` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `fromUser` bigint(20) DEFAULT NULL,
  `toUser` bigint(20) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `authInfo` varchar(255) DEFAULT NULL,
  `replyInfo` varchar(255) DEFAULT NULL,
  `fromRealName` varchar(255) DEFAULT NULL,
  `toRealName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `friend`
-- ----------------------------
DROP TABLE IF EXISTS `friend`;
CREATE TABLE `friend` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `fromUser` bigint(20) DEFAULT NULL,
  `toUser` bigint(20) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;


CREATE TABLE `college` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

CREATE TABLE `company` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

CREATE TABLE `target_house` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

CREATE TABLE `user_college` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL,
  `collegeId` bigint(20) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE `user_company` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL,
  `companyId` bigint(20) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `user_target_house` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL,
  `targetHouseId` bigint(20) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE `house_view` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL,
  `houseInfoId` bigint(20) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  `count` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8；




