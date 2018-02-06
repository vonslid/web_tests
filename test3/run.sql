DROP DATABASE IF EXISTS books_db;

CREATE DATABASE books_db DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

USE books_db;

CREATE TABLE books (
	id INT AUTO_INCREMENT PRIMARY KEY,
	isbn VARCHAR(17),
	title VARCHAR(100),
	pages SMALLINT,
	published DATE,
	UNIQUE (isbn)
);

CREATE TABLE authors (
	id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(20),
	last_name VARCHAR(50)
);

CREATE TABLE genres (
	id INT AUTO_INCREMENT PRIMARY KEY,
	genre VARCHAR(50)
);

CREATE TABLE books_genres (
	book_id INT,
	genre_id INT,
	PRIMARY KEY (book_id, genre_id),
	FOREIGN KEY (book_id) REFERENCES books(id)
		ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (genre_id) REFERENCES genres(id)
		ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;


CREATE TABLE books_authors (
	author_id INT,
	book_id INT,
	PRIMARY KEY (author_id, book_id),
	FOREIGN KEY (author_id) REFERENCES authors(id)
		ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (book_id) REFERENCES books(id)
		ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO books (isbn, title, pages, published) VALUES
(111, "Книга один.", 56, "2001-10-11"),
(112, "Книга два.", 45, "2001-10-12"),
(113, "Книга три.", 678, "2001-10-13"),
(114, "Книга четыре.", 345, "2001-10-14"),
(115, "Книга пять.", 253, "2001-10-15"),
(116, "Книга шесть.", 368, "2001-10-16"),
(117, "Книга семь.", 536, "2001-10-17"),
(118, "Книга восемь.", 778, "2001-10-18"),
(119, "Книга девять.", 113, "2001-10-19");

INSERT INTO authors (first_name, last_name) VALUES
("Иван", "Иванов"),
("Петр", "Петров"),
("Сергей", "Сегреев"),
("Сидор", "Сидоров"),
("Александр", "Александров"),
("Василий", "Васильев");

INSERT INTO genres (genre) VALUES
("нф"),
("фэнтези"),
("история"),
("кино"),
("технологии"),
("учебная литература"),
("рукоделие"),
("фантастика"),
("религия");

INSERT INTO books_genres (book_id, genre_id) VALUES
(1,6),
(1,3),
(2,6),
(2,7),
(3,6),
(3,5),
(4,8),
(4,2),
(5,8),
(5,1),
(6,8),
(6,1),
(7,9),
(8,6),
(8,4),
(9,8),
(9,2);

INSERT INTO books_authors (author_id, book_id) VALUES
(1,5),
(2,6),
(2,9),
(3,9),
(3,4),
(3,1),
(4,7),
(5,2),
(6,3),
(6,8);

-- 1. Получаем книги жанра "фантастка"
SELECT
  b.isbn,
  b.title,
  b.pages,
  b.published,
  GROUP_CONCAT(DISTINCT CONCAT(a.first_name, " ", a.last_name)) AS `authors`,
  g.genre -- For MySQL 5.7 and newer use ANY_VALUE(g.genre) or disable sql_mode=only_full_group_by
  FROM books AS b
INNER JOIN books_genres AS bg ON bg.book_id = b.id
INNER JOIN genres AS g ON bg.genre_id = g.id
INNER JOIN books_authors AS ba ON b.id = ba.book_id
INNER JOIN `authors` AS a ON ba.author_id = a.id
WHERE bg.genre_id = (
  SELECT genres.id FROM genres
  WHERE genres.genre = "фантастика"
)
GROUP BY b.id;

-- 2. Получаем максимальное количество книг для автора
SELECT MAX(books_count) FROM (
	SELECT au_bo_ids.id,COUNT(au_bo_ids.id) AS books_count FROM(
		SELECT authors.id, books_authors.book_id FROM authors JOIN books_authors
		ON (authors.id = books_authors.author_id)
	) AS au_bo_ids
	GROUP BY au_bo_ids.id
) AS max_count;

