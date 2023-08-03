psql -U postgres
CREATE ROLE node_user WITH LOGIN PASSWORD 'node_password';
ALTER ROLE node_user CREATEDB;
\q
psql -d postgres -U node_user
CREATE DATABASE db_bootcamps;
\c db_bootcamps;
CREATE TABLE users(
    id SERIAL PRIMARY KEY NOT NULL,
    firstname VARCHAR (50) NOT NULL, 
    lastname VARCHAR (50) NOT NULL, 
    email VARCHAR (50) UNIQUE NOT NULL,
    createat DATE,
    updateat TIMESTAMP WITH TIME ZONE NOT NULL
);
CREATE TABLE bootcamps (
    id SERIAL PRIMARY KEY NOT NULL,
    title VARCHAR (100) NOT NULL, 
    cue INTEGER NOT NULL CHECK (cue >= 5 AND cue <= 10), 
    descript VARCHAR (500) NOT NULL,
    createat DATE,
    updateat TIMESTAMP WITH TIME ZONE NOT NULL
);
CREATE TABLE usersYbootcamps (
    createat TIMESTAMP WITH TIME ZONE NOT NULL,
    updateat TIMESTAMP WITH TIME ZONE NOT NULL,
    idbootcamp INTEGER,
    idcliente INTEGER,
    FOREIGN KEY(idbootcamp) REFERENCES bootcamps(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(idcliente) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO users (firstName, lastName, email, createat , updateat) VALUES ('Angeles', 'Cahill', 'angeles.cahill@gmail.com', '2023/08/02 13:00:00.59', '2023/08/02 13:00:00.59');

INSERT INTO bootcamps (title, cue, descript, createat , updateat) VALUES ('Bootcamp Front Vue', 8, 'El curso se enfocará en desarrollar las habilidades necesarias para crear paginas web con VueJs', '2023/08/02 14:00:00.59', '2023/08/02 14:00:00.59');

INSERT INTO usersYbootcamps (createat , updateat, idbootcamp, idcliente) VALUES ('2023/08/02 14:00:00.59', '2023/08/02 14:00:00.59', 1, 1);


// Devolucion:

CREATE TABLE IF NOT EXISTS users (
    id SERIAL , 
    firstName VARCHAR(255), 
    lastName VARCHAR(255), 
    email VARCHAR(255), 
    createdAt TIMESTAMP WITH TIME ZONE NOT NULL, 
    updatedAt TIMESTAMP WITH TIME ZONE NOT NULL, 
    UNIQUE (email), 
    PRIMARY KEY (id)
    );

SELECT i.relname AS name, ix.indisprimary AS primary, ix.indisunique AS unique, ix.indkey AS indkey,
array_agg(a.attnum) as column_indexes, array_agg(a.attname) AS column_names, pg_get_indexdef(ix.indexrelid) 
AS definition FROM
pg_class t, pg_class i, pg_index ix, pg_attribute a 
WHERE t.oid = ix.indrelid 
AND i.oid = ix.indexrelid 
AND a.attrelid = t.oid 
AND
t.relkind = 'r' and t.relname = 'users' 
GROUP BY i.relname, ix.indexrelid, ix.indisprimary, ix.indisunique, ix.indkey 
ORDER BY i.relname;

CREATE TABLE IF NOT EXISTS bootcamps (
    id SERIAL , 
    title VARCHAR(255), 
    cue INTEGER,
    description VARCHAR(255), 
    createdAt TIMESTAMP WITH TIME ZONE NOT NULL, 
    updatedAt TIMESTAMP WITH TIME ZONE NOT NULL, PRIMARY KEY (id)
);

SELECT i.relname AS name, ix.indisprimary AS primary, ix.indisunique AS unique, ix.indkey AS indkey,
array_agg(a.attnum) as column_indexes, array_agg(a.attname) AS column_names, pg_get_indexdef(ix.indexrelid) 
AS definition FROM
pg_class t, pg_class i, pg_index ix, pg_attribute a 
WHERE t.oid = ix.indrelid 
AND i.oid = ix.indexrelid 
AND a.attrelid = t.oid 
AND
t.relkind = 'r' and t.relname = 'bootcamps' GROUP BY i.relname, ix.indexrelid, ix.indisprimary, ix.indisunique, ix.indkey 
ORDER BY i.relname;


CREATE TABLE IF NOT EXISTS user_bootcamp (
    createdAt TIMESTAMP WITH TIME ZONE NOT NULL,
    updatedAt TIMESTAMP WITH TIME ZONE NOT NULL, 
    user_id INTEGER REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE, 
    bootcamp_id INTEGER REFERENCES bootcamps (id) ON DELETE CASCADE ON UPDATE CASCADE, 
    PRIMARY KEY (user_id,bootcamp_id)
);

SELECT i.relname AS name, ix.indisprimary AS primary, ix.indisunique AS unique, ix.indkey AS indkey,
array_agg(a.attnum) as column_indexes, array_agg(a.attname) AS column_names, pg_get_indexdef(ix.indexrelid) 
AS definition FROM
pg_class t, pg_class i, pg_index ix, pg_attribute a 
WHERE t.oid = ix.indrelid 
AND i.oid = ix.indexrelid 
AND a.attrelid = t.oid 
AND
t.relkind = 'r' and t.relname = 'user_bootcamp' GROUP BY i.relname, ix.indexrelid, ix.indisprimary, ix.indisunique, ix.indkey 
ORDER BY i.relname;

Eliminando y resincronizando la base de datos.
INSERT INTO "users" ("id","firstName","lastName","email","createdAt","updatedAt") VALUES
(DEFAULT,$1,$2,$3,$4,$5) RETURNING "id","firstName","lastName","email","createdAt","updatedAt";

>> Se ha creado el usuario: 
{
    "id": 1,
    "firstName": "Mateo",
    "lastName": "Díaz",
    "email": "mateo.diaz@correo.com",
    "updatedAt": "2022-04-23T18:06:22.251Z",
    "createdAt": "2022-04-23T18:06:22.251Z"
}

INSERT INTO "users" ("id","firstName","lastName","email","createdAt","updatedAt") VALUES
(DEFAULT,$1,$2,$3,$4,$5) RETURNING "id","firstName","lastName","email","createdAt","updatedAt";

>> Se ha creado el usuario: 
{
    "id": 2,
    "firstName": "Santiago",
    "lastName": "Mejias",
    "email": "santiago.mejias@correo.com",
    "updatedAt": "2022-04-23T18:06:22.307Z",
    "createdAt": "2022-04-23T18:06:22.307Z"
}

INSERT INTO "users" ("id","firstName","lastName","email","createdAt","updatedAt") VALUES
(DEFAULT,$1,$2,$3,$4,$5) RETURNING "id","firstName","lastName","email","createdAt","updatedAt";

>> Se ha creado el usuario: 
{
    "id": 3,
    "firstName": "Lucas",
    "lastName": "Rojas",
    "email": "lucas.rojas@correo.com",
    "updatedAt": "2022-04-23T18:06:22.318Z",
    "createdAt": "2022-04-23T18:06:22.318Z"
}

INSERT INTO "users" ("id","firstName","lastName","email","createdAt","updatedAt") VALUES
(DEFAULT,$1,$2,$3,$4,$5) RETURNING "id","firstName","lastName","email","createdAt","updatedAt";

>> Se ha creado el usuario: 
{
    "id": 4,
    "firstName": "Facundo",
    "lastName": "Fernández",
    "email": "facundo.fernandez@correo.com",
    "updatedAt": "2022-04-23T18:06:22.330Z",
    "createdAt": "2022-04-23T18:06:22.33"
}