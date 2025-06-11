package controller.lists;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ListType;
import model.ItemList.*;
import model.List.ListDTO;
import model.Product.*;

import java.io.IOException;
import java.sql.SQLException;

import org.json.JSONObject;

@WebServlet("/AddToList")
public class AddToList extends HttpServlet {
    private static final long serialVersionUID = 1L; 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        response.setContentType("application/json;charset=UTF-8");

        ItemListDAO itemsDao = new ItemListDAO();
        boolean addedSuccess = false;
        int quantityToAdd = 1;
        int newQuantity = 0;

        try {
            ListType type = ListType.valueOf(request.getParameter("type"));
            int productId = Integer.parseInt(request.getParameter("id"));
            String quantityStr = request.getParameter("quantity");
            
            
            if(quantityStr != null && !quantityStr.isEmpty())
            	quantityToAdd = Integer.parseInt(quantityStr);

            ProductDAO productDao = new ProductDAO();
            ProductDTO product = productDao.findByCode(productId);

            if (product != null && product.isOnSale() && product.getStocks() > 0) {
                ListDTO list = ListManager.getList(request, response, type, true);

                if (list == null) {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lista non trovata o creata");
                    return;
                }

                ItemListDTO existingItem = itemsDao.findProduct(list.getId(), productId);

                if (existingItem == null) {
                    ItemListDTO newItem = new ItemListDTO();
                    newItem.setId_list(list.getId());
                    newItem.setId_product(productId);
                    newItem.setQuantity(quantityToAdd);
                    itemsDao.save(newItem);
                    addedSuccess = true;
                    newQuantity = quantityToAdd;
                    
                } else if (type.name().equalsIgnoreCase("cart") && product.getStocks() > existingItem.getQuantity() + quantityToAdd) {
                    existingItem.setQuantity(existingItem.getQuantity() + quantityToAdd);
                    itemsDao.update(existingItem);
                    addedSuccess = true;
                    newQuantity = existingItem.getQuantity();
                }
            }

            JSONObject json = new JSONObject();
            json.put("functionName", "UpdateQuantityJSON");
            json.put("quantity", newQuantity);
            json.put("success", addedSuccess);

            response.getWriter().print(json.toString());

        } catch (SQLException | IllegalArgumentException | NullPointerException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doGet(request,response);
    }
}
