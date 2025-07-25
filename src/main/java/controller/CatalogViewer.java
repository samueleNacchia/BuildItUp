package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product.*;
import model.ProductImage.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@WebServlet("/common/CatalogViewer")
public class CatalogViewer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = 1;
        int pageSize = 12; 

        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException ignored) {}
        }

       
        String category = request.getParameter("category");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        String name = request.getParameter("name");
        String type = request.getParameter("type"); // discounts, bestsellers, null
        String order = request.getParameter("order");

        Double minPrice = null;
        Double maxPrice = null;
        try {
            if (minPriceStr != null && !minPriceStr.isEmpty()) {
                minPrice = Double.parseDouble(minPriceStr);
            }
            if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
                maxPrice = Double.parseDouble(maxPriceStr);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        ProductDAO productDao = new ProductDAO(); 
        ProductImageDAO imageDao = new ProductImageDAO();

        try {
            List<ProductDTO> products = productDao.getFilteredProducts(type, 0, name, category, minPrice, maxPrice, order, page, pageSize, false);
        
            int totalProducts = productDao.countFiltered(type, category, minPrice, maxPrice, name);
            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
            
            
            Map<Integer, ProductImageDTO> coverImages = new HashMap<>();
            for(ProductDTO product: products) {
                ProductImageDTO img = imageDao.findProductCover(product.getId());
                if (img != null) {
                    coverImages.put(product.getId(), img);
                }
            }
            
            request.setAttribute("prodotti", products);
            request.setAttribute("coverImages", coverImages);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("category", category);
            request.setAttribute("minPrice", minPrice);
            request.setAttribute("maxPrice", maxPrice);
            request.setAttribute("name", name);
            request.setAttribute("type", type);
            request.setAttribute("order", order);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errore", "Errore durante il recupero dei dati.");
        }
        
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
		response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("/common/catalog.jsp").forward(request, response);
    }


	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
