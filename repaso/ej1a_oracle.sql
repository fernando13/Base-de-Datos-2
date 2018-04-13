drop table item_factura;
drop table factura;
drop table cliente;
drop table producto;

CREATE TABLE cliente(
nro_cliente integer not null primary key,
apellido varchar(30),
nombre varchar(30),
direccion varchar(30),
telefono varchar(20)
);

insert into cliente values (124,'bentolila','fernando','mitre 258','3584402066');
insert into cliente values (123,'diaz','mario','constitucion 127','3584125699');
insert into cliente values (122,'rodriguez','amanda','alberdi 787','3584560287');
insert into cliente values (121,'basualdo','enrique','san martin 055','3584651238');
insert into cliente values (120,'flores','florencia','buenos aires 889','3584062589');

CREATE TABLE producto(
cod_producto integer not null primary key,
descripcion varchar(100),
precio float,
stock_min integer,
stock_max integer,
cantidad integer,
constraint control_min_max check (stock_min < stock_max), 
constraint precio_positivo check (precio > 0)
); 

insert into producto values (1,'tomate',5.00,10,100,20);
insert into producto values (2,'queso',18.00,6,45,10);
insert into producto values (3,'jamon',20.00,8,40,30);
insert into producto values (4,'papa',9.00,30,90,50);
insert into producto values (5,'acelga',4.00,15,80,79);
insert into producto values (6,'alfajor',10.00,20,50,42);

CREATE TABLE factura(
nro_factura integer not null primary key,
nro_cliente integer,
fecha date, 
monto float,
constraint fk_cliente foreign key (nro_cliente) references cliente(nro_cliente) on delete cascade
);

insert into factura values (10,122,'21-NOV-96',50.00) 
insert into factura values (11,122,'20-FEB-94',12.00); 
insert into factura values (12,123,'22-NOV-96',20.00);  
insert into factura values (13,120,'08-FEB-98',25.00); 
insert into factura values (14,120,'17-NOV-10',100.00);  

CREATE TABLE item_factura(
cod_producto integer not null,
nro_factura integer not null,
cantidad integer,
precio float,
constraint pk_itemfact primary key (cod_producto, nro_factura),
constraint precio_positivo2 check (precio > 0),
constraint fk_producto foreign key (cod_producto) references producto(cod_producto) on delete restrict,
constraint fk_factura foreign key (nro_factura) references factura(nro_factura) on delete cascade
);

insert into item_factura values(1,13,5,25.00);
insert into item_factura values(5,11,3,12.00);
insert into item_factura values(3,12,1,20.00);
insert into item_factura values(3,14,5,100.00);
insert into item_factura values(6,10,5,50);