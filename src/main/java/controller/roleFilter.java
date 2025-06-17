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

@WebFilter(urlPatterns = {"/admin/*", "/user/*"})
public class roleFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Se servono inizializzazioni
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        
        if (session == null || session.getAttribute("ruolo") == null) {
        	if(session == null)
        		System.out.println("sessione nulla");
        	// Nessuna sessione o ruolo -> redirect login
        	else 
        		System.out.println("ruolo nullo");
        	res.sendRedirect(req.getContextPath() + "/LogIn_page.jsp");
            return;
        }

        int role = (int) session.getAttribute("ruolo");
        String path = req.getRequestURI();

        // Controllo accesso
        if (path.contains("/admin/") && role != 1) {
            // Non admin ma cerca di accedere a risorsa admin
            //res.sendError(HttpServletResponse.SC_FORBIDDEN, "Accesso negato");
            res.sendRedirect(req.getContextPath() + "/LogIn_page.jsp");
            return;
        } else if (path.contains("/user/")&& role != 2) {
            // Solo utenti o admin possono accedere a /user/*
           // res.sendError(HttpServletResponse.SC_FORBIDDEN, "Accesso negato");
            res.sendRedirect(req.getContextPath() + "/LogIn_page.jsp");
            return;
        } else {
            // Accesso consentito
            chain.doFilter(request, response);
        }
    }


}
