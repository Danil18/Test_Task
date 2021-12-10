-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Дек 10 2021 г., 11:19
-- Версия сервера: 5.7.23
-- Версия PHP: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `library`
--

-- --------------------------------------------------------

--
-- Структура таблицы `access_keys`
--

DROP TABLE IF EXISTS `access_keys`;
CREATE TABLE IF NOT EXISTS `access_keys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `a_key` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `access_keys`
--

INSERT INTO `access_keys` (`id`, `a_key`) VALUES
(1, '202cb962ac59075b964b07152d234b70');

-- --------------------------------------------------------

--
-- Структура таблицы `books`
--

DROP TABLE IF EXISTS `books`;
CREATE TABLE IF NOT EXISTS `books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `book_status` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `books`
--

INSERT INTO `books` (`id`, `title`, `author`, `book_status`) VALUES
(1, 'Собака Баскервилей', 'Артур Конан Дойл', 'active'),
(2, 'Мастер и Маргарита', 'Михаил Булгаков', 'active'),
(3, 'Робинзон Крузо', 'Даниель Дефо', 'active'),
(4, 'Муму', 'Иван Тургенев', 'active'),
(5, 'Война и мир', 'Лев Толстой', 'active'),
(6, 'Властелин Колец. В 3-х томах', 'Дж. Толкин', 'active');

-- --------------------------------------------------------

--
-- Структура таблицы `give_books`
--

DROP TABLE IF EXISTS `give_books`;
CREATE TABLE IF NOT EXISTS `give_books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_reader` int(11) NOT NULL,
  `id_books` int(11) NOT NULL,
  `status` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_reader` (`id_reader`,`id_books`),
  KEY `id_books` (`id_books`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `give_books`
--

INSERT INTO `give_books` (`id`, `id_reader`, `id_books`, `status`) VALUES
(1, 1, 1, 'returned'),
(2, 2, 2, 'reading'),
(3, 3, 4, 'returned'),
(4, 1, 3, 'reading'),
(5, 1, 5, 'returned'),
(6, 5, 4, 'reading'),
(7, 6, 1, 'reading'),
(8, 5, 5, 'reading'),
(9, 4, 6, 'reading');

-- --------------------------------------------------------

--
-- Структура таблицы `reader`
--

DROP TABLE IF EXISTS `reader`;
CREATE TABLE IF NOT EXISTS `reader` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `surname` varchar(80) NOT NULL,
  `name` varchar(80) NOT NULL,
  `patronymic` varchar(80) NOT NULL,
  `account_status` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `reader`
--

INSERT INTO `reader` (`id`, `surname`, `name`, `patronymic`, `account_status`) VALUES
(1, 'Иванов', 'Иван', 'Иванович', 'active'),
(2, 'Антонов', 'Антон', 'Антонович', 'active'),
(3, 'Александров', 'Александр', 'Александрович', 'active'),
(4, 'Владимиров', 'Владимир', 'Владимирович', 'active'),
(5, 'Николаев', 'Николай', 'Николаевич', 'active'),
(6, 'Евгеньев', 'Евгений', 'Евгеньевич', 'active');

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `give_books`
--
ALTER TABLE `give_books`
  ADD CONSTRAINT `give_books_ibfk_1` FOREIGN KEY (`id_books`) REFERENCES `books` (`id`),
  ADD CONSTRAINT `give_books_ibfk_2` FOREIGN KEY (`id_reader`) REFERENCES `reader` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
