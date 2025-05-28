package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product.ProductDAO;
import model.Product.ProductDTO;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;


@WebServlet("/CatalogViewer")
public class CatalogViewer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = 1;
        int pageSize = 5; 

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

        try {
            List<ProductDTO> prodotti = productDao.getFilteredProducts(type, 0, name, category, minPrice, maxPrice, page, pageSize);
            int totalProducts = productDao.countFiltered(type, category, minPrice, maxPrice, name);
            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

            
            request.setAttribute("prodotti", prodotti);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("category", category);
            request.setAttribute("minPrice", minPrice);
            request.setAttribute("maxPrice", maxPrice);
            request.setAttribute("name", name);
            request.setAttribute("type", type);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errore", "Errore durante il recupero dei dati.");
        }
        
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
		response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("/catalog.jsp").forward(request, response);
    }


	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
