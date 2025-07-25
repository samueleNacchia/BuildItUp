package controller.reviews;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Order.*;
import model.Product.*;
import model.ProductOrder.*;
import model.Review.*;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;


@WebServlet("/user/ReviewServlet")
public class ReviewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	    HttpSession session = request.getSession();
	    Integer id_user = (Integer) session.getAttribute("id");

	    if (id_user == null) {
	        response.sendRedirect(request.getContextPath() + "/common/LogIn_page.jsp");
	        return;
	    }

	    int code = Integer.parseInt(request.getParameter("productId"));
	    String text = request.getParameter("text");
	    int vote = Integer.parseInt(request.getParameter("vote"));
	    LocalDate ld = LocalDate.now();

	    ReviewDAO rv = new ReviewDAO();
	    OrderDAO orderDAO = new OrderDAO();
	    ProductOrderDAO productOrderDAO = new ProductOrderDAO();
	    ProductDAO productDAO = new ProductDAO();

	    boolean isVerified = false;

	    try {
	        ReviewDTO reviewDTO = new ReviewDTO();
	        reviewDTO.setId_product(code);
	        reviewDTO.setId_user(id_user);
	        reviewDTO.setText(text);
	        reviewDTO.setVote(vote);
	        reviewDTO.setReviewDate(ld);

	        List<OrderDTO> ordini = orderDAO.findByUserCode(id_user);

	        if (ordini != null) {
	            for (OrderDTO ordine : ordini) {
	                List<ProductOrderDTO> productsOrder = productOrderDAO.findAllforOrder(ordine.getId());
	                
	                for (ProductOrderDTO pr : productsOrder) {
	                	
	                	if (code == pr.getId_product()) {
	                	    
	                	    isVerified = true;
	                	    break;
	                	}


	                }
	                if (isVerified) break;
	            }
	        }

	        
	        reviewDTO.setIsVerified(isVerified);
	        rv.save(reviewDTO);

	        ProductDTO product = productDAO.findByCode(code);
	        productDAO.updateValutation(product, true);

	        response.sendRedirect(request.getContextPath() + "/user/review-status.jsp?id=" + code + "&action=added");
	        return;

	    } catch (SQLException e) {
	        e.printStackTrace();
	        request.setAttribute("errore", "Errore durante il recupero dei dati.");
	        request.getRequestDispatcher("/user/review-status.jsp").forward(request, response);
	        return;
	    }
	}
}