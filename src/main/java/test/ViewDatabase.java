package test;

import model.Admin.*;
import model.Bill.*;
import model.Order.*;
import model.Product.*;
import model.ProductOrder.*;
import model.Review.*;
import model.User.*;
import model.Newsletter.*;
import model.List.*;
import model.ItemList.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/products")
public class ViewDatabase extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
        ProductDAO ProductDao = new ProductDAO();
        UserDAO UserDao = new UserDAO();
        AdminDAO AdminDao = new AdminDAO();
        OrderDAO OrderDao = new OrderDAO();
        ProductOrderDAO ProductOrderDao = new ProductOrderDAO();
        ReviewDAO ReviewDao = new ReviewDAO();
        BillDAO BillDao = new BillDAO();
        NewsletterDAO NewsletterDao = new NewsletterDAO();
        ListDAO ListDao = new ListDAO();
        ItemListDAO ItemListDao = new ItemListDAO();
        
        try {
            List<ProductDTO> prodotti = ProductDao.findAll();
            request.setAttribute("prodotti", prodotti);
            
            List<UserDTO> utenti = UserDao.findAll();
            request.setAttribute("utenti", utenti);
            
            List<AdminDTO> admin = AdminDao.findAll(); 
            request.setAttribute("admin", admin);
            
            List<OrderDTO> ordini = OrderDao.findAll();
            request.setAttribute("ordini", ordini);
            
            
            List<ProductOrderDTO> prodottiOrdinati = ProductOrderDao.findAll();
            request.setAttribute("prodottiOrdinati", prodottiOrdinati);
            
            
            List<ReviewDTO> recensioniProdotto = ReviewDao.findAll();
            request.setAttribute("recensioniProdotto", recensioniProdotto);
            
            
            List<BillDTO> fatture = BillDao.findAll();
            request.setAttribute("fatture", fatture);
            
            
            List<NewsletterDTO> Newsletter = NewsletterDao.findAll();
            request.setAttribute("news", Newsletter);
            
            List<ListDTO> liste = ListDao.findAll();
            request.setAttribute("liste", liste);
            
            List<ItemListDTO> item = ItemListDao.findAll();
            request.setAttribute("item", item);
            
            
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