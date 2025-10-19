/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controlador;

import Modelo.Usuario;
import ModeloDao.UsuarioDAO;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "UsuarioControlador", urlPatterns = {"/UsuarioControlador"})
public class UsuarioControlador extends HttpServlet {

    String listar = "VistaUsuario/listar.jsp";
    String add = "VistaUsuario/agregar.jsp";
    String edit = "VistaUsuario/editar.jsp";
    Usuario usr = new Usuario();
    UsuarioDAO dao = new UsuarioDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Verificar permisos (solo Administrador)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("idCargo") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int idCargo = (Integer) session.getAttribute("idCargo");
        if (idCargo != 1) {
            response.sendRedirect("home.jsp?error=no_permission");
            return;
        }
        
        String acceso = "";
        String action = request.getParameter("action");
        
        if (action != null) {
            switch (action) {
                case "listar":
                    acceso = listar;
                    break;
                case "add":
                    acceso = add;
                    break;
                case "agregar":
                    String usuario = request.getParameter("txtusuario");
                    String clave = request.getParameter("txtclave");
                    String nombre = request.getParameter("txtnombre");
                    String apellido = request.getParameter("txtapellido");
                    String email = request.getParameter("txtemail");
                    int cargo = Integer.parseInt(request.getParameter("txtcargo"));
                    int estado = Integer.parseInt(request.getParameter("txtestado"));
                    
                    usr.setUsuario(usuario);
                    usr.setClave(clave);
                    usr.setNombre(nombre);
                    usr.setApellido(apellido);
                    usr.setEmail(email);
                    usr.setIdCargo(cargo);
                    usr.setEstado(estado);
                    dao.add(usr);
                    acceso = listar;
                    break;
                case "editar":
                    int id = Integer.parseInt(request.getParameter("id"));
                    request.setAttribute("idUsuario", id);
                    acceso = edit;
                    break;
                case "actualizar":
                    int id2 = Integer.parseInt(request.getParameter("txtidusuario"));
                    String usuario2 = request.getParameter("txtusuario");
                    String clave2 = request.getParameter("txtclave");
                    String nombre2 = request.getParameter("txtnombre");
                    String apellido2 = request.getParameter("txtapellido");
                    String email2 = request.getParameter("txtemail");
                    int cargo2 = Integer.parseInt(request.getParameter("txtcargo"));
                    int estado2 = Integer.parseInt(request.getParameter("txtestado"));
                    
                    usr.setIdUsuario(id2);
                    usr.setUsuario(usuario2);
                    usr.setClave(clave2);
                    usr.setNombre(nombre2);
                    usr.setApellido(apellido2);
                    usr.setEmail(email2);
                    usr.setIdCargo(cargo2);
                    usr.setEstado(estado2);
                    dao.edit(usr);
                    acceso = listar;
                    break;
                case "eliminar":
                    int id3 = Integer.parseInt(request.getParameter("id"));
                    dao.eliminar(id3);
                    acceso = listar;
                    break;
                default:
                    acceso = listar;
                    break;
            }
        } else {
            acceso = listar;
        }

        RequestDispatcher vista = request.getRequestDispatcher(acceso);
        vista.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Controlador de Usuario";
    }
}