CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `depth` int(11) DEFAULT NULL,
  `drugs_count` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_lr` (`lft`,`rgt`),
  KEY `index_parent` (`parent_id`),
  KEY `index_plr` (`parent_id`,`lft`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8;

CREATE TABLE `chengfens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `meta` text,
  `shouzi` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_chengfens_on_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1365 DEFAULT CHARSET=utf8;

CREATE TABLE `chengfens_drugs` (
  `chengfen_id` int(11) DEFAULT NULL,
  `drug_id` int(11) DEFAULT NULL,
  KEY `index_chengfens_drugs_on_chengfen_id_and_drug_id` (`chengfen_id`,`drug_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `cities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `province_id` int(11) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `zip_code` varchar(255) DEFAULT NULL,
  `name_en` varchar(255) DEFAULT NULL,
  `name_abbr` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `companies_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_cities_on_name` (`name`),
  KEY `index_cities_on_province_id` (`province_id`),
  KEY `index_cities_on_level` (`level`),
  KEY `index_cities_on_zip_code` (`zip_code`),
  KEY `index_cities_on_name_en` (`name_en`),
  KEY `index_cities_on_name_abbr` (`name_abbr`)
) ENGINE=InnoDB AUTO_INCREMENT=352 DEFAULT CHARSET=utf8;

CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `commentable_id` int(11) DEFAULT '0',
  `commentable_type` varchar(255) DEFAULT '',
  `title` varchar(255) DEFAULT '',
  `body` text,
  `subject` varchar(255) DEFAULT '',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `parent_id` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `author_name` varchar(255) DEFAULT NULL,
  `author_ip` varchar(255) DEFAULT NULL,
  `author_email` varchar(255) DEFAULT NULL,
  `approved` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_comments_on_user_id` (`user_id`),
  KEY `index_comments_on_approved` (`approved`),
  KEY `index_comments_on_parent_id` (`parent_id`),
  KEY `index_comments_on_created_at` (`created_at`),
  KEY `approved_created_at` (`approved`,`created_at`),
  KEY `commentable` (`commentable_id`,`commentable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=366 DEFAULT CHARSET=utf8;

CREATE TABLE `companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `oid` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `sn` varchar(255) DEFAULT NULL,
  `capital` varchar(255) DEFAULT NULL,
  `postal` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `scopes` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `pinyin` varchar(255) DEFAULT NULL,
  `abbr` varchar(255) DEFAULT NULL,
  `short` varchar(255) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `stores_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_companies_on_slug` (`slug`),
  KEY `index_companies_on_city_id` (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8;

CREATE TABLE `delayed_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `priority` int(11) DEFAULT '0',
  `attempts` int(11) DEFAULT '0',
  `handler` text,
  `last_error` text,
  `run_at` datetime DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `locked_by` varchar(255) DEFAULT NULL,
  `queue` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `delayed_jobs_priority` (`priority`,`run_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `districts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `name_en` varchar(255) DEFAULT NULL,
  `name_abbr` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_districts_on_name` (`name`),
  KEY `index_districts_on_city_id` (`city_id`),
  KEY `index_districts_on_name_en` (`name_en`),
  KEY `index_districts_on_name_abbr` (`name_abbr`)
) ENGINE=InnoDB AUTO_INCREMENT=2863 DEFAULT CHARSET=utf8;

CREATE TABLE `drugs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `en` varchar(255) DEFAULT NULL,
  `abbr` varchar(255) DEFAULT NULL,
  `abbr2` varchar(255) DEFAULT NULL,
  `yaopins_count` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `shuoming` text,
  `has_shuoming` tinyint(1) DEFAULT NULL,
  `meta` text,
  `description` varchar(255) DEFAULT NULL,
  `shouzi` varchar(255) DEFAULT NULL,
  `items_count` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_drugs_on_name` (`name`),
  KEY `index_drug_category` (`category_id`),
  KEY `index_yaopins_count` (`yaopins_count`)
) ENGINE=InnoDB AUTO_INCREMENT=19492 DEFAULT CHARSET=utf8;

CREATE TABLE `entries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `yaopin_id` int(11) DEFAULT NULL,
  `chengfen` varchar(255) DEFAULT NULL,
  `yongfa` varchar(255) DEFAULT NULL,
  `zhuzhi` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `guige` varchar(255) DEFAULT NULL,
  `changjia_name` varchar(255) DEFAULT NULL,
  `pihao` varchar(255) DEFAULT NULL,
  `tags_input` varchar(255) DEFAULT NULL,
  `description` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `views` int(11) DEFAULT '0',
  `contact` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_entries_on_yaopin_id` (`yaopin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

CREATE TABLE `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `price` decimal(6,2) DEFAULT NULL,
  `yaopin_id` int(11) DEFAULT NULL,
  `scope` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_items_on_yaopin_id` (`yaopin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11721 DEFAULT CHARSET=utf8;

CREATE TABLE `ji_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jibing_id` int(11) DEFAULT NULL,
  `drug_id` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT '1',
  `likes` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_ji_items_on_jibing_id` (`jibing_id`),
  KEY `index_ji_items_on_drug_id` (`drug_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4361 DEFAULT CHARSET=utf8;

CREATE TABLE `jibings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `items_count` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1441 DEFAULT CHARSET=utf8;

CREATE TABLE `links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `published` tinyint(1) DEFAULT '1',
  `priority` int(11) DEFAULT '5',
  `context` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `inhome` tinyint(1) DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `nofollow` tinyint(1) DEFAULT '0',
  `favicon_type` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `data` text,
  `autoload` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

CREATE TABLE `page_views` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `viewable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `viewable_id` int(11) DEFAULT NULL,
  `user_agent` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `referer` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `visitor_hash` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=674549 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `publish` tinyint(1) DEFAULT NULL,
  `laiyuan` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `laiyuan_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `author` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `excerpt` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `keywords` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `seo_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_posts_on_publish` (`publish`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `provinces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `name_en` varchar(255) DEFAULT NULL,
  `name_abbr` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_provinces_on_name` (`name`),
  KEY `index_provinces_on_name_en` (`name_en`),
  KEY `index_provinces_on_name_abbr` (`name_abbr`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

CREATE TABLE `rails_admin_histories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text COLLATE utf8_unicode_ci,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `item` int(11) DEFAULT NULL,
  `table` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `month` smallint(6) DEFAULT NULL,
  `year` bigint(20) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_rails_admin_histories` (`item`,`table`,`month`,`year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `resource_id` int(11) DEFAULT NULL,
  `resource_type` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_roles_on_name` (`name`),
  KEY `index_roles_on_name_and_resource_type_and_resource_id` (`name`,`resource_type`,`resource_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `stores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `tousu` varchar(255) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `province_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `district_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_stores_on_company_id` (`company_id`),
  KEY `index_stores_on_city_id` (`city_id`),
  KEY `index_stores_on_province_id` (`province_id`),
  KEY `index_stores_on_district_id` (`district_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5209 DEFAULT CHARSET=utf8;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `confirmation_token` varchar(255) DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `unconfirmed_email` varchar(255) DEFAULT NULL,
  `entries_count` int(11) DEFAULT '0',
  `contact` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB AUTO_INCREMENT=243 DEFAULT CHARSET=utf8;

CREATE TABLE `users_roles` (
  `user_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  KEY `index_users_roles_on_user_id_and_role_id` (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `yaopins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `en` varchar(255) DEFAULT NULL,
  `wenhao` varchar(255) DEFAULT NULL,
  `yuanwenhao` varchar(255) DEFAULT NULL,
  `benweima` varchar(255) DEFAULT NULL,
  `benweima_beizhu` varchar(255) DEFAULT NULL,
  `shangpin_name` varchar(255) DEFAULT NULL,
  `changjia_name` varchar(255) DEFAULT NULL,
  `changjia_guojia` varchar(255) DEFAULT NULL,
  `changjia_dizhi` varchar(255) DEFAULT NULL,
  `guige` varchar(255) DEFAULT NULL,
  `jixing` varchar(255) DEFAULT NULL,
  `leibie` varchar(255) DEFAULT NULL,
  `pizhunri` date DEFAULT NULL,
  `daoqiri` date DEFAULT NULL,
  `meta` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `drug_id` int(11) DEFAULT NULL,
  `found_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_yaopins_on_wenhao` (`wenhao`),
  KEY `index_drug_id` (`drug_id`)
) ENGINE=InnoDB AUTO_INCREMENT=190634 DEFAULT CHARSET=utf8;

INSERT INTO schema_migrations (version) VALUES ('20120630143423');

INSERT INTO schema_migrations (version) VALUES ('20120630143440');

INSERT INTO schema_migrations (version) VALUES ('20120630143447');

INSERT INTO schema_migrations (version) VALUES ('20120630143453');

INSERT INTO schema_migrations (version) VALUES ('20120630165938');

INSERT INTO schema_migrations (version) VALUES ('20120701162715');

INSERT INTO schema_migrations (version) VALUES ('20120701214239');

INSERT INTO schema_migrations (version) VALUES ('20120702033812');

INSERT INTO schema_migrations (version) VALUES ('20120702094915');

INSERT INTO schema_migrations (version) VALUES ('20120702122942');

INSERT INTO schema_migrations (version) VALUES ('20120703051848');

INSERT INTO schema_migrations (version) VALUES ('20120709054553');

INSERT INTO schema_migrations (version) VALUES ('20120709065831');

INSERT INTO schema_migrations (version) VALUES ('20120904081247');

INSERT INTO schema_migrations (version) VALUES ('20120905024916');

INSERT INTO schema_migrations (version) VALUES ('20121023092406');

INSERT INTO schema_migrations (version) VALUES ('20121023100645');

INSERT INTO schema_migrations (version) VALUES ('20121023140630');

INSERT INTO schema_migrations (version) VALUES ('20130401100744');

INSERT INTO schema_migrations (version) VALUES ('20130418170731');

INSERT INTO schema_migrations (version) VALUES ('20130419100537');

INSERT INTO schema_migrations (version) VALUES ('20130420075224');

INSERT INTO schema_migrations (version) VALUES ('20130421072209');

INSERT INTO schema_migrations (version) VALUES ('20130421122841');

INSERT INTO schema_migrations (version) VALUES ('20130421124101');

INSERT INTO schema_migrations (version) VALUES ('20130424174241');

INSERT INTO schema_migrations (version) VALUES ('20130807181619');

INSERT INTO schema_migrations (version) VALUES ('20130808113100');

INSERT INTO schema_migrations (version) VALUES ('20130809145715');

INSERT INTO schema_migrations (version) VALUES ('20130810075759');

INSERT INTO schema_migrations (version) VALUES ('20130810091554');

INSERT INTO schema_migrations (version) VALUES ('20130813123307');

INSERT INTO schema_migrations (version) VALUES ('20130819115733');

INSERT INTO schema_migrations (version) VALUES ('20130827103922');

INSERT INTO schema_migrations (version) VALUES ('20131102113816');

INSERT INTO schema_migrations (version) VALUES ('20131222135530');

INSERT INTO schema_migrations (version) VALUES ('20131222172943');