CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- To have the minimal data of a user.
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    username VARCHAR NOT NULL,
    password VARCHAR NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(id),
    UNIQUE(username)
);

CREATE TYPE user_status AS ENUM ('NOT_VERIFIED', 'VERIFIED', 'BLOCKED');
DROP TABLE IF EXISTS user_details;
CREATE TABLE user_details (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users (id),
    phone VARCHAR DEFAULT '',
    email VARCHAR DEFAULT '',
    address VARCHAR DEFAULT '',
    first_name VARCHAR DEFAULT '',
    last_name VARCHAR DEFAULT '',
    status user_status default 'NOT_VERIFIED',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(id),
    UNIQUE(user_id)
);

-- All about access tokens
CREATE TYPE access_token_type AS ENUM ('DEFAULT', 'FACEBOOK', 'GOOGLE', 'TWITTER', 'LINKEDIN');
DROP TABLE IF EXISTS access_token;
CREATE TABLE access_token (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    token VARCHAR NOT NULL,
    user_id UUID NOT NULL REFERENCES users (id),
    ttl INTEGER NOT NULL DEFAULT 100000,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    type access_token_type default 'DEFAULT',
    UNIQUE(id)
);
