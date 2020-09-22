/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Lemmar
 */
public class Conexion {

    Connection con;

    public Conexion() {
        try {
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/proyecto", "postgres", "123456");
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Error " + e);
        }
    }

    public Connection getConnection() {
        return con;
    }
}
