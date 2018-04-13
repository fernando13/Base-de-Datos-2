/*
Ejercicio 3
Realizar un programa Java que liste las tablas de la base de datos del ejercicio 1 c) de la
práctica 1) de repaso de SQL(bases de datos cliente, automóviles, etc), debe listar las
tablas, su clave primaria, atributos y claves únicas y foráneas.
Nota: Resolver utilizando los motores que se utilizaron en la creación de las bases de datos .
*/
//java -cp .:postgresql-9.0-801.jdbc4.jar ej3_jdbc
import java.sql.*;
import java.util.*;
public class ej3_jdbc {

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
                while(resultSetColums.next() )  
                    System.out.println("-" + resultSetColums.getString(4) + ": " + resultSetColums.getString(6) );
               
                //Obtengo las claves primarias de la tabla.
                ResultSet primaryKeys = metaData.getPrimaryKeys(null, "ejercicio_c", tableName); 
                while(primaryKeys.next()) {
                    System.out.println("Primary key: " + primaryKeys.getString("COLUMN_NAME"));
                }
    
                //Obtengo las claves foraneas
                ResultSet resultForeignKeys = metaData.getImportedKeys("postgres","ejercicio_c", tableName);
                while(resultForeignKeys.next()){
                    System.out.println("Foreign key: "+resultForeignKeys.getString(3));
                }
            }
    
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