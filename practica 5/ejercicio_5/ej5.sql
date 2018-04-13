/*
Ejercicio 5.
b) Cree un programa que, por cada persona inserte al menos 1 registro en la tabla
seguimiento_acceso por cada recurso.
*/

SET search_path = practica5_ej5;

CREATE OR REPLACE FUNCTION ejercicio_b() returns void AS
$$
DECLARE 
	registro RECORD;
	fecha_in TIMESTAMP; 
	fecha_out TIMESTAMP;
	recurso bigint;
	count int;
BEGIN
    FOR registro IN select persona_id from practica5_ej5.persona  LOOP
  		count := (select trunc(random() * 10 + 1));
  		FOR i IN 1..count LOOP
    		fecha_in := (select NOW() + random() * (timestamp '2016-01-01 00:00:00' - NOW())); --fecha random entre NOW() y la dada
    		--fecha_in := registro."FECHA_INGRESO";
    		fecha_out := (select fecha_in + random() * (timestamp '2020-01-20 20:00:00' - fecha_in));

    		select "RECURSO_ID" into recurso from recurso order by RANDOM() limit 1; --recurso aleatorio

    		insert into practica5_ej5.seguimiento_acceso (FECHA_YHORA_ENTRADA, FECHA_YHORA_SALIDA, HOST, PERSONA_ID, RECURSO_ID) 
    	    	values(fecha_in,fecha_out,NULL,registro.persona_id,recurso);

		END LOOP;  
    END LOOP;
END;
$$ LANGUAGE plpgsql;

select ejercicio_b();


/*
c) Observe y analice en el catálogo la información estadística de las tablas creadas
en este ejercicio.
*/


/*
d) Luego de ejecutar la siguiente consulta:
explain select * from seguimiento_acceso WHERE FECHA_YHORA_ENTRADA = '2017-09-12 17:07:57.611526';  
       
	a. Observe que plan de ejecución utilizó postgres para resolver la consulta
	   del punto anterior (utilice Explain Select......).
*/
			"Seq Scan on seguimiento_acceso  (cost=0.00..2976.49 rows=1 width=254)"
			"Filter: (fecha_yhora_entrada = '2017-09-12 17:07:57.611526'::timestamp without time zone)"
		
			Total query runtime: 42 ms.
			1 row retrieved.

/*	   
	b. Que podría hacer para mejorar la performance de la consulta, y hacer que
	   el motor de base de datos cambie el plan de ejecución.( hágalo y vea el nuevo plan)
*/
			CREATE INDEX index_dateIn ON seguimiento_acceso (FECHA_YHORA_ENTRADA);
			
			"Index Scan using index_datein on seguimiento_acceso  (cost=0.42..8.44 rows=1 width=254)"
			"Index Cond: (fecha_yhora_entrada = '2017-09-12 17:07:57.611526'::timestamp without time zone)"
			
			Total query runtime: 13 ms.
			1 row retrieved.



/*
e) Luego de ejecutar siguiente consulta:
select * from seguimiento_acceso NATURAL JOIN persona

	a. Analice su plan de ejecución.
*/
			explain select * from seguimiento_acceso NATURAL JOIN persona

			"Hash Join  (cost=828.83..15915.35 rows=142839 width=460)"
			"  Hash Cond: (seguimiento_acceso.persona_id = persona.persona_id)"
			"  ->  Seq Scan on seguimiento_acceso  (cost=0.00..2619.39 rows=142839 width=254)"
			"  ->  Hash  (cost=286.70..286.70 rows=12970 width=214)"
			"        ->  Seq Scan on persona  (cost=0.00..286.70 rows=12970 width=214)"
		
			Total query runtime: 44963 ms.
			142839 rows retrieved.
/*	
	b. Modifique la consulta para hacer que el motor de base de datos utilice el
	   algoritmo de Merge Join, en lugar del algoritmo de Hash Join.
*/
			explain select * from seguimiento_acceso NATURAL JOIN persona ORDER BY persona_id
	
			"Merge Join  (cost=49030.64..52070.87 rows=142839 width=460)"
			"  Merge Cond: (persona.persona_id = seguimiento_acceso.persona_id)"
			"  ->  Index Scan using persona_pkey on persona  (cost=0.29..508.55 rows=12970 width=214)"
			"  ->  Materialize  (cost=49030.29..49744.48 rows=142839 width=254)"
			"        ->  Sort  (cost=49030.29..49387.38 rows=142839 width=254)"
			"              Sort Key: seguimiento_acceso.persona_id"
			"              ->  Seq Scan on seguimiento_acceso  (cost=0.00..2619.39 rows=142839 width=254)"
		
			Total query runtime: 45061 ms.
			142839 rows retrieved.

--Tener en cuenta que deberia ser hecho en igualdad de condiciones.

	