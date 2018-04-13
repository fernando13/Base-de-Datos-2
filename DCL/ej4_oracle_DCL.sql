/*
Ejercicio 4
Crear los usuarios “empleado1”, “empleado2” y “director”.
Los usuarios empleado 1 y 2 poseen el rol de “empleados” (si no existe crearlo), el rol
de empleados puede consultar información de la tabla automóvil y categoría de la base
de datos del ejercicio 1) c) de la práctica 1) (base de datos de automóviles, accidentes,
etc).
Tener en cuenta que empleado1 debe renovar su password.
Adicionalmente, al usuario director se le debe restringir el tiempo máximo de 20
minutos para estar conectado.

El usuario “empleado1” tiene el privilegio de borrar, actualizar y agregar los datos de la
tabla accidente.

El usuario “empleado2” puede consultar, además por lo que su rol le permite, los
campos apellido, nombre y dirección de la tabla cliente y puede pasar este privilegio a
otros usuarios.
*/

CREATE PROFILE director_profile LIMIT CONNECT_TIME 20; -- 20 minutos
CREATE PROFILE empleado1_profile LIMIT PASSWORD_LIFE_TIME 30; -- 30 dias

CREATE USER empleado1 
IDENTIFIED BY fernando1234
PROFILE empleado1_profile;

CREATE USER empleado2 IDENTIFIED BY fernando1234;
GRANT SELECT(apellido,nombre,direccion) ON cliente TO empleado2 WITH GRANT OPTION; --no anda

CREATE USER director IDENTIFIED BY fernando1234;
ALTER USER director PROFILE director_profile;


CREATE ROLE empleados;
GRANT SELECT ON categoría TO empleados;
GRANT SELECT ON automovil TO empleados;

GRANT empleados TO empleado1, empleado2 ;


grant connect to empleado1;
grant connect, resource to empleado2;
grant connect, resource to director;

/*
alter user nombre_usuario profile nombre_perfil;

o
	
create user nombre_usuario
identified by        password_usuario
default tablespace   nombre_tbs
temporary tablespace nombre_tbs
profile              nombre_perfil;
*/



--https://orlandoolguin.wordpress.com/2009/09/20/manejo-de-perfiles/

--tutorial oracle:
--https://chartio.com/resources/tutorials/how-to-create-a-user-and-grant-permissions-in-oracle/ 
