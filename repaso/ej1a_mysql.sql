/*
Cliente (nro_cliente, apellido, nombre, dirección, teléfono)
Producto (cod_producto, descripción, precio, stock_minimo, stock_maximo, cantidad)
ItemFactura (cod_producto, nro_factura, cantidad, precio)
Factura (nro_factura, nro_cliente, fecha, monto)

Considerar el precio no puede ser 0 ni negativo; el Stock mínimo no puede ser mayor
que el Stock máximo. Tener en cuenta al borrar un cliente debe eliminarse toda la
información de facturas realizadas para el mismo; y al eliminar un producto, no permitir
hacerlo si hay alguna factura en la que fue utilizado.
*/
Use ejercicio1a;
drop table if exists item_factura;
drop table if exists factura;
drop table if exists cliente;
drop table if exists producto;

CREATE TABLE cliente(
nro_cliente integer not null auto_increment primary key,    
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
constraint control_min_max check (stock_min < stock_max), -- MYSQL no implementa CHECK (simularlo con triggers)
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
fecha date, /*'YYYY-MM-DD'*/
monto float,
constraint fk_cliente foreign key (nro_cliente) references cliente(nro_cliente) on delete cascade
);

insert into factura values (10,122,'2017-12-03',50.00); -- alfajor x5
insert into factura values (11,122,'2017-11-20',12.00);  -- acelga x3
insert into factura values (12,123,'2017-09-07',20.00);  -- jamon x1
insert into factura values (13,120,'2017-10-15',25.00); -- tomate x5
insert into factura values (14,120,'2017-03-14',100.00);  -- jamon x5

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

/*a) Listar los clientes (todos sus datos) que no se le han realizado ninguna venta (clientes
que no tienen ninguna factura asociada). Al listado ordenarlo por apellido y nombre en
forma descendente.

select * from cliente where nro_cliente not in (select nro_cliente from cliente natural join factura)
order by apellido desc, nombre desc

d) Obtener el máximo y mínimo precio de montos pagados en las facturas por cada
cliente. Listar Nro_cliente, nombre y máximo y mínimo monto de factura.

select nro_cliente, nombre, MAX(monto)as max_monto,MIN(monto)as min_monto 
from cliente natural join factura
group by nro_cliente
*/

-- MYSQL no implementa DOMAIN, ni CHECK (simularlo con triggers)
