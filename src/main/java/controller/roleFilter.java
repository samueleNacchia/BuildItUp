package controller;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {"/admin/*", "/user/*", "/unlogged/*, /common/*"})
public class roleFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String path = req.getRequestURI();
        Boolean role = null;

        // Estrai il ruolo dalla sessione se disponibile
        if (session != null) {
            Object ruoloAttr = session.getAttribute("ruolo");
            if (ruoloAttr instanceof Boolean) {
                role = (Boolean) ruoloAttr;
            }
        }

        // 1. /unlogged/ → accesso per non loggati o utenti (ruolo 2)
        if (path.contains("/unlogged/")) {
            if (role == null || role == false) {

            	chain.doFilter(request, response);
                return;
            } else {
                res.sendRedirect(req.getContextPath() + "/common/LogIn_page.jsp");
                return;
            }
        }

        // 2. /admin/ → solo ruolo 1
        if (path.contains("/admin/")) {
            if (role != null && role == true) {
                chain.doFilter(request, response);
                return;
            } else {
                res.sendRedirect(req.getContextPath() + "/common/LogIn_page.jsp");
                return;
            }
        }

        // 3. /user/ → solo ruolo 2
        if (path.contains("/user/")) {
            if (role != null && role == false) {
                chain.doFilter(request, response);
                return;
            } else {
                res.sendRedirect(req.getContextPath() + "/common/LogIn_page.jsp");
                return;
            }
        }

        // 4. Default: blocca tutto il resto
        res.sendRedirect(req.getContextPath() + "/common/LogIn_page.jsp");
    }
}
