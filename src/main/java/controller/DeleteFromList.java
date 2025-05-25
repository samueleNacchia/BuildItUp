package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ListType;
import model.ItemList.ItemListDAO;
import model.ItemList.ItemListDTO;
import model.List.ListDTO;
import model.Product.ProductDAO;
import model.Product.ProductDTO;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/DeleteFromList")
public class DeleteFromList extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    
    	ItemListDAO ItemListDao = new ItemListDAO();
        
    	try {
            ListType type = ListType.valueOf(request.getParameter("type"));
            int productId = Integer.parseInt(request.getParameter("id"));
            
            ProductDAO productDao = new ProductDAO();
            ProductDTO product = productDao.findByCode(productId);
            
            ListDTO list = ListManager.getList(request, response, type);
            
            if (product != null) {
                
	            if (list == null) {
	                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lista non trovata o creata");
	                return;
	            }
	           
	            ItemListDTO item = ItemListDao.findProduct(list.getId(), productId);
	            
	            
	            	if(type.name().equals("cart") && item.getQuantity() > 1) {
	            		item.setQuantity(item.getQuantity() - 1);
	            		ItemListDao.update(item);
	            	} else {
	            		ItemListDao.deleteFromList(list.getId(), productId);
	            	}
            }
            
            
            response.setContentType("text/html;charset=UTF-8");
           
            // torna alla pagina precedente
            String referer = request.getHeader("Referer");
            if (referer != null) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect(request.getContextPath() + "/index.html");
            }
         

        } catch (SQLException | IllegalArgumentException | NullPointerException e) {
            e.printStackTrace();
        } 
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}


