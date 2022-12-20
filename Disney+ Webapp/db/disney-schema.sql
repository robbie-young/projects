CREATE TABLE super_table(
    id SERIAL,
    type_id INT,
    title TEXT,
    director TEXT,
    actors TEXT,
    countries_id INT,
    date_added_id INT,
    release_year INT,
    rating_id INT,
    duration TEXT,
    genres_id INT,
    description TEXT
);

CREATE TABLE type(
    id SERIAL,
    type TEXT
);

CREATE TABLE countries(
    id SERIAL,
    countries TEXT
);

CREATE TABLE date_added(
    id SERIAL,
    date_added TEXT
);

CREATE TABLE rating(
    id SERIAL,
    rating TEXT
);

CREATE TABLE genres(
    id SERIAL,
    genres TEXT
);