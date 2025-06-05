package controller;

import model.User.UserDAO;
import model.User.UserDTO;

import java.io.IOException;
import java.sql.SQLException;

import controller.functions.HashFunction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LogInServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = HashFunction.generateToken(request.getParameter("password"));

        UserDAO dao = new UserDAO();
        UserDTO user = null;
		try {
			user = dao.findByEmail(email);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		//System.out.println("form " + password + "  \n  db   " +user.getPassword());
        if (user != null && password.equals(user.getPassword())) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("id", user.getId());
            session.setAttribute("password", password);
            session.setAttribute("email", email);
            response.sendRedirect("index.jsp");
        } else {
            response.sendRedirect("LogIn_page.jsp?error=1");
        }
    }
}
