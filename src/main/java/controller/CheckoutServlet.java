package controller;

import model.User.UserDAO;
import model.User.UserDTO;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/user/Checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect(request.getContextPath() + "/common/LogIn_page.jsp");
            return;
        }

        try {
            int userId = (int) session.getAttribute("id");

            UserDAO userDAO = new UserDAO();
            UserDTO user = userDAO.findByCode(userId);

            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/common/logout");
                return;
            }

            request.setAttribute("userAddress", user);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/user/Checkout.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Errore durante il caricamento dei dati di checkout", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
