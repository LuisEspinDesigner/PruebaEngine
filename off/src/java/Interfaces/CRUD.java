/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Interfaces;

import java.util.List;
import model.Puntos;

/**
 *
 * @author Lemmar
 */
public interface CRUD {

    public List listar();

    public Puntos list(String sitio);

    public boolean agregar(Puntos per);

    public boolean editar(Puntos per);

    public boolean eliminar(String sitio);
}
