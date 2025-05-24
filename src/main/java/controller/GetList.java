package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

import static controller.GetCookie.*;
import model.List.*;
import model.Product.ProductDAO;
import model.ItemList.*;
import model.ListType;

@WebServlet("/GetList")
public class GetList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    
		
			
		Cookie[] cookies = request.getCookies();
		System.out.println("→ Cookies ricevuti:");
		if (cookies != null) {
		    for (Cookie c : cookies) {
		        System.out.println("   - " + c.getName() + " = " + c.getValue());
		    }
		} else {
		    System.out.println("   - Nessun cookie ricevuto (null)");
		}
	
		 
		
		ListType type = ListType.valueOf(request.getParameter("type")); 
	    ListDAO listDao = new ListDAO();
	    ItemListDAO itemsDao = new ItemListDAO();
	    ProductDAO productDao = new ProductDAO();

	    ListDTO list = null;
	    List<ItemListDTO> items = null;

	    HttpSession session = request.getSession(false);
	    Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;

	    try {
	        if (userId != null) {
	            // Utente loggato: prendo lista da DB
	            list = listDao.findByUser(userId, type);
	            if (list != null) {
	                items = itemsDao.findByList(list.getId());
	            }
	            System.out.println("Utente loggato: id= " + userId);

	        } else {
	            // Utente anonimo: gestisco tramite cookie
	            String cookieName = (type == ListType.cart) ? "idCart" :
	                                (type == ListType.wishlist) ? "idWishlist" : null;

	            if (cookieName != null) {
	                Cookie cookie = getCookieByName(request, cookieName);

	                if (cookie != null) {
	                    int idList = Integer.parseInt(cookie.getValue());
	                    list = listDao.findByCode(idList);

	                    if (list != null) {
	                        // Lista valida: aggiorno last access e prendo items
	                        listDao.updateLastAccess(list);
	                        items = itemsDao.findByList(idList);
	                    } else {
	                        // Lista non trovata: creo nuova lista
	                        list = new ListDTO();
	                        list.setType(type);
	                        listDao.save(list);
	                    }
	                } else {
	                    // Cookie non presente: creo nuova lista
	                    list = new ListDTO();
	                    list.setType(type);
	                    listDao.save(list);
	                }

	                // Imposto/aggiorno cookie con id lista corrente
	                cookie = new Cookie(cookieName, String.valueOf(list.getId()));
	                cookie.setMaxAge(24 * 60 * 60);
	                cookie.setPath("/");
	                response.addCookie(cookie);
	            }
	        }

	        // Se ho prodotti nella lista, carico i dettagli dei prodotti
	        if (items != null) {
	            for (ItemListDTO item : items) {
	                try {
	                    item.setProduct(productDao.findByCode(item.getId_product()));
	                } catch (SQLException e) {
	                    e.printStackTrace();
	                }
	            }
	        }

	        request.setAttribute("items", items);
	        response.setContentType("text/html;charset=UTF-8");
	        request.getRequestDispatcher("/ViewList.jsp").forward(request, response);

	    } catch (SQLException e) {
	        e.printStackTrace();
	        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
	    }
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
