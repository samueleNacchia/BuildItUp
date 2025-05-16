package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;

public class UserDAO {

    private DataSource dataSource;
	
	public UserDAO() {
        this.dataSource = DataSourceManager.getDataSource();
    }

 // Metodo per salvare un utente nel database
    public void save(UserDTO user) throws SQLException {
        String query = "INSERT INTO Users (email, password, name, surname, via, roadNum, postalCode, tel, isSubscribed) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
   
        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getName());
            stmt.setString(4, user.getSurname());
            stmt.setString(5, user.getVia());
            stmt.setInt(6, user.getRoadNum());
            stmt.setString(7, user.getPostalCode());
            stmt.setString(8, user.getTel());
            stmt.setBoolean(9, user.isSubscribed());
            

            stmt.executeUpdate();

            // Recupera l'ID generato automaticamente (se presente)
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    user.setId(generatedKeys.getInt(1)); // Imposta l'ID nel DTO
                }
            }

        } catch (SQLException e) {
            System.out.println("Errore durante il salvataggio dell'utente: " + e.getMessage());
            throw e; // rilancia l'eccezione se necessario
        }
    }


    // Metodo per recuperare un utente per codice
    public UserDTO findByCode(int code) throws SQLException {
        String query = "SELECT * FROM Users WHERE ID = ?";
        UserDTO user = null;

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

        	stmt.setInt(1, code);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	user = new UserDTO();
                	user.setId(rs.getInt("ID"));
                	user.setEmail(rs.getString("email"));
                	user.setPassword(rs.getString("password"));
                	user.setName(rs.getString("name"));
                	user.setSurname(rs.getString("surname"));
                	user.setVia(rs.getString("via"));
                	user.setRoadNum(rs.getInt("roadNum"));
                	user.setPostalCode(rs.getString("postalCode"));
                	user.setTel(rs.getString("tel")); 
                	user.setSubscribed(rs.getBoolean("isSubscribed")); 
                }
            }
        }

        return user;
    }

    // Metodo per recuperare tutti i utenti
    public List<UserDTO> findAll() throws SQLException {
        List<UserDTO> users = new ArrayList<>();
        String query = "SELECT * FROM Users";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
    	
            while (rs.next()) { 
           
                UserDTO user = new UserDTO();
                user.setId(rs.getInt("ID"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setSurname(rs.getString("surname"));
                user.setVia(rs.getString("via"));
                user.setRoadNum(rs.getInt("roadNum"));
                user.setPostalCode(rs.getString("postalCode"));
                user.setTel(rs.getString("tel"));
                user.setSubscribed(rs.getBoolean("isSubscribed")); 
                
                users.add(user);
            }
        }
       
        return users;
    }

    // Metodo per aggiornare un utente nel database
    public boolean update(UserDTO user) throws SQLException {
        String query = "UPDATE Users SET email=?, password=?, name=?, surname=?, via=?, roadNum=?, postalCode=?, tel=? isSubscribed=?, WHERE ID=?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getPassword());
        	stmt.setString(3, user.getName());
        	stmt.setString(4, user.getSurname());
        	stmt.setString(5, user.getVia());
        	stmt.setInt(6, user.getRoadNum());
        	stmt.setString(7, user.getPostalCode());
        	stmt.setString(8, user.getTel());
        	stmt.setBoolean(9, user.isSubscribed());
        	stmt.setInt(10, user.getId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Metodo per eliminare un utente dal database 
    /*
    public boolean delete(int code) throws SQLException {
        String query = "DELETE FROM Users WHERE ID = ?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

        	stmt.setInt(1, code);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
    */
}
