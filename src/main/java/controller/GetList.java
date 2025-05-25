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
import java.util.List;

import static controller.function.GetCookie.*;
import static controller.function.HashFunction.*;

import model.List.*;
import model.Product.ProductDAO;
import model.ItemList.*;
import model.ListType;

@WebServlet("/GetList")
public class GetList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private ListDTO createAnonymousList(ListType type, ListDAO listDao) throws SQLException {
	    ListDTO list = new ListDTO();
	    list.setType(type);
	    list.setId_user(0);  
	    listDao.save(list);
	    String token = generateTokenFromId(list.getId());
	    list.setToken(token);
	    listDao.updateToken(list);

	    return list;
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*	
		Cookie[] cookies = request.getCookies();
		System.out.println("→ Cookies ricevuti:");
		if (cookies != null) {
		    for (Cookie c : cookies) {
		        System.out.println("   - " + c.getName() + " = " + c.getValue());
		    }
		} else {
		    System.out.println("   - Nessun cookie ricevuto (null)");
		}
		*/
		 
		
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
	            if (list == null) {
	                // Lista non trovata: crea nuova lista e salvala
	                list = new ListDTO();
	                list.setType(type);
	                list.setId_user(userId);
	                listDao.save(list);
	            }
	            
	            items = itemsDao.findByList(list.getId()); 
	            
	        } else {
	            // Utente anonimo: gestisco tramite cookie
	        	String cookieName = null;

	        	if (type.name().equals("cart")) {
	        	    cookieName = "idCart";
	        	} else if (type.name().equals("wishlist")) {
	        	    cookieName = "idWishlist";
	        	}

	            if (cookieName != null) {
	                Cookie cookie = getCookieByName(request, cookieName);
	                String token = null;
	                if (cookie != null) {
	           
	                    token = cookie.getValue();
	                    list = listDao.findByToken(token);

	                    if (list != null && list.getId_user() == 0 && list.getType().equals(type)) {
	                        // Lista valida: aggiorno last access e prendo items
	                        listDao.updateLastAccess(list);
	                        items = itemsDao.findByList(list.getId());
	                        
	                    } else {
	                    	// Lista non valida: cancello il cookie (non nessessario)
	                        Cookie deleteCookie = new Cookie(cookieName, "");
	                        deleteCookie.setMaxAge(0);
	                        deleteCookie.setPath("/");
	                        response.addCookie(deleteCookie);
	                    	
	                        // Lista non trovata: creo nuova lista
	                        list = createAnonymousList(type, listDao);
	                        token = list.getToken();
	                    }
	                } else {
	                    // Cookie non presente: creo nuova lista
	                	list = createAnonymousList(type, listDao);
                        token = list.getToken();
	                }

	                // Imposto/aggiorno cookie con id lista corrente
	                cookie = new Cookie(cookieName, token);
	                cookie.setMaxAge(8 * 60 * 60); //8 ore
	                cookie.setPath("/");
	                cookie.setHttpOnly(true);
	                //cookie.setSecure(true); con HTTPS
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
