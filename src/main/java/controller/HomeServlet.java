package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product.ProductDAO;
import model.Product.ProductDTO;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;


@WebServlet("/Home")
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ProductDAO productDao = new ProductDAO();
		
		try {
            List<ProductDTO> disc = productDao.getFilteredProducts("discounts", 5, null, null, null, null, 0, 0);
            request.setAttribute("scontati", disc);
            
            List<ProductDTO> bs = productDao.getFilteredProducts("bestsellers", 5,  null, null, null, null, 0, 0);
            request.setAttribute("bestsellers", bs);
            
		}catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errore", "Errore durante il recupero dei dati.");
        }
		
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
        response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("/index.jsp").forward(request, response);
        
	}

}
