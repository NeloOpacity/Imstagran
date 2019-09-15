

create table user_role(
    user_id INT,
    roles varchar(255)
);

insert into user_role(user_id,roles)
    values(1,'USER'),(1,'ADMIN');