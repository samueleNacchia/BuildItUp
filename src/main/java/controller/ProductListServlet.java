package controller;

import model.ProductDAO;
import model.ProductDTO;
import model.UserDAO;
import model.UserDTO;
import model.AdminDAO;
import model.AdminDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

//@WebServlet("/products")
public class ProductListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        ProductDAO ProductDao = new ProductDAO();
        UserDAO UserDao = new UserDAO();
        AdminDAO AdminDao = new AdminDAO();
        
        try {
            List<ProductDTO> prodotti = ProductDao.findAll();
            request.setAttribute("prodotti", prodotti);
            
            List<UserDTO> utenti = UserDao.findAll();
            request.setAttribute("utenti", utenti);
            
            List<AdminDTO> admin = AdminDao.findAll(); 
            request.setAttribute("admin", admin);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errore", "Errore durante il recupero dei pati.");
        }

        request.getRequestDispatcher("/ViewData.jsp").forward(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            doPost(request,response);
    }
       
}