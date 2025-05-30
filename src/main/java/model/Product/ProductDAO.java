package model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;

import model.Category;
import model.DataSourceManager;
import model.ProductOrder.ProductOrderDAO;

public class ProductDAO {

    private DataSource dataSource;

    // Costruttore che recupera il DataSource dal DataSourceManager
    public ProductDAO() {
        this.dataSource = DataSourceManager.getDataSource();
        if (this.dataSource == null) {
            throw new IllegalStateException("ProductDAO: DataSource is null! Check DataSourceManager.");
        }
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
                    product.setCategory(Category.valueOf(rs.getString("category")));
                    product.setDescription(rs.getString("description"));
                    product.setPrice(rs.getFloat("price"));
                    product.setDiscount(rs.getFloat("discount"));
                    product.setOnSale(rs.getBoolean("isOnSale"));
                    product.setStocks(rs.getInt("stocks"));                     
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
    
    // Metodo per aggiornare le disponibilità di un prodotto nel database
    public boolean updateStock(int id, int stock) throws SQLException {
        String query = "UPDATE Products SET stocks=? WHERE ID=?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
        	
        	stmt.setInt(1, stock);
            stmt.setInt(2, id);	
        	
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
    
    
    public int countFiltered(String type, String category, Double minPrice, Double maxPrice, String name) throws SQLException {
        StringBuilder query = new StringBuilder();
        List<Object> params = new ArrayList<>();

        if ("bestsellers".equalsIgnoreCase(type)) {
            query.append("SELECT COUNT(DISTINCT p.ID) FROM ProductOrder po JOIN Products p ON po.ID_product = p.ID WHERE p.isOnSale=TRUE");
            
            if (category != null) {
                query.append(" AND p.category = ?");
                params.add(category);
            }
            if (minPrice != null) {
                query.append(" AND p.price >= ?");
                params.add(minPrice);
            }
            if (maxPrice != null) {
                query.append(" AND p.price <= ?");
                params.add(maxPrice);
            }
            if (name != null && !name.isEmpty()) {
                query.append(" AND p.name LIKE ?");
                params.add("%" + name + "%");
            }
        } else {
            
            query.append("SELECT COUNT(*) FROM Products WHERE isOnSale=TRUE");
            
            if ("discounts".equalsIgnoreCase(type)) {
                query.append(" AND discount > 0");
            }
            if (category != null && !category.isEmpty()) {
                query.append(" AND category = ?");
                params.add(category);
            }
            if (minPrice != null) {
                query.append(" AND price >= ?");
                params.add(minPrice);
            }
            if (maxPrice != null) {
                query.append(" AND price <= ?");
                params.add(maxPrice);
            }
            if (name != null && !name.isEmpty()) {
                query.append(" AND name LIKE ?");
                params.add("%" + name + "%");
            }
        }

        try (Connection con = dataSource.getConnection();
             PreparedStatement stmt = con.prepareStatement(query.toString())) {

            for (int i = 0; i < params.size(); i++) {
                Object param = params.get(i);
                if (param instanceof String) {
                    stmt.setString(i + 1, (String) param);
                } else if (param instanceof Double) {
                    stmt.setDouble(i + 1, (Double) param);
                }
            }

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }

        return 0;
    }


    //VERSIONE CON SEPARAZIONE
    public List<ProductDTO> getFilteredProducts(String type, int limit, String name, String category,
    		Double minPrice, Double maxPrice, int page, int pageSize) throws SQLException {

    	List<ProductDTO> products =  new ArrayList<>();;

        if ("bestsellers".equalsIgnoreCase(type)) {
        	int offset, effectiveLimit;
        	
        	if (page > 0 && pageSize > 0) 
        		offset = ((page - 1) * pageSize);
        	else 
        		offset = 0;
        
        	if (pageSize > 0) 
        		effectiveLimit = pageSize;
        	else 
        		effectiveLimit = limit;	

            ProductOrderDAO productOrderDao = new ProductOrderDAO();
            return productOrderDao.getBestsellers(category, name, minPrice, maxPrice, effectiveLimit, offset);
        }

        // Costruzione query per altri tipi di filtri
        StringBuilder query = new StringBuilder("SELECT * FROM Products WHERE isOnSale=TRUE");

        if ("discounts".equalsIgnoreCase(type)) {
            query.append(" AND discount > 0");
        }

        if (category != null && !category.isEmpty()) query.append(" AND category = ?");
        if (minPrice != null) query.append(" AND price >= ?");
        if (maxPrice != null) query.append(" AND price <= ?");
        if (name != null && !name.isEmpty()) query.append(" AND name LIKE ?");

        if ("discounts".equalsIgnoreCase(type)) {
        	query.append(" ORDER BY discount DESC");
        }
        
        // Gestione LIMIT e OFFSET
        if (pageSize > 0 && page > 0) {
            query.append(" LIMIT ? OFFSET ?");
        } else if (limit > 0) {
            query.append(" LIMIT ?");
        }
        
        try (Connection con = dataSource.getConnection();
             PreparedStatement stmt = con.prepareStatement(query.toString())) {

            int index = 1;
            if (category != null && !category.isEmpty()) stmt.setString(index++, category);
            if (minPrice != null) stmt.setDouble(index++, minPrice);
            if (maxPrice != null) stmt.setDouble(index++, maxPrice);
            if (name != null && !name.isEmpty()) stmt.setString(index++, "%" + name + "%");

            if (pageSize > 0 && page > 0) {
                stmt.setInt(index++, pageSize);
                stmt.setInt(index++, (page - 1) * pageSize);
            } else if (limit > 0) {
                stmt.setInt(index++, limit);
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ProductDTO product = new ProductDTO();
                    product.setId(rs.getInt("ID"));
                    product.setName(rs.getString("name"));
                    product.setPrice(rs.getFloat("price"));
                    product.setDiscount(rs.getFloat("discount"));
                    product.setCategory(Category.valueOf(rs.getString("category")));
                    product.setDiscount(rs.getFloat("discount"));
                    
                    products.add(product);
                }
            }
        }

        return products;
    }
    
}
    