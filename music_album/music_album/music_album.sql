create table if not exists genre (
id serial primary key,
name varchar(60) not null
);

create table if not exists artist (
id serial primary key,
name varchar (60) not null,
genre text not null
);

create table if not exists album (
id serial primary key,
name varchar(60) not null,
year integer not null,
executor text not null
);

create table if not exists track (
id serial primary key,
name varchar(60) not null,
time integer not null,
album text not null
);

create table if not exists collection (
id serial primary key,
name varchar(60) not null,
year integer not null
);

create table if not exists artist_genre(
genre_id integer references genre(id),
artist_id integer references artist(id),
primary key (genre_id, artist_id)
);

create table if not exists artist_album(
artist_id integer references artist(id),
album_id integer references album(id),
primary key (artist_id, album_id)
);

create table if not exists track_collection(
track_id integer references track(id),
collection_id integer references collection(id),
primary key (track_id, collection_id)
);

