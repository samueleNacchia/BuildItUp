package controller.orders;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Status;
import model.Order.OrderDAO;

import java.io.IOException;
import java.sql.SQLException;

import org.json.JSONObject;

@WebServlet("/UpdateOrder")
public class UpdateOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		OrderDAO orderDao = new OrderDAO();
		
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
		response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");

	    String idParam = request.getParameter("id");
	    String statoParam = request.getParameter("stato");

	    JSONObject json = new JSONObject();
	    json.put("functionName", "updateStatus");
	    
	    
	    try {
	        
	    	int orderId = Integer.parseInt(idParam);
	        Status newStatus = Status.valueOf(statoParam);
	        
			orderDao.updateStatus(orderId,newStatus);
			json.put("status", true);
			
		} catch (SQLException e) {
			e.printStackTrace();
			json.put("status", false);
		}
	
	    response.getWriter().write(json.toString());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
