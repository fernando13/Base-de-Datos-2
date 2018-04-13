/*
Ejercicio 1
Teniendo en cuenta el ejercicio 1 a) de la práctica de repaso, cree un programa java que
implemente un Alta y listado de clientes. El programa puede ser hecho sin Interfaz gráfica,
sólo en línea de comandos.
Nota: Resolver utilizando los motores que se utilizaron en la creación de las tablas .
*/

//java -cp .:mysql-connector-java-5.0.8-bin.jar ej1_jdbc

import java.sql.*;
import java.util.*;
public class ej1_jdbc {

   static final String jdbc_driver = "org.gjt.mm.mysql.Driver";  
   static final String url = "jdbc:mysql://localhost/ejercicio1a";
   static final String username = "root";
   static final String password = "root";

public static void printUsers(ResultSet rs) throws SQLException{
   System.out.println(); 
     
   rs.beforeFirst();
	while(rs.next()){
      System.out.print("Id:" + rs.getInt("nro_cliente"));
      System.out.print(", Nombre: " + rs.getString("nombre"));
      System.out.print(", Apellido: " + rs.getString("apellido"));
      System.out.print(", Direc: " + rs.getString("direccion"));
      System.out.print(", Tel: " + rs.getString("telefono"));
      System.out.println(); 
   }
}

public static void newUser(Connection connection) throws SQLException{
   System.out.println(); 

   Scanner sc = new Scanner(System.in);
   System.out.println("/**********- Seccion de Alta de Usuario -**********/\n");
   
   System.out.print("Ingrese Nombre: ");
   String name = sc.next();
   System.out.print("\n");

   System.out.print("Ingrese Apellido: ");
   String surname = sc.next();
   System.out.print("\n");

   System.out.print("Ingrese Direccion: ");
   String dir = sc.next();
   System.out.print("\n");

   System.out.print("Ingrese Telefono: ");
   String tel = sc.next();
   System.out.print("\n");

   connection.setAutoCommit(false); 
   String query = "insert into cliente (nombre, apellido, direccion, telefono) values(?,?,?,?)";
   PreparedStatement  stmt = connection.prepareStatement(query);
   // Send query to database and store results.
   stmt.setString(1, name);
   stmt.setString(2, surname);
   stmt.setString(3, dir);
   stmt.setString(4, tel);
   stmt.executeUpdate();

   connection.commit();
   System.out.println("Usuario Creado!!");
}


public static void main(String[] args) {
      Connection connection = null;
      try{
         //Register JDBC driver
         Class.forName(jdbc_driver);

         //Open a connection
         System.out.println("Connecting to database...");
         connection = DriverManager.getConnection(url, username, password);

         //Execute a query to create statment with required arguments for RS example.
         System.out.println("Creating statement...");
         Statement statement = connection.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE,
                                                           ResultSet.CONCUR_UPDATABLE);

         /******************************************************/
         Scanner sc = new Scanner(System.in);
         int opt=0;
         while(opt!=3){
            System.out.println("\n\n/********- MENU PRINCIPAL -********/\n");
            System.out.println("Escoja una opcion:");
            System.out.println("  1- Listar Usuarios");
            System.out.println("  2- Crear Nuevo Usuario");
            System.out.println("  3- Salir");

            opt=sc.nextInt();
            switch (opt) {
               case 1: 
                  String sql = "Select * from cliente;";
                  ResultSet rs = statement.executeQuery(sql);
                  printUsers(rs);  
                  break;

               case 2:
                  newUser(connection);
                  break;

               case 3:
                  break;

               default:
                  System.out.println("Opcion Invalida");
                  break;
            }
            
         }
         statement.close();
         connection.close();
         
      }catch(SQLException se){
         //Handle errors for JDBC
         se.printStackTrace();
      }catch(Exception e){
         //Handle errors for Class.forName
         e.printStackTrace();
      }finally{
         //finally block used to close resources
         try{
            if(connection!=null)
               connection.close();
         }catch(SQLException se){
            se.printStackTrace();
         }//end finally try
      }//end try
      System.out.println("GoodBye!");
   }//end main
   
}