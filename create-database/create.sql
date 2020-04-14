drop table if exists items;
drop table if exists users;
drop table if exists bids;
drop table if exists categories;
create table items
(
  item_id	    text primary key not null,
  user_id     text not null,
  name	      text not null,
  buy_price   float,
  first_bid   float not null,
  currently   float not null,
	num_of_bids integer not null,
	started     text not null,	
	ends        text not null,
	description text not null
);

create table bids
(
	item_id     text not null references items(item_id), 
	user_id     text not null references users(user_id),
	time        text not null,
	amount      float not null,
	primary key (item_id, user_id, time)
);

create table categories
(
	item_id     text not null references items(item_id),
	category    text not null,
	primary key(item_id, category)
);

create table users
(
  user_id	    text primary key not null,
  rating      int not null,
	location    text,
	country	    text
);
