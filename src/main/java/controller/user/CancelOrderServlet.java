package controller.user;

import model.Order.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/cancelOrder")
public class CancelOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderIdStr = request.getParameter("orderId");
        if (orderIdStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID ordine mancante.");
            return;
        }

        int orderId = Integer.parseInt(orderIdStr);
        OrderDAO orderDAO = new OrderDAO();

        try {
            String status = (String) orderDAO.findByCode(orderId).getStatusName();

            if (!"In_elaborazione".equals(status)) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "L'ordine non è più annullabile.");
                return;
            }

            boolean success = orderDAO.cancelOrder(orderId);
            if (success) {
                response.sendRedirect(request.getContextPath()+"/user/MyProfile?cancelSuccess=1");
            } else {
                response.sendRedirect(request.getContextPath()+"/user/MyProfile?cancelFailed=1");
            }

        } catch (SQLException e) {
            throw new ServletException("Errore durante l'annullamento dell'ordine.", e);
        }
    }
}
