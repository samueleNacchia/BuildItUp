package model.ProductImage;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;

import model.DataSourceManager;

public class ProductImageDAO {

    private DataSource dataSource;

    // Costruttore che recupera il DataSource dal DataSourceManager
    public ProductImageDAO() {
        this.dataSource = DataSourceManager.getDataSource();
        if (this.dataSource == null) {
            throw new IllegalStateException("ProductImageDAO: DataSource is null! Check DataSourceManager.");
        }
    }

 // Metodo per salvare un prodotto nel database
    public void save(ProductImageDTO productImage) throws SQLException {
        String query = "INSERT INTO ProductImages (ID_product, image, isCover) VALUES (?, ?, ?)";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, productImage.getIdProduct());
            stmt.setBytes(2, productImage.getImage());
            stmt.setBoolean(3, productImage.isCover());

            stmt.executeUpdate();

            // Recupera l'ID generato automaticamente (se presente)
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    productImage.setId(generatedKeys.getInt(1)); // Imposta l'ID nel DTO
                }
            }

        } catch (SQLException e) {
            System.out.println("Errore durante il salvataggio dell'immagine prodotto: " + e.getMessage());
            throw e; // rilancia l'eccezione se necessario
        }
    }


    // Metodo per recuperare un imagine per codice
    public ProductImageDTO findByCode(int code) throws SQLException {
        String query = "SELECT * FROM ProductImages WHERE ID = ?";
        ProductImageDTO productImage = null;

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

        	stmt.setInt(1, code);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    productImage = new ProductImageDTO();
                    productImage.setId(rs.getInt("ID"));  
                    productImage.setIdProduct(rs.getInt("ID_product")); 
                    productImage.setImage(rs.getBytes("image"));                    
                }
            }
        }

        return productImage;
    }
    
    
 // Metodo per recuperare l'immagine di copertina di un prodotto
    public ProductImageDTO findProductCover(int idProduct) throws SQLException {
        String query = "SELECT * FROM ProductImages WHERE ID_product = ? AND isCover = TRUE";
        ProductImageDTO productImage = null;

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

        	stmt.setInt(1, idProduct);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    productImage = new ProductImageDTO();
                    productImage.setId(rs.getInt("ID"));  
                    productImage.setIdProduct(idProduct); 
                    productImage.setImage(rs.getBytes("image"));
                    productImage.setCover(true);
                }
            }
        }

        return productImage;
    }
     
    
    // Metodo per recuperare tutte le immagini di un prodotto
    public List<ProductImageDTO> findAllByProduct(int idProduct) throws SQLException {
        List<ProductImageDTO> productImages = new ArrayList<>();
        String query = "SELECT * FROM ProductImages WHERE ID_product = ?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)){
        		
            stmt.setInt(1, idProduct);
                
            try (ResultSet rs = stmt.executeQuery()) {
            	while (rs.next()) {
            		ProductImageDTO productImage = new ProductImageDTO();
            		productImage.setId(rs.getInt("ID"));  
                    productImage.setIdProduct(rs.getInt("ID_product")); 
                    productImage.setImage(rs.getBytes("image"));
                        
                    productImages.add(productImage);
            	}
            }
        }
       
        return productImages;
    }

    
    // Metodo per recuperare tutte le immagini
    public List<ProductImageDTO> findAll() throws SQLException {
        List<ProductImageDTO> productImages = new ArrayList<>();
        String query = "SELECT * FROM ProductImages";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
    	
            while (rs.next()) { 
           
                ProductImageDTO productImage = new ProductImageDTO();
                productImage.setId(rs.getInt("ID"));
                productImage.setIdProduct(rs.getInt("ID_product"));
                productImage.setImage(rs.getBytes("image")); 
  
                productImages.add(productImage);
            }
        }
       
        return productImages;
    }


    // Metodo per eliminare un'immagine dal database
    public boolean delete(int code) throws SQLException {
    	String query = "DELETE FROM ProductImages WHERE ID = ?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

        	stmt.setInt(1, code);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
     
 
}
    