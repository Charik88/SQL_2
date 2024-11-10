/*Задание 2
 
 Написать SELECT-запросы, которые выведут информацию согласно инструкциям ниже.

 Внимание: результаты запросов не должны быть пустыми, учтите это при заполнении таблиц.

     Название и продолжительность самого длительного трека.
     Название треков, продолжительность которых не менее 3,5 минут.
     Названия сборников, вышедших в период с 2018 по 2020 годы включительно.
     Исполнители, чьё имя состоит из одного слова.
     Название треков, которые содержат слова «мой» или «my».
*/



-- Создание таблицы жанров
CREATE TABLE IF NOT EXISTS genre (
    id SERIAL PRIMARY KEY,
    name VARCHAR(60) NOT NULL
);

-- Создание таблицы исполнителей
CREATE TABLE IF NOT EXISTS artist (
    id SERIAL PRIMARY KEY,
    name VARCHAR(60) NOT NULL,
    genre TEXT NOT NULL
);

-- Создание таблицы альбомов
CREATE TABLE IF NOT EXISTS album (
    id SERIAL PRIMARY KEY,
    name VARCHAR(60) NOT NULL,
    year INTEGER NOT NULL,
    executor TEXT NOT NULL
);

-- Создание таблицы треков
CREATE TABLE IF NOT EXISTS track (
    id SERIAL PRIMARY KEY,
    name VARCHAR(60) NOT NULL,
    time INTEGER NOT NULL,  -- Время в секундах
    album TEXT NOT NULL
);

-- Создание таблицы сборников
CREATE TABLE IF NOT EXISTS collection (
    id SERIAL PRIMARY KEY,
    name VARCHAR(60) NOT NULL,
    year INTEGER NOT NULL
);

-- Создание таблицы связей исполнителей и жанров
CREATE TABLE IF NOT EXISTS artist_genre (
    genre_id INTEGER REFERENCES genre(id),
    artist_id INTEGER REFERENCES artist(id),
    PRIMARY KEY (genre_id, artist_id)
);

-- Создание таблицы связей исполнителей и альбомов
CREATE TABLE IF NOT EXISTS artist_album (
    artist_id INTEGER REFERENCES artist(id),
    album_id INTEGER REFERENCES album(id),
    PRIMARY KEY (artist_id, album_id)
);

-- Создание таблицы связей треков и сборников
CREATE TABLE IF NOT EXISTS track_collection (
    track_id INTEGER REFERENCES track(id),
    collection_id INTEGER REFERENCES collection(id),
    PRIMARY KEY (track_id, collection_id)
);

-- Вставка данных в таблицу жанров
INSERT INTO genre (name) VALUES
('Rock'),
('Pop'),
('Hip-Hop'),
('Jazz');

-- Вставка данных в таблицу исполнителей
INSERT INTO artist (name, genre) VALUES
('ArtistA', 'Rock'),  -- Одно слово
('ArtistB', 'Pop'),   -- Одно слово
('Artist C', 'Hip-Hop'), -- Два слова
('ArtistD', 'Jazz');  -- Одно слово

-- Вставка данных в таблицу альбомов
INSERT INTO album (name, year, executor) VALUES
('Album 1', 2020, 'Artist A'),
('Album 2', 2021, 'Artist B'),
('Album 3', 2019, 'Artist C');

-- Вставка данных в таблицу треков
INSERT INTO track (name, time, album) VALUES
('Track 1 - мой', 210, 'Album 1'),  -- 3.5 минуты
('Track 2', 180, 'Album 1'),         -- 3 минуты
('Track 3 - my', 240, 'Album 2'),    -- 4 минуты
('Track 4', 200, 'Album 2'),         -- 3 минуты 20 секунд
('Track 5', 220, 'Album 3'),         -- 3.66 минуты
('Track 6', 190, 'Album 3');         -- 3 минуты 10 секунд

-- Вставка данных в таблицу сборников
INSERT INTO collection (name, year) VALUES
('Collection 1', 2019),  -- Входит в диапазон
('Collection 2', 2020),  -- Входит в диапазон
('Collection 3', 2021),  -- Входит в диапазон
('Collection 4', 2022);  -- Не входит в диапазон

-- Вставка данных в таблицу связей исполнителей и жанров
INSERT INTO artist_genre (genre_id, artist_id) VALUES
(1, 1),  -- Artist A - Rock
(2, 2),  -- Artist B - Pop
(3, 3),  -- Artist C - Hip-Hop
(4, 4);  -- Artist D - Jazz

-- Вставка данных в таблицу связей исполнителей и альбомов
INSERT INTO artist_album (artist_id, album_id) VALUES
(1, 1),  -- Artist A - Album 1
(2, 2),  -- Artist B - Album 2
(3, 3);  -- Artist C - Album 3

-- Вставка данных в таблицу связей треков и сборников
INSERT INTO track_collection (track_id, collection_id) VALUES
(1, 1),  -- Track 1 in Collection 1
(2, 1),  -- Track 2 in Collection 1
(3, 2),  -- Track 3 in Collection 2
(4, 2),  -- Track 4 in Collection 2
(5, 3),  -- Track 5 in Collection 3
(6, 4);  -- Track 6 in Collection 4

-- Запрос 1: Название и продолжительность самого длительного трека
SELECT name, time
FROM track
ORDER BY time DESC
LIMIT 1;

-- Запрос 2: Название треков, продолжительность которых не менее 3,5 минут
SELECT name
FROM track
WHERE time >= 210;  -- 3.5 minutes = 210 seconds

-- Запрос 3: Названия сборников, вышедших в период с 2018 по 2020 годы включительно
SELECT name
FROM collection
WHERE year BETWEEN 2018 AND 2020;

-- Запрос 4: Исполнители, чьё имя состоит из одного слова
SELECT name
FROM artist
WHERE name NOT LIKE '% %';  -- Не содержит пробелов

-- Запрос 5: Название треков, которые содержат слова «мой» или «my»
SELECT name
FROM track
WHERE name ILIKE '%мой%' OR name ILIKE '%my%';  -- ILIKE для нечувствительности к регистру
