/*
Ejercicio 6
Utilizando triggers, solucione las restricciones de dominios de los ejercicios 1 a) y b)
de la Práctica 1) de Repaso de SQL, que no pudieron resolver utilizando el comando
check.
*/

use ejercicio1a;
/*TABLE producto(
cod_producto integer not null primary key,
descripcion varchar(100),
precio float,
stock_min integer,
stock_max integer,
cantidad integer,
*/

-- constraint control_min_max check (stock_min < stock_max)
delimiter $$
create or replace trigger control_min_max before insert on producto for each row 
begin
	if(new.stock_min >= new.stock_max)
	then
		signal sqlstate '45000' 
		set message_text ='El stock minimo supera al maximo';
	end if;
end$$ delimiter ;


-- constraint precio_positivo check (precio > 0)
delimiter $$
create or replace trigger precio_positivo before insert on producto for each row 
begin
	if(new.precio > 0)
	then
		signal sqlstate '45000' 
		set message_text ='El precio ingresado debe ser positivo';
	end if;
end
$$ delimiter ;


use ejercicio1b;
/*
TABLE parquimetro(
nro_parq integer not null primary key,
calle varchar(20),
altura integer,
*/

-- constraint control_altura check ((altura >= 0)and(altura <= 5000))
delimiter $$
create or replace trigger control_altura before insert on parquimetro for each row 
begin
	if((new.altura >= 0)and(new.altura <= 5000))then
		signal sqlstate '45000' 
		set message_text ='Altura ingresada incorrecta';
	end if;
end
$$ delimiter ;

