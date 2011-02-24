-- phpMyAdmin SQL Dump
-- version 3.3.7deb5build0.10.10.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 24, 2011 at 01:52 PM
-- Server version: 5.1.49
-- PHP Version: 5.3.3-1ubuntu9.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `WhyISoFool_development`
--

-- --------------------------------------------------------

--
-- Table structure for table `schema_migrations`
--

CREATE TABLE IF NOT EXISTS `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `schema_migrations`
--

INSERT INTO `schema_migrations` (`version`) VALUES
('20110219150726'),
('20110220184600');

-- --------------------------------------------------------

--
-- Table structure for table `stories`
--

CREATE TABLE IF NOT EXISTS `stories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  `author` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `aprooved` tinyint(1) DEFAULT NULL,
  `rate` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=18 ;

--
-- Dumping data for table `stories`
--

INSERT INTO `stories` (`id`, `content`, `author`, `aprooved`, `rate`, `created_at`, `updated_at`) VALUES
(1, 'Был у меня парень, хороший, красивый, зарабатывал прилично. Захотела проверить его на верность и попросила лучшую подругу мне в этом деле помочь. Прошло какое-то время, подруга сказала, пробовала его соблазнить,  но он ни в какую. Ну я на радостях решила сделать ему сюрприз: надела своё любимое бельё, купила торт и пошла к нему без предупреждения. И знаете, что я там увидела? Я увидела как он трахал мою лучшую подругу… Теперь нет ни парня, ни подруги. Блять, почему я такая дура???', '', 1, 1, '2011-02-23 17:25:59', '2011-02-24 00:44:38'),
(2, 'На одной вечеринке друг познакомил меня с классной девушкой, которая мне очень понравилась. 3 месяца  я за ней ухаживал: цветы, подарки, рестораны… В итоге узнаю, что всё это время она занималась сексом с моим другом, который нас познакомил, а от меня ей нужно было только ухаживание… Ну не дурра, а?', '', 1, 1, '2011-02-23 17:26:28', '2011-02-24 00:44:41'),
(3, 'Кошка обгадила моё свадебное платье!!! Ну не дуры ли?', '', 1, 1, '2011-02-23 17:26:49', '2011-02-24 00:44:45'),
(4, 'Расскажу про случай с моей бывшей женой. Еще в 1991 году приваливаю поздно домой – в "бобика пьяный".  Жена сжалилась и стала меня раздевать, но случайно нашла в моем кармане женские трусики одной девчонки, с которой мы стоя занимались сексом в подъезде... Жена вой подняла. Я говорю, что эти трусы я ей принес в подарок. Она орет, что они старые. Я трезвею и объясняю: "Ну, ты темная у меня. Это же "сэконд-хенд" - американская распродажа для бедных россиян. Я всю зарплату на эти трусы с сеточкой грохнул. Носи, не сомневайся". Но эти трусики \r\nжене поносить не пришлось. Она на них в этот же вечер нашла советскую этикетку московской швейной фабрики. Без толку ей было потом объяснять, что это русские эмигранты, наверно, сдали эти ношеные трусы в Америке...   Помню, мы с женой пол года не разговаривали...  \r\n', '', 1, 0, '2011-02-23 17:27:05', '2011-02-23 17:27:08'),
(5, 'Меня возмущают высказывания женщин по поводу того, что их не устраивают \r\nразмеры половых достоинств их партнеров. Ведь не размер важен. Просто женщины \r\nвсегда чем-то недовольны, а свою похотливость им оправдать чем-то нужно. В этом \r\nя сам убедился. Однажды я познакомился с женщиной на пять лет старше меня. Она \r\nвсе время жаловалась: "Вот у моего мужа маленький, тонкий...". А когда у нас с \r\nней дело дошло до постели, то получилась хохма. Стоило мне обнажить свое \r\nхозяйство, как она с диким криком: "Ты мне все там порвешь!" - вскочила и быстро \r\nоделась. Так объясните мне женщины, что вам нужно: если в диаметре 3,5 см вам \r\nмало, а 6 см - много? Дуры!\r\n', '', 1, 2, '2011-02-23 17:27:25', '2011-02-23 19:01:25'),
(6, 'Шеф вызвал к себе, и вручив документы сказал СРОЧНО отправить их заказчику. По дороге обратно в совой кабинет встретила девочек из бухгалтерии, те завалакли к себе на чай… В итоге, документы я отправить забыла, и фирма лишилась контракта на $ 600 тыс. Шеф сказал, что до конца жизни отрабатывать буду. Почему я такая дура?', '', 1, 0, '2011-02-23 17:27:43', '2011-02-23 17:28:03'),
(7, 'На выходных решила познакомить своего парня с предками. Думала, что найдут  общий язык, ну вроде интеллигентные люди.\r\nНо тут случилось то, что я не ожидала  - маму понесло. Весь вечер рассказывала о моих достоинствах, о том, какие у меня раньше парни хорошие были, богатые, красивые, умные, какие перспективы и тому подобное.  Ну вот почему она такая дура?\r\n', '', 1, -1, '2011-02-23 17:27:56', '2011-02-24 00:44:50'),
(8, 'Я далеко не глупая девушка, но из-за вот таких вот сайтов мне грозит вот уже 3-е отчисление с первого курса. Дура я!', '', 1, 0, '2011-02-23 17:28:21', '2011-02-23 19:01:09'),
(9, 'WTF???', '', 1, 1, '2011-02-23 17:28:43', '2011-02-23 19:01:07'),
(10, 'Я прошёл Властелин Колец!!! УХУ =)', '', 1, 2, '2011-02-23 17:29:13', '2011-02-23 19:01:13'),
(11, 'бла-бла-бла', '', 1, -1, '2011-02-23 17:29:30', '2011-02-23 19:01:18'),
(14, 'А я пычку зматерся. у еее', 'тыдыщ', 1, 0, '2011-02-24 00:52:29', '2011-02-24 00:56:58'),
(15, 'тыдыщ', '', 1, -1, '2011-02-24 00:53:06', '2011-02-24 00:59:47'),
(16, 'фыв', '', 1, 0, '2011-02-24 00:53:24', '2011-02-24 11:04:03');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_salt` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password_salt`, `password_hash`, `created_at`, `updated_at`) VALUES
(1, 'Smit', 'T0KG3/Pi', 'f63686c54a6e7efc7e23ebc38259a658acbcdab39186ca10ee411524f03321f7', '2011-02-23 17:20:21', '2011-02-23 17:20:21'),
(2, 'papka', 'pGp6/kGX', 'b18363b5716428c6bdbb3a5878ecb684275f60ad08954076e2765b0e17420319', '2011-02-23 17:21:56', '2011-02-23 17:21:56');
