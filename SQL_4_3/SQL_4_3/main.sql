/*Задание 3

Написать SELECT-запросы, которые выведут информацию согласно инструкциям ниже.

Внимание: результаты запросов не должны быть пустыми, при необходимости добавьте данные в таблицы.

    Количество исполнителей в каждом жанре.
    Количество треков, вошедших в альбомы 2019–2020 годов.
    Средняя продолжительность треков по каждому альбому.
    Все исполнители, которые не выпустили альбомы в 2020 году.
    Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).*/



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
('ArtistD', 'Jazz'),  -- Одно слово
('ArtistE', 'Pop');   -- Еще один исполнитель

-- Вставка данных в таблицу альбомов
INSERT INTO album (name, year, executor) VALUES
('Album 1', 2020, 'Artist A'),
('Album 2', 2019, 'Artist B'),
('Album 3', 2020, 'Artist C'),
('Album 4', 2019, 'Artist D'),
('Album 5', 2021, 'Artist E');  -- Альбом вне диапазона

-- Вставка данных в таблицу треков
INSERT INTO track (name, time, album) VALUES
('Track 1 - мой', 210, 'Album 1'),  -- 3.5 минуты
('Track 2', 180, 'Album 1'),         -- 3 минуты
('Track 3 - my', 240, 'Album 2'),    -- 4 минуты
('Track 4', 200, 'Album 2'),         -- 3 минуты 20 секунд
('Track 5', 220, 'Album 3'),         -- 3.66 минуты
('Track 6', 190, 'Album 4'),         -- 3 минуты 10 секунд
('Track 7', 210, 'Album 4');         -- 3.5 минуты

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
(4, 4),  -- Artist D - Jazz
(2, 5);  -- Artist E - Pop

-- Вставка данных в таблицу связей исполнителей и альбомов
INSERT INTO artist_album (artist_id, album_id) VALUES
(1, 1),  -- Artist A - Album 1
(2, 2),  -- Artist B - Album 2
(3, 3),  -- Artist C - Album 3
(4, 4),  -- Artist D - Album 4
(5, 5);  -- Artist E - Album 5

-- Вставка данных в таблицу связей треков и сборников
INSERT INTO track_collection (track_id, collection_id) VALUES
(1, 1),  -- Track 1 in Collection 1
(2, 1),  -- Track 2 in Collection 1
(3, 2),  -- Track 3 in Collection 2
(4, 2),  -- Track 4 in Collection 2
(5, 3),  -- Track 5 in Collection 3
(6, 4),  -- Track 6 in Collection 4
(7, 1);  -- Track 7 in Collection 1

-- Запрос 1: Количество исполнителей в каждом жанре
SELECT g.name AS genre, COUNT(a.id) AS artist_count
FROM genre g
LEFT JOIN artist a ON g.name = a.genre
GROUP BY g.name;

-- Запрос 2: Количество треков, вошедших в альбомы 2019–2020 годов
SELECT COUNT(t.id) AS track_count
FROM track t
JOIN album a ON t.album = a.name
WHERE a.year BETWEEN 2019 AND 2020;

-- Запрос 3: Средняя продолжительность треков по каждому альбому
SELECT a.name AS album_name, AVG(t.time) AS average_duration
FROM album a
JOIN track t ON a.name = t.album
GROUP BY a.name;

-- Запрос 4: Все исполнители, которые не выпустили альбомы в 2020 году
SELECT DISTINCT ar.name
FROM artist ar
WHERE ar.id NOT IN (
    SELECT DISTINCT aa.artist_id
    FROM artist_album aa
    JOIN album al ON aa.album_id = al.id
    WHERE al.year = 2020
);

-- Запрос 5: Названия сборников, в которых присутствует конкретный исполнитель (например, Artist A)
SELECT c.name AS collection_name
FROM collection c
JOIN track_collection tc ON c.id = tc.collection_id
JOIN track t ON tc.track_id = t.id
WHERE t.album IN (
    SELECT a.name
    FROM album a
    WHERE a.executor = 'Artist A'
);
