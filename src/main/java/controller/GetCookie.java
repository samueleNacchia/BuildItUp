package controller;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;

public class GetCookie {
	public static Cookie getCookieByName(HttpServletRequest request, String name) {
		
	    Cookie[] cookies = request.getCookies();
	    if (cookies != null) {
	        for (Cookie c : cookies) {
	            if (name.equals(c.getName())) {
	                return c;
	            }
	        }
	    }
	    return null;
	}
}
