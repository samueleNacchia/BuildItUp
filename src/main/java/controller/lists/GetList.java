package controller.lists;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import model.List.*;
import model.Product.ProductDAO;
import model.ItemList.*;
import model.ListType;

@WebServlet("/unlogged/GetList")
public class GetList extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    	ItemListDAO itemsDao = new ItemListDAO();
        ProductDAO productDao = new ProductDAO();
    	boolean flag = false;
    	
    	try {
    		if(request.getParameter("type") != null) {
    			ListType type = ListType.valueOf(request.getParameter("type"));
	            ListDTO list = ListManager.getList(request, response, type, false);
	
	            List<ItemListDTO> items = null;
	            if (list != null) {
	                items = itemsDao.findByList(list.getId());
	                if (items != null && !items.isEmpty()) {
	                	flag = true;
	                    for (ItemListDTO item : items) {
	                        try {
	                            item.setProduct(productDao.findByCode(item.getId_product()));
	                        } catch (SQLException e) {
	                            e.printStackTrace();
	                        }
	                    }
	                }
	            }
	         
	            request.setAttribute("items", items);
    		}
    		
    		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    		response.setHeader("Pragma", "no-cache");
    		response.setDateHeader("Expires", 0);
            response.setContentType("text/html;charset=UTF-8");
            
            
            String str = request.getParameter("to");

            if (str!=null && str.equals("checkout")) {
            	if(flag == false) {
            		response.sendRedirect(request.getContextPath()+"/common/Home");
            		return;
            	}

                request.getRequestDispatcher("/user/Checkout").forward(request, response);
            } else 
                request.getRequestDispatcher("/unlogged/ViewList.jsp").forward(request, response);
            

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Tipo lista non valido");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}