/*
Ejercicio 2
Utilizando el motor de base de datos PostgresSQL, cree las tablas:
Banco (cod_banco, nombre, precio, cotizacion_maxima)
Cotización (cod_cotizacion, cod_banco, cotización)
Cod_banco: clave foránea a Banco
Realizar una función que obtenga la máxima cotización para un banco dado y actualice
el valor en la tabla Banco, la función debe retornar la cotización máxima en un
parámetro de salida.
Nota: No utilizar la función MAX!!!.
*/

drop table if exists sp_ej2.banco cascade;
create table sp_ej2.banco(
cod_banco varchar(20) not null primary key,
nombre varchar(30),
precio float,
cot_max float
);

insert into sp_ej2.banco values ('01','bancor',2000.00,0);
insert into sp_ej2.banco values ('02','cordoba',4700.00,0);
insert into sp_ej2.banco values ('03','nose',1500.00,0);


drop table if exists sp_ej2.cotizacion cascade;
create table sp_ej2.cotizacion(
cod_cot varchar(20) primary key,
cod_banco varchar(20),
cotiza float,
constraint fk_cotizacion foreign key (cod_banco) references sp_ej2.banco on delete cascade
);

insert into sp_ej2.cotizacion values ('111','01',21000.00);
insert into sp_ej2.cotizacion values ('112','01',700.00);
insert into sp_ej2.cotizacion values ('113','01',1400.00);
insert into sp_ej2.cotizacion values ('114','02',9000.00);
insert into sp_ej2.cotizacion values ('115','02',7700.00);
insert into sp_ej2.cotizacion values ('116','02',6540.00);
insert into sp_ej2.cotizacion values ('117','03',21000.00);
insert into sp_ej2.cotizacion values ('118','03',7008.00);



drop function if exists max_cot(in varchar, out float);

CREATE OR REPLACE FUNCTION max_cot(in bank varchar(20), out maximo float) AS
$$
DECLARE registro RECORD;
BEGIN
  maximo := 0;  

  FOR registro IN select * from sp_ej2.cotizacion where (cod_banco = bank) LOOP
    if(maximo < registro.cotiza) then
      maximo:= registro.cotiza;
    end if;  
  END LOOP;

  update sp_ej2.banco set cot_max = maximo where (cod_banco = bank);

END;
$$ LANGUAGE plpgsql;

-- invocacion a la funcion:
-- select max_cot('01');
