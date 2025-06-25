package controller;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {"/admin/*", "/user/*", "/unlogged/*"})
public class roleFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String path = req.getRequestURI();
        Boolean isAdmin = null;

        // Estrai il ruolo dalla sessione se disponibile
        if (session != null) {
            Object ruoloAttr = session.getAttribute("isAdmin");
            if (ruoloAttr instanceof Boolean) {
                isAdmin = (Boolean) ruoloAttr;
            }
        }

        
        if (path.contains("/unlogged/")) {
            if (!Boolean.TRUE.equals(isAdmin)) {
            	chain.doFilter(request, response);
                return;
            } else {
                res.sendRedirect(req.getContextPath() + "/common/LogIn_page.jsp");
                return;
            }
        }

        
        if (path.contains("/admin/")) {
            if (Boolean.TRUE.equals(isAdmin)) {
                chain.doFilter(request, response);
                return;
            } else {
                res.sendRedirect(req.getContextPath() + "/common/LogIn_page.jsp");
                return;
            }
        }

        
        if (path.contains("/user/")) {
            if (Boolean.FALSE.equals(isAdmin)) {
                chain.doFilter(request, response);
                return;
            } else {
                res.sendRedirect(req.getContextPath() + "/common/LogIn_page.jsp");
                return;
            }
        }

        //Default
        res.sendRedirect(req.getContextPath() + "/common/LogIn_page.jsp");
    }
}