CREATE TABLE order_deatils(
order_details_id SMALLINT NOT NULL,
order_id SMALLINT NOT NULL,
order_date DATE,
order_time TIME,
item_id SMALLINT,
primary key (order_details_id)
)


CREATE TABLE menu_items(
menu_item_id SMALLINT NOT NULL,
item_name VARCHAR(45),
category VARCHAR(45),
price INT
)
