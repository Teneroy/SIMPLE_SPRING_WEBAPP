delete from user_role;
delete from users_data;

insert into users_data(id, active, username, password) values
(1, true, 'admin', '$2a$08$zPG5GP45BHfJQ5SWepSz7.IbNJQSz4iiAclNGNSZRwe4cffST6gTG'),
(2, true, 'test', '$2a$08$zPG5GP45BHfJQ5SWepSz7.IbNJQSz4iiAclNGNSZRwe4cffST6gTG'),
(3, true, 'bob', '$2a$08$zPG5GP45BHfJQ5SWepSz7.IbNJQSz4iiAclNGNSZRwe4cffST6gTG');

insert into user_role(user_id, roles) values
(1, 'USER'), (1, 'ADMIN'),
(2, 'USER'), (2, 'ADMIN'),
(3, 'USER');