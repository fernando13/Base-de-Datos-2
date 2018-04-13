//FALTA HACEEEEEEEEEER


import java.sql.*;
import java.util.*;
public class ej2_jdbc {

    public static void main(String[] args) {
    
        try{
    
            String driver = "org.postgresql.Driver";
            String url = "jdbc:postgresql://localhost:5432/postgres/practica5_ej5";
            String username = "postgres";
            String password = "root";
    
            // Load database driver if not already loaded.
            Class.forName(driver);
            
            // Establish network connection to database.
            Connection connection = DriverManager.getConnection(url, username, password);
            connection.setAutoCommit(false); 
            

            Statement stmt = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "Select persona_id from practica5_ej5.persona;";
            ResultSet rsPesona = stmt.executeQuery(query);
            ResultSet rsRecurso;
            PreparedStatement  preparedStmt;
            int count;
            String fecha_in, fecha_out;

            while(rsPesona.next()){
                count = (int)Math.random()*10
                for (i=1; i <= count; i++) {
                    fecha_in = //random date
                    fecha_out = //random date    2016-01-01 00:00:00
                    rsRecurso = stmt.executeQuery("select "RECURSO_ID" into recurso from recurso order by RANDOM() limit 1;");

                    query = "insert into seguimiento_acceso 
                            (FECHA_YHORA_ENTRADA, FECHA_YHORA_SALIDA, HOST, PERSONA_ID, RECURSO_ID) values(?,?,?,?,?);";

                    preparedStmt = connection.prepareStatement(query);               
                    preparedStmt;.setString(1, fecha_in);
                    preparedStmt;.setString(2, fecha_out);
                    preparedStmt;.setString(3, NULL);
                    preparedStmt;.setInt(4, rsPesona.getInt("PERSONA_ID"));
                    preparedStmt;.setInt(5, rsRecurso.getInt("RECURSO_ID"));
                    preparedStmt;.executeUpdate();

                    connection.commit();
                }                
            }
            connection.close();
            System.out.println("Done!");
            

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