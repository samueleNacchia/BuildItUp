package controller.orders;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

import controller.lists.ListManager;
import model.List.*;
import model.ItemList.*;
import model.Product.*;
import model.ProductOrder.*;
import model.Order.*;
import model.Bill.*;
import model.ListType;
import model.Status;

@WebServlet("/user/SaveOrder")
public class SaveOrder extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	System.out.println("Servlet iniziata");
        HttpSession session = request.getSession(false);
        Integer userId = (Integer) (session != null ? session.getAttribute("id") : null);

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/common/LogIn_page.jsp");
            return;
        }
        System.out.println("Id non nullo");
        ProductDAO productDao = new ProductDAO();
        OrderDAO orderDao = new OrderDAO();
        ProductOrderDAO productOrderDao = new ProductOrderDAO();
        BillDAO billDao = new BillDAO();
        ItemListDAO itemsDao = new ItemListDAO();

        LocalDate now = LocalDate.now();
        float price, total = 0;

        try {
        	System.out.println("Inizio recupero indirizzo");
            // Recupero dati form (se presenti)
            String indirizzo = request.getParameter("street");
            int civico = Integer.parseInt(request.getParameter("civic"));
            String cap = String.valueOf(request.getParameter("zip"));
            String provincia = request.getParameter("province");
            System.out.println("Recupero inirizzo finito");
            
            ListDTO list = ListManager.getList(request, response, ListType.cart, false);
            if (list == null) {
                response.sendRedirect(request.getContextPath() + "/common/Home");
                return;
            }
            System.out.println("La lista è salvata bene");

            List<ItemListDTO> items = itemsDao.findByList(list.getId());
            if (items == null || items.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/common/Home");
                return;
            }
            System.out.println("Recupero item lista eseguito");
            for (ItemListDTO item : items) {
                try {
                    item.setProduct(productDao.findByCode(item.getId_product()));
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

            for (ItemListDTO item : items) {
                ProductDTO product = item.getProduct();
                if (product.getStocks() < item.getQuantity()) {
                    itemsDao.deleteFromList(item.getId_list(), product.getId());
                    response.sendRedirect(request.getContextPath() + "/user/OrderSummary.jsp");
                    return;
                }
            }

            OrderDTO order = new OrderDTO();
            order.setId_user(userId);
            order.setOrderDate(now);
            order.setStatus(Status.In_elaborazione);

            // Salva i dati indirizzo nell'ordine (se OrderDTO ha i campi corrispondenti)
            order.setVia(indirizzo);
            order.setRoadNum(civico);
            order.setPostalCode(cap);
            order.setProvincia(provincia);
            System.out.println("Set indirizzo riuscito");
            orderDao.save(order);
            System.out.println("Salvataggio ordine riuscito");
            for (ItemListDTO item : items) {
                ProductDTO product = item.getProduct();
                price = product.getPrice() * (1 - product.getDiscount());

                BigDecimal bd = new BigDecimal(Float.toString(price));
                bd = bd.setScale(2, RoundingMode.HALF_UP);
                price = bd.floatValue();

                ProductOrderDTO productOrder = new ProductOrderDTO();
                productOrder.setId_product(product.getId());
                productOrder.setId_order(order.getId());
                productOrder.setPrice(price);
                productOrder.setQuantity(item.getQuantity());
                productOrderDao.save(productOrder);

                total += price * item.getQuantity();

                int newStock = product.getStocks() - item.getQuantity();
                productDao.updateStock(product.getId(), newStock);

                itemsDao.deleteFromList(item.getId_list(), product.getId());
            }

            BillDTO bill = new BillDTO();
            bill.setId_order(order.getId());
            bill.setBillDate(now);
            bill.setTotal(total);
            billDao.save(bill);
            System.out.println("Salvataggio fattura");
            session.setAttribute("ordine", order);
            session.setAttribute("fattura", bill);

            response.sendRedirect(request.getContextPath() + "/user/OrderSummary.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Errore nel database");
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Tipo lista non valido");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}