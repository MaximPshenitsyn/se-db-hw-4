create schema if not exists station;

create table station.city (
    city_name varchar(32) not null,
    region varchar(32) not null,
    constraint city_pk primary key (region, city_name)
);

create table station.station (
    id serial primary key not null,
    station_name varchar(32) not null,
    tracks integer not null,
    lie_in_region varchar(32) not null,
    lie_in_city varchar(32) not null,
    constraint lie_in_fk foreign key (lie_in_region, lie_in_city) references station.city(region, city_name)
);

create table station.train (
    train_nr integer unique primary key not null,
    train_length integer not null,
    start_station integer not null,
    end_station integer not null,
    constraint start_station_fk foreign key (start_station) references station.station(id),
    constraint end_station_fk foreign key (end_station) references station.station(id)
);

create table station.connected (
    id serial primary key not null,
    departure timestamp not null,
    arrival timestamp not null,
    departure_station integer not null,
    arrival_station integer not null,
    constraint departure_fk foreign key (departure_station) references station.station(id),
    constraint arrival_fk foreign key (arrival_station) references station.station(id)
);
