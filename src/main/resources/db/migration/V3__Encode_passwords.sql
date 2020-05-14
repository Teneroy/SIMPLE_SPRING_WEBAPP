create extension if not exists pgcrypto;

update users_data set password = crypt(password, gen_salt('bf', 8));