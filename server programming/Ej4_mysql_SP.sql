/*

Utilizando el motor MySQL con la base de datos definida en el ejercicio 1a) de la
Práctica 1 de Repaso de SQL(Base de datos de clientes y productos), y haciéndole las
modificaciones que crea necesarias, cree un procedimiento que guarde información en
una tabla con las facturas que no son consistentes (una factura no es consistente si la
suma de sus ítems es diferentes al monto total de la factura). Considerar:
a) El procedimiento debe ser creado con el usuario vendedor3 (creado en la
practica anterior) y el procedimiento debe ser creado para ejecutarse con los
permisos del invocador.
b) Ejecute el procedimiento con los usuarios vendedor3 y vendedor1.

*/

use p1e1a;

drop table if exists facturas_incons;

create table facturas_incons(
  nro_factura int,
  monto_facturado float,
  monto_real float,
  constraint fac_inc_fk1 foreign key (nro_factura) references factura (nro_factura)
);

drop procedure if exists es_incosistente;
drop procedure if exists facturas_inconsistentes;

delimiter $$

create definer = 'vendedor2'@'localhost'
procedure facturas_inconsistentes () sql security invoker
BEGIN
    declare done int default 0;
    declare nfact int;
  
    declare cursor_factura cursor for select nro_factura from factura;
  
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
    BEGIN
        SET done = 1;
    END;
  
    truncate facturas_incons;
  
    open cursor_factura;
    repeat
        fetch cursor_factura into nfact;
        if not done then
          call es_incosistente(nfact);
        end if;
    until done end repeat;
      
    select * from facturas_incons;

END
$$

create definer = 'vendedor2'@'localhost'
procedure es_incosistente (IN nfac_par int) sql security invoker
BEGIN
    declare total_fact, monto_orig float;

   -- truncate facturas_incons;

    select sum(precio*cantidad) into total_fact from item_factura where nro_factura = nfac_par;

    select monto into monto_orig from factura where nro_factura = nfac_par;

    if( monto_orig != total_fact) then
        INSERT INTO facturas_incons values (nfac_par,monto_orig,total_fact);
    end if;

END
$$
delimiter ;


/*
-- invocar metodo

call facturas_inconsistentes();

select * from facturas_incons;

*/