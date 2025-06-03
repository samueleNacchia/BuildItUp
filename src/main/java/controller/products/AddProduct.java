package controller.products;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;

import model.Category;
import model.Product.*;
import model.ProductImage.*;

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

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO productDao = new ProductDAO();
        ProductDTO product = new ProductDTO();
        
        if( request.getContentType() != null && request.getContentType().toLowerCase().startsWith("multipart/")){
	        product.setName(readPartAsString(request.getPart("nome")));
	        product.setDescription(readPartAsString(request.getPart("descrizione")));
	        product.setPrice(Float.parseFloat(readPartAsString(request.getPart("prezzo"))));
	        product.setDiscount(0);
	        product.setCategory(Category.valueOf(readPartAsString(request.getPart("categoria"))));
	        product.setOnSale(true);
	        product.setStocks(Integer.parseInt(readPartAsString(request.getPart("stocks"))));
	
	        int productId = -1;
	
	        try {
	        	productDao.save(product);
	            productId = product.getId();
	        
	
		        // Inserisci immagini se il prodotto è stato salvato correttamente
		        if (productId > 0) {
		            Collection<Part> parts = request.getParts();
		
		            ProductImageDAO imageDao = new ProductImageDAO();
		
		            for (Part part : parts) {
		                if ("immagini".equals(part.getName()) && part.getSize() > 0) {
		                    byte[] imageBytes = part.getInputStream().readAllBytes();
		                    ProductImageDTO image = new ProductImageDTO(productId,imageBytes);
		                    imageDao.save(image);
						} else if ("copertina".equals(part.getName()) && part.getSize() > 0) {
		                    byte[] imageBytes = part.getInputStream().readAllBytes();
		                    ProductImageDTO image = new ProductImageDTO(productId,imageBytes, true);
		                    imageDao.save(image);
						}
		            }
		        }
        
	        } catch (SQLException e) {
	        	e.printStackTrace();
	        }
        }

        // Redirect o forward alla pagina Admin
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        response.setContentType("text/html;charset=UTF-8");
        response.sendRedirect(request.getContextPath()+"/AdminPanelServlet");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

}
