package model.ProductOrder;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;
import model.DataSourceManager;
import model.Product.ProductDTO;

public class ProductOrderDAO {
    private DataSource dataSource;
	
	public ProductOrderDAO() {
        this.dataSource = DataSourceManager.getDataSource();
        if (this.dataSource == null) {
            throw new IllegalStateException("ProductDAO: DataSource is null! Check DataSourceManager.");
        }
    }

 // Metodo per salvare un prodotto dell'ordine nel database
    public void save(ProductOrderDTO productOrder) throws SQLException {
        String query = "INSERT INTO ProductOrder (ID_product, ID_order, price, quantity) VALUES (?, ?, ?, ?)";
        
        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, productOrder.getId_product());
            stmt.setInt(2, productOrder.getId_order());
            stmt.setFloat(3, productOrder.getPrice());
            stmt.setInt(4, productOrder.getQuantity());
          
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Errore durante il salvataggio del prodotto: " + e.getMessage());
            throw e; // rilancia l'eccezione se necessario
        }
    }


    // Metodo per recuperare un prodotto di un certo ordine
    public ProductOrderDTO findByCode(int id_product, int id_order) throws SQLException {
        String query = "SELECT * FROM ProductOrder WHERE ID_product = ? AND ID_order = ?";
        ProductOrderDTO productOrder = null;

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

        	stmt.setInt(1, id_product);
        	stmt.setInt(2, id_order);
        	
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	productOrder = new ProductOrderDTO();
                	productOrder.setId_product(id_product);
                	productOrder.setId_order(id_order);
                	productOrder.setPrice(rs.getFloat("price"));
                	productOrder.setQuantity(rs.getInt("quantity"));
                }
            }
        }

        return productOrder;
    }

    // Metodo per recuperare tutti i prodotti di un certo ordine
    public List<ProductOrderDTO> findAllforOrder(int id_order) throws SQLException {
        List<ProductOrderDTO> productOrders = new ArrayList<>();
        String query = "SELECT * FROM ProductOrder WHERE ID_order = ?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
        		
        	stmt.setInt(1, id_order);
        		
            try(ResultSet rs = stmt.executeQuery()) {
    	
	            while (rs.next()) { 
	           
	                ProductOrderDTO productOrder = new ProductOrderDTO();
	                productOrder.setId_product(rs.getInt("ID_product"));
	                productOrder.setId_order(id_order);
	            	productOrder.setPrice(rs.getFloat("price"));
	            	productOrder.setQuantity(rs.getInt("quantity"));
	                
	                productOrders.add(productOrder);
	            }
            }
        }
       
        return productOrders;
    }

    
 // Metodo per recuperare tutti i prodotti
    public List<ProductOrderDTO> findAll() throws SQLException {
        List<ProductOrderDTO> productOrders = new ArrayList<>();
        String query = "SELECT * FROM ProductOrder";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
        		
        		
            try(ResultSet rs = stmt.executeQuery()) {
	            while (rs.next()) { 
	           
	                ProductOrderDTO productOrder = new ProductOrderDTO();
	                productOrder.setId_product(rs.getInt("ID_product"));
	                productOrder.setId_order(rs.getInt("ID_order"));
	            	productOrder.setPrice(rs.getFloat("price"));
	            	productOrder.setQuantity(rs.getInt("quantity"));
	                
	                productOrders.add(productOrder);
	            }
            }
        }
       
        return productOrders;
    }
    
    
   public List<ProductDTO> getBestsellers(String category, String name, Double minPrice, Double maxPrice, String order, int limit, int offset) throws SQLException {
        List<ProductDTO> result = new ArrayList<>();

        StringBuilder query = new StringBuilder("""
            SELECT p.ID, p.name, p.price, p.discount, p.numReview, p.avgReview, SUM(po.quantity) AS quantity
            FROM ProductOrder po JOIN Products p ON po.ID_product = p.ID  WHERE p.isOnSale=TRUE """);

        if (category != null && !category.isEmpty()) query.append(" AND p.category = ?");
        if (name != null && !name.isEmpty()) query.append(" AND p.name LIKE ?");
        if (minPrice != null) query.append(" AND p.price >= ?");
        if (maxPrice != null) query.append(" AND p.price <= ?");

        query.append(" GROUP BY p.ID");
        
        if (order != null) {
            switch (order) {
            	case "priceASC": query.append(" ORDER BY price ASC"); break;
            	case "priceDESC": query.append(" ORDER BY price DESC"); break;
                case "avgRate": query.append(" ORDER BY avgReview DESC"); break;
                default: break;
            }
        }

        if (limit > 0) {
            query.append(" LIMIT ?");
            if (offset >= 0) {
                query.append(" OFFSET ?");
            }
        }

        try (Connection con = dataSource.getConnection();
             PreparedStatement stmt = con.prepareStatement(query.toString())) {

            int index = 1;
            if (category != null && !category.isEmpty()) stmt.setString(index++, category);
            if (name != null && !name.isEmpty()) stmt.setString(index++, "%" + name + "%");
            if (minPrice != null) stmt.setDouble(index++, minPrice);
            if (maxPrice != null) stmt.setDouble(index++, maxPrice);
            if (limit > 0) stmt.setInt(index++, limit);
            if (limit > 0 && offset >= 0) stmt.setInt(index++, offset);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ProductDTO product = new ProductDTO();
                    product.setId(rs.getInt("ID"));
                    product.setName(rs.getString("name"));
                    product.setPrice(rs.getFloat("price"));
                    product.setDiscount(rs.getFloat("discount"));
                    product.setNumReview(rs.getInt("numReview"));
                    product.setAvgReview(rs.getFloat("avgReview"));
                    
                    result.add(product);
                }
            }
        }
        return result;
    }
}