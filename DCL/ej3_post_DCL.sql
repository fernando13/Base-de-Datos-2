/*
Utilizando el motor de bases de datos PostgresSQL y teniendo en cuenta la base de
datos del inciso c) del practico 1) (base de datos de automóviles, accidentes, etc),
cree los usuarios “asesor”, “administrativo” y “encargado”, teniendo en cuenta:

a) El “asesor” sólo puede consultar la tabla taller e insertar en la tabla accidente.

b) El “administrativo” sólo puede consultar la tabla automóvil.

c) El usuario “encargado” tiene los privilegios de borrar todas las tablas y
actualizar el campo tasa de la tabla categoría.

d) Todos los usuarios pertenecen al rol “empleado”. El rol de empleado puede
consultar los campos apellido y nombre de la tabla cliente.
*/

--a)
CREATE USER asesor WITH PASSWORD 'fernando123';
GRANT SELECT ON ejercicio_c.taller TO asesor;		
GRANT INSERT ON ejercicio_c.accidente TO asesor;

--b)
CREATE USER administrativo WITH PASSWORD 'fernando123';
GRANT SELECT ON ejercicio_c.automovil TO administrativo;	

--c)
CREATE USER encargado WITH PASSWORD 'fernando123';
GRANT DELETE ON ALL TABLES IN SCHEMA ejercicio_c TO encargado;
GRANT UPDATE(tasa) ON ejercicio_c.categoria TO encargado;

--d)
CREATE ROLE empleado NOLOGIN;
GRANT SELECT(apellido, nombre) ON ejercicio_c.cliente TO empleado;
GRANT empleado TO asesor, administrativo, encargado;


FLUSH PRIVILEGES;