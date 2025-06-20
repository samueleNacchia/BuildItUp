package controller;

import model.User.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/UpdateAddressServlet")
public class UpdateAddressServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDAO dao = new UserDAO();
        UserDTO user = null;
		try {
			user = (UserDTO) dao.findByCode( (int) session.getAttribute("id"));
		} catch (SQLException e) {
			System.out.println("Utente non trovato");
			
			response.sendRedirect(request.getContextPath() + "/user/MyProfile");
			e.printStackTrace();
		}

        if (user != null) {
            String via = request.getParameter("ind");
            int roadNum = Integer.parseInt(request.getParameter("civ"));
            String cap = request.getParameter("cap");
            String prov = request.getParameter("prov");
            // aggiorna anche nella sessione
            user.setVia(via);
            user.setRoadNum(roadNum);
            user.setPostalCode(cap);
            user.setProvincia(prov);
            try {
				dao.update(user);
			
            } catch (SQLException e) {
				System.out.println("Update non riuscito");

				response.sendRedirect(request.getContextPath() + "/user/MyProfile");
				return;
			}

           
        }

        response.sendRedirect(request.getContextPath() + "/user/MyProfile");
    }
}
