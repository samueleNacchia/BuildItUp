package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.sql.SQLException;

import model.Category;
import model.Product.*;

@MultipartConfig(maxFileSize = 1024 * 1024 * 16) // max 16MB per file
@WebServlet("/AddProduct")
public class AddProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	
	private String readPartAsString(Part part) throws IOException {
	    if (part != null) {
	        return new String(part.getInputStream().readAllBytes(), "UTF-8");
	    }
	    return null;
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ProductDAO productDao = new ProductDAO();
		ProductDTO product = new ProductDTO();
		
		product.setName(readPartAsString(request.getPart("nome")));
		product.setDescription(readPartAsString(request.getPart("descrizione")));
		product.setPrice(Float.parseFloat(readPartAsString(request.getPart("prezzo"))));
		product.setDiscount(0);
		product.setCategory(Category.valueOf(readPartAsString(request.getPart("categoria"))));
		product.setOnSale(true);
		product.setStocks(Integer.parseInt(readPartAsString(request.getPart("stocks"))));
		
		Part immagine1 = request.getPart("immagine1");
		Part immagine2 = request.getPart("immagine2");
		Part immagine3 = request.getPart("immagine3");

		if (immagine1 != null && immagine1.getSize() > 0)  
		    product.setImage1(immagine1.getInputStream().readAllBytes());
		if (immagine2 != null && immagine2.getSize() > 0)  
		    product.setImage2(immagine2.getInputStream().readAllBytes());
		if (immagine3 != null && immagine3.getSize() > 0)  
		    product.setImage3(immagine3.getInputStream().readAllBytes());
		
		
		
		try {
			productDao.save(product);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
		response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("/AdminPage.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
