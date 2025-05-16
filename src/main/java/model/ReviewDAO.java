package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;

public class ReviewDAO {

    private DataSource dataSource;
	
	public ReviewDAO() {
        this.dataSource = DataSourceManager.getDataSource();
    }

 // Metodo per salvare una recensione nel database
    public void save(ReviewDTO review) throws SQLException {
        String query = "INSERT INTO Reviews (ID_user, ID_product, text, vote, reviewDate) VALUES (?, ?, ?, ?, ?)";
   
        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, review.getId_user());
            stmt.setInt(2, review.getId_product());
            stmt.setString(3, review.getText());
            stmt.setInt(4, review.getVote());
            stmt.setDate(5, java.sql.Date.valueOf(review.getReviewDate()));

            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Errore durante il salvataggio dell'utente: " + e.getMessage());
            throw e; // rilancia l'eccezione se necessario
        }
    }


    // Metodo per recuperare una recensione per codice
    public ReviewDTO findByCode(int id_user, int id_product) throws SQLException {
        String query = "SELECT * FROM Reviews WHERE ID_user=? AND ID_product=?";
        ReviewDTO review = null;

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

        	stmt.setInt(1, id_user);
        	stmt.setInt(2, id_product);
        	
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	review = new ReviewDTO();
                	review.setId_user(id_user);
                	review.setId_product(id_product);
                	review.setText(rs.getString("text"));
                	review.setReviewDate(rs.getDate("reviewDate").toLocalDate());
                	 
                }
            }
        }

        return review;
    }

    // Metodo per recuperare le recensioni di un prodotto
    public List<ReviewDTO> findAllforProduct(int id_product) throws SQLException {
        List<ReviewDTO> reviews = new ArrayList<>();
        String query = "SELECT * FROM Reviews WHERE ID_product = ?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

        	stmt.setInt(1, id_product);
        	
        	try(ResultSet rs = stmt.executeQuery()){
        	
	            while (rs.next()) { 
	           
	                ReviewDTO review = new ReviewDTO();
	                review.setId_user(rs.getInt("ID_user"));
	                review.setId_product(id_product);
	                review.setText(rs.getString("text"));
	                review.setVote(rs.getInt("vote"));
	                review.setReviewDate(rs.getDate("reviewDate").toLocalDate());
	                
	                reviews.add(review);
	            }
        	}
        }
       
        return reviews;
    }

    // Metodo per aggiornare una recensione nel database
    public boolean update(ReviewDTO review) throws SQLException {
        String query = "UPDATE Reviews SET text=?, vote=?, reviewDate=? WHERE ID_user=? AND ID_product=?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, review.getText());
            stmt.setInt(2, review.getVote());
            stmt.setDate(3, java.sql.Date.valueOf(review.getReviewDate()));
        	stmt.setInt(4, review.getId_user());
        	stmt.setInt(5, review.getId_product());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Metodo per eliminare una recenzione dal database 
    public boolean delete(int id_user, int id_product) throws SQLException {
        String query = "DELETE FROM Reviews WHERE ID_user=? AND ID_product=?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

        	stmt.setInt(1, id_user);
        	stmt.setInt(2, id_product);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
   
}