/*Задание 1
 
 Продолжаем работать со своей базой данных. В этом задании заполните базу данных из домашнего задания к занятию «Работа с SQL. Создание БД».
 В ней должно быть:

     не менее четырёх исполнителей,
     не менее трёх жанров,
     не менее трёх альбомов,
     не менее шести треков,
     не менее четырёх сборников.

 Внимание: должны быть заполнены все поля каждой таблицы, в том числе таблицы связей исполнителей с жанрами, исполнителей с альбомами, сборников с треками.*/



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
    time INTEGER NOT NULL,
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
('Artist A', 'Rock'),
('Artist B', 'Pop'),
('Artist C', 'Hip-Hop'),
('Artist D', 'Jazz');

-- Вставка данных в таблицу альбомов
INSERT INTO album (name, year, executor) VALUES
('Album 1', 2020, 'Artist A'),
('Album 2', 2021, 'Artist B'),
('Album 3', 2019, 'Artist C');

-- Вставка данных в таблицу треков
INSERT INTO track (name, time, album) VALUES
('Track 1', 210, 'Album 1'),
('Track 2', 180, 'Album 1'),
('Track 3', 240, 'Album 2'),
('Track 4', 200, 'Album 2'),
('Track 5', 220, 'Album 3'),
('Track 6', 190, 'Album 3');

-- Вставка данных в таблицу сборников
INSERT INTO collection (name, year) VALUES
('Collection 1', 2021),
('Collection 2', 2020),
('Collection 3', 2019),
('Collection 4', 2022);

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

