/*
Ejercicio 5
Cree triggers teniendo en cuenta las siguientes consideraciones:
*/

/*
a) En la base de datos creada en el ejercicio 1a) de la Práctica 1) de Repaso de
SQL, agregue un trigger para que antes de cada inserción de un producto se
guarde la descripción en mayúsculas.
*/

Use ejercicio1a;

drop trigger if exists mayus_prod_dec;

delimiter $$
create or replace trigger mayus_prod_dec before insert on producto 
for each row 
begin
	SET NEW.descripcion = UPPER(NEW.descripcion);
end
$$ delimiter ;



/*
b) En la base de datos creada en el ejercicio 1a) de la Práctica 1) de Repaso de
SQL, agregue un trigger, para que luego de cada modificación en la cantidad de
un producto se guarde información de auditoria. Esta información debe quedar
almacenada en la tabla auditoriaProducto (crearla antes de definir el trigger), la
información a almacenar es cod_producto, movimiento (diferencia de
cantidades), fecha de realización de la actualización y el usuario que lo hizo.
Con respecto al usuario que la realizó, debe ser el código de usuario del usuario
logueado en la aplicación cliente de la base de datos
Hint: ver ejemplo Teórico
*/

Use ejercicio1a;

drop table if exists auditoriaProducto; 
create table auditoriaProducto(
cod_producto integer, 
movimiento float,  -- (diferencia decantidades)
fecha date,
usuario varchar(30)
);

drop trigger if exists auditoria_produtos;
set @id_usuario = 4;

delimiter $$
create or replace trigger auditoria_produtos after update on producto for each row
begin
	if(new.cantidad != old.cantidad)then
		insert into auditoriaProductos 
		values (OLD.cod_producto,(new.cantidad - old.cantidad), NOW(), @id_usuario);
	end if;
end
$$ delimiter ;



/*
c) Modifique la base de datos creada en el inciso b) del ejercicio 1 de la Práctica
1(bases de datos de estacionamiento) considerando que #parquimetro es auto
numerado.
¿Cómo lo resolvería en Oracle? Hint: ver SEQUENCE
*/
Use ejercicio1b;
alter table parquimetro modify nro_parq int AUTO_INCREMENT;

-- oracle:
/* 
https://stackoverflow.com/questions/11296361/
how-to-create-id-with-auto-increment-on-oracle  

https://stackoverflow.com/questions/13782824/
how-to-add-a-sequence-column-to-an-existing-table-with-records
*/
