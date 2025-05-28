package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ListType;
import model.ItemList.*;
import model.List.ListDTO;
import model.Product.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/AddToList")
public class AddToList extends HttpServlet {
    private static final long serialVersionUID = 1L; 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	ItemListDAO itemsDao = new ItemListDAO();
    	
    	try {
            ListType type = ListType.valueOf(request.getParameter("type"));
            int productId = Integer.parseInt(request.getParameter("id"));
            
            ProductDAO productDao = new ProductDAO();
            ProductDTO product = productDao.findByCode(productId);
            
            if (product != null && product.isOnSale() && product.getStocks()>0) {
            	
            	ListDTO list = ListManager.getList(request, response, type, true);
	            
            	if (list == null) {
	                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lista non trovata o creata");
	                return;
	            }
	
	            //Controllo se il prodotto è già nella lista
	            ItemListDTO existingItem = itemsDao.findProduct(list.getId(), productId);
	            
	            if (existingItem == null && product != null && product.isOnSale()) {
	            	
	                //Se non c’è, creo un nuovo item
	                ItemListDTO newItem = new ItemListDTO();
	                newItem.setId_list(list.getId());
	                newItem.setId_product(productId);
	                
	                if(type.name().equalsIgnoreCase("cart"))
	                	newItem.setQuantity(1); 
	                
	                itemsDao.save(newItem);
	            } 
	            
	            else if(type.name().equalsIgnoreCase("cart") && product.getStocks() > existingItem.getQuantity()) {
	            	existingItem.setQuantity(existingItem.getQuantity() + 1);
	            	itemsDao.update(existingItem);
	            	
	            }
            }
            
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    		response.setHeader("Pragma", "no-cache");
    		response.setDateHeader("Expires", 0);
            response.setContentType("text/html;charset=UTF-8");
           
            // torna alla pagina precedente
            String referer = request.getHeader("Referer");
            if (referer != null) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect(request.getContextPath() + "/index.html");
            }
         

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IllegalArgumentException | NullPointerException e) {
        	e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}

