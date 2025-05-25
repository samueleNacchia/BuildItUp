package model.List;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import model.DataSourceManager;
import model.ListType;

public class ListDAO {
	private DataSource dataSource;

    // Costruttore che recupera il DataSource dal DataSourceManager
    public ListDAO() {
        this.dataSource = DataSourceManager.getDataSource();
        if (this.dataSource == null) {
            throw new IllegalStateException("ListDAO: DataSource is null! Check DataSourceManager.");
        }
    }

 // Metodo per salvare una lista nel database
    public void save(ListDTO list) throws SQLException {
        String query = "INSERT INTO Lists (ID_user, type) VALUES (?, ?)";
        
        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

        	if (list.getId_user() != 0) {
        	    stmt.setInt(1, list.getId_user());
        	} else {
        	    stmt.setNull(1, java.sql.Types.INTEGER);
        	}
        	
            stmt.setString(2, list.getType().name());
       
            stmt.executeUpdate();

            // Recupera l'ID generato automaticamente (se presente)
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    list.setId(generatedKeys.getInt(1)); // Imposta l'ID nel DTO
                }
            }

        } catch (SQLIntegrityConstraintViolationException e) {
            System.out.println("La lista esiste già per questo utente e tipo.");
           
        }
    }
    
    // Metodo per recuperare una lista per utente e tipo (wishlist o carrello)
    public ListDTO findByToken(String token) throws SQLException {
        String query = "SELECT * FROM Lists WHERE token=?";
        ListDTO list = null;

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

        	stmt.setString(1, token);
        	
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    list = new ListDTO();
                    list.setId(rs.getInt("ID"));
                    list.setId_user(rs.getInt("ID_user"));
                    list.setType(ListType.valueOf(rs.getString("type")));
                    list.setLastAccess(rs.getTimestamp("lastAccess").toLocalDateTime());
                }
            }
        } 

        return list;
    }
    
    
    // Metodo per recuperare una lista per utente e tipo (wishlist o carrello)
    public ListDTO findByUser(int idUser, ListType type) throws SQLException {
        String query = "SELECT * FROM Lists WHERE ID_user=? AND type=?";
        ListDTO list = new ListDTO();

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

        	stmt.setInt(1, idUser);
        	stmt.setString(2, type.name());
        	
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    list = new ListDTO();
                    list.setId(rs.getInt("ID"));
                    list.setId_user(rs.getInt("ID_user"));
                    list.setType(ListType.valueOf(rs.getString("type")));
                    list.setLastAccess(rs.getTimestamp("lastAccess").toLocalDateTime());
                }
            }
        } 

        return list;
    }

    // Metodo per recuperare tutte le liste
    public List<ListDTO> findAll() throws SQLException {
        List<ListDTO> lists = new ArrayList<>();
        String query = "SELECT * FROM Lists";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
    	
            while (rs.next()) { 
           
                ListDTO list = new ListDTO();
                list.setId(rs.getInt("ID"));
                list.setToken(rs.getString("token"));
                list.setId_user(rs.getInt("ID_user"));
                list.setType(ListType.valueOf(rs.getString("type")));
                list.setLastAccess(rs.getTimestamp("lastAccess").toLocalDateTime());
                
                lists.add(list);
            }
        }
       
        return lists;
    }

    // Metodo per aggiornare l'ultimo accesso ad una lista
    public boolean updateLastAccess(ListDTO list) throws SQLException {
        String query = "UPDATE Lists SET lastAccess = CURRENT_TIMESTAMP  WHERE ID=?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, list.getId());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
    
    
    public boolean updateToken(ListDTO list) throws SQLException {
        String sql = "UPDATE Lists SET token = ? WHERE ID = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, list.getToken());
            stmt.setInt(2, list.getId());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
    
 

    // Metodo per eliminare una lista dal database
    public boolean delete(int code) throws SQLException {
    	String query = "DELETE FROM Lists WHERE ID = ?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

        	stmt.setInt(1, code);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
    
    
 // Metodo per eliminare una lista dal database
    public boolean deleteOldList() throws SQLException {
    	String query = "DELETE FROM lists WHERE ID_user IS NULL AND lastAccess < NOW() - INTERVAL 12 HOUR;";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
    
}
