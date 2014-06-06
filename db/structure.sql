CREATE TABLE `affiliates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `logo_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logo_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logo_file_size` int(11) DEFAULT NULL,
  `logo_updated_at` datetime DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `public` tinyint(1) DEFAULT NULL,
  `link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `afg_opportunities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `imported` tinyint(1) DEFAULT '0',
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `latlong` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `location_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `sponsoringOrganizationName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `xml_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `skills` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `reverse_geocoded` tinyint(1) DEFAULT '0',
  `street` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `neighborhood_string` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `checkins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `delayed_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `priority` int(11) DEFAULT '0',
  `attempts` int(11) DEFAULT '0',
  `handler` text COLLATE utf8_unicode_ci,
  `last_error` text COLLATE utf8_unicode_ci,
  `run_at` datetime DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `locked_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queue` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `delayed_jobs_priority` (`priority`,`run_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `event_affiliations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `affiliate_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `created` date DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `neighborhood_id` int(11) DEFAULT NULL,
  `creator_id` int(11) DEFAULT NULL,
  `User_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `street` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zip` int(11) DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'WA',
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `special_instructions` text COLLATE utf8_unicode_ci,
  `twitter_hashtags` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `hosted_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo_featured_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo_featured_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo_featured_file_size` int(11) DEFAULT NULL,
  `photo_featured_updated_at` datetime DEFAULT NULL,
  `photo_2_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo_2_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo_2_file_size` int(11) DEFAULT NULL,
  `photo_2_updated_at` datetime DEFAULT NULL,
  `photo_3_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo_3_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo_3_file_size` int(11) DEFAULT NULL,
  `photo_3_updated_at` datetime DEFAULT NULL,
  `photo_4_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo_4_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo_4_file_size` int(11) DEFAULT NULL,
  `photo_4_updated_at` datetime DEFAULT NULL,
  `photo_5_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo_5_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo_5_file_size` int(11) DEFAULT NULL,
  `photo_5_updated_at` datetime DEFAULT NULL,
  `featured` tinyint(1) DEFAULT '0',
  `vm_id` int(11) DEFAULT '0',
  `lonlat` point DEFAULT NULL,
  `moved_marker` tinyint(1) DEFAULT '1',
  `private` tinyint(1) DEFAULT NULL,
  `max_users` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `help_articles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `hubs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `center` point DEFAULT NULL,
  `zoom` int(11) DEFAULT NULL,
  `radius` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city_state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `neighborhoods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `region` polygon NOT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `county` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `center` point DEFAULT NULL,
  PRIMARY KEY (`id`),
  SPATIAL KEY `index_neighborhoods_on_region` (`region`)
) ENGINE=MyISAM AUTO_INCREMENT=2131 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `orgs_admins` (
  `user_id` int(11) DEFAULT NULL,
  `org_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `orgs_followers` (
  `user_id` int(11) DEFAULT NULL,
  `org_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `participations` (
  `user_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `hours_volunteered` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=288 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `privacies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `upcoming_events` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'everyone',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `props` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `giver_id` int(11) DEFAULT NULL,
  `receiver_id` int(11) DEFAULT NULL,
  `message` text COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `roles_users` (
  `role_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `searches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `query` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `users_found` int(11) DEFAULT '0',
  `orgs_found` int(11) DEFAULT '0',
  `events_found` int(11) DEFAULT '0',
  `help_articles_found` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `skills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `offset` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `skills_events` (
  `skill_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `skills_users` (
  `skill_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `sponsors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `logo_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logo_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logo_file_size` int(11) DEFAULT NULL,
  `logo_updated_at` datetime DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `user_affiliations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `affiliate_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `moderator` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `user_notifications` (
  `notification_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `confirmation_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `unconfirmed_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar_file_size` int(11) DEFAULT NULL,
  `avatar_updated_at` datetime DEFAULT NULL,
  `neighborhood_id` int(11) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `org_id` int(11) DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mission` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vision` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `website` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`),
  UNIQUE KEY `index_users_on_confirmation_token` (`confirmation_token`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `users_followers` (
  `user_id` int(11) DEFAULT NULL,
  `follower_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `volunteer_match_metadata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `volunteer_matches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vm_id` int(11) DEFAULT NULL,
  `imported` tinyint(1) DEFAULT '0',
  `allow_group_invitations` tinyint(1) DEFAULT NULL,
  `allow_group_reservation` tinyint(1) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `beneficiary` int(11) DEFAULT NULL,
  `category_ids` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact_phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `great_for` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `has_wait_list` tinyint(1) DEFAULT NULL,
  `image_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `minimum_age` int(11) DEFAULT NULL,
  `num_referred` int(11) DEFAULT NULL,
  `requires_address` tinyint(1) DEFAULT NULL,
  `requirements` text COLLATE utf8_unicode_ci,
  `skills_needed` text COLLATE utf8_unicode_ci,
  `spaces_available` int(11) DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tags` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `virtual` tinyint(1) DEFAULT NULL,
  `vm_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `volunteers_needed` int(11) DEFAULT NULL,
  `reverse_geocoded` tinyint(1) DEFAULT '0',
  `street` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `neighborhood_string` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO schema_migrations (version) VALUES ('20110724194133');

INSERT INTO schema_migrations (version) VALUES ('20110724220516');

INSERT INTO schema_migrations (version) VALUES ('20110724220744');

INSERT INTO schema_migrations (version) VALUES ('20110724221739');

INSERT INTO schema_migrations (version) VALUES ('20111210065204');

INSERT INTO schema_migrations (version) VALUES ('20111215024451');

INSERT INTO schema_migrations (version) VALUES ('20111216010338');

INSERT INTO schema_migrations (version) VALUES ('20111216041522');

INSERT INTO schema_migrations (version) VALUES ('20111216053101');

INSERT INTO schema_migrations (version) VALUES ('20111216053509');

INSERT INTO schema_migrations (version) VALUES ('20120115004638');

INSERT INTO schema_migrations (version) VALUES ('20120121230552');

INSERT INTO schema_migrations (version) VALUES ('20120211202839');

INSERT INTO schema_migrations (version) VALUES ('20120211203158');

INSERT INTO schema_migrations (version) VALUES ('20120211203306');

INSERT INTO schema_migrations (version) VALUES ('20120211221527');

INSERT INTO schema_migrations (version) VALUES ('20120211231644');

INSERT INTO schema_migrations (version) VALUES ('20120211234700');

INSERT INTO schema_migrations (version) VALUES ('20120211234726');

INSERT INTO schema_migrations (version) VALUES ('20120211234753');

INSERT INTO schema_migrations (version) VALUES ('20120218200040');

INSERT INTO schema_migrations (version) VALUES ('20120218200718');

INSERT INTO schema_migrations (version) VALUES ('20120219004038');

INSERT INTO schema_migrations (version) VALUES ('20120312015606');

INSERT INTO schema_migrations (version) VALUES ('20120312033449');

INSERT INTO schema_migrations (version) VALUES ('20120312040405');

INSERT INTO schema_migrations (version) VALUES ('20120324211637');

INSERT INTO schema_migrations (version) VALUES ('20120325174935');

INSERT INTO schema_migrations (version) VALUES ('20120401180623');

INSERT INTO schema_migrations (version) VALUES ('20120417035646');

INSERT INTO schema_migrations (version) VALUES ('20120420062309');

INSERT INTO schema_migrations (version) VALUES ('20120422214449');

INSERT INTO schema_migrations (version) VALUES ('20120505203828');

INSERT INTO schema_migrations (version) VALUES ('20120506060825');

INSERT INTO schema_migrations (version) VALUES ('20120603181644');

INSERT INTO schema_migrations (version) VALUES ('20120614031710');

INSERT INTO schema_migrations (version) VALUES ('20120617161000');

INSERT INTO schema_migrations (version) VALUES ('20120617161130');

INSERT INTO schema_migrations (version) VALUES ('20120621022910');

INSERT INTO schema_migrations (version) VALUES ('20120621044134');

INSERT INTO schema_migrations (version) VALUES ('20120624202445');

INSERT INTO schema_migrations (version) VALUES ('20120702043140');

INSERT INTO schema_migrations (version) VALUES ('20120703041302');

INSERT INTO schema_migrations (version) VALUES ('20120704192328');

INSERT INTO schema_migrations (version) VALUES ('20120704204138');

INSERT INTO schema_migrations (version) VALUES ('20121110224144');

INSERT INTO schema_migrations (version) VALUES ('20121110230242');

INSERT INTO schema_migrations (version) VALUES ('20130203053304');

INSERT INTO schema_migrations (version) VALUES ('20130223231803');

INSERT INTO schema_migrations (version) VALUES ('20130415042629');

INSERT INTO schema_migrations (version) VALUES ('20130416015940');

INSERT INTO schema_migrations (version) VALUES ('20130423021634');

INSERT INTO schema_migrations (version) VALUES ('20130425040744');

INSERT INTO schema_migrations (version) VALUES ('20130903064521');

INSERT INTO schema_migrations (version) VALUES ('20130906234916');

INSERT INTO schema_migrations (version) VALUES ('20130918021924');

INSERT INTO schema_migrations (version) VALUES ('20130923062946');

INSERT INTO schema_migrations (version) VALUES ('20131004231118');

INSERT INTO schema_migrations (version) VALUES ('20131129000000');

INSERT INTO schema_migrations (version) VALUES ('20140117050509');

INSERT INTO schema_migrations (version) VALUES ('20140207041648');