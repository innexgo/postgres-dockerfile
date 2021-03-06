-- Table Structure
-- Primary Key
-- Creation Time
-- Creator User Id (if applicable)
-- Everything else

CREATE DATABASE auth;
\c auth

drop table if exists verification_challenge;
create table verification_challenge(
  verification_challenge_key_hash varchar(64) not null primary key,
  creation_time bigint not null,
  name text not null,
  email text not null,
  password_hash varchar(128) not null
);


drop table if exists user_t;
create table user_t(
  user_id bigserial primary key,
  creation_time bigint not null,
  name text not null,
  email text not null,
  verification_challenge_key_hash text not null
);


drop table if exists password_reset;
create table password_reset(
  password_reset_key_hash varchar(64) not null primary key,
  creation_time bigint not null,
  creator_user_id bigint not null
);

drop table if exists password;
create table password( 
  password_id bigserial primary key,
  creation_time bigint not null,
  creator_user_id bigint not null,
  password_kind bigint not null, -- CHANGE | RESET | CANCEL
  password_hash varchar(128) not null, -- only valid if RESET | CANCEL
  password_reset_key_hash varchar(64) not null -- only valid if RESET
);

drop table if exists api_key;
create table api_key(
  api_key_id bigserial primary key,
  creation_time bigint not null,
  creator_user_id bigint not null,
  api_key_hash varchar(64) not null,
  api_key_kind bigint not null, -- VALID, CANCEL
  duration bigint not null -- only valid if api_key_kind == VALID
);

