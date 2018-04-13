/*
Ejercicio 2
Realizar un programa Java que invoque la función implementada en el ejercicio 2 de la
práctica 3 (máxima cotización) y muestre los parámetros de salida.
*/

//java -cp .:postgresql-9.0-801.jdbc4.jar ej2_jdbc (cod_banco)

import java.sql.*;
import java.util.*;
public class ej2_jdbc {

	public static void main(String[] args) {
    
	    try{
	
	        String driver = "org.postgresql.Driver";
	        String url = "jdbc:postgresql://localhost:5432/postgres/sp_ej2";
	        String username = "postgres";
	        String password = "root";
	
	        // Load database driver if not already loaded.
	        Class.forName(driver);
	        
	        // Establish network connection to database.
	        Connection connection = DriverManager.getConnection(url, username, password);
	        connection.setAutoCommit(false); 
	        
			//FUNCTION max_cot(in bank varchar(20), out maximo float) returns float
	   		CallableStatement  cstmt = connection.prepareCall("{call max_cot(?,?)}");

	   		String bank = args[0];
	   		cstmt.setString(1, bank);
	   		cstmt.registerOutParameter(2, Types.DOUBLE);
			cstmt.execute();
	   	
	   		System.out.println("\n--------------------------------------------------");
	   		System.out.println("     Cotización maxima obtenida: " + cstmt.getDouble(2)); 
			System.out.println("--------------------------------------------------\n");

	   		connection.commit();
			cstmt.close();
	   		

    	}catch(ClassNotFoundException cnfe) {
    	    System.err.println("Error loading driver: " + cnfe);
    	    }catch(SQLException sqle) {
    	        try{
    	           // como se produjo una excepción en el acceso a la base de datos se debe hacer el rollback  
    	           // Thread.sleep (20*1000);  
    	           System.err.println("antes rollback: " + sqle);
    	           System.err.println("Error Se produjo una Excepción accediendo a la base de datos: " + sqle);
    	           sqle.printStackTrace();
    	        }catch(Exception e) {
    	            //System.err.println("Error Ejecutando el rollback de la transaccion: " + e.getMessage());
    	            e.printStackTrace();
    	        }
    	    } 
 	}        
}          		