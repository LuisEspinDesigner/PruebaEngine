/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ws;

import java.io.IOException;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

/**
 *
 * @author Dell i5
 */
@ServerEndpoint("/datos")
public class Datos {
//PWS-PIVI
  @OnOpen
    public void conexionOpen() {
        System.out.println("Conexion abierta");
    }

    @OnClose
    public void conexionClose() {
        System.out.println("Conexion Cerrada");
    }

    @OnMessage
     public synchronized void processMessage(Session session, String message) {
        //se impremime el mensaje   
        //System.out.println("mesaje recibido:" +message);
        //captura las sessiones
        try {
            for (Session sess : session.getOpenSessions()) {
                if (sess.isOpen()) {
                    sess.getBasicRemote().sendText(message);
                }
            }
        } catch (IOException ioe) {
            System.out.println(ioe.getMessage());
        }
    }
}
