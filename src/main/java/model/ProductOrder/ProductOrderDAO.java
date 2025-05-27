package model.ProductOrder;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import model.Category;
import model.DataSourceManager;
import model.Product.ProductDAO;
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
    

 // Metodo per recuperare tutti i prodotti ordinati, in ordine di quantità venduta
    public List<ProductDTO> GetBestsellers() throws SQLException {
        List<ProductDTO> bs = new ArrayList<>();
        String query = """
                SELECT p.ID, p.name, p.image1, SUM(po.quantity) AS quantity
                FROM ProductOrder po
                JOIN Products p ON po.ID_product = p.ID
                GROUP BY p.ID, p.name, p.image1
                ORDER BY quantity DESC LIMIT 5
            """;

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
        		        		
            try(ResultSet rs = stmt.executeQuery()) {
    	
	            while (rs.next()) { 
	           
	            	ProductDTO p = new ProductDTO();
	                p.setId(rs.getInt("ID"));
	                p.setName(rs.getString("name"));
	                p.setImage1(rs.getBytes("image1"));
	                
	                bs.add(p);
	            }
            }
        }
       
        return bs;
    }
    
    
}