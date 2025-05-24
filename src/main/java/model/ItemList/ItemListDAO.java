package model.ItemList;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import model.DataSourceManager;

public class ItemListDAO {
	private DataSource dataSource;

    // Costruttore che recupera il DataSource dal DataSourceManager
    public ItemListDAO() {
        this.dataSource = DataSourceManager.getDataSource();
        if (this.dataSource == null) {
            throw new IllegalStateException("ItemListDAO: DataSource is null! Check DataSourceManager.");
        }
    }

 // Metodo per salvare un prodotto nel database
    public void save(ItemListDTO itemList) throws SQLException {
        String query = "INSERT INTO ItemList (ID_list, ID_product, quantity) VALUES (?, ?, ?)";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, itemList.getId_list());
            stmt.setInt(2, itemList.getId_product());
            stmt.setInt(3, itemList.getQuantity());
            
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Errore durante il salvataggio del prodotto: " + e.getMessage());
            throw e; // rilancia l'eccezione se necessario
        }
    }
   
    
    // Metodo per recuperare una lista (sia essa una wishlist o il carrello)
    public List<ItemListDTO> findByList(int idList) throws SQLException {
        List<ItemListDTO> itemsList = new ArrayList<>();
        String query = "SELECT * FROM ItemList WHERE ID_list = ?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
    	
        	stmt.setInt(1, idList);
        	
        	try (ResultSet rs = stmt.executeQuery()) {
        		while (rs.next()) { 
           
	                ItemListDTO itemList = new ItemListDTO();
	                itemList.setId_list(rs.getInt("ID_list"));
	                itemList.setId_product(rs.getInt("ID_product"));
	                itemList.setQuantity(rs.getInt("quantity"));
	                
	                itemsList.add(itemList);
        		}
        	}
        }
       
        return itemsList;
    }
    

    // Metodo per recuperare tutti i prodotti
    public List<ItemListDTO> findAll() throws SQLException {
        List<ItemListDTO> itemLists = new ArrayList<>();
        String query = "SELECT * FROM ItemList";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
    	
            while (rs.next()) { 
           
                ItemListDTO itemList = new ItemListDTO();
                itemList.setId_list(rs.getInt("ID_list"));
                itemList.setId_product(rs.getInt("ID_product"));
                itemList.setQuantity(rs.getInt("quantity"));
                
                itemLists.add(itemList);
            }
        }
       
        return itemLists;
    }

    // Metodo per aggiornare la quantià di un prodotto nella lista (carrello)
    public boolean update(ItemListDTO itemList) throws SQLException {
        String query = "UPDATE ItemList SET quantity=? WHERE ID_list=? AND ID_product=?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, itemList.getQuantity());
            stmt.setInt(2, itemList.getId_list());
        	stmt.setInt(3, itemList.getId_product());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Metodo per eliminare un prodotto da una lista (wishlist/carrello)
    public boolean deleteFromList(int idList, int idProduct) throws SQLException {
    	String query = "DELETE FROM ItemList WHERE ID_list=? AND ID_product=?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

        	stmt.setInt(1, idList);
        	stmt.setInt(2, idProduct);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
    
 // Metodo per eliminare tutti i prodotti da una lista (wishlist/carrello)
    /*public boolean deleteAllFromList(int idList) throws SQLException {
    	String query = "DELETE FROM ItemList WHERE ID_list=?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

        	stmt.setInt(1, idList);
       
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }*/
}
