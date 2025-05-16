package controller;

import model.ProductDAO;
import model.ProductDTO;
import model.UserDAO;
import model.UserDTO;
import model.AdminDAO;
import model.AdminDTO;
import model.OrderDAO;
import model.OrderDTO;
import model.ProductOrderDAO;
import model.ProductOrderDTO;
import model.ReviewDAO;
import model.ReviewDTO;
import model.BillDAO;
import model.BillDTO;
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
        OrderDAO OrderDao = new OrderDAO();
        ProductOrderDAO ProductOrderDao = new ProductOrderDAO();
        ReviewDAO ReviewDao = new ReviewDAO();
        BillDAO BillDao = new BillDAO();
        
        try {
            List<ProductDTO> prodotti = ProductDao.findAll();
            request.setAttribute("prodotti", prodotti);
            
            List<UserDTO> utenti = UserDao.findAll();
            request.setAttribute("utenti", utenti);
            
            List<AdminDTO> admin = AdminDao.findAll(); 
            request.setAttribute("admin", admin);
            
            List<OrderDTO> ordini = OrderDao.findAll();
            request.setAttribute("ordini", ordini);
            
            for(OrderDTO order : ordini) {
            	List<ProductOrderDTO> prodottiOrdinati = ProductOrderDao.findAllforOrder(order.getId());
            	request.setAttribute("prodottiOrdinati", prodottiOrdinati);
            	break;
            }
            
            for(ProductDTO product : prodotti) {
            	List<ReviewDTO> recensioniProdotto = ReviewDao.findAllforProduct(product.getId());
                request.setAttribute("recensioniProdotto", recensioniProdotto);
            	break;
            }
            
            List<BillDTO> fatture = BillDao.findAll();
            request.setAttribute("fatture", fatture);
            
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errore", "Errore durante il recupero dei pati.");
        }
        
        response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("/ViewData.jsp").forward(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            doPost(request,response);
    }
       
}