package controller.products;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

import model.ItemList.ItemListDAO;
import model.Product.*;

@MultipartConfig(maxFileSize = 1024 * 1024 * 16) // max 16MB per file
@WebServlet("/UpdateProduct")
public class UpdateProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ProductDAO productDao = new ProductDAO();

		try {
			String idStr = request.getParameter("id");
			
			if(idStr!=null) {
				int idProduct =  Integer.parseInt(idStr);
				ProductDTO product = productDao.findByCode(idProduct);

				boolean onSaleBefore = product.isOnSale();
				
				product.setDescription(request.getParameter("descrizione"));
				product.setPrice(Float.parseFloat(request.getParameter("prezzo")));
				product.setDiscount(Float.parseFloat(request.getParameter("sconto")));
				product.setOnSale("true".equals(request.getParameter("inVendita")));
				product.setStocks(Integer.parseInt(request.getParameter("stocks")));
					
				productDao.update(product);
						
				if(!product.isOnSale() && onSaleBefore) {
					ItemListDAO itemListDao = new ItemListDAO();
					itemListDao.deleteProductFromLists(idProduct);
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
		response.setContentType("text/html;charset=UTF-8");
		response.sendRedirect(request.getContextPath()+"/AdminPanelServlet");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
