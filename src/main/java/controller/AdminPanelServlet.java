package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Order.*;
import model.Product.*;
import model.ProductImage.*;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/AdminPanelServlet")
public class AdminPanelServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ProductDAO productDao = new ProductDAO();
		OrderDAO orderDao = new OrderDAO();
		ProductImageDAO imageDao = new ProductImageDAO();
		
		List<ProductDTO> prodotti = new ArrayList<>();
		List<OrderDTO> ordini = new ArrayList<>();
		Map<Integer, List<ProductImageDTO>> immaginiPerProdotto = new HashMap<>();
		
		try {
			String fromStr = request.getParameter("fromDate");
			String toStr = request.getParameter("toDate");
			String userIdStr = request.getParameter("userId");
			String category = request.getParameter("category");
	        String name = request.getParameter("name");
			
			
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
			prodotti = productDao.getFilteredProducts(null, 0, name, category, null, null, null, 0, 0, true);
			
			for (ProductDTO p : prodotti) {
			    immaginiPerProdotto.put(p.getId(), imageDao.findAllByProduct(p.getId()));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("prodotti", prodotti);
		request.setAttribute("immaginiPerProdotto", immaginiPerProdotto);
		request.setAttribute("ordini", ordini);
		
		
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	    response.setHeader("Pragma", "no-cache");
	    response.setDateHeader("Expires", 0);
	    response.setContentType("text/html;charset=UTF-8");
	    request.getRequestDispatcher("/admin/AdminPanel.jsp").forward(request, response);	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}