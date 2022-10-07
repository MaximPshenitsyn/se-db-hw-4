create schema if not exists station_hospital;

create table station_hospital.station (
    station_nr serial primary key,
    station_name varchar(32) not null
);

create table station_hospital.room (
    room_nr serial primary key,
    beds integer not null,
    station integer not null,
    constraint station_fk foreign key (station) references station_hospital.station(station_nr)
);

create table station_hospital.station_staff (
    person_nr serial primary key,
    works_for integer not null,
    staff_name varchar(32) not null,
    constraint station_fk foreign key (works_for) references station_hospital.station(station_nr)
);

create table station_hospital.doctor (
    person_nr integer primary key not null,
    area varchar(32) not null,
    rank varchar(32) not null,
    constraint person_fk foreign key (person_nr) references station_hospital.station_staff(person_nr)
);

create table station_hospital.caregiver (
    person_nr integer primary key not null,
    qualification varchar(32) not null,
    constraint person_fk foreign key (person_nr) references station_hospital.station_staff(person_nr)
);

create table station_hospital.patient (
    patient_nr serial primary key,
    patient_name varchar(32) not null,
    disease varchar(32) not null,
    occupies_room integer not null,
    occupies_from timestamp not null,
    occupies_to timestamp not null,
    treated_by integer not null,
    constraint room_fk foreign key (occupies_room) references station_hospital.room(room_nr),
    constraint doctor_fk foreign key (treated_by) references station_hospital.doctor(person_nr)
);
