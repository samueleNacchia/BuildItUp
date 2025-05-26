package test;

import model.Admin.AdminDAO;
import model.Admin.AdminDTO;
import model.Bill.BillDAO;
import model.Bill.BillDTO;
import model.Order.OrderDAO;
import model.Order.OrderDTO;
import model.Product.ProductDAO;
import model.Product.ProductDTO;
import model.ProductOrder.ProductOrderDAO;
import model.ProductOrder.ProductOrderDTO;
import model.Review.ReviewDAO;
import model.Review.ReviewDTO;
import model.User.UserDAO;
import model.User.UserDTO;

import model.Newsletter.NewsletterDAO;
import model.Newsletter.NewsletterDTO;

import model.List.ListDAO;
import model.List.ListDTO;

import model.ItemList.ItemListDAO;
import model.ItemList.ItemListDTO;

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
            
            
            List<NewsletterDTO> Newsletter = NewsletterDao.findAll();
            request.setAttribute("news", Newsletter);
            
            List<ListDTO> liste = ListDao.findAll();
            request.setAttribute("liste", liste);
            
            List<ItemListDTO> item = ItemListDao.findAll();
            request.setAttribute("item", item);
            
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errore", "Errore durante il recupero dei dati.");
        }
        
        response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("/ViewData.jsp").forward(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            doPost(request,response);
    }
       
}