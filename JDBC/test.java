/*
Ejercicio 3
Realizar un programa Java que liste las tablas de la base de datos del ejercicio 1 c) de la
práctica 1) de repaso de SQL(bases de datos cliente, automóviles, etc), debe listar las
tablas, su clave primaria, atributos y claves únicas y foráneas.
Nota: Resolver utilizando los motores que se utilizaron en la creación de las bases de datos .
*/
//java -cp .:postgresql-9.0-801.jdbc4.jar test
//SET search_path = practica5_ej5;
//CREATE INDEX index_dateIn ON seguimiento_acceso (FECHA_YHORA_ENTRADA);
import java.sql.*;
import java.util.*;
public class test {

    public static void main(String[] args) {
    
        try{
    
            String driver = "org.postgresql.Driver";
            String url = "jdbc:postgresql://localhost:5432/postgres";
            String username = "postgres";
            String password = "root";
    
            // Load database driver if not already loaded.
            Class.forName(driver);
            
            // Establish network connection to database.
            Connection connection = DriverManager.getConnection(url, username, password);
      
            DatabaseMetaData metaData = connection.getMetaData();
          
            //Obtengo las tablas de la Base de Datos.
            String[] tipo = {"TABLE"};
            ResultSet resultSetTables = metaData.getTables("postgres","ejercicio_c", null, tipo);
            /*String schema = "ejercicio_c";
            Statement stmt = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);     
            String query = "select * from information_schema.triggers where trigger_schema ='"+schema+"';";
            ResultSet rs = stmt.executeQuery(query);
            rs.beforeFirst();
            while(rs.next()){
                System.out.println("Catalogo: "+rs.getString("trigger_catalog"));
                System.out.println("Schema: "+rs.getString("trigger_schema"));
                System.out.println("Trigger-Name: "+rs.getString("trigger_name"));
                System.out.println("Evento: "+rs.getString("event_manipulation"));
                System.out.println("On table: "+rs.getString("event_object_table"));
                System.out.println("Timing: "+rs.getString("action_timing"));
                System.out.println();
            }*/
            /*String check ="CHECK";
            String tableName = "cliente";
            Statement stmt = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String schema = "ejercicio_c";
            String query = "SELECT tc.constraint_schema, tc.constraint_name, tc.table_name, cc.check_clause FROM information_schema.table_constraints as tc JOIN information_schema.check_constraints as cc ON tc.constraint_name = cc.constraint_name WHERE tc.table_name ='"+tableName+"' and tc.constraint_schema ='"+schema+"' and tc.constraint_type ='"+check+"';";
            ResultSet rs = stmt.executeQuery(query);
            rs.beforeFirst();
            while(rs.next()){
                System.out.println("Schema: "+rs.getString("constraint_schema"));
                System.out.println("Constraint_name: "+rs.getString("constraint_name"));
                System.out.println("Table: "+rs.getString("table_name"));
                System.out.println("Check_clause: "+rs.getString("check_clause"));
                System.out.println();
            }*/









            
            /*
            //Obtengo las funciones
            ResultSet rsProc = metaData.getProcedures(connection.getCatalog(), "ejercicio_c", "%");
            while(rsProc.next()) {

                String procedureName = rsProc.getString(3);
                short  type  = rsProc.getShort(8); 

                System.out.println("\n\n---------------------------------------");
                System.out.println("procedureName: "+procedureName);
                System.out.println("procedure_type: "+type);
                System.out.println("\n---------------------------------------");

                ResultSet rsPColum = metaData.getProcedureColumns(connection.getCatalog(), "ejercicio_c", procedureName, null);
                while(rsPColum.next()) {

                    // get stored procedure metadata
                    String procedureCatalog     = rsPColum.getString(1);
                    String procedureSchema      = rsPColum.getString(2);
                    String name                 = rsPColum.getString(3); 
                    String columnName           = rsPColum.getString(4);
                    short  in_out         		= rsPColum.getShort(5); //1-IN
                    int    columnDataType       = rsPColum.getInt(6);
                    String columnReturnTypeName = rsPColum.getString(7);

	                /*
	                getShort(5); // COLUMN_TYPE Short => kind of column/parameter:
	                (?)procedureColumnUnknown - nobody knows
	                (1)procedureColumnIn - IN parameter
	                (2)procedureColumnInOut - INOUT parameter
	                (4)procedureColumnOut - OUT parameter
	                (5)procedureColumnReturn - procedure return value
	                (?)procedureColumnResult - result column in ResultSet
	                

	                System.out.println("-----------Column-----------\n");
	                System.out.println("-procedureCatalog: "+procedureCatalog);
	                System.out.println("-procedureSchema: "+procedureSchema);
	                System.out.println("-procedureName: "+name);
	                System.out.println("-columnName: "+columnName);
	                System.out.println("-in-out: "+in_out);
	                System.out.println("-columnDataType: "+columnDataType);
	                System.out.println("-columnTypeName: "+columnReturnTypeName);
	                 //System.out.println("-oder: "+order);
                
                } 
            } */   
            

           System.out.println(" tablas de la base de datos ");
            while(resultSetTables.next()){
                System.out.println("\n----------------------------------------------\n");
                //System.out.println("catalogo: " + resultSetTables.getString(1));
                //System.out.println("esquema: " + resultSetTables.getString(2));
                System.out.println("Table: " + resultSetTables.getString(3));
                //System.out.println("type: " + resultSetTables.getString(4));
                //System.out.println(" comentarios: " + resultSetTables.getString(5));
      
                //Obtengo las columnas de la tabla.
                String tableName = resultSetTables.getString(3);
                ResultSet resultSetColums = metaData.getColumns(null, null, tableName, null);   
                while(resultSetColums.next() ){  
                    //System.out.println("-" + resultSetColums.getString(4) + ": " + resultSetColums.getString(6) );

                    ResultSet index = metaData.getIndexInfo("postgres","ejercicio_c", tableName, false,true);
                    while(index.next() ){
                    	//System.out.println("TABLE: "+index.getString(3));
                    	//if(index.getBoolean(4)){

                    		System.out.println("\nNON_UNIQUE: "+index.getBoolean(4));
                    		System.out.println("INDEX_QUALIFIER: "+index.getString(5));
                    		System.out.println("INDEX_NAME: "+index.getString(6));
                    		System.out.println("TYPE: "+index.getString(7));
                    		System.out.println("COLUMN_NAME: "+index.getString(9));
                    		//System.out.println("INDEX_NAME: "+resultSetTables.getString(6));*/
                   		// }
                } 
                    

                  
                }
            }


                /*
                //Obtengo las claves primarias de la tabla.
                ResultSet primaryKeys = metaData.getPrimaryKeys(null, "ejercicio_c", tableName); 
                while(primaryKeys.next()) {
                    System.out.println("Primary key: " + primaryKeys.getString("COLUMN_NAME")); //(4)
                }
   				*/
                //Obtengo las claves foraneas
               /* ResultSet resultForeignKeys = metaData.getImportedKeys("postgres","ejercicio_c", tableName);
                while(resultForeignKeys.next()){

                    System.out.println("tabla "+resultForeignKeys.getString(3));
                    System.out.println("columna: "+resultForeignKeys.getString(4));
                    System.out.println("tableName: "+resultForeignKeys.getString(7));
                    System.out.println("columnName: "+resultForeignKeys.getString(8));

                }*/
                
            	
    
        }catch(ClassNotFoundException cnfe) {
            System.err.println("Error loading driver: " + cnfe);
            }catch(SQLException sqle) {
                try{
                   // como se produjo una excepción en el acceso a la base de datos se debe hacer el rollback  
                   // Thread.sleep (20*1000);  
                   System.err.println("antes rollback: " + sqle);
                   System.err.println("Error Se producjo una Excepción accediendo a la base de datoas: " + sqle);
                   sqle.printStackTrace();
                }catch(Exception e) {
                    //System.err.println("Error Ejecutando el rollback de la transaccion: " + e.getMessage());
                    e.printStackTrace();
                }
            }
    }          
} 
/*
SET search_path = ejercicio_c;
CREATE FUNCTION triggg() RETURNS trigger AS $triggg$
    BEGIN
        -- Check that empname and salary are given
        IF NEW.dni<0 THEN
            RAISE EXCEPTION 'dn cannot be negative';
        END IF;
        
        RETURN NEW;
    END;
$triggg$ LANGUAGE plpgsql;

CREATE TRIGGER T_triggg BEFORE INSERT ON cliente
    FOR EACH ROW EXECUTE PROCEDURE triggg();*/



//https://www.postgresql.org/docs/9.0/static/catalog-pg-trigger.html   (trigger catalogue)