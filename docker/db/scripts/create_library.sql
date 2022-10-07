create schema if not exists library;

create table library.producer (
    id serial primary key not null,
    producer_name varchar(256) not null,
    address varchar(256) not null
);

create table  library.category (
    id serial primary key not null,
    category_name varchar(64) not null,
    parent integer default null,
    constraint parent_fk foreign key (parent) references library.category(id)
);

create table  library.book (
    isbn varchar(13) unique primary key not null,
    book_name varchar (64) not null,
    author varchar (32) not null,
    production_year integer not null,
    pages integer not null,
    book_category integer not null,
    book_producer integer not null,
    constraint category_fk foreign key (book_category) references library.category(id),
    constraint producer_fk foreign key (book_producer) references library.producer(id)
);

create table  library.example (
    id serial primary key not null,
    book_isbn varchar(13) unique not null,
    shelf_position varchar(64) not null,
    rent integer default null,
    constraint book_fk foreign key (book_isbn) references library.book(isbn)
);

create table  library.rent (
    id serial primary key not null,
    return_date date not null,
    book_copy_id integer not null,
    constraint book_copy_fk foreign key (book_copy_id) references library.example(id)
);

create table  library.reader (
    id serial primary key not null,
    surname varchar(32) not null,
    firstname varchar(32) not null,
    address varchar(256) not null,
    birth date not null,
    rent integer default null,
    constraint rent_fk foreign key (rent) references library.rent(id)
);

alter table library.example add constraint rent_fk foreign key (rent) references library.rent(id);

