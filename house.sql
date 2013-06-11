
CREATE TABLE `province` (
  `id` int(11) NOT NULL auto_increment,
  `provinceid` varchar(100) NOT NULL default '',
  `provincename` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `idx_province_provinceid` (`provinceid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
insert into province values(1,1,'北京');

CREATE TABLE `city` (
  `id` int(11) NOT NULL auto_increment,
  `provinceid` varchar(100) NOT NULL default '',
  `provincename` varchar(255) NOT NULL default '',
  `cityid` varchar(100) NOT NULL default '',
  `cityname` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `idx_city_cityid` (`cityid`),
  KEY `idx_city_pidctid` (`provinceid`,`cityid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
insert into city values(1,1,'北京','1','北京');
CREATE TABLE `region` (
  `id` int(11) NOT NULL auto_increment,
  `provinceid` varchar(100) NOT NULL default '',
  `provincename` varchar(255) NOT NULL default '',
  `cityid` varchar(100) NOT NULL default '',
  `cityname` varchar(255) NOT NULL default '',
  `areaid` varchar(100) NOT NULL default '',
  `areaname` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `idx_city_cityid` (`cityid`),
  KEY `idx_city_pidctid` (`provinceid`,`cityid`),
  KEY `idx_city_areaid` (`provinceid`,`cityid`,`areaid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
insert into region values(1,1,'北京','1','北京','1','东城');
insert into region values(2,1,'北京','1','北京','2','西城');
insert into region values(3,1,'北京','1','北京','3','崇文');
insert into region values(4,1,'北京','1','北京','4','宣武');
insert into region values(5,1,'北京','1','北京','5','朝阳');
insert into region values(6,1,'北京','1','北京','6','丰台');
insert into region values(7,1,'北京','1','北京','7','石景山');
insert into region values(8,1,'北京','1','北京','8','海淀');
insert into region values(9,1,'北京','1','北京','9','门头沟');
insert into region values(10,1,'北京','1','北京','10','房山');
insert into region values(11,1,'北京','1','北京','11','通州');
insert into region values(12,1,'北京','1','北京','12','顺义');
insert into region values(13,1,'北京','1','北京','13','昌平');
insert into region values(14,1,'北京','1','北京','14','大兴');
insert into region values(15,1,'北京','1','北京','15','平谷');
insert into region values(16,1,'北京','1','北京','16','怀柔');
insert into region values(17,1,'北京','1','北京','17','密云');
insert into region values(18,1,'北京','1','北京','18','延庆');

/*
*房源信息表，主要是发布的房源信息
*/
CREATE TABLE `house_info` (
  `house_id` bigint(20) NOT NULL auto_increment,
  `user_id` bigint(20) NOT NULL  COMMENT '用户id',
  `title` varchar(256) NOT NULL default '' COMMENT '标题',
  `purpose` int(4) NOT NULL default '1' COMMENT 'rent_in:1;rent_out:2',
  `house_type` int(4) NOT NULL default '0' COMMENT '111:一室一厅一卫；311:三室一厅一卫...',
  `price` int(4) NOT NULL default '0' ,
  `area` int(4) NOT NULL default '0' COMMENT '面积',
  `flor_info` int(4) NOT NULL default '0' COMMENT '100010 前三位表示最高层，后三位表示当前层数',
  `remark` varchar(1024) NOT NULL default '' COMMENT '用户备注描述',
  `detail_description` text NOT NULL  COMMENT '详细描述，类似与物品详情页',
  `region` int(4) NOT NULL default '1' COMMENT '用户大地址，到城市下面的区',
  `address_info` varchar(512) NOT NULL default '' COMMENT '详细地址',
  `contact_person` varchar(256) NOT NULL default '' COMMENT '联系人姓名',
  `contact_phone` varchar(50) NOT NULL default '' COMMENT '联系人电话',
  `contact_qq` varchar(50) NOT NULL default '' COMMENT '联系人qq',
  `contact_weixin` varchar(50) NOT NULL default '' COMMENT '联系人weixin',
  `contact_email` varchar(50) NOT NULL default '' COMMENT '联系人email',
  `decoration` varchar(512) NOT NULL default '' COMMENT '装修情况',
  `furniture` varchar(512) NOT NULL default '' COMMENT '家具，家电配置情况',
  `build_year` varchar(50) NOT NULL default '' COMMENT '房子年份',
  `request` varchar(512) NOT NULL default '' COMMENT '对对方的要求',
  `input_time` int(11) unsigned NOT NULL default '0' COMMENT '录入时间',
  `attention_count` int(11) unsigned NOT NULL default '0' COMMENT '关注数量',
  PRIMARY KEY  (`house_id`),
  KEY `idx_house` (`house_id`),
  KEY `idx_inputtime` (`input_time`),
  KEY `idx_house_userid` (`house_id`,`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/*
*房源申请表  记录用户申请房源表
*/
CREATE TABLE `apply_house` (
  `apply_id` bigint(20) NOT NULL auto_increment,
  `user_id` bigint(20) NOT NULL  COMMENT '用户id',
  `house_id` bigint(20 NOT NULL  COMMENT '房子id',
  `input_time` int(11) unsigned NOT NULL default '0' COMMENT '录入时间',
  `status` int(4) NOT NULL default '1' COMMENT '1：applying，2：cancel，3：finish',
  PRIMARY KEY  (`apply_id`),
  KEY `idx_apply_userid` (`apply_id`,`user_id`),
  KEY `idx_apply_house_userid` (`apply_id`,`user_id`,`house_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/*
*房源关注表  记录房源被关注的记录
*/
CREATE TABLE `apply_house` (
  `attention_id` bigint(20) NOT NULL auto_increment,
  `user_id` bigint(20) NOT NULL  COMMENT '用户id',
  `house_id` bigint(20 NOT NULL  COMMENT '房子id',
  `input_time` int(11) unsigned NOT NULL default '0' COMMENT '录入时间',
  PRIMARY KEY  (`attention_id`),
  KEY `idx_apply_userid` (`attention_id`,`user_id`),
  KEY `idx_apply_house_userid` (`attention_id`,`user_id`,`house_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


xiaozhujun/xiao654321

