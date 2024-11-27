CREATE TABLE public.points (
    id integer NOT NULL,
    x double precision NOT NULL,
    y double precision NOT NULL,
    r double precision NOT NULL,
    creation_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    execution_time bigint NOT NULL,
    result boolean NOT NULL
);
