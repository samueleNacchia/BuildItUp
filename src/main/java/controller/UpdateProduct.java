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
import model.ItemList.ItemListDAO;
import model.Product.ProductDAO;
import model.Product.ProductDTO;

@MultipartConfig(maxFileSize = 1024 * 1024 * 16) // max 16MB per file
@WebServlet("/UpdateProduct")
public class UpdateProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	
	private String readPartAsString(Part part) throws IOException {
	    if (part != null && part.getSize() > 0) {
	        return new String(part.getInputStream().readAllBytes(), "UTF-8");
	    }
	    return null;
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ProductDAO productDao = new ProductDAO();
		if (request.getContentType() != null && request.getContentType().toLowerCase().startsWith("multipart/")) {        
		
			int idProduct =  Integer.parseInt(readPartAsString(request.getPart("id")));
			
			ProductDTO product;
			try {
				product = productDao.findByCode(idProduct);
				
				boolean onSaleBefore = product.isOnSale();
				
				product.setName(readPartAsString(request.getPart("nome")));
				product.setDescription(readPartAsString(request.getPart("descrizione")));
				product.setPrice(Float.parseFloat(readPartAsString(request.getPart("prezzo"))));
				product.setDiscount(Float.parseFloat(readPartAsString(request.getPart("sconto"))));
				product.setCategory(Category.valueOf(readPartAsString(request.getPart("categoria"))));
				product.setOnSale("true".equals(readPartAsString(request.getPart("inVendita"))));
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
				
				String deleteImgStr = readPartAsString(request.getPart("deleteImage"));
			    if (deleteImgStr != null) {
			        int imgToDelete = Integer.parseInt(deleteImgStr);
			        switch (imgToDelete) {
			            case 1:
			                product.setImage1(null);
			                break;
			            case 2:
			               product.setImage2(null); 
			                break;
			            case 3:
			               product.setImage3(null);
			                break;
			        }
			        
			            productDao.deleteImage(product.getId(), imgToDelete);
			        
			    }
			
				productDao.updateAll(product);
				
				
				if(!product.isOnSale() && onSaleBefore) {
					ItemListDAO itemListDao = new ItemListDAO();
					itemListDao.deleteProductFromLists(idProduct);
				}
			
			
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("/AdminPage.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
