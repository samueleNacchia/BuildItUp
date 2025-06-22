package controller.lists;

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

import org.json.JSONObject;

@WebServlet("/unlogged/DeleteFromList")
public class DeleteFromList extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
 		response.setHeader("Pragma", "no-cache");
 		response.setDateHeader("Expires", 0);
 		response.setContentType("application/json;charset=UTF-8");
    	
    	ItemListDAO ItemListDao = new ItemListDAO();
        boolean deleted = false;
        int newQuantity = 0;
        boolean success = false;
        
    	try {
            ListType type = ListType.valueOf(request.getParameter("type"));
            int productId = Integer.parseInt(request.getParameter("id"));
            
            ProductDAO productDao = new ProductDAO();
            ProductDTO product = productDao.findByCode(productId);
            
            ListDTO list = ListManager.getList(request, response, type, false);
            
            if (product != null) {
                
	            if (list == null) {
	                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lista non trovata o creata");
	                return;
	            }
	           
	            ItemListDTO item = ItemListDao.findProduct(list.getId(), productId);
	            
	            if (item == null) {
	                // item non presente, non si può decrementare o eliminare
	                JSONObject json = new JSONObject();
	                json.put("success", false);
	                json.put("message", "Prodotto non presente nella lista.");
	                response.getWriter().print(json.toString());
	                return;
	            }
	            
	            if(type.name().equals("cart") && item.getQuantity() > 1) {
	           		item.setQuantity(item.getQuantity() - 1);
	           		ItemListDao.update(item);
	           		newQuantity = item.getQuantity();
	           	} else {
	           		ItemListDao.deleteFromList(list.getId(), productId);
	           		deleted = true;
	           	}
	            	
	           	success = true;
            }
            
            JSONObject json = new JSONObject();
            json.put("functionName", "UpdateQuantityJSON");
            json.put("quantity", newQuantity);
            json.put("deleted", deleted);
            json.put("success", success);
            response.getWriter().print(json.toString());
           
            // torna alla pagina precedente
            /*String referer = request.getHeader("Referer");
            if (referer != null) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect(request.getContextPath() + "/index.html");
            }*/
         

        } catch (SQLException | IllegalArgumentException | NullPointerException e) {
        	e.printStackTrace();
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "Errore interno: " + e.getMessage());
            response.getWriter().print(json.toString());
        } 
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}


