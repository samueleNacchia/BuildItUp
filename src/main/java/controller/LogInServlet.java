package controller;

import model.User.*;
import model.Admin.*;

import java.io.IOException;
import java.sql.SQLException;

import controller.functions.HashFunction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/common/login")
public class LogInServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = HashFunction.generateToken(request.getParameter("password"));
        
        AdminDAO aDAO = new AdminDAO();
        AdminDTO admin = null;
        HttpSession session = request.getSession();

        try {
            admin = new AdminDTO(email, password);
            if (aDAO.isAdmin(admin)) {
                session.setAttribute("ruolo", 1);
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
            response.sendRedirect("../common/LogIn_page.jsp?error=server");
            return;
        }

        if (user != null && password.equals(user.getPassword())) {
            session.setAttribute("id", user.getId());
            session.setAttribute("ruolo", 2);
            response.sendRedirect(request.getContextPath()+"/common/Home");
            return; 
        } else {
            response.sendRedirect("../common/LogIn_page.jsp?error=1");
            return;
        }
    }
}
