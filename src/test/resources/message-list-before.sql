delete from message;

insert into message(id, text, tag, user_id) values
(1, 'First message', 't1', 1),
(2, 'Second message', 't1', 2),
(3, 'Third message', 't2', 2),
(4, 'Fourth message', 't3', 3);

alter sequence hibernate_sequence restart with 10;