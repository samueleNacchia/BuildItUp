package model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;

import model.Category;
import model.DataSourceManager;

public class ProductDAO {

    private DataSource dataSource;

    // Costruttore che recupera il DataSource dal DataSourceManager
    public ProductDAO() {
        this.dataSource = DataSourceManager.getDataSource();
    }

 // Metodo per salvare un prodotto nel database
    public void save(ProductDTO product) throws SQLException {
        String query = "INSERT INTO Products (name, category, description, price, discount, isOnSale, stocks, image1, image2, image3)"
        			 + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, product.getName());
            stmt.setString(2, product.getCategory().name());
            stmt.setString(3, product.getDescription());
            stmt.setFloat(4, product.getPrice());
            stmt.setFloat(5, product.getDiscount());
            stmt.setBoolean(6, product.isOnSale());
            stmt.setInt(7, product.getStocks());
            stmt.setBytes(8, product.getImage1());
            stmt.setBytes(9, product.getImage2());
            stmt.setBytes(10, product.getImage3());

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
                    product.setCategory(Category.valueOf(rs.getString("category")));
                    product.setDescription(rs.getString("description"));
                    product.setPrice(rs.getFloat("price"));
                    product.setDiscount(rs.getFloat("discount"));
                    product.setOnSale(rs.getBoolean("isOnSale"));
                    product.setStocks(rs.getInt("stocks")); 
                    product.setImage1(rs.getBytes("image1"));
                    product.setImage2(rs.getBytes("image2"));
                    product.setImage3(rs.getBytes("image3"));                    
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
                product.setCategory(Category.valueOf(rs.getString("category")));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getFloat("price"));
                product.setDiscount(rs.getFloat("discount"));
                product.setOnSale(rs.getBoolean("isOnSale"));
                product.setStocks(rs.getInt("stocks"));
                product.setImage1(rs.getBytes("image1"));
                product.setImage2(rs.getBytes("image2"));
                product.setImage3(rs.getBytes("image3")); 
  
                products.add(product);
            }
        }
       
        return products;
    }

    // Metodo per aggiornare un prodotto nel database
    public boolean update(ProductDTO product) throws SQLException {
        String query = "UPDATE Products SET  description=?, price=?, discount=?, isOnSale=?, stocks=? WHERE ID=?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
      
        	stmt.setString(1, product.getDescription());
        	stmt.setFloat(2, product.getPrice());
        	stmt.setFloat(3, product.getDiscount());
        	stmt.setBoolean(4, product.isOnSale());
        	stmt.setInt(5, product.getStocks());
            stmt.setInt(6, product.getId());	
        	
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
    

    public boolean updateAll(ProductDTO product) throws SQLException {
        StringBuilder sql = new StringBuilder(
            "UPDATE Products SET name=?, category=?, description=?, price=?, discount=?, isOnSale=?, stocks=?"
        );
        List<Object> params = new ArrayList<>();
        params.add(product.getName());
        params.add(product.getCategory().name());
        params.add(product.getDescription());
        params.add(product.getPrice());
        params.add(product.getDiscount());
        params.add(product.isOnSale());
        params.add(product.getStocks());

        if (product.getImage1() != null) {
            sql.append(", image1=?");
            params.add(product.getImage1());
        }
        if (product.getImage2() != null) {
            sql.append(", image2=?");
            params.add(product.getImage2());
        }
        if (product.getImage3() != null) {
            sql.append(", image3=?");
            params.add(product.getImage3());
        }

        sql.append(" WHERE ID=?");
        params.add(product.getId());

        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                Object p = params.get(i);
                if (p instanceof byte[]) stmt.setBytes(i + 1, (byte[]) p);
                else stmt.setObject(i + 1, p);
            }

            return stmt.executeUpdate() > 0;
        }
    }
    
    //eliminare una determinata immagine
    public boolean deleteImage(int productId, int imageNumber) throws SQLException {
        String column = switch(imageNumber) {
            case 1 -> "image1";
            case 2 -> "image2";
            case 3 -> "image3";
            default -> throw new IllegalArgumentException("Numero immagine non valido");
        };
        String sql = "UPDATE Products SET " + column + " = NULL WHERE ID = ?";
        
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            return stmt.executeUpdate() > 0;
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