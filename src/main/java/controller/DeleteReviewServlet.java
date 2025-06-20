package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Review.ReviewDAO;

import java.io.IOException;


@WebServlet("/DeleteReviewServlet")
public class DeleteReviewServlet extends HttpServlet {
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
        	
        	HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("id");
            int productId = Integer.parseInt(request.getParameter("productId"));
            
            ReviewDAO rv = new ReviewDAO();

            if (userId != null) {
                rv.delete(userId, productId);

                response.sendRedirect(request.getContextPath() + "/review-status.jsp?id=" + productId + "&action=deleted");
            } else {

            	response.sendRedirect(request.getContextPath() + "/LogIn_page.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/review-status.jsp?action=error");
        }
    }
}


