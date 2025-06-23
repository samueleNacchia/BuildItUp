package controller.products;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ProductImage.ProductImageDAO;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/DeleteImage")
public class DeleteImage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int imageId = Integer.parseInt(request.getParameter("imageId"));
        ProductImageDAO imageDao = new ProductImageDAO();
        try {
            imageDao.delete(imageId);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        response.setContentType("text/html;charset=UTF-8");
        response.sendRedirect(request.getContextPath()+"/admin/AdminPanelServlet");
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}