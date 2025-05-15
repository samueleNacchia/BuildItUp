package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;

public class ProductDAO {

    private DataSource dataSource;

    // Costruttore che recupera il DataSource dal DataSourceManager
    public ProductDAO() {
        this.dataSource = DataSourceManager.getDataSource();
    }

 // Metodo per salvare un prodotto nel database
    public void save(ProductDTO product) throws SQLException {
        String query = "INSERT INTO Products (name, category, description, price, discount, isOnSale, stocks) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, product.getName());
            stmt.setString(2, product.getCategory().name());
            stmt.setString(3, product.getDescription());
            stmt.setFloat(4, product.getPrice());
            stmt.setFloat(5, product.getDiscount());
            stmt.setBoolean(6, product.isOnSale());
            stmt.setInt(7, product.getStocks());

            stmt.executeUpdate();

            // Recupera l'ID generato automaticamente (se presente)
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    product.setId(generatedKeys.getInt(1)); // Imposta l'ID nel DTO
                }
            }

        } catch (SQLException e) {
            System.out.println("Errore durante il salvataggio del prodotto: " + e.getMessage());
            throw e; // rilancia l'eccezione se necessario
        }
    }


    // Metodo per recuperare un prodotto per codice
    public ProductDTO findByCode(int code) throws SQLException {
        String query = "SELECT * FROM Products WHERE ID = ?";
        ProductDTO product = null;

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

        	stmt.setInt(1, code);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    product = new ProductDTO();
                    product.setId(rs.getInt("ID"));
                    product.setName(rs.getString("name"));
                    product.setDescription(rs.getString("description"));
                    product.setPrice(rs.getFloat("price"));
                    product.setDiscount(rs.getFloat("discount"));
                    product.setOnSale(rs.getBoolean("isOnSale"));
                    product.setStocks(rs.getInt("stocks")); 
                    
                    String categoryStr = rs.getString("category");
                    Category category = Category.valueOf(categoryStr);
                    product.setCategory(category);
                }
            }
        }

        return product;
    }

    // Metodo per recuperare tutti i prodotti
    public List<ProductDTO> findAll() throws SQLException {
        List<ProductDTO> products = new ArrayList<>();
        String query = "SELECT * FROM Products";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
    	
            while (rs.next()) { 
           
                ProductDTO product = new ProductDTO();
                product.setId(rs.getInt("ID"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getFloat("price"));
                product.setDiscount(rs.getFloat("discount"));
                product.setOnSale(rs.getBoolean("isOnSale"));
                product.setStocks(rs.getInt("stocks"));
                
                String categoryStr = rs.getString("category");
                Category category = Category.valueOf(categoryStr);
                product.setCategory(category);
                
                products.add(product);
            }
        }
       
        return products;
    }

    // Metodo per aggiornare un prodotto nel database
    public boolean update(ProductDTO product) throws SQLException {
        String query = "UPDATE Products SET name=?, category=?, description=?, price=?, discount=?, isOnSale=?, stocks=? WHERE ID=?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, product.getName());
            stmt.setString(2, product.getCategory().name());
        	stmt.setString(3, product.getDescription());
        	stmt.setFloat(4, product.getPrice());
        	stmt.setFloat(5, product.getDiscount());
        	stmt.setBoolean(6, product.isOnSale());
        	stmt.setInt(7, product.getStocks());
        	stmt.setInt(8, product.getId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Metodo per eliminare un prodotto dal database
    public boolean delete(int code) throws SQLException {
    	String query = "UPDATE Products SET isOnSale=false WHERE ID=?";
        //String query = "DELETE FROM Products WHERE ID = ?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

        	stmt.setInt(1, code);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
}