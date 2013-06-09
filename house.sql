
CREATE TABLE `province` (
  `id` int(11) NOT NULL auto_increment,
  `provinceid` varchar(100) NOT NULL default '',
  `provincename` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `idx_province_provinceid` (`provinceid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
insert into province values(1,1,'����');

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
insert into city values(1,1,'����','1','����');
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
insert into region values(1,1,'����','1','����','1','����');
insert into region values(2,1,'����','1','����','2','����');
insert into region values(3,1,'����','1','����','3','����');
insert into region values(4,1,'����','1','����','4','����');
insert into region values(5,1,'����','1','����','5','����');
insert into region values(6,1,'����','1','����','6','��̨');
insert into region values(7,1,'����','1','����','7','ʯ��ɽ');
insert into region values(8,1,'����','1','����','8','����');
insert into region values(9,1,'����','1','����','9','��ͷ��');
insert into region values(10,1,'����','1','����','10','��ɽ');
insert into region values(11,1,'����','1','����','11','ͨ��');
insert into region values(12,1,'����','1','����','12','˳��');
insert into region values(13,1,'����','1','����','13','��ƽ');
insert into region values(14,1,'����','1','����','14','����');
insert into region values(15,1,'����','1','����','15','ƽ��');
insert into region values(16,1,'����','1','����','16','����');
insert into region values(17,1,'����','1','����','17','����');
insert into region values(18,1,'����','1','����','18','����');

/*
*��Դ��Ϣ����Ҫ�Ƿ����ķ�Դ��Ϣ
*/
CREATE TABLE `house_info` (
  `house_id` bigint(20) NOT NULL auto_increment,
  `user_id` bigint(20) NOT NULL  COMMENT '�û�id',
  `title` varchar(256) NOT NULL default '' COMMENT '����',
  `purpose` int(4) NOT NULL default '1' COMMENT 'rent_in:1;rent_out:2',
  `house_type` int(4) NOT NULL default '0' COMMENT '111:һ��һ��һ����311:����һ��һ��...',
  `price` int(4) NOT NULL default '0' ,
  `area` int(4) NOT NULL default '0' COMMENT '���',
  `flor_info` int(4) NOT NULL default '0' COMMENT '100010 ǰ��λ��ʾ��߲㣬����λ��ʾ��ǰ����',
  `remark` varchar(1024) NOT NULL default '' COMMENT '�û���ע����',
  `detail_description` text NOT NULL  COMMENT '��ϸ��������������Ʒ����ҳ',
  `region` int(4) NOT NULL default '1' COMMENT '�û����ַ���������������',
  `address_info` varchar(512) NOT NULL default '' COMMENT '��ϸ��ַ',
  `contact_person` varchar(256) NOT NULL default '' COMMENT '��ϵ������',
  `contact_phone` varchar(50) NOT NULL default '' COMMENT '��ϵ�˵绰',
  `contact_qq` varchar(50) NOT NULL default '' COMMENT '��ϵ��qq',
  `contact_weixin` varchar(50) NOT NULL default '' COMMENT '��ϵ��weixin',
  `contact_email` varchar(50) NOT NULL default '' COMMENT '��ϵ��email',
  `decoration` varchar(512) NOT NULL default '' COMMENT 'װ�����',
  `furniture` varchar(512) NOT NULL default '' COMMENT '�Ҿߣ��ҵ��������',
  `build_year` varchar(50) NOT NULL default '' COMMENT '�������',
  `request` varchar(512) NOT NULL default '' COMMENT '�ԶԷ���Ҫ��',
  `input_time` int(11) unsigned NOT NULL default '0' COMMENT '¼��ʱ��',
  `attention_count` int(11) unsigned NOT NULL default '0' COMMENT '��ע����',
  PRIMARY KEY  (`house_id`),
  KEY `idx_house` (`house_id`),
  KEY `idx_inputtime` (`input_time`),
  KEY `idx_house_userid` (`house_id`,`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/*
*��Դ�����  ��¼�û����뷿Դ��
*/
CREATE TABLE `apply_house` (
  `apply_id` bigint(20) NOT NULL auto_increment,
  `user_id` bigint(20) NOT NULL  COMMENT '�û�id',
  `house_id` bigint(20 NOT NULL  COMMENT '����id',
  `input_time` int(11) unsigned NOT NULL default '0' COMMENT '¼��ʱ��',
  `status` int(4) NOT NULL default '1' COMMENT '1��applying��2��cancel��3��finish',
  PRIMARY KEY  (`apply_id`),
  KEY `idx_apply_userid` (`apply_id`,`user_id`),
  KEY `idx_apply_house_userid` (`apply_id`,`user_id`,`house_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/*
*��Դ��ע��  ��¼��Դ����ע�ļ�¼
*/
CREATE TABLE `apply_house` (
  `attention_id` bigint(20) NOT NULL auto_increment,
  `user_id` bigint(20) NOT NULL  COMMENT '�û�id',
  `house_id` bigint(20 NOT NULL  COMMENT '����id',
  `input_time` int(11) unsigned NOT NULL default '0' COMMENT '¼��ʱ��',
  PRIMARY KEY  (`attention_id`),
  KEY `idx_apply_userid` (`attention_id`,`user_id`),
  KEY `idx_apply_house_userid` (`attention_id`,`user_id`,`house_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;




