/*
Teniendo en cuenta la base de datos del incsio b) del practico 1) (base de datos de
automóviles, estacionamiento, etc), cree los usuarios “encargado_estacionamiento” el
cual se conecta sólo desde la máquina servidor (localhost) y “cobrador” que se puede
conectar desde cualquier máquina. Además tenga en cuenta lo siguiente:

a) El “cobrador” sólo puede consultar la tabla estacionamiento y realizar 3
conexiones/hora y 10 consultas/hora.

b) El usuario “encargado_estacionamiento” tiene los privilegios de consultar todas
las tablas de la base de datos y de insertar en la tabla parquímetro en dicha base
de datos.

c) Compruebe la correcta definición de permisos (de accesos al servidor y a las
base de datos).

d) Borre el privilegio de consulta del usuario “cobrador”.
*/
Use ejercicio1b;

-- drop user'encargado_est'@'localhost';
-- drop user 'cobrador'@'%';

-- a)
CREATE USER 'cobrador'@'%' IDENTIFIED BY 'fernando123';
GRANT SELECT ON ejercicio1b.estacionamiento TO 'cobrador'@'%' 
WITH MAX_QUERIES_PER_HOUR 10
	 MAX_CONNECTIONS_PER_HOUR 3;

/* or...

CREATE USER 'cobrador'@'%' IDENTIFIED BY 'fernando123';
WITH MAX_QUERIES_PER_HOUR 10 MAX_CONNECTIONS_PER_HOUR 3;


ALTER USER 'cobrador'@'%'
WITH MAX_QUERIES_PER_HOUR 10 MAX_CONNECTIONS_PER_HOUR 3;

https://dev.mysql.com/doc/refman/5.7/en/create-user.html
*/

-- b)
CREATE USER 'encargado_est'@'localhost' IDENTIFIED BY 'fernando123';
GRANT SELECT ON *.* TO 'encargado_est'@'localhost';
GRANT INSERT ON ejercicio1b.parquimetro TO 'encargado_est'@'localhost';

-- d)
REVOKE SELECT ON ejercicio1b.estacionamiento from 'cobrador'@'%';

FLUSH PRIVILEGES;