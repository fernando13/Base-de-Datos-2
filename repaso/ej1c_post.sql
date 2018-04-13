/*
Dado el siguiente esquema:
Cliente (DNI, nombre, apellido, dirección, tarifa)
Automovil (patente, marca, modelo, dni, nro_categoria)
Categoría (nro_categoria, tasa)
Taller (nro_taller, nombre, dirección)
Accidente (nro_accidente, DNI, patente, nro_taller, fecha, costo)
DNI clave foránea que referencia DNI de Cliente
nro_taller clave foránea que referencia nro_taller de Taller
patente clave foránea que referencia patente de Automóvil

Considerar que el modelo de un automóvil es un entero positivo entre 1990 y 2015. El
atributo marca de un automóvil puede ser {FIAT, RENAULT, FORD}. El atributo
tarifa es un entero positivo menos a 10000. Tener en cuenta al borrar un cliente debe
eliminarse toda la información de los accidentes que lo involucran.
*/

drop table if exists ejercicio_c.accidente;
drop table if exists ejercicio_c.categoria cascade;
drop table if exists ejercicio_c.automovil;
drop table if exists ejercicio_c.taller;
drop table if exists ejercicio_c.cliente;

drop domain if exists tMarca cascade;
create domain tMarca varchar(10)
   check (value in ('fiat', 'renault', 'ford'));

CREATE TABLE ejercicio_c.cliente(
dni varchar(20) not null primary key,
nombre varchar(30),
apellido varchar(30),
direccion varchar(30),
tarifa integer,
constraint control_tarifa check ((tarifa >= 0) and (tarifa <= 10000))
);

insert into ejercicio_c.cliente values ('380199826','pedro','sanchez','general paz 121',10);
insert into ejercicio_c.cliente values ('320119871','juan','menendez','constitucion 454',20);
insert into ejercicio_c.cliente values ('368177862','fernando','martinez','mitre 855',30);
insert into ejercicio_c.cliente values ('354499885','roberto','quiroga','buenos aires 444',40);
insert into ejercicio_c.cliente values ('375129833','santiago','giacomelli','alberdi 666',50);


CREATE TABLE ejercicio_c.categoria(
nro_cate integer not null primary key,
tasa integer
);

insert into ejercicio_c.categoria values (1,5289);
insert into ejercicio_c.categoria values (2,8600);
insert into ejercicio_c.categoria values (3,1050);
insert into ejercicio_c.categoria values (4,7000);
insert into ejercicio_c.categoria values (5,4300);


CREATE TABLE ejercicio_c.automovil(
patente varchar(20) not null primary key,
marca tMarca,
modelo integer,
dni varchar(20),
nro_categ integer,
constraint control_modelo check ((modelo >= 1990) and (modelo <= 2015)),
constraint fk_toCategoria foreign key (nro_categ) references ejercicio_c.categoria,
constraint fk_cliente foreign key (dni) references ejercicio_c.cliente
);

insert into ejercicio_c.automovil values ('kuv-111','renault',1998,'380199826',1);
insert into ejercicio_c.automovil values ('klo-477','fiat',2014,'380199826',2);
insert into ejercicio_c.automovil values ('xzv-379','renault',2000,'320119871',1);
insert into ejercicio_c.automovil values ('omm-231','fiat',2015,'368177862',3);
insert into ejercicio_c.automovil values ('ffa-664','ford',1994,'354499885',4);
insert into ejercicio_c.automovil values ('nmr-197','ford',1999,'375129833',2);
insert into ejercicio_c.automovil values ('tdu-865','fiat',2006,'375129833',5);


CREATE TABLE ejercicio_c.taller(
nro_taller integer not null primary key,
nombre varchar(30),
direccion varchar(30)
);

insert into ejercicio_c.taller values (10,'el carlo y cia.','buenos aires 158');
insert into ejercicio_c.taller values (11,'don tito','mitre 641');
insert into ejercicio_c.taller values (12,'carpincho loco','alberdi 1308');
insert into ejercicio_c.taller values (13,'juancho expres','constitucion 1005');


CREATE TABLE ejercicio_c.accidente(
nro_acc integer not null primary key, 
dni varchar(20),
patente varchar(30),
nro_taller integer,
fecha date,
costo float,
constraint fk_toCliente foreign key (dni) references ejercicio_c.cliente on delete cascade,
constraint fk_toTaller foreign key (nro_taller) references ejercicio_c.taller,
constraint fk_toAutomovil foreign key (patente) references ejercicio_c.automovil
);

insert into ejercicio_c.accidente values (1,'354499885','ffa-664',10,'1996-03-11',500);
insert into ejercicio_c.accidente values (2,'380199826','kuv-111',13,'1998-11-21',400);
insert into ejercicio_c.accidente values (3,'354499885','ffa-664',11,'1998-09-25',1.500);
insert into ejercicio_c.accidente values (4,'380199826','kuv-111',10,'2004-06-30',3.000);
insert into ejercicio_c.accidente values (5,'380199826','kuv-111',10,'2007-02-12',1.600);
insert into ejercicio_c.accidente values (6,'320119871','xzv-379',12,'2004-05-11',200);
insert into ejercicio_c.accidente values (7,'375129833','nmr-197',11,'2000-04-22',1.850);
insert into ejercicio_c.accidente values (8,'380199826','kuv-111',10,'2017-07-02',2.700);
insert into ejercicio_c.accidente values (9,'354499885','ffa-664',12,'2000-12-21',8.350);
insert into ejercicio_c.accidente values (10,'354499885','ffa-664',10,'2002-05-03',900);
insert into ejercicio_c.accidente values (11,'375129833','nmr-197',12,'2016-07-07',7.100);


/*
b) Listar los clientes cuya cantidad de accidentes que tuvieron es superior a 3. Listar
DNI, nombre y apellido.

select dni, nombre, apellido, COUNT(dni)as cant_accidentes from ejercicio_c.cliente natural join ejercicio_c.accidente
group by dni having COUNT(dni)>3
*/


