create table if not exists musical_genre (
id serial primary key,
name varchar(60) not null
);

create table if not exists executor (
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

create table if not exists musical_genre_executor(
musical_genre_id integer references musical_genre(id),
executor_id integer references executor(id)
);

create table if not exists executor_album (
executor_id integer references executor(id),
album_id integer references album(id)
);

create table if not exists track_collection (
track_id integer references track(id),
collection_id integer references collection(id)
);
