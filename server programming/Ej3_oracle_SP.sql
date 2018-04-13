/*
Ejercicio 3
Utilizando el motor de base de datos Oracle, cree las tablas:
cuenta (nro_cuenta, saldo)
movimiento(nro_movimiento, nro_cuenta, fecha, debe, haber)
nro_cuenta: Clave foránea a cuenta
*/

create table cuenta(
nro_cuenta integer not null primary key,
saldo float	
);

create table movimiento(
nro_movimiento integer not null primary key,
nro_cuenta integer not null,
fecha date, -- 21-NOV-96
debe float,
haber float,
constraint fk_mov foreign key (nro_cuenta) references cuenta(nro_cuenta) on delete cascade
);


/*
Luego, cree los siguientes procedimientos almacenados:

a)Que inserte un movimiento y mantenga consistente el saldo en la tabla cuenta.
El procedimiento debe tomar como parámetro el nro de cuenta, el debe y el
haber. Al final del procedimiento imprima por pantalla el número de cuenta y el
saldo actual.
*/

CREATE SEQUENCE mov_seq START WITH 1;

CREATE OR REPLACE TRIGGER movimiento_genid 
BEFORE INSERT ON movimiento 
FOR EACH ROW
BEGIN
  :new.nro_movimiento := mov_seq.NEXTVAL;
END;


CREATE OR REPLACE PROCEDURE insert_movimiento( pcuenta in integer, pdebe in float, phaber in float) IS
BEGIN
	insert into movimiento(nro_cuenta, fecha, debe, haber) values (pcuenta, CURRENT_DATE, pdebe, phaber); 
	update cuenta set saldo =  (saldo + pdebe - phaber) where nro_cuenta = pcuenta;
END;



/*
b)Que calcule el saldo de una cuenta a una determinada fecha. El procedimiento,
además de mostrar por pantalla el saldo, lo debe retornar en un parámetro.
*/

CREATE OR REPLACE PROCEDURE calc_saldo( _cuenta in  integer, _fecha in date ) IS
BEGIN
 
END;


/*
CURSOR cproductos IS SELECT nProd, precio FROM
productos

regProducto cproductos%ROWTYPE;

BEGIN
	OPEN cproductos;
	FETCH cproductos INTO regProducto;
	WHILE cproductos%FOUND LOOP
		dbms_output.put_line( regProducto.Precio);
		FETCH cproductos INTO regProducto;
	END LOOP;
	CLOSE cproductos;
END;
*/