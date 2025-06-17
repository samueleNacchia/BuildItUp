package controller;

import model.Order.*;
import model.User.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;


import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

@WebServlet("/UserProfileServlet")
public class UserProfileServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String str_id = session.getId();
        if (str_id == null) {
            response.sendRedirect("LogIn_page.jsp");
            return;
        }
        int id = Integer.parseInt(str_id);

     

        UserDAO utenteDAO = new UserDAO();
        OrderDAO ordineDAO = new OrderDAO();

        UserDTO user = null;
		try {
			user = utenteDAO.findByCode(id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        if (user != null) {
            session.setAttribute("user", user);
            List<OrderDTO> ordini = null;
			try {
				ordini = (List<OrderDTO>) ordineDAO.findByCode(user.getId());
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            request.setAttribute("ordini", ordini);
        }

        request.getRequestDispatcher("MyProfile.jsp").forward(request, response);
    }
}
