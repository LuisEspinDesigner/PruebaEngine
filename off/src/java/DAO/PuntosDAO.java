/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Interfaces.CRUD;
import conexion.Conexion;
import java.io.Console;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Puntos;

/**
 *
 * @author Lemmar
 */
public class PuntosDAO implements CRUD {

    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    Puntos p = new Puntos();

    @Override
    public List listar() {
        ArrayList<Puntos> list = new ArrayList<>();
        String sql = "select gid, direccion, sitio, ST_X(geom), ST_Y(geom) from puntos";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Puntos per = new Puntos();
                per.setGid(rs.getInt("gid"));
                per.setDireccion(rs.getString("direccion"));
                per.setSitio(rs.getString("sitio"));
                per.setDelito(rs.getString("delito"));
                per.setX(rs.getString("ST_X(geom)"));
                per.setY(rs.getString("ST_Y(geom)"));
                list.add(per);
            }
        } catch (SQLException e) {

        }
        return list;
    }

    @Override
    public Puntos list(String sitio) {
        String sql = "select gid, direccion, sitio, ST_X(geom), ST_Y(geom) from puntos where UPPER(sitio) = UPPER(" + sitio + ")";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {

                p.setGid(rs.getInt("gid"));
                p.setDireccion(rs.getString("direccion"));
                p.setSitio(rs.getString("sitio"));
                p.setDelito(rs.getString("delito"));
                p.setX(rs.getString("ST_X(geom)"));
                p.setY(rs.getString("ST_Y(geom)"));

            }
        } catch (SQLException e) {

        }
        return p;
    }

    @Override
    public boolean agregar(Puntos per) {

        String puntosxy = per.getY() + " " + per.getX();
        String sql = "insert into puntos(geom, direccion, sitio, crimen) values(ST_GeomFromText('point(" + puntosxy + ")', 4326), '" + per.getDireccion() + "', '" + per.getSitio() + "', '" + per.getDelito() + "')";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.print(e.getMessage());
        }
        return false;
    }

    @Override
    public boolean editar(Puntos per) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean eliminar(String sitio) {
        String sql = "delete from puntos where UPPER(sitio) = UPPER(" + sitio + ")";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
        return false;
    }

}
