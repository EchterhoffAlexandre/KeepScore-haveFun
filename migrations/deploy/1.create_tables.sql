-- Deploy KSHF:1.create_tables to pg

BEGIN;

CREATE TABLE shop (
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    description TEXT NOT NULL,
    price int NOT NULL
);

CREATE TABLE collection (
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    description TEXT NOT NULL,
    own BOOLEAN NOT NULL DEFAULT NULL, -- 0 = ne possède pas / 1 = possède
    active BOOLEAN NOT NULL DEFAULT NULL -- 0 = pas actif / 1 = actif
);

CREATE TABLE quest (
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    description TEXT NOT NULL, 
    difficulty int NOT NULL, -- 1 easy 2 medium 3 hard
    reward_exp int NOT NULL, -- valeur en expérience
    reward_coin int NOT NULL, -- valeur en or
    reward_item int REFERENCES collection(id)
);


CREATE TABLE transaction (
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,  
    date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    input int NOT NULL,
    output int NOT NULL
);


CREATE TABLE "user" (
    id int GENERATED ALWAYS AS IDENTITY,
    mail TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    lastname TEXT NOT NULL,
    password TEXT NOT NULL UNIQUE,
    level int NOT NULL DEFAULT 1,
    wallet int NOT NULL DEFAULT 50,
    transaction int REFERENCES transaction(id),
    collection int[] REFERENCES collection(id),
    family int REFERENCES family(id) DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE family (
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    level INT NOT NULL,
    members int[] REFERENCES "user"(id) 
);


CREATE TABLE user_has_family (
    family_id int REFERENCES family(id),
    user_id int REFERENCES "user"(id),
    date TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY (user_id, family_id)
);

CREATE TABLE user_has_friend (
    user_id int REFERENCES "user"(id),
    friend_id int REFERENCES "user"(id),
    date TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY (user_id, friend_id)
);


COMMIT;