-- phpMyAdmin SQL Dump
-- version 4.0.3
-- http://www.phpmyadmin.net
--
-- Host: e98c6e56d5a5fa289ece47d5f735ef95a2c8cc04.rackspaceclouddb.com
-- Generation Time: Jul 03, 2015 at 01:56 AM
-- Server version: 5.1.73-1+deb6u1
-- PHP Version: 5.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `Meta3DB`
--
CREATE DATABASE IF NOT EXISTS `Meta3DB` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `Meta3DB`;

-- --------------------------------------------------------

--
-- Table structure for table `action_recorder`
--

CREATE TABLE IF NOT EXISTS `action_recorder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `identifier` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `success` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_action_recorder_module` (`module`),
  KEY `idx_action_recorder_user_id` (`user_id`),
  KEY `idx_action_recorder_identifier` (`identifier`),
  KEY `idx_action_recorder_date_added` (`date_added`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=671 ;

-- --------------------------------------------------------

--
-- Table structure for table `address_book`
--

CREATE TABLE IF NOT EXISTS `address_book` (
  `address_book_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_id` int(11) NOT NULL,
  `entry_gender` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entry_company` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entry_firstname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `entry_lastname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `entry_street_address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `entry_suburb` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entry_postcode` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `entry_city` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `entry_state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entry_country_id` int(11) NOT NULL DEFAULT '0',
  `entry_zone_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`address_book_id`),
  KEY `idx_address_book_customers_id` (`customers_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3596 ;

-- --------------------------------------------------------

--
-- Table structure for table `address_format`
--

CREATE TABLE IF NOT EXISTS `address_format` (
  `address_format_id` int(11) NOT NULL AUTO_INCREMENT,
  `address_format` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `address_summary` varchar(48) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`address_format_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- Table structure for table `administrators`
--

CREATE TABLE IF NOT EXISTS `administrators` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `user_password` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Table structure for table `affiliateorders`
--

CREATE TABLE IF NOT EXISTS `affiliateorders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aid` varchar(255) NOT NULL,
  `eventorderid` int(255) NOT NULL,
  `eventid` int(44) NOT NULL,
  `customeremail` varchar(255) NOT NULL,
  `purchasetype` varchar(255) NOT NULL,
  `amount` varchar(255) NOT NULL,
  `orderdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1750 ;

-- --------------------------------------------------------

--
-- Table structure for table `affiliates`
--

CREATE TABLE IF NOT EXISTS `affiliates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aid` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `website` varchar(255) NOT NULL,
  `commission` int(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

-- --------------------------------------------------------

--
-- Table structure for table `banners`
--

CREATE TABLE IF NOT EXISTS `banners` (
  `banners_id` int(11) NOT NULL AUTO_INCREMENT,
  `banners_title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `banners_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `banners_image` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `banners_group` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `banners_html_text` text COLLATE utf8_unicode_ci,
  `expires_impressions` int(7) DEFAULT '0',
  `expires_date` datetime DEFAULT NULL,
  `date_scheduled` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL,
  `date_status_change` datetime DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`banners_id`),
  KEY `idx_banners_group` (`banners_group`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Table structure for table `banners_history`
--

CREATE TABLE IF NOT EXISTS `banners_history` (
  `banners_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `banners_id` int(11) NOT NULL,
  `banners_shown` int(5) NOT NULL DEFAULT '0',
  `banners_clicked` int(5) NOT NULL DEFAULT '0',
  `banners_history_date` datetime NOT NULL,
  PRIMARY KEY (`banners_history_id`),
  KEY `idx_banners_history_banners_id` (`banners_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1121 ;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `categories_id` int(11) NOT NULL AUTO_INCREMENT,
  `categories_image` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `sort_order` int(3) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`categories_id`),
  KEY `idx_categories_parent_id` (`parent_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=22 ;

-- --------------------------------------------------------

--
-- Table structure for table `categories_description`
--

CREATE TABLE IF NOT EXISTS `categories_description` (
  `categories_id` int(11) NOT NULL DEFAULT '0',
  `language_id` int(11) NOT NULL DEFAULT '1',
  `categories_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`categories_id`,`language_id`),
  KEY `idx_categories_name` (`categories_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cms_associated_content`
--

CREATE TABLE IF NOT EXISTS `cms_associated_content` (
  `category_parent_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `content_id` int(11) NOT NULL,
  `child_category_parent_id` int(11) NOT NULL,
  `child_category_id` int(11) NOT NULL,
  `child_content_id` int(11) NOT NULL,
  `child_order` int(11) NOT NULL DEFAULT '0',
  `extrainfo` text NOT NULL,
  KEY `category_parent_id` (`category_parent_id`,`category_id`,`content_id`,`child_category_parent_id`,`child_category_id`,`child_content_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `cms_categories`
--

CREATE TABLE IF NOT EXISTS `cms_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_parent_id` int(11) NOT NULL DEFAULT '0',
  `category_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `category_content_1` text COLLATE utf8_unicode_ci NOT NULL,
  `category_slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `category_meta_title` text COLLATE utf8_unicode_ci NOT NULL,
  `category_meta_description` text COLLATE utf8_unicode_ci NOT NULL,
  `category_meta_keywords` text COLLATE utf8_unicode_ci NOT NULL,
  `category_order` int(11) NOT NULL,
  `category_allow_delete` tinyint(1) NOT NULL DEFAULT '1',
  `category_allow_content` tinyint(1) NOT NULL DEFAULT '1',
  `category_allow_subcats` tinyint(1) NOT NULL DEFAULT '1',
  `category_show_subcats` tinyint(1) NOT NULL DEFAULT '1',
  `category_allow_subcat_content` tinyint(1) NOT NULL DEFAULT '1',
  `category_allow_subcat_delete` tinyint(1) NOT NULL DEFAULT '1',
  `category_keep_original_images` tinyint(1) NOT NULL DEFAULT '1',
  `category_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`category_id`),
  KEY `category_parent_id` (`category_parent_id`,`category_order`),
  KEY `category_active` (`category_active`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=30 ;

-- --------------------------------------------------------

--
-- Table structure for table `cms_categories_fields`
--

CREATE TABLE IF NOT EXISTS `cms_categories_fields` (
  `fields_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `title_1_text` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Title',
  `show_title_show` tinyint(1) NOT NULL DEFAULT '0',
  `title_2_text` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Title 2',
  `title_2_show` tinyint(1) NOT NULL DEFAULT '0',
  `title_3_text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title_3_show` tinyint(1) NOT NULL DEFAULT '0',
  `date_text` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Date',
  `date_show` tinyint(1) NOT NULL DEFAULT '1',
  `flag_1_text` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Flag',
  `flag_1_show` tinyint(1) NOT NULL DEFAULT '0',
  `content_1_text` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Content',
  `content_1_show` tinyint(1) NOT NULL DEFAULT '1',
  `content_1_wysiwyg` tinyint(1) NOT NULL DEFAULT '1',
  `content_2_text` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Content 2',
  `content_2_show` tinyint(1) NOT NULL DEFAULT '0',
  `content_2_wysiwyg` tinyint(1) NOT NULL DEFAULT '1',
  `image_1_text` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Image 1',
  `image_1_show` tinyint(1) NOT NULL DEFAULT '1',
  `image_2_text` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Image 2',
  `image_2_show` tinyint(1) NOT NULL DEFAULT '0',
  `image_3_text` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Image 3',
  `image_3_show` tinyint(1) NOT NULL DEFAULT '0',
  `file_1_text` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'File 1',
  `file_1_show` tinyint(1) NOT NULL DEFAULT '0',
  `file_2_text` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'File 2',
  `file_2_show` tinyint(1) NOT NULL DEFAULT '0',
  `f1_text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `f1_show` tinyint(1) NOT NULL DEFAULT '0',
  `f2_text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `f2_show` tinyint(1) NOT NULL DEFAULT '0',
  `f3_text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `f3_show` tinyint(1) NOT NULL DEFAULT '0',
  `meta_title_show` tinyint(1) NOT NULL DEFAULT '1',
  `meta_description_show` tinyint(1) NOT NULL DEFAULT '1',
  `meta_keywords_show` tinyint(1) NOT NULL DEFAULT '1',
  `active_show` tinyint(1) NOT NULL DEFAULT '1',
  `gallery_image_text` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Images',
  `gallery_image_count` int(11) NOT NULL DEFAULT '0',
  `gallery_title_text` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Title',
  `gallery_title_show` tinyint(1) NOT NULL DEFAULT '0',
  `gallery_description_text` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Description',
  `gallery_description_show` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`fields_id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=30 ;

-- --------------------------------------------------------

--
-- Table structure for table `cms_categories_image_sizes`
--

CREATE TABLE IF NOT EXISTS `cms_categories_image_sizes` (
  `category_id` int(11) NOT NULL,
  `image_width` int(11) NOT NULL,
  `image_height` int(11) NOT NULL,
  `image_crop` tinyint(1) NOT NULL DEFAULT '0',
  `image_folder` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `image_thumbnail` tinyint(1) NOT NULL DEFAULT '0',
  `image_custom_imagemagick` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cms_content`
--

CREATE TABLE IF NOT EXISTS `cms_content` (
  `content_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `category_parent_id` int(11) NOT NULL,
  `content_title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content_slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content_show_title` tinyint(1) NOT NULL DEFAULT '0',
  `content_title_2` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content_title_3` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content_flag_1` tinyint(1) NOT NULL DEFAULT '0',
  `content_date` int(11) NOT NULL,
  `content_content_1` text COLLATE utf8_unicode_ci NOT NULL,
  `content_content_2` text COLLATE utf8_unicode_ci NOT NULL,
  `content_image_1` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content_image_2` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content_image_3` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content_file_1` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content_file_2` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content_f1` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content_f2` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content_f3` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content_meta_title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content_meta_description` text COLLATE utf8_unicode_ci NOT NULL,
  `content_meta_keywords` text COLLATE utf8_unicode_ci NOT NULL,
  `content_active` tinyint(1) NOT NULL DEFAULT '1',
  `content_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`content_id`),
  KEY `category_id` (`category_id`),
  KEY `category_parent_id` (`category_parent_id`),
  KEY `content_active` (`content_active`),
  KEY `content_order` (`content_order`),
  KEY `category_id_2` (`category_id`,`content_date`,`content_active`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=110 ;

-- --------------------------------------------------------

--
-- Table structure for table `cms_content_gallery_images`
--

CREATE TABLE IF NOT EXISTS `cms_content_gallery_images` (
  `image_id` int(11) NOT NULL AUTO_INCREMENT,
  `content_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `image_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `image_title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `image_description` text COLLATE utf8_unicode_ci NOT NULL,
  `image_order` int(11) NOT NULL,
  PRIMARY KEY (`image_id`),
  KEY `content_id` (`content_id`,`category_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=305 ;

-- --------------------------------------------------------

--
-- Table structure for table `cms_users`
--

CREATE TABLE IF NOT EXISTS `cms_users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `user_email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `user_password` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Table structure for table `configuration`
--

CREATE TABLE IF NOT EXISTS `configuration` (
  `configuration_id` int(11) NOT NULL AUTO_INCREMENT,
  `configuration_title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `configuration_key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `configuration_value` text COLLATE utf8_unicode_ci NOT NULL,
  `configuration_description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `configuration_group_id` int(11) NOT NULL,
  `sort_order` int(5) DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL,
  `use_function` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `set_function` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`configuration_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=479 ;

-- --------------------------------------------------------

--
-- Table structure for table `configuration_group`
--

CREATE TABLE IF NOT EXISTS `configuration_group` (
  `configuration_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `configuration_group_title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `configuration_group_description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sort_order` int(5) DEFAULT NULL,
  `visible` int(1) DEFAULT '1',
  PRIMARY KEY (`configuration_group_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=16 ;

-- --------------------------------------------------------

--
-- Table structure for table `counter`
--

CREATE TABLE IF NOT EXISTS `counter` (
  `startdate` char(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `counter` int(12) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `counter_history`
--

CREATE TABLE IF NOT EXISTS `counter_history` (
  `month` char(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `counter` int(12) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE IF NOT EXISTS `countries` (
  `countries_id` int(11) NOT NULL AUTO_INCREMENT,
  `countries_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `countries_iso_code_2` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `countries_iso_code_3` char(3) COLLATE utf8_unicode_ci NOT NULL,
  `address_format_id` int(11) NOT NULL,
  PRIMARY KEY (`countries_id`),
  KEY `IDX_COUNTRIES_NAME` (`countries_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=240 ;

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE IF NOT EXISTS `currencies` (
  `currencies_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `code` char(3) COLLATE utf8_unicode_ci NOT NULL,
  `symbol_left` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `symbol_right` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `decimal_point` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `thousands_point` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `decimal_places` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` float(13,8) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`currencies_id`),
  KEY `idx_currencies_code` (`code`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE IF NOT EXISTS `customers` (
  `customers_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_gender` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customers_firstname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `customers_lastname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `customers_dob` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `customers_email_address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `customers_default_address_id` int(11) DEFAULT NULL,
  `customers_telephone` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `customers_fax` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customers_password` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `customers_newsletter` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_alerts` int(11) DEFAULT NULL,
  PRIMARY KEY (`customers_id`),
  UNIQUE KEY `customers_email_address` (`customers_email_address`),
  KEY `idx_customers_email_address` (`customers_email_address`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=55341 ;

-- --------------------------------------------------------

--
-- Table structure for table `customers_basket`
--

CREATE TABLE IF NOT EXISTS `customers_basket` (
  `customers_basket_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_id` int(11) NOT NULL,
  `products_id` tinytext COLLATE utf8_unicode_ci NOT NULL,
  `customers_basket_quantity` int(2) NOT NULL,
  `final_price` decimal(15,4) DEFAULT NULL,
  `customers_basket_date_added` char(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`customers_basket_id`),
  KEY `idx_customers_basket_customers_id` (`customers_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6669 ;

-- --------------------------------------------------------

--
-- Table structure for table `customers_basket_attributes`
--

CREATE TABLE IF NOT EXISTS `customers_basket_attributes` (
  `customers_basket_attributes_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_id` int(11) NOT NULL,
  `products_id` tinytext COLLATE utf8_unicode_ci NOT NULL,
  `products_options_id` int(11) NOT NULL,
  `products_options_value_id` int(11) NOT NULL,
  PRIMARY KEY (`customers_basket_attributes_id`),
  KEY `idx_customers_basket_att_customers_id` (`customers_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=67 ;

-- --------------------------------------------------------

--
-- Table structure for table `customers_info`
--

CREATE TABLE IF NOT EXISTS `customers_info` (
  `customers_info_id` int(11) NOT NULL,
  `customers_info_date_of_last_logon` datetime DEFAULT NULL,
  `customers_info_number_of_logons` int(5) DEFAULT NULL,
  `customers_info_date_account_created` datetime DEFAULT NULL,
  `customers_info_date_account_last_modified` datetime DEFAULT NULL,
  `global_product_notifications` int(1) DEFAULT '0',
  `password_reset_key` char(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_reset_date` datetime DEFAULT NULL,
  PRIMARY KEY (`customers_info_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `event_orders`
--

CREATE TABLE IF NOT EXISTS `event_orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `zip` varchar(20) NOT NULL,
  `country` varchar(255) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `price` decimal(15,2) NOT NULL,
  `transaction_details` text NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `access_token` varchar(50) NOT NULL,
  `event_order_date` int(11) NOT NULL,
  PRIMARY KEY (`order_id`,`event_id`,`customer_id`),
  KEY `event_id` (`access_token`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=53248 ;

-- --------------------------------------------------------

--
-- Table structure for table `forgot_password`
--

CREATE TABLE IF NOT EXISTS `forgot_password` (
  `email` varchar(300) NOT NULL,
  `token` varchar(500) NOT NULL,
  KEY `email` (`email`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `geo_zones`
--

CREATE TABLE IF NOT EXISTS `geo_zones` (
  `geo_zone_id` int(11) NOT NULL AUTO_INCREMENT,
  `geo_zone_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `geo_zone_description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_modified` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`geo_zone_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE IF NOT EXISTS `languages` (
  `languages_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `code` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `directory` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sort_order` int(3) DEFAULT NULL,
  PRIMARY KEY (`languages_id`),
  KEY `IDX_LANGUAGES_NAME` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `manufacturers`
--

CREATE TABLE IF NOT EXISTS `manufacturers` (
  `manufacturers_id` int(11) NOT NULL AUTO_INCREMENT,
  `manufacturers_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `manufacturers_image` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`manufacturers_id`),
  KEY `IDX_MANUFACTURERS_NAME` (`manufacturers_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=11 ;

-- --------------------------------------------------------

--
-- Table structure for table `manufacturers_info`
--

CREATE TABLE IF NOT EXISTS `manufacturers_info` (
  `manufacturers_id` int(11) NOT NULL,
  `languages_id` int(11) NOT NULL,
  `manufacturers_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `url_clicked` int(5) NOT NULL DEFAULT '0',
  `date_last_click` datetime DEFAULT NULL,
  PRIMARY KEY (`manufacturers_id`,`languages_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `matches`
--

CREATE TABLE IF NOT EXISTS `matches` (
  `match_id` int(11) NOT NULL,
  `opponent1_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `opponent1_votes` int(11) NOT NULL DEFAULT '0',
  `opponent1_percentage` int(11) NOT NULL DEFAULT '0',
  `opponent2_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `opponent2_votes` int(11) NOT NULL DEFAULT '0',
  `opponent2_percentage` int(11) NOT NULL DEFAULT '0',
  KEY `match_id` (`match_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `match_results`
--

CREATE TABLE IF NOT EXISTS `match_results` (
  `match1_winner` tinyint(1) NOT NULL DEFAULT '0',
  `match1_wintype` tinyint(1) NOT NULL DEFAULT '0',
  `match1_wintime` tinyint(1) NOT NULL DEFAULT '0',
  `match1_winhold` tinyint(1) NOT NULL DEFAULT '0',
  `match1_show` tinyint(1) NOT NULL DEFAULT '0',
  `match2_winner` tinyint(1) NOT NULL DEFAULT '0',
  `match2_wintype` tinyint(1) NOT NULL DEFAULT '0',
  `match2_wintime` tinyint(1) NOT NULL DEFAULT '0',
  `match2_winhold` tinyint(1) NOT NULL DEFAULT '0',
  `match2_show` tinyint(1) NOT NULL DEFAULT '0',
  `match3_winner` tinyint(1) NOT NULL DEFAULT '0',
  `match3_wintype` tinyint(1) NOT NULL DEFAULT '0',
  `match3_wintime` tinyint(1) NOT NULL DEFAULT '0',
  `match3_winhold` tinyint(1) NOT NULL DEFAULT '0',
  `match3_show` tinyint(1) NOT NULL DEFAULT '0',
  `match4_winner` tinyint(1) NOT NULL DEFAULT '0',
  `match4_wintype` tinyint(1) NOT NULL DEFAULT '0',
  `match4_wintime` tinyint(1) NOT NULL DEFAULT '0',
  `match4_winhold` tinyint(1) NOT NULL DEFAULT '0',
  `match4_show` tinyint(1) NOT NULL DEFAULT '0',
  `match5_winner` tinyint(1) NOT NULL DEFAULT '0',
  `match5_wintype` tinyint(1) NOT NULL DEFAULT '0',
  `match5_wintime` tinyint(1) NOT NULL DEFAULT '0',
  `match5_winhold` tinyint(1) NOT NULL DEFAULT '0',
  `match5_show` tinyint(1) NOT NULL DEFAULT '0',
  `match6_winner` tinyint(1) NOT NULL DEFAULT '0',
  `match6_wintype` tinyint(1) NOT NULL DEFAULT '0',
  `match6_wintime` tinyint(1) NOT NULL DEFAULT '0',
  `match6_winhold` tinyint(1) NOT NULL DEFAULT '0',
  `match6_show` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`match1_winner`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `match_votes`
--

CREATE TABLE IF NOT EXISTS `match_votes` (
  `match_id` int(11) NOT NULL,
  `opponent_id` tinyint(1) NOT NULL,
  `time` int(11) NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  KEY `match_id` (`match_id`,`opponent_id`,`time`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `newsletter`
--

CREATE TABLE IF NOT EXISTS `newsletter` (
  `email` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ip_address` varchar(50) NOT NULL,
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `newsletters`
--

CREATE TABLE IF NOT EXISTS `newsletters` (
  `newsletters_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  `module` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_added` datetime NOT NULL,
  `date_sent` datetime DEFAULT NULL,
  `status` int(1) DEFAULT NULL,
  `locked` int(1) DEFAULT '0',
  PRIMARY KEY (`newsletters_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE IF NOT EXISTS `orders` (
  `orders_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_id` int(11) NOT NULL,
  `customers_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `customers_company` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customers_street_address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `customers_suburb` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customers_city` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `customers_postcode` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `customers_state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customers_country` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `customers_telephone` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `customers_email_address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `customers_address_format_id` int(5) NOT NULL,
  `delivery_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `delivery_company` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `delivery_street_address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `delivery_suburb` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `delivery_city` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `delivery_postcode` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `delivery_state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `delivery_country` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `delivery_address_format_id` int(5) NOT NULL,
  `billing_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `billing_company` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_street_address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `billing_suburb` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_city` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `billing_postcode` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `billing_state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_country` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `billing_address_format_id` int(5) NOT NULL,
  `payment_method` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cc_type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cc_owner` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cc_number` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cc_expires` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `date_purchased` datetime DEFAULT NULL,
  `orders_status` int(5) NOT NULL,
  `orders_date_finished` datetime DEFAULT NULL,
  `currency` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `currency_value` decimal(14,6) DEFAULT NULL,
  PRIMARY KEY (`orders_id`),
  KEY `idx_orders_customers_id` (`customers_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2963 ;

-- --------------------------------------------------------

--
-- Table structure for table `orders_products`
--

CREATE TABLE IF NOT EXISTS `orders_products` (
  `orders_products_id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `products_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `products_price` decimal(15,4) NOT NULL,
  `final_price` decimal(15,4) NOT NULL,
  `products_tax` decimal(7,4) NOT NULL,
  `products_quantity` int(2) NOT NULL,
  PRIMARY KEY (`orders_products_id`),
  KEY `idx_orders_products_orders_id` (`orders_id`),
  KEY `idx_orders_products_products_id` (`products_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3819 ;

-- --------------------------------------------------------

--
-- Table structure for table `orders_products_attributes`
--

CREATE TABLE IF NOT EXISTS `orders_products_attributes` (
  `orders_products_attributes_id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL,
  `orders_products_id` int(11) NOT NULL,
  `products_options` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `products_options_values` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `options_values_price` decimal(15,4) NOT NULL,
  `price_prefix` char(1) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`orders_products_attributes_id`),
  KEY `idx_orders_products_att_orders_id` (`orders_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=30 ;

-- --------------------------------------------------------

--
-- Table structure for table `orders_products_download`
--

CREATE TABLE IF NOT EXISTS `orders_products_download` (
  `orders_products_download_id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL DEFAULT '0',
  `orders_products_id` int(11) NOT NULL DEFAULT '0',
  `orders_products_filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `download_maxdays` int(2) NOT NULL DEFAULT '0',
  `download_count` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`orders_products_download_id`),
  KEY `idx_orders_products_download_orders_id` (`orders_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `orders_status`
--

CREATE TABLE IF NOT EXISTS `orders_status` (
  `orders_status_id` int(11) NOT NULL DEFAULT '0',
  `language_id` int(11) NOT NULL DEFAULT '1',
  `orders_status_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `public_flag` int(11) DEFAULT '1',
  `downloads_flag` int(11) DEFAULT '0',
  PRIMARY KEY (`orders_status_id`,`language_id`),
  KEY `idx_orders_status_name` (`orders_status_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders_status_history`
--

CREATE TABLE IF NOT EXISTS `orders_status_history` (
  `orders_status_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL,
  `orders_status_id` int(5) NOT NULL,
  `date_added` datetime NOT NULL,
  `customer_notified` int(1) DEFAULT '0',
  `comments` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`orders_status_history_id`),
  KEY `idx_orders_status_history_orders_id` (`orders_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3915 ;

-- --------------------------------------------------------

--
-- Table structure for table `orders_total`
--

CREATE TABLE IF NOT EXISTS `orders_total` (
  `orders_total_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` decimal(15,4) NOT NULL,
  `class` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY (`orders_total_id`),
  KEY `idx_orders_total_orders_id` (`orders_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6900 ;

-- --------------------------------------------------------

--
-- Table structure for table `orders_total_dead`
--

CREATE TABLE IF NOT EXISTS `orders_total_dead` (
  `orders_total_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` decimal(15,4) NOT NULL,
  `class` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY (`orders_total_id`),
  KEY `idx_orders_total_orders_id` (`orders_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=413 ;

-- --------------------------------------------------------

--
-- Table structure for table `orders_total_safe`
--

CREATE TABLE IF NOT EXISTS `orders_total_safe` (
  `orders_total_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` decimal(15,4) NOT NULL,
  `class` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY (`orders_total_id`),
  KEY `idx_orders_total_orders_id` (`orders_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=413 ;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE IF NOT EXISTS `products` (
  `products_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_parid` int(11) NOT NULL,
  `products_granid` int(11) NOT NULL,
  `products_quantity` int(4) NOT NULL,
  `products_model` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `products_image` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `products_price_old` decimal(15,4) DEFAULT NULL,
  `products_price` decimal(15,4) NOT NULL,
  `products_date_added` datetime NOT NULL,
  `products_last_modified` datetime DEFAULT NULL,
  `products_date_available` datetime DEFAULT NULL,
  `products_weight` decimal(5,2) NOT NULL,
  `products_status` tinyint(1) NOT NULL,
  `products_tax_class_id` int(11) NOT NULL,
  `manufacturers_id` int(11) DEFAULT NULL,
  `products_ordered` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`products_id`),
  KEY `idx_products_model` (`products_model`),
  KEY `idx_products_date_added` (`products_date_added`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=248 ;

-- --------------------------------------------------------

--
-- Table structure for table `products_attributes`
--

CREATE TABLE IF NOT EXISTS `products_attributes` (
  `products_attributes_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_id` int(11) NOT NULL,
  `options_id` int(11) NOT NULL,
  `options_values_id` int(11) NOT NULL,
  `options_values_price` decimal(15,4) NOT NULL,
  `price_prefix` char(1) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`products_attributes_id`),
  KEY `idx_products_attributes_products_id` (`products_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=35 ;

-- --------------------------------------------------------

--
-- Table structure for table `products_attributes_download`
--

CREATE TABLE IF NOT EXISTS `products_attributes_download` (
  `products_attributes_id` int(11) NOT NULL,
  `products_attributes_filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `products_attributes_maxdays` int(2) DEFAULT '0',
  `products_attributes_maxcount` int(2) DEFAULT '0',
  PRIMARY KEY (`products_attributes_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products_description`
--

CREATE TABLE IF NOT EXISTS `products_description` (
  `products_id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL DEFAULT '1',
  `products_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `products_short_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `products_description` text COLLATE utf8_unicode_ci,
  `products_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `products_viewed` int(5) DEFAULT '0',
  PRIMARY KEY (`products_id`,`language_id`),
  KEY `products_name` (`products_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=248 ;

-- --------------------------------------------------------

--
-- Table structure for table `products_images`
--

CREATE TABLE IF NOT EXISTS `products_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `products_id` int(11) NOT NULL,
  `image` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `htmlcontent` text COLLATE utf8_unicode_ci,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `products_images_prodid` (`products_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=70 ;

-- --------------------------------------------------------

--
-- Table structure for table `products_notifications`
--

CREATE TABLE IF NOT EXISTS `products_notifications` (
  `products_id` int(11) NOT NULL,
  `customers_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`products_id`,`customers_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products_options`
--

CREATE TABLE IF NOT EXISTS `products_options` (
  `products_options_id` int(11) NOT NULL DEFAULT '0',
  `language_id` int(11) NOT NULL DEFAULT '1',
  `products_options_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`products_options_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products_options_values`
--

CREATE TABLE IF NOT EXISTS `products_options_values` (
  `products_options_values_id` int(11) NOT NULL DEFAULT '0',
  `language_id` int(11) NOT NULL DEFAULT '1',
  `products_options_values_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`products_options_values_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products_options_values_to_products_options`
--

CREATE TABLE IF NOT EXISTS `products_options_values_to_products_options` (
  `products_options_values_to_products_options_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_options_id` int(11) NOT NULL,
  `products_options_values_id` int(11) NOT NULL,
  PRIMARY KEY (`products_options_values_to_products_options_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=21 ;

-- --------------------------------------------------------

--
-- Table structure for table `products_to_categories`
--

CREATE TABLE IF NOT EXISTS `products_to_categories` (
  `products_id` int(11) NOT NULL,
  `categories_id` int(11) NOT NULL,
  PRIMARY KEY (`products_id`,`categories_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE IF NOT EXISTS `reviews` (
  `reviews_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_id` int(11) NOT NULL,
  `customers_id` int(11) DEFAULT NULL,
  `customers_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `reviews_rating` int(1) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `reviews_status` tinyint(1) NOT NULL DEFAULT '0',
  `reviews_read` int(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`reviews_id`),
  KEY `idx_reviews_products_id` (`products_id`),
  KEY `idx_reviews_customers_id` (`customers_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Table structure for table `reviews_description`
--

CREATE TABLE IF NOT EXISTS `reviews_description` (
  `reviews_id` int(11) NOT NULL,
  `languages_id` int(11) NOT NULL,
  `reviews_text` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`reviews_id`,`languages_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sec_directory_whitelist`
--

CREATE TABLE IF NOT EXISTS `sec_directory_whitelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `directory` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=14 ;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE IF NOT EXISTS `sessions` (
  `sesskey` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `expiry` int(11) unsigned NOT NULL,
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`sesskey`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `specials`
--

CREATE TABLE IF NOT EXISTS `specials` (
  `specials_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_id` int(11) NOT NULL,
  `specials_new_products_price` decimal(15,4) NOT NULL,
  `specials_date_added` datetime DEFAULT NULL,
  `specials_last_modified` datetime DEFAULT NULL,
  `expires_date` datetime DEFAULT NULL,
  `date_status_change` datetime DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`specials_id`),
  KEY `idx_specials_products_id` (`products_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=63 ;

-- --------------------------------------------------------

--
-- Table structure for table `tax_class`
--

CREATE TABLE IF NOT EXISTS `tax_class` (
  `tax_class_id` int(11) NOT NULL AUTO_INCREMENT,
  `tax_class_title` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `tax_class_description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_modified` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`tax_class_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `tax_rates`
--

CREATE TABLE IF NOT EXISTS `tax_rates` (
  `tax_rates_id` int(11) NOT NULL AUTO_INCREMENT,
  `tax_zone_id` int(11) NOT NULL,
  `tax_class_id` int(11) NOT NULL,
  `tax_priority` int(5) DEFAULT '1',
  `tax_rate` decimal(7,4) NOT NULL,
  `tax_description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_modified` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`tax_rates_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Table structure for table `tv_subscriptions`
--

CREATE TABLE IF NOT EXISTS `tv_subscriptions` (
  `tv_subscriptions_id` int(11) NOT NULL AUTO_INCREMENT,
  `authnet_subscription_id` int(11) NOT NULL,
  `customers_id` int(11) NOT NULL,
  `subscription_type` int(11) NOT NULL,
  `price` decimal(15,4) NOT NULL,
  `status` varchar(20) NOT NULL,
  `purchase_date` datetime NOT NULL,
  `expiration_date` datetime NOT NULL,
  `cancellation_date` datetime DEFAULT NULL,
  `access_token` varchar(64) NOT NULL,
  PRIMARY KEY (`tv_subscriptions_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9706 ;

-- --------------------------------------------------------

--
-- Table structure for table `twitter_feed`
--

CREATE TABLE IF NOT EXISTS `twitter_feed` (
  `tweet_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `tweet_date` int(11) NOT NULL,
  `tweet_text` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`tweet_id`),
  KEY `tweet_date` (`tweet_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `USPS_intl_maxins`
--

CREATE TABLE IF NOT EXISTS `USPS_intl_maxins` (
  `country_code` char(2) NOT NULL,
  `method` varchar(128) NOT NULL,
  `insurable` tinyint(1) NOT NULL DEFAULT '0',
  `max_insurance` smallint(5) unsigned NOT NULL DEFAULT '0',
  `last_modified` datetime NOT NULL,
  PRIMARY KEY (`country_code`,`method`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `videos`
--

CREATE TABLE IF NOT EXISTS `videos` (
  `video_id` int(11) NOT NULL AUTO_INCREMENT,
  `public_id` varchar(500) NOT NULL,
  `title` varchar(300) NOT NULL,
  `featuring` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `event` varchar(50) NOT NULL,
  `year` varchar(10) NOT NULL,
  `duration` varchar(20) NOT NULL,
  `expire` int(11) NOT NULL,
  `thumbnail_url` varchar(500) NOT NULL,
  `poster_url` varchar(500) NOT NULL,
  `video_url` varchar(500) NOT NULL,
  `added_on` date NOT NULL,
  PRIMARY KEY (`video_id`),
  UNIQUE KEY `public_id` (`public_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=89 ;

-- --------------------------------------------------------

--
-- Table structure for table `video_categories`
--

CREATE TABLE IF NOT EXISTS `video_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `video_category_map`
--

CREATE TABLE IF NOT EXISTS `video_category_map` (
  `video_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `video_ratings`
--

CREATE TABLE IF NOT EXISTS `video_ratings` (
  `video_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  KEY `video_id` (`video_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `video_views`
--

CREATE TABLE IF NOT EXISTS `video_views` (
  `video_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `viewed_on` datetime NOT NULL,
  KEY `video_id` (`video_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `voting`
--

CREATE TABLE IF NOT EXISTS `voting` (
  `vote_id` int(6) NOT NULL AUTO_INCREMENT,
  `user_id` int(6) NOT NULL,
  `date_entered` int(10) NOT NULL,
  `match1_winner` tinyint(1) NOT NULL DEFAULT '0',
  `match1_wintype` tinyint(1) NOT NULL DEFAULT '0',
  `match1_wintime` tinyint(1) NOT NULL DEFAULT '0',
  `match1_winhold` tinyint(1) NOT NULL DEFAULT '0',
  `match2_winner` tinyint(1) NOT NULL DEFAULT '0',
  `match2_wintype` tinyint(1) NOT NULL DEFAULT '0',
  `match2_wintime` tinyint(1) NOT NULL DEFAULT '0',
  `match2_winhold` tinyint(1) NOT NULL DEFAULT '0',
  `match3_winner` tinyint(1) NOT NULL DEFAULT '0',
  `match3_wintype` tinyint(1) NOT NULL DEFAULT '0',
  `match3_wintime` tinyint(1) NOT NULL DEFAULT '0',
  `match3_winhold` tinyint(1) NOT NULL DEFAULT '0',
  `match4_winner` tinyint(1) NOT NULL DEFAULT '0',
  `match4_wintype` tinyint(1) NOT NULL DEFAULT '0',
  `match4_wintime` tinyint(1) NOT NULL DEFAULT '0',
  `match4_winhold` tinyint(1) NOT NULL DEFAULT '0',
  `match5_winner` tinyint(1) NOT NULL DEFAULT '0',
  `match5_wintype` tinyint(1) NOT NULL DEFAULT '0',
  `match5_wintime` tinyint(1) NOT NULL DEFAULT '0',
  `match5_winhold` tinyint(1) NOT NULL DEFAULT '0',
  `match6_winner` tinyint(1) NOT NULL DEFAULT '0',
  `match6_wintype` tinyint(1) NOT NULL DEFAULT '0',
  `match6_wintime` tinyint(1) NOT NULL DEFAULT '0',
  `match6_winhold` tinyint(1) NOT NULL DEFAULT '0',
  `metamoris_match_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`vote_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4302 ;

-- --------------------------------------------------------

--
-- Table structure for table `voting_decision`
--

CREATE TABLE IF NOT EXISTS `voting_decision` (
  `vote_id` int(6) NOT NULL AUTO_INCREMENT,
  `user_id` int(6) NOT NULL,
  `date_entered` int(10) NOT NULL,
  `match2_winner` tinyint(1) NOT NULL DEFAULT '0',
  `match3_winner` tinyint(1) NOT NULL DEFAULT '0',
  `match4_winner` tinyint(1) NOT NULL DEFAULT '0',
  `match5_winner` tinyint(1) NOT NULL DEFAULT '0',
  `match6_winner` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`vote_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=599 ;

-- --------------------------------------------------------

--
-- Table structure for table `voting_decision_results`
--

CREATE TABLE IF NOT EXISTS `voting_decision_results` (
  `match2_1` int(3) NOT NULL,
  `match3_1` int(3) NOT NULL,
  `match3_2` int(3) NOT NULL,
  `match3_3` int(3) NOT NULL,
  `match4_1` int(3) NOT NULL,
  `match4_2` int(3) NOT NULL,
  `match4_3` int(3) NOT NULL,
  `match5_1` int(3) NOT NULL,
  `match5_2` int(3) NOT NULL,
  `match5_3` int(3) NOT NULL,
  `match6_1` int(3) NOT NULL,
  `match6_2` int(3) NOT NULL,
  `match6_3` int(3) NOT NULL,
  `match2_2` int(3) NOT NULL,
  `match2_3` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `voting_results`
--

CREATE TABLE IF NOT EXISTS `voting_results` (
  `match1_1` int(3) NOT NULL,
  `match1_2` int(3) NOT NULL,
  `match1_3` int(3) NOT NULL,
  `wintype1a_1` int(3) NOT NULL,
  `wintype1a_2` int(3) NOT NULL,
  `wintype1b_1` int(3) NOT NULL,
  `wintype1b_2` int(3) NOT NULL,
  `wintime1a_1` int(3) NOT NULL,
  `wintime1a_2` int(3) NOT NULL,
  `wintime1b_1` int(3) NOT NULL,
  `wintime1b_2` int(3) NOT NULL,
  `winhold1a_1` int(3) NOT NULL,
  `winhold1a_2` int(3) NOT NULL,
  `winhold1a_3` int(3) NOT NULL,
  `winhold1b_1` int(3) NOT NULL,
  `winhold1b_2` int(3) NOT NULL,
  `winhold1b_3` int(3) NOT NULL,
  `match2_1` int(3) NOT NULL,
  `match2_2` int(3) NOT NULL,
  `match2_3` int(3) NOT NULL,
  `wintype2a_1` int(3) NOT NULL,
  `wintype2a_2` int(3) NOT NULL,
  `wintype2b_1` int(3) NOT NULL,
  `wintype2b_2` int(3) NOT NULL,
  `wintime2a_1` int(3) NOT NULL,
  `wintime2a_2` int(3) NOT NULL,
  `wintime2b_1` int(3) NOT NULL,
  `wintime2b_2` int(3) NOT NULL,
  `winhold2a_1` int(3) NOT NULL,
  `winhold2a_2` int(3) NOT NULL,
  `winhold2a_3` int(3) NOT NULL,
  `winhold2b_1` int(3) NOT NULL,
  `winhold2b_2` int(3) NOT NULL,
  `winhold2b_3` int(3) NOT NULL,
  `match3_1` int(3) NOT NULL,
  `match3_2` int(3) NOT NULL,
  `match3_3` int(3) NOT NULL,
  `wintype3a_1` int(3) NOT NULL,
  `wintype3a_2` int(3) NOT NULL,
  `wintype3b_1` int(3) NOT NULL,
  `wintype3b_2` int(3) NOT NULL,
  `wintime3a_1` int(3) NOT NULL,
  `wintime3a_2` int(3) NOT NULL,
  `wintime3b_1` int(3) NOT NULL,
  `wintime3b_2` int(3) NOT NULL,
  `winhold3a_1` int(3) NOT NULL,
  `winhold3a_2` int(3) NOT NULL,
  `winhold3a_3` int(3) NOT NULL,
  `winhold3b_1` int(3) NOT NULL,
  `winhold3b_2` int(3) NOT NULL,
  `winhold3b_3` int(3) NOT NULL,
  `match4_1` int(3) NOT NULL,
  `match4_2` int(3) NOT NULL,
  `match4_3` int(3) NOT NULL,
  `wintype4a_1` int(3) NOT NULL,
  `wintype4a_2` int(3) NOT NULL,
  `wintype4b_1` int(3) NOT NULL,
  `wintype4b_2` int(3) NOT NULL,
  `wintime4a_1` int(3) NOT NULL,
  `wintime4a_2` int(3) NOT NULL,
  `wintime4b_1` int(3) NOT NULL,
  `wintime4b_2` int(3) NOT NULL,
  `winhold4a_1` int(3) NOT NULL,
  `winhold4a_2` int(3) NOT NULL,
  `winhold4a_3` int(3) NOT NULL,
  `winhold4b_1` int(3) NOT NULL,
  `winhold4b_2` int(3) NOT NULL,
  `winhold4b_3` int(3) NOT NULL,
  `match5_1` int(3) NOT NULL,
  `match5_2` int(3) NOT NULL,
  `match5_3` int(3) NOT NULL,
  `wintype5a_1` int(3) NOT NULL,
  `wintype5a_2` int(3) NOT NULL,
  `wintype5b_1` int(3) NOT NULL,
  `wintype5b_2` int(3) NOT NULL,
  `wintime5a_1` int(3) NOT NULL,
  `wintime5a_2` int(3) NOT NULL,
  `wintime5b_1` int(3) NOT NULL,
  `wintime5b_2` int(3) NOT NULL,
  `winhold5a_1` int(3) NOT NULL,
  `winhold5a_2` int(3) NOT NULL,
  `winhold5a_3` int(3) NOT NULL,
  `winhold5b_1` int(3) NOT NULL,
  `winhold5b_2` int(3) NOT NULL,
  `winhold5b_3` int(3) NOT NULL,
  `match6_1` int(3) NOT NULL,
  `match6_2` int(3) NOT NULL,
  `match6_3` int(3) NOT NULL,
  `wintype6a_1` int(3) NOT NULL,
  `wintype6a_2` int(3) NOT NULL,
  `wintype6b_1` int(3) NOT NULL,
  `wintype6b_2` int(3) NOT NULL,
  `wintime6a_1` int(3) NOT NULL,
  `wintime6a_2` int(3) NOT NULL,
  `wintime6b_1` int(3) NOT NULL,
  `wintime6b_2` int(3) NOT NULL,
  `winhold6a_1` int(3) NOT NULL,
  `winhold6a_2` int(3) NOT NULL,
  `winhold6a_3` int(3) NOT NULL,
  `winhold6b_1` int(3) NOT NULL,
  `winhold6b_2` int(3) NOT NULL,
  `winhold6b_3` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `voting_results_metamoris_3`
--

CREATE TABLE IF NOT EXISTS `voting_results_metamoris_3` (
  `match1_1` int(3) NOT NULL,
  `match1_2` int(3) NOT NULL,
  `match1_3` int(3) NOT NULL,
  `wintype1a_1` int(3) NOT NULL,
  `wintype1a_2` int(3) NOT NULL,
  `wintype1b_1` int(3) NOT NULL,
  `wintype1b_2` int(3) NOT NULL,
  `wintime1a_1` int(3) NOT NULL,
  `wintime1a_2` int(3) NOT NULL,
  `wintime1b_1` int(3) NOT NULL,
  `wintime1b_2` int(3) NOT NULL,
  `winhold1a_1` int(3) NOT NULL,
  `winhold1a_2` int(3) NOT NULL,
  `winhold1a_3` int(3) NOT NULL,
  `winhold1b_1` int(3) NOT NULL,
  `winhold1b_2` int(3) NOT NULL,
  `winhold1b_3` int(3) NOT NULL,
  `match2_1` int(3) NOT NULL,
  `match2_2` int(3) NOT NULL,
  `match2_3` int(3) NOT NULL,
  `wintype2a_1` int(3) NOT NULL,
  `wintype2a_2` int(3) NOT NULL,
  `wintype2b_1` int(3) NOT NULL,
  `wintype2b_2` int(3) NOT NULL,
  `wintime2a_1` int(3) NOT NULL,
  `wintime2a_2` int(3) NOT NULL,
  `wintime2b_1` int(3) NOT NULL,
  `wintime2b_2` int(3) NOT NULL,
  `winhold2a_1` int(3) NOT NULL,
  `winhold2a_2` int(3) NOT NULL,
  `winhold2a_3` int(3) NOT NULL,
  `winhold2b_1` int(3) NOT NULL,
  `winhold2b_2` int(3) NOT NULL,
  `winhold2b_3` int(3) NOT NULL,
  `match3_1` int(3) NOT NULL,
  `match3_2` int(3) NOT NULL,
  `match3_3` int(3) NOT NULL,
  `wintype3a_1` int(3) NOT NULL,
  `wintype3a_2` int(3) NOT NULL,
  `wintype3b_1` int(3) NOT NULL,
  `wintype3b_2` int(3) NOT NULL,
  `wintime3a_1` int(3) NOT NULL,
  `wintime3a_2` int(3) NOT NULL,
  `wintime3b_1` int(3) NOT NULL,
  `wintime3b_2` int(3) NOT NULL,
  `winhold3a_1` int(3) NOT NULL,
  `winhold3a_2` int(3) NOT NULL,
  `winhold3a_3` int(3) NOT NULL,
  `winhold3b_1` int(3) NOT NULL,
  `winhold3b_2` int(3) NOT NULL,
  `winhold3b_3` int(3) NOT NULL,
  `match4_1` int(3) NOT NULL,
  `match4_2` int(3) NOT NULL,
  `match4_3` int(3) NOT NULL,
  `wintype4a_1` int(3) NOT NULL,
  `wintype4a_2` int(3) NOT NULL,
  `wintype4b_1` int(3) NOT NULL,
  `wintype4b_2` int(3) NOT NULL,
  `wintime4a_1` int(3) NOT NULL,
  `wintime4a_2` int(3) NOT NULL,
  `wintime4b_1` int(3) NOT NULL,
  `wintime4b_2` int(3) NOT NULL,
  `winhold4a_1` int(3) NOT NULL,
  `winhold4a_2` int(3) NOT NULL,
  `winhold4a_3` int(3) NOT NULL,
  `winhold4b_1` int(3) NOT NULL,
  `winhold4b_2` int(3) NOT NULL,
  `winhold4b_3` int(3) NOT NULL,
  `match5_1` int(3) NOT NULL,
  `match5_2` int(3) NOT NULL,
  `match5_3` int(3) NOT NULL,
  `wintype5a_1` int(3) NOT NULL,
  `wintype5a_2` int(3) NOT NULL,
  `wintype5b_1` int(3) NOT NULL,
  `wintype5b_2` int(3) NOT NULL,
  `wintime5a_1` int(3) NOT NULL,
  `wintime5a_2` int(3) NOT NULL,
  `wintime5b_1` int(3) NOT NULL,
  `wintime5b_2` int(3) NOT NULL,
  `winhold5a_1` int(3) NOT NULL,
  `winhold5a_2` int(3) NOT NULL,
  `winhold5a_3` int(3) NOT NULL,
  `winhold5b_1` int(3) NOT NULL,
  `winhold5b_2` int(3) NOT NULL,
  `winhold5b_3` int(3) NOT NULL,
  `match6_1` int(3) NOT NULL,
  `match6_2` int(3) NOT NULL,
  `match6_3` int(3) NOT NULL,
  `wintype6a_1` int(3) NOT NULL,
  `wintype6a_2` int(3) NOT NULL,
  `wintype6b_1` int(3) NOT NULL,
  `wintype6b_2` int(3) NOT NULL,
  `wintime6a_1` int(3) NOT NULL,
  `wintime6a_2` int(3) NOT NULL,
  `wintime6b_1` int(3) NOT NULL,
  `wintime6b_2` int(3) NOT NULL,
  `winhold6a_1` int(3) NOT NULL,
  `winhold6a_2` int(3) NOT NULL,
  `winhold6a_3` int(3) NOT NULL,
  `winhold6b_1` int(3) NOT NULL,
  `winhold6b_2` int(3) NOT NULL,
  `winhold6b_3` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `voting_results_metamoris_4`
--

CREATE TABLE IF NOT EXISTS `voting_results_metamoris_4` (
  `match1_1` int(3) NOT NULL,
  `match1_2` int(3) NOT NULL,
  `match1_3` int(3) NOT NULL,
  `wintype1a_1` int(3) NOT NULL,
  `wintype1a_2` int(3) NOT NULL,
  `wintype1b_1` int(3) NOT NULL,
  `wintype1b_2` int(3) NOT NULL,
  `wintime1a_1` int(3) NOT NULL,
  `wintime1a_2` int(3) NOT NULL,
  `wintime1b_1` int(3) NOT NULL,
  `wintime1b_2` int(3) NOT NULL,
  `winhold1a_1` int(3) NOT NULL,
  `winhold1a_2` int(3) NOT NULL,
  `winhold1a_3` int(3) NOT NULL,
  `winhold1b_1` int(3) NOT NULL,
  `winhold1b_2` int(3) NOT NULL,
  `winhold1b_3` int(3) NOT NULL,
  `match2_1` int(3) NOT NULL,
  `match2_2` int(3) NOT NULL,
  `match2_3` int(3) NOT NULL,
  `wintype2a_1` int(3) NOT NULL,
  `wintype2a_2` int(3) NOT NULL,
  `wintype2b_1` int(3) NOT NULL,
  `wintype2b_2` int(3) NOT NULL,
  `wintime2a_1` int(3) NOT NULL,
  `wintime2a_2` int(3) NOT NULL,
  `wintime2b_1` int(3) NOT NULL,
  `wintime2b_2` int(3) NOT NULL,
  `winhold2a_1` int(3) NOT NULL,
  `winhold2a_2` int(3) NOT NULL,
  `winhold2a_3` int(3) NOT NULL,
  `winhold2b_1` int(3) NOT NULL,
  `winhold2b_2` int(3) NOT NULL,
  `winhold2b_3` int(3) NOT NULL,
  `match3_1` int(3) NOT NULL,
  `match3_2` int(3) NOT NULL,
  `match3_3` int(3) NOT NULL,
  `wintype3a_1` int(3) NOT NULL,
  `wintype3a_2` int(3) NOT NULL,
  `wintype3b_1` int(3) NOT NULL,
  `wintype3b_2` int(3) NOT NULL,
  `wintime3a_1` int(3) NOT NULL,
  `wintime3a_2` int(3) NOT NULL,
  `wintime3b_1` int(3) NOT NULL,
  `wintime3b_2` int(3) NOT NULL,
  `winhold3a_1` int(3) NOT NULL,
  `winhold3a_2` int(3) NOT NULL,
  `winhold3a_3` int(3) NOT NULL,
  `winhold3b_1` int(3) NOT NULL,
  `winhold3b_2` int(3) NOT NULL,
  `winhold3b_3` int(3) NOT NULL,
  `match4_1` int(3) NOT NULL,
  `match4_2` int(3) NOT NULL,
  `match4_3` int(3) NOT NULL,
  `wintype4a_1` int(3) NOT NULL,
  `wintype4a_2` int(3) NOT NULL,
  `wintype4b_1` int(3) NOT NULL,
  `wintype4b_2` int(3) NOT NULL,
  `wintime4a_1` int(3) NOT NULL,
  `wintime4a_2` int(3) NOT NULL,
  `wintime4b_1` int(3) NOT NULL,
  `wintime4b_2` int(3) NOT NULL,
  `winhold4a_1` int(3) NOT NULL,
  `winhold4a_2` int(3) NOT NULL,
  `winhold4a_3` int(3) NOT NULL,
  `winhold4b_1` int(3) NOT NULL,
  `winhold4b_2` int(3) NOT NULL,
  `winhold4b_3` int(3) NOT NULL,
  `match5_1` int(3) NOT NULL,
  `match5_2` int(3) NOT NULL,
  `match5_3` int(3) NOT NULL,
  `wintype5a_1` int(3) NOT NULL,
  `wintype5a_2` int(3) NOT NULL,
  `wintype5b_1` int(3) NOT NULL,
  `wintype5b_2` int(3) NOT NULL,
  `wintime5a_1` int(3) NOT NULL,
  `wintime5a_2` int(3) NOT NULL,
  `wintime5b_1` int(3) NOT NULL,
  `wintime5b_2` int(3) NOT NULL,
  `winhold5a_1` int(3) NOT NULL,
  `winhold5a_2` int(3) NOT NULL,
  `winhold5a_3` int(3) NOT NULL,
  `winhold5b_1` int(3) NOT NULL,
  `winhold5b_2` int(3) NOT NULL,
  `winhold5b_3` int(3) NOT NULL,
  `match6_1` int(3) NOT NULL,
  `match6_2` int(3) NOT NULL,
  `match6_3` int(3) NOT NULL,
  `wintype6a_1` int(3) NOT NULL,
  `wintype6a_2` int(3) NOT NULL,
  `wintype6b_1` int(3) NOT NULL,
  `wintype6b_2` int(3) NOT NULL,
  `wintime6a_1` int(3) NOT NULL,
  `wintime6a_2` int(3) NOT NULL,
  `wintime6b_1` int(3) NOT NULL,
  `wintime6b_2` int(3) NOT NULL,
  `winhold6a_1` int(3) NOT NULL,
  `winhold6a_2` int(3) NOT NULL,
  `winhold6a_3` int(3) NOT NULL,
  `winhold6b_1` int(3) NOT NULL,
  `winhold6b_2` int(3) NOT NULL,
  `winhold6b_3` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `whos_online`
--

CREATE TABLE IF NOT EXISTS `whos_online` (
  `customer_id` int(11) DEFAULT NULL,
  `full_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `session_id` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `ip_address` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `time_entry` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `time_last_click` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `last_page_url` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `zones`
--

CREATE TABLE IF NOT EXISTS `zones` (
  `zone_id` int(11) NOT NULL AUTO_INCREMENT,
  `zone_country_id` int(11) NOT NULL,
  `zone_code` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `zone_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`zone_id`),
  KEY `idx_zones_country_id` (`zone_country_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=183 ;

-- --------------------------------------------------------

--
-- Table structure for table `zones_to_geo_zones`
--

CREATE TABLE IF NOT EXISTS `zones_to_geo_zones` (
  `association_id` int(11) NOT NULL AUTO_INCREMENT,
  `zone_country_id` int(11) NOT NULL,
  `zone_id` int(11) DEFAULT NULL,
  `geo_zone_id` int(11) DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`association_id`),
  KEY `idx_zones_to_geo_zones_country_id` (`zone_country_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=241 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
