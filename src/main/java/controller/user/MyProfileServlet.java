package controller.user;

import model.User.*;
import model.Order.*;
import model.Bill.*;
import model.Product.*;
import model.ProductOrder.*;
import model.Review.*; 
import model.ProductImage.*;

import java.io.IOException;
import java.util.*;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.sql.SQLException;

@WebServlet("/user/MyProfile")
public class MyProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect(request.getContextPath() + "/common/LoginIn_page.jsp");
            return;
        }

        try {
        	int userId = (int) session.getAttribute("id");

        	UserDAO userDAO = new UserDAO();
        	UserDTO user = userDAO.findByCode(userId);

        	if (user == null) {
        	    response.sendRedirect(request.getContextPath() + "/logout");
        	    return;
        	}

        	OrderDAO orderDAO = new OrderDAO();
        	List<OrderDTO> ordini = orderDAO.findByUserCode(user.getId());
            BillDAO billDAO = new BillDAO();
            ProductOrderDAO pOrderDAO = new ProductOrderDAO();
            ProductDAO pDAO = new ProductDAO();
            ReviewDAO reviewDAO = new ReviewDAO();
        	ProductImageDAO imageDao = new ProductImageDAO();
    		Map<Integer, ProductImageDTO> coverImages = new HashMap<>();
            Map<Integer, BillDTO> billsMap = new HashMap<>();
            Map<Integer, List<ProductOrderDTO>> prodottiPerOrdine = new HashMap<>();
            Map<Integer, ProductDTO> prodotti = new HashMap<>();
            Collections.reverse(ordini);
            for (OrderDTO ordine : ordini) {
            	
        	
        		
                BillDTO bill = null;
                try {
                    bill = billDAO.findByOrder(ordine.getId());
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                billsMap.put(ordine.getId(), bill);

                List<ProductOrderDTO> prodottiOrdine = pOrderDAO.findAllforOrder(ordine.getId());
                prodottiPerOrdine.put(ordine.getId(), prodottiOrdine);

                for (ProductOrderDTO pr : prodottiOrdine) {
                    if (!prodotti.containsKey(pr.getId_product())) {
                    	
                        ProductDTO product = pDAO.findByCode(pr.getId_product());
                        coverImages.put(pr.getId_product(), imageDao.findProductCover(pr.getId_product()));
                         
                        prodotti.put(pr.getId_product(), product);
                    }
                }
            }

            //Recupera i productId già recensiti dall'utente
            List<Integer> prodottiRecensiti = reviewDAO.findProductIdsReviewedByUser(userId);

            //Set degli attributi da passare alla JSP
            request.setAttribute("user", user);
            request.setAttribute("ordini", ordini);
            request.setAttribute("billsMap", billsMap);
            request.setAttribute("prodottiPerOrdine", prodottiPerOrdine);
            request.setAttribute("prodotti", prodotti);
            request.setAttribute("prodottiRecensiti", prodottiRecensiti); 
            request.setAttribute("coverImages", coverImages);   

            RequestDispatcher dispatcher = request.getRequestDispatcher("/user/MyProfile.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Errore nella generazione del profilo utente", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
