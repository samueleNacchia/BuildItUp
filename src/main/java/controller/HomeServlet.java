package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product.ProductDAO;
import model.Product.ProductDTO;
import model.ProductOrder.ProductOrderDAO;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;


@WebServlet("/Home")
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HomeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ProductDAO p = new ProductDAO();
		
		
		try {
            List<ProductDTO> disc = p.getFilteredProducts("discounts", 5, null, null, null, null, 0, 0);
            request.setAttribute("scontati", disc);
            
            List<ProductDTO> bs = p.getFilteredProducts("bestsellers", 5,  null, null, null, null, 0, 0);
            request.setAttribute("bestsellers", bs);
            
		}catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errore", "Errore durante il recupero dei dati.");
        }
        
        response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("/index.jsp").forward(request, response);
        
	}

}
