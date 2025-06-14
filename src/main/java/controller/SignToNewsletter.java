package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Newsletter.NewsletterDAO;
import model.Newsletter.NewsletterDTO;
import model.Product.ProductDTO;
import model.ProductImage.ProductImageDTO;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;


@WebServlet("/SignToNewsletter")
public class SignToNewsletter extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public SignToNewsletter() {
        super();
        // TODO Auto-generated constructor stub
    }

	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        
        NewsletterDAO dao = new NewsletterDAO();

        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
        response.setContentType("text/html;charset=UTF-8");

        if (email == null || email.isEmpty()) {
            
        	response.sendRedirect(request.getContextPath() + "/newsletter-status.jsp?status=fail");
        }

        try {
            NewsletterDTO nl = new NewsletterDTO(email); 
            dao.save(nl);
            
            response.sendRedirect(request.getContextPath() + "/newsletter-status.jsp?status=success");
            
		}catch (SQLException e) {
            e.printStackTrace();
            
            response.sendRedirect(request.getContextPath() + "/newsletter-status.jsp?status=fail");
        }
		
		
        
    }
    
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().write("Servlet attiva!");
    }



}
