/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controlador;
import Modelo.Cliente;
import ModeloDao.ClienteDAO;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 *
 * @author HP
 */
@WebServlet(name = "ClienteControlador", urlPatterns = {"/ClienteControlador"})
public class ClienteControlador extends HttpServlet {

    String listar = "VistaCliente/listar.jsp";
    String add = "VistaCliente/agregar.jsp";
    String edit = "VistaCliente/editar.jsp";
    Cliente cli = new Cliente();
    ClienteDAO dao = new ClienteDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
                    String dni = request.getParameter("txtdni");
                    String nom = request.getParameter("txtnombres");
                    String ape = request.getParameter("txtapellidos");
                    String dir = request.getParameter("txtdireccion");
                    String em = request.getParameter("txtemail");
                    String cla = request.getParameter("txtclave");
                    cli.setDni(dni);
                    cli.setNombres(nom);
                    cli.setApellidos(ape);
                    cli.setDireccion(dir);
                    cli.setEmail(em);
                    cli.setClave(cla);
                    dao.add(cli);
                    acceso = listar;
                    break;
                case "editar":
                    String vdni = request.getParameter("vdni");
                    request.setAttribute("vdni", vdni);
                    acceso = edit;
                    break;
                case "actualizar":
                    String dni2 = request.getParameter("txtdni");
                    String nom2 = request.getParameter("txtnombres");
                    String ape2 = request.getParameter("txtapellidos");
                    String dir2 = request.getParameter("txtdireccion");
                    String em2 = request.getParameter("txtemail");
                    String cla2 = request.getParameter("txtclave");
                    cli.setDni(dni2);
                    cli.setNombres(nom2);
                    cli.setApellidos(ape2);
                    cli.setDireccion(dir2);
                    cli.setEmail(em2);
                    cli.setClave(cla2);
                    dao.edit(cli);
                    acceso = listar;
                    break;
                case "eliminar":
                    String vdni2 = request.getParameter("vdni");
                    dao.eliminar(vdni2);
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
        return "Controlador de Cliente";
    }
}
