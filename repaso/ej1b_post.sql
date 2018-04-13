/*
Vehiculo (#patente, marca, modelo, color, saldoActual)
Persona (dni, nombreYApellido, direccion)
Dueño (#patente, dni)
Estacionamiento (#estacionamiento, #patente, #parquímetro, fecha, saldoInicio,
saldoFinal, horaEntrada, horaSalida)
Parquímetro (#parquímetro, calle, altura)

Considerar que el número de calle no puede ser un número negativo ni superior a 5000;
crear un dominio para el nombre y apellido de una persona que es un varchar de 45.
Considerar que el dominio del atributo color de un vehiculo es {gris, negro, azul}. No
permitir eliminar un vehiculo si este fue estacionado. El #estacionamiento debe ser
autonumerado.
*/

drop domain if exists colores cascade;
create domain colores varchar(10)
   check (value in ('gris', 'negro', 'azul'));
/* create type color2 as enum ('gris', 'negro', 'azul');*/   

drop domain if exists full_name cascade;     
create domain full_name as varchar(45);

drop table if exists ejercicio_b.estacionamiento;
drop table if exists ejercicio_b.vehiculo;
drop table if exists ejercicio_b.persona;
drop table if exists ejercicio_b.duenio;
drop table if exists ejercicio_b.parquimetro;

create table ejercicio_b.vehiculo(
nro_patente varchar(20) not null primary key,
marca varchar(20),
modelo varchar(20),
color colores,
saldoActual float
);

insert into ejercicio_b.vehiculo values ('kuv-111','audi','a1','gris',20.50);
insert into ejercicio_b.vehiculo values ('klo-477','fiat','punto','negro',60.00);
insert into ejercicio_b.vehiculo values ('xzv-379','bmw','sedan','negro',42.00);
insert into ejercicio_b.vehiculo values ('omm-231','bmw','coupe','azul',10.50);
insert into ejercicio_b.vehiculo values ('ffa-664','chevrolet','cobalt','azul',5.00);
insert into ejercicio_b.vehiculo values ('nmr-197','chevrolet','camaro','gris',18.00);
insert into ejercicio_b.vehiculo values ('tdu-865','audi','a3','negro',24.00);


create table ejercicio_b.persona(
dni integer not null primary key,
nom_ape full_name, /* MYSQL no soporta CREATE DOMAIN*/
direccion varchar(30)
);

insert into ejercicio_b.persona values (380199826,'pedro sanchez','general paz 121');
insert into ejercicio_b.persona values (320119871,'juan menendez','constitucion 454');
insert into ejercicio_b.persona values (368177862,'fernando martinez','mitre 855');
insert into ejercicio_b.persona values (354499885,'roberto quiroga','buenos aires 444');
insert into ejercicio_b.persona values (375129833,'santiago giacomelli','alberdi 666');


create table ejercicio_b.duenio(
nro_patente varchar(20) not null,
dni integer not null,
constraint pk_duenio primary key (nro_patente, dni)
);

insert into ejercicio_b.duenio values ('kuv-111',380199826);
insert into ejercicio_b.duenio values ('klo-477',380199826);
insert into ejercicio_b.duenio values ('xzv-379',320119871);
insert into ejercicio_b.duenio values ('omm-231',368177862);
insert into ejercicio_b.duenio values ('ffa-664',354499885);
insert into ejercicio_b.duenio values ('nmr-197',375129833);


create table ejercicio_b.parquimetro(
nro_parq integer not null primary key,
calle varchar(20),
altura integer,
constraint control_altura check ((altura >= 0)and(altura <= 5000))
);

insert into ejercicio_b.parquimetro values (1,'mitre',1100);
insert into ejercicio_b.parquimetro values (2,'buenos aires',500);
insert into ejercicio_b.parquimetro values (3,'alberdi',789);
insert into ejercicio_b.parquimetro values (4,'constitucion',200);


create table ejercicio_b.estacionamiento(
nro_est serial not null primary key ,
nro_patente varchar(20),
nro_parq integer,
fecha date,  --values in 'YYYY-MM-DD' format
saldoInicio float,
saldoFinal float,
hora_in time,
hora_out time,
constraint fk_patente foreign key (nro_patente) references ejercicio_b.vehiculo on delete restrict,
constraint fk_parquimetro foreign key (nro_parq) references ejercicio_b.parquimetro
);

insert into ejercicio_b.estacionamiento(nro_patente, nro_parq, fecha, saldoInicio, saldoFinal, hora_in, hora_out ) values ('kuv-111',1,'2017-08-01',20.50,15.28,'11:00:40','12:50:30');
insert into ejercicio_b.estacionamiento(nro_patente, nro_parq, fecha, saldoInicio, saldoFinal, hora_in, hora_out ) values ('xzv-379',2,'2017-08-09',42.00,32.15,'01:20:33','04:01:31');
insert into ejercicio_b.estacionamiento(nro_patente, nro_parq, fecha, saldoInicio, saldoFinal, hora_in, hora_out ) values ('omm-231',2,'2017-07-20',10.50,02.05,'08:00:00','13:10:45');
insert into ejercicio_b.estacionamiento(nro_patente, nro_parq, fecha, saldoInicio, saldoFinal, hora_in, hora_out ) values ('ffa-664',3,'2017-09-11',25.00,23.35,'22:14:44','22:39:59');
insert into ejercicio_b.estacionamiento(nro_patente, nro_parq, fecha, saldoInicio, saldoFinal, hora_in, hora_out ) values ('nmr-197',4,'2017-09-24',18.00,09.50,'05:00:50','08:30:13');



/*
c) Listar los vehículos que utilizaron el parquímetro 9, indicar modelo y color

select vehiculo.* from ejercicio_b.vehiculo inner join 
(select * from ejercicio_b.estacionamiento natural join ejercicio_b.parquimetro where (nro_parq = 2)) as aux using(nro_patente)

o

select vehiculo.* from ejercicio_b.vehiculo natural join 
(select * from ejercicio_b.estacionamiento natural join ejercicio_b.parquimetro where (nro_parq = 2)) as aux 
*/
