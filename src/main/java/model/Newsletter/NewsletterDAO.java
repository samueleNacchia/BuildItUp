package model.Newsletter;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import model.DataSourceManager;


public class NewsletterDAO {
    private DataSource dataSource;
	
	public NewsletterDAO() {
        this.dataSource = DataSourceManager.getDataSource();
        if (this.dataSource == null) {
            throw new IllegalStateException("NewsletterDAO: DataSource is null! Check DataSourceManager.");
        }
    }

	
 // Metodo per salvare una fattura nel database
    public void save(NewsletterDTO newsletter) throws SQLException {
        String query = "INSERT INTO Newsletters (email) VALUES (?)";
        
        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, newsletter.getEmail());
          
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Errore durante il salvataggio dell'utente: " + e.getMessage());
            throw e; // rilancia l'eccezione se necessario
        }
    }
    

    // Metodo per recuperare tutte le fatture
    public List<NewsletterDTO> findAll() throws SQLException {
        List<NewsletterDTO> newsletters = new ArrayList<>();
        String query = "SELECT * FROM Newsletters";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) { 
                
                NewsletterDTO newsletter = new NewsletterDTO();
                newsletter.setEmail(rs.getString("email"));
                
                newsletters.add(newsletter);
            }
        }

        return newsletters;
    }
    
}

