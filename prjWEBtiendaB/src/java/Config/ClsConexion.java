package Config;

import java.sql.*;

public class ClsConexion {
    Connection con = null;

    public ClsConexion() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/dbtienda",
                "root",
                ""
            );
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Error de conexión: " + e.getMessage());
        }
    }

    public Connection getConnection() {
        
        return con;
    }
}