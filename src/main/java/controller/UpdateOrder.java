package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Status;
import model.Order.OrderDAO;
import model.Order.OrderDTO;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/UpdateOrder")
public class UpdateOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		OrderDAO orderDao = new OrderDAO();
		OrderDTO order = new OrderDTO();
		
		order.setId(Integer.parseInt(request.getParameter("id")));
		order.setStatus(Status.valueOf(request.getParameter("stato")));
		
		try {
			orderDao.updateStatus(order);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("/AdminPage.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
