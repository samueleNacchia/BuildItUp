package controller.products;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.ProductImage.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/AddImages")
@MultipartConfig(maxFileSize = 1024 * 1024 * 16)

public class AddImages extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        ProductImageDAO imageDao = new ProductImageDAO();

        for (Part part : request.getParts()) {
            if ("immagini".equals(part.getName()) && part.getSize() > 0) {
                byte[] imageBytes = part.getInputStream().readAllBytes();
                ProductImageDTO image = new ProductImageDTO(productId, imageBytes);
                
                try {
                    imageDao.save(image);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                
            } else if ("copertina".equals(part.getName()) && part.getSize() > 0) {
                byte[] imageBytes = part.getInputStream().readAllBytes();
                ProductImageDTO image = new ProductImageDTO(productId, imageBytes, true);
                
                try { 
                	ProductImageDTO existingImage = imageDao.findProductCover(productId);
                	if(existingImage != null) {
                		imageDao.delete(existingImage.getId());
                	}
                	imageDao.save(image);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
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