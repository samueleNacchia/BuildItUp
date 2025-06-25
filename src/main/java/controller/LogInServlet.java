package controller;

import model.User.*;
import model.ListType;
import model.Admin.*;

import java.io.IOException;
import java.sql.SQLException;

import controller.functions.HashFunction;
import controller.lists.ListManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/common/login")
public class LogInServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = HashFunction.generateToken(request.getParameter("password"));
        
        AdminDAO aDAO = new AdminDAO();
        AdminDTO admin = null;
        HttpSession session = request.getSession();

        try {
            admin = new AdminDTO(email, password);
            if (aDAO.isAdmin(admin)) {
                session.setAttribute("ruolo", true);
                response.sendRedirect(request.getContextPath()+"/common/Home");
                return;
            }
        } catch (SQLException e) {
            e.printStackTrace();

            response.sendRedirect("../common/LogIn_page.jsp?error=server");
            return;
        }

        UserDAO dao = new UserDAO();
        UserDTO user = null;
        try {
            user = dao.findByEmail(email);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath()+"/common/LogIn_page.jsp?error=server");
            return;
        }

        if (user != null && password.equals(user.getPassword())) {
        	try {
        		ListManager  manager = new ListManager();
        		manager.mergeList(ListType.cart, user, request, response);
        		manager.mergeList(ListType.wishlist, user, request, response);
        	} catch (SQLException e) {
        	    e.printStackTrace();
        	}
        	
        	session.setAttribute("id", user.getId());
            session.setAttribute("ruolo", false);
            response.sendRedirect(request.getContextPath()+"/common/Home");
            return; 
        } else {
            response.sendRedirect(request.getContextPath()+"/common/LogIn_page.jsp?error=1");
            return;
        }
    }
}
