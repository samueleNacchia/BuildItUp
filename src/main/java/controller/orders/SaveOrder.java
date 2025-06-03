package controller.orders;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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


@WebServlet("/SaveOrder")
public class SaveOrder extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	/*HttpSession session = request.getSession(false);
        Integer userId = (Integer) session.getAttribute("userId");
        */
        /*if (userId == null) {
             response.sendRedirect("login.jsp");
             return;
        }*/
         
        ProductDTO product = new ProductDTO();
        ProductDAO productDao = new ProductDAO();
        
        OrderDAO orderDao = new OrderDAO();
        OrderDTO order = new OrderDTO();
        
        ProductOrderDAO productOrderDao = new ProductOrderDAO();
        ProductOrderDTO productOrder = new ProductOrderDTO();
        
        BillDTO bill = new BillDTO();
        BillDAO billDao = new BillDAO();
        
    	ItemListDAO itemsDao = new ItemListDAO();
    	LocalDate now = LocalDate.now();
    	float price, total = 0;
    	
    	
    	try {
            ListDTO list = ListManager.getList(request, response, ListType.cart, false);

            List<ItemListDTO> items = null;
            if (list != null) {
                items = itemsDao.findByList(list.getId());
                if (items != null) {
                    for (ItemListDTO item : items) {
                        try {
                            item.setProduct(productDao.findByCode(item.getId_product()));
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }     
            
            for(ItemListDTO item : items) {
            	product = item.getProduct();
            	
            	if(product.getStocks()<item.getQuantity()) {
            		itemsDao.deleteFromList(item.getId_list(), product.getId());
            		
            		response.setContentType("text/html;charset=UTF-8");
            	    response.sendRedirect("OrderSummary.jsp");
            	    return;
            	}
            }
            
            //order.setId_user(userId);
        	order.setId_user(1); //DA CAMBIARE
        	order.setOrderDate(now);
        	order.setStatus(Status.In_elaborazione);
        	orderDao.save(order); 
            
            for(ItemListDTO item : items) {
            	product = item.getProduct();
            	price = product.getPrice() * (1-product.getDiscount());
            	
            	productOrder.setId_product(product.getId());
            	productOrder.setId_order(order.getId());
            	productOrder.setPrice(price);
            	productOrder.setQuantity(item.getQuantity());
            	productOrderDao.save(productOrder);
            
            	total += (price*item.getQuantity());
            	
            	int newStock = product.getStocks()-item.getQuantity();
            	productDao.updateStock(product.getId(), newStock);
            	
            	itemsDao.deleteFromList(item.getId_list(), product.getId());
            }
            
            bill.setId_order(order.getId());
            bill.setBillDate(now);
            bill.setTotal(total);
            billDao.save(bill);
            
            LocalDate orderDate = order.getOrderDate();

            String formattedDate = orderDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
            
            request.setAttribute("data", formattedDate);
            request.setAttribute("ordine",order);
            request.setAttribute("fattura",bill);
            
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    		response.setHeader("Pragma", "no-cache");
    		response.setDateHeader("Expires", 0);
            response.setContentType("text/html;charset=UTF-8");
            request.getRequestDispatcher("/OrderSummary.jsp").forward(request, response);
            

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Tipo lista non valido");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
