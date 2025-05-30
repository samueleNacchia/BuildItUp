package controller.products;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ProductImage.ProductImageDAO;
import model.ProductImage.ProductImageDTO;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/image")
public class ViewImage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	int id = Integer.parseInt(request.getParameter("id"));
    	
        ProductImageDAO productImageDao = new ProductImageDAO();
        ProductImageDTO image = null;
		try {
			if(request.getParameter("cover")!= null && request.getParameter("cover").equals("true"))
				image = productImageDao.findProductCover(id);
			else
				image = productImageDao.findByCode(id);
		} catch (SQLException e) {
			e.printStackTrace();
		}

        if (image != null) {
        	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
            response.setContentType("image/jpeg"); // o image/png se sai che è PNG
            response.setContentLength(image.getImage().length);
            response.getOutputStream().write(image.getImage());
            response.getOutputStream().flush();
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	doGet(request,response);
    }
}
