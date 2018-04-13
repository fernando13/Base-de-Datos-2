/*
Ejercicio 1
Teniendo en cuenta el ejercicio 1 a) de la práctica Nro 1(base de datos de facturación),
agregue a la tabla factura el campo cantidad máxima de ítems permitidos.
Controlar que la base de datos no acepte que una factura tenga más ítems que la
cantidad de ítems permitidos por esta.
*/

Use ejercicio1a;

alter table factura add max_item int;


drop trigger if exists check_items;
delimiter $$
create or replace trigger check_items before insert on item_factura for each row 
begin

    declare cantMax int;
	declare aux int;

 	select COUNT(*) into aux  from item_factura where nro_factura = new.nro_factura;
    
    select max_item into cantMax from factura where nro_factura = new.nro_factura;

    if(cantMax < aux+1)
	then
   
		signal sqlstate '45000' 
		set message_text ='Su factura exede la cantidad de items permitidos';

	end if;
end
$$ delimiter ;


