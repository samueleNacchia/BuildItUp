package controller.products;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product.ProductDAO;
import model.Product.ProductDTO;
import model.ProductImage.ProductImageDAO;
import model.ProductImage.ProductImageDTO;
import model.Review.ReviewDAO;
import model.Review.ReviewDTO;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@WebServlet("/ProductDetails")
public class ProductDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ProductDAO productDao = new ProductDAO();
		ProductImageDAO image = new ProductImageDAO();
		ReviewDAO rv = new ReviewDAO();
		int code = Integer.parseInt(request.getParameter("id"));
		
		
		try {
            ProductDTO p = productDao.findByCode(code);
            List<ProductImageDTO> images = image.findAllByProduct(code);
            
            
            request.setAttribute("prodotto", p);
            request.setAttribute("immagini", images);
            
		}catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errore", "Errore durante il recupero dei dati.");
        }
		
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
        response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("/Product.jsp").forward(request, response);
        
	}

	

}
