package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Order.OrderDAO;
import model.Order.OrderDTO;
import model.Product.ProductDAO;
import model.Product.ProductDTO;
import model.ProductImage.ProductImageDAO;
import model.ProductImage.ProductImageDTO;
import model.ProductOrder.ProductOrderDAO;
import model.ProductOrder.ProductOrderDTO;
import model.Review.ReviewDAO;
import model.Review.ReviewDTO;
import model.User.UserDAO;
import model.User.UserDTO;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;


@WebServlet("/ReviewServlet")
public class ReviewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		Integer id_user = (Integer)session.getAttribute("id");
		
		if (id_user == null) response.sendRedirect(request.getContextPath() + "/LogIn_page.jsp");
		
		int code = Integer.parseInt(request.getParameter("productId"));
		
		ReviewDAO rv = new ReviewDAO();
		OrderDAO orderDAO = new OrderDAO();
		ProductOrderDAO productOrderDAO = new ProductOrderDAO();
		ProductDAO productDAO = new ProductDAO ();
		
		boolean isVerified = false;
		
		String text = request.getParameter("text");
		int vote = Integer.parseInt(request.getParameter("vote"));
		LocalDate ld = LocalDate.now();
		
		
		try {
			
			ReviewDTO reviewDTO = new ReviewDTO();
			reviewDTO.setId_product(code);
			reviewDTO.setId_user(id_user);
			reviewDTO.setText(text);
			reviewDTO.setVote(vote);
			reviewDTO.setReviewDate(ld);
			
			
			
			//verifica se il prodotto recensito è verificato come acquistato
			List<OrderDTO> ordini = orderDAO.findByUserCode(id_user);
			
			if(ordini == null) return;
			
			else {
				
				for (OrderDTO ordine : ordini) {
					
					int id_ordine = ordine.getId();
					
					List<ProductOrderDTO> productsOrder = productOrderDAO.findAllforOrder(id_ordine);
					
					for (ProductOrderDTO pr : productsOrder) {
						
						if (pr.getId_product() == code) {
		                    isVerified = true;
		                    break;
		                }
		            }

		            if (isVerified) break;
	                    
					
				}
				
				
			}
			
			
			
			reviewDTO.setIsVerified(isVerified);
			rv.save(reviewDTO);
			
			response.sendRedirect(request.getContextPath() + "/review-status.jsp?id=" + code + "&action=addedd");

			
            
		}catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errore", "Errore durante il recupero dei dati.");
        }
		
		
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
        response.setContentType("text/html;charset=UTF-8");

        
	
	}

}
