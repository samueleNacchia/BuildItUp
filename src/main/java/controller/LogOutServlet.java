package controller;
import java.io.IOException;


import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/common/logout")
public class LogOutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
    		
    		HttpSession session = request.getSession(false);
    		if (session != null)
    		{
    			session.invalidate();
        }
    		 response.sendRedirect(request.getContextPath() + "/common/Home");
    }


protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
	doGet(request,response);
}
}