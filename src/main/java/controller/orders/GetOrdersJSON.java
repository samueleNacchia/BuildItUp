package controller.orders;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Order.*;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/admin/GetOrdersJSON")
public class GetOrdersJSON extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		OrderDAO orderDao = new OrderDAO();
		List<OrderDTO> ordini = new ArrayList<>();
		response.setContentType("application/json");
		
		try {
		    String fromStr = request.getParameter("fromDate");
		    String toStr = request.getParameter("toDate");
		    String userIdStr = request.getParameter("userId");
		    
		    LocalDate from = null;
			if (fromStr != null && !fromStr.isEmpty()) {
			    from = LocalDate.parse(fromStr);
			}

			LocalDate to = null;
			if (toStr != null && !toStr.isEmpty()) {
			    to = LocalDate.parse(toStr);
			}

			Integer userId = null;
			if (userIdStr != null && !userIdStr.isEmpty()) {
			    userId = Integer.parseInt(userIdStr);
			}
		    
		    ordini = orderDao.getFilteredOrders(from, to, userId);

		    StringBuilder json = new StringBuilder();
		    json.append("{\"success\": true, \"functionName\": \"searchOrders\", \"orders\": [");
		    
		    
		    for (int i = 0; i < ordini.size(); i++) {
		        OrderDTO o = ordini.get(i);
		        json.append("{")
		            .append("\"id\": ").append(o.getId()).append(", ")
		            .append("\"userId\": ").append(o.getId_user()).append(", ")
		            .append("\"orderDate\": \"").append(o.getOrderDateFormatted()).append("\", ")
		            .append("\"status\": \"").append(o.getStatusName()).append("\"")
		            .append("}");
		        if (i < ordini.size() - 1) json.append(",");
		    }

		    json.append("]}");

		    response.getWriter().print(json.toString());

		} catch (Exception e) {
		    e.printStackTrace();
		    response.setContentType("application/json");
		    response.getWriter().print("{\"success\": false, \"message\": \"Errore durante il recupero degli ordini.\"}");
		}
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
