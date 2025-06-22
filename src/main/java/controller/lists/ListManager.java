package controller.lists;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ListType;
import model.ItemList.*;
import model.List.*;
import model.User.UserDTO;

import static controller.functions.GetCookie.*;
import static controller.functions.HashFunction.*;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ListManager {
	
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
    
    
    public void mergeList(ListType type, UserDTO user, HttpServletRequest request, HttpServletResponse response) throws SQLException {
        ListDAO listDao = new ListDAO();
        ItemListDAO itemsDao = new ItemListDAO();

        ListDTO anonList = ListManager.getList(request, response, type, false);
        List<ItemListDTO> anonItems = (anonList != null) ? itemsDao.findByList(anonList.getId()) : new ArrayList<>();

        ListDTO userList = listDao.findByUser(user.getId(), type);
        List<ItemListDTO> userItems = (userList != null) ? itemsDao.findByList(userList.getId()) : new ArrayList<>();

        if (userList == null && anonItems.isEmpty()) return;

        if (userList == null) {
            userList = new ListDTO();
            userList.setId_user(user.getId());
            userList.setType(type);
            listDao.save(userList);
            userItems = new ArrayList<>();
        }

        if (anonList != null && anonList.getId() != userList.getId()) {
        	for (ItemListDTO anonItem : anonItems) {
        	    ItemListDTO existing = null;
        	    for (ItemListDTO userItem : userItems) {
        	        if (userItem.getId_product() == anonItem.getId_product()) {
        	            existing = userItem;
        	            break;
        	        }
        	    }

        	    if (existing != null) {
        	        if (type == ListType.cart) {
        	            existing.setQuantity(existing.getQuantity() + anonItem.getQuantity());
        	            itemsDao.update(existing);
        	        }
        	    } else {
        	        anonItem.setId_list(userList.getId());
        	        itemsDao.save(anonItem);
        	    }
        	}

            listDao.delete(anonList.getId());

            String cookieName = (type == ListType.cart) ? "tokenCart" : "tokenWishlist";
            Cookie cookie = new Cookie(cookieName, "");
            cookie.setMaxAge(0);
            response.addCookie(cookie);
        }
    }
    
}