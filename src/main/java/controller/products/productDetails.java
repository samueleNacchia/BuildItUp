package controller.products;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Product.ProductDAO;
import model.Product.ProductDTO;
import model.ProductImage.ProductImageDAO;
import model.ProductImage.ProductImageDTO;
import model.Review.ReviewDAO;
import model.Review.ReviewDTO;
import model.User.UserDAO;
import model.User.UserDTO;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;


@WebServlet("/productDetails")
public class productDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ProductDAO productDao = new ProductDAO();
		ProductImageDAO image = new ProductImageDAO();
		ReviewDAO rv = new ReviewDAO();
		UserDAO user = new UserDAO();
		
		HttpSession session = request.getSession();
		Integer id_user = (Integer)session.getAttribute("id");
		int code = Integer.parseInt(request.getParameter("id"));
		
		
		try {
            ProductDTO p = productDao.findByCode(code);
            List<ProductImageDTO> images = image.findAllByProduct(code);
            List<ReviewDTO> recensioni = rv.findAllforProduct(code);

            Map<ReviewDTO, UserDTO> recensioneUtente = new LinkedHashMap();
            for (ReviewDTO r : recensioni) {
                UserDTO u = user.findByCode(r.getId_user());
                recensioneUtente.put(r, u);
            }
            
            
            request.setAttribute("prodotto", p);
            request.setAttribute("immagini", images);
            request.setAttribute("recensioni", recensioneUtente);
            
            if(id_user != null) request.setAttribute("userId", id_user);
            
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
