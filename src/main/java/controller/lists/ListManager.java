package controller.lists;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ListType;
import model.List.*;

import static controller.functions.GetCookie.*;
import static controller.functions.HashFunction.*;

import java.sql.SQLException;

public class ListManager {
	
	//type: wishlist,cart;  create: se non esiste la creo o no
    public static ListDTO getList(HttpServletRequest request, HttpServletResponse response, ListType type, boolean create) throws SQLException {
        ListDAO listDao = new ListDAO();
        HttpSession session = request.getSession(false);
        Integer userId = null;
        if (session != null) 
            userId = (Integer) session.getAttribute("id");
        

        ListDTO list;

        if (userId != null) {
            list = listDao.findByUser(userId, type);
            if (list == null && create) {
                list = new ListDTO();
                list.setType(type);
                list.setId_user(userId);
                listDao.save(list);
            }
        } else {
        	
        	String cookieName = null;
        	if (type == ListType.cart) 
        	    cookieName = "tokenCart";
        	else if (type == ListType.wishlist) 
        	    cookieName = "tokenWishlist";
     

        	if (cookieName == null) 
        	    throw new IllegalArgumentException("Tipo lista non supportato: " + type);
        	
        	
            Cookie cookie = getCookieByName(request, cookieName);
            String token = null;
            
            if (cookie != null) 
                token = cookie.getValue();
            
            if (token != null) 
                list = listDao.findByToken(token);
            else 
                list = null;
            

            if ((list == null || list.getId_user() != 0 || !list.getType().equals(type)) && create) {
                list = new ListDTO();
                list.setType(type);
                listDao.save(list);
                token = generateTokenFromId(list.getId());
                list.setToken(token);
                listDao.updateToken(list);

                cookie = new Cookie(cookieName, token);
                cookie.setMaxAge(8 * 60 * 60); //8 ore
                cookie.setPath("/");
                cookie.setHttpOnly(true);
                //cookie.setSecure(true);//per https
               
                response.addCookie(cookie);
            }
        }

        return list;
    }
}

