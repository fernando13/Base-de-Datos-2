/*
Dado el ejercicio 1)a) de la práctica 1) (base de datos clientes, productos, etc), cree los
usuarios: vendedor1, vendedor2 y administrador, tener en cuenta

a) El vendedor1 posee el privilegio de insertar datos en la tabla cliente. Este usuario no
tiene permitido otorgar estos privilegios a otros usuarios.

b) El vendedor2 sólo tiene privilegios para borrar en la tabla factura y para seleccionar
los campos de la tabla producto.

c) El administrador tiene los privilegios de actualización del campo descripción de la
tabla producto, pudiendo otorgar este privilegio a otros usuarios.

d) Tener en cuenta que todos los usuarios cuentan con el privilegio de borrar los datos
de la tabla cliente.

e) Verificar que los permisos asignados a los usuarios en los incisos anteriores estén
bien definidos.

f) Al finalizar revoque todos los privilegios del vendedor2.
Nota: Resolver utilizando los motores de MYSQL .
*/

Use ejercicio1a;
/*
drop user 'vendedor1';
drop user 'vendedor2';
drop user 'administrador';
*/

-- a)
CREATE USER 'vendedor1' IDENTIFIED BY 'fernando123';
GRANT INSERT ON cliente TO vendedor1;

-- b)
CREATE USER vendedor2 IDENTIFIED BY 'fernando123';
GRANT DELETE ON factura TO vendedor2;
GRANT SELECT ON producto TO vendedor2;

-- c)
CREATE USER administrador IDENTIFIED BY 'fernando123';
GRANT UPDATE(descripcion) ON producto TO administrador WITH GRANT OPTION;

-- d)
GRANT DELETE ON cliente TO vendedor1, vendedor2, administrador;

-- f)
REVOKE ALL PRIVILEGES, GRANT OPTION FROM vendedor2;

FLUSH PRIVILEGES;