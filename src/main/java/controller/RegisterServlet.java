package controller;

import model.User.*;
import controller.functions.HashFunction;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/common/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");

        if (!password.equals(confirm)) {
            response.sendRedirect(request.getContextPath()+"/common/Register_page.jsp?error=pwd");
            return;
        }
        UserDAO dao = new UserDAO();
        try {
			if (dao.findByEmail(email)!= null)
			{
				System.out.println("Duplicato");
			    response.sendRedirect(request.getContextPath()+"/common/Register_page.jsp?error=dupe");
			    return;
			}
		} catch (SQLException | IOException e) {
			e.printStackTrace();
		}
   
        UserDTO user = new UserDTO();
        user.setEmail(email);
        user.setPassword(HashFunction.generateToken(password));
        user.setName(request.getParameter("nome"));
        user.setSurname(request.getParameter("cognome"));
        user.setTel(request.getParameter("cell"));
        user.setVia(request.getParameter("ind"));
        user.setRoadNum(Integer.parseInt(request.getParameter("civ")));
        user.setPostalCode(request.getParameter("cap"));
        user.setProvincia(request.getParameter("provincia"));

        try {
			dao.save(user);
		} catch (SQLException e) {
			System.out.println("Errore nel salvataggio");
			e.printStackTrace();
		}

        response.sendRedirect(request.getContextPath()+"/common/LogIn_page.jsp?success=1");
        return;
    }
}
