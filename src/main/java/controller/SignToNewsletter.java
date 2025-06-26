package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Newsletter.*;

import java.io.IOException;
import java.sql.SQLException;


@WebServlet("/common/SignToNewsletter")
public class SignToNewsletter extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        
        NewsletterDAO dao = new NewsletterDAO();

        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
        response.setContentType("text/html;charset=UTF-8");

        if (email == null || email.isEmpty()) { 
        	response.sendRedirect(request.getContextPath() + "/common/newsletter-status.jsp?status=fail");
        	return;
        }

        try {
            NewsletterDTO nl = new NewsletterDTO(email); 
            dao.save(nl);
            response.sendRedirect(request.getContextPath() + "/common/newsletter-status.jsp?status=success");
            return;
            
		}catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/common/newsletter-status.jsp?status=fail");
            return;
        }  
    }
    
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

}