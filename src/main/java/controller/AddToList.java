package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ListType;

import java.io.IOException;


@WebServlet("/AddItemList")
public class AddToList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ListType type = ListType.valueOf(request.getParameter("type")); 
		int	idProduct = Integer.parseInt(request.getParameter("id"));
		
		
		response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("/AdminPage.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
