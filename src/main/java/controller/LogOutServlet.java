package controller;
import java.io.IOException;


import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogOutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
    		
    		HttpSession session = request.getSession(false);
    		if (session != null)
    		{
    			session.invalidate();
        }
    		 response.sendRedirect(request.getContextPath() + "/Home");
    }
}
