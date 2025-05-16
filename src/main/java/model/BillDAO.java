package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;


public class BillDAO {
    private DataSource dataSource;
	
	public BillDAO() {
        this.dataSource = DataSourceManager.getDataSource();
    }

	
 // Metodo per salvare una fattura nel database
    public void save(BillDTO bill) throws SQLException {
        String query = "INSERT INTO Bills (ID_order, total, billDate) VALUES (?, ?, ?)";
        
        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, bill.getId_order());
            stmt.setFloat(2, bill.getTotal());
            stmt.setDate(3, java.sql.Date.valueOf(bill.getBillDate()));
          
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Errore durante il salvataggio dell'utente: " + e.getMessage());
            throw e; // rilancia l'eccezione se necessario
        }
    }


    // Metodo per recuperare una fattura per codice
    public BillDTO findByCode(int code) throws SQLException {
        String query = "SELECT * FROM Bills WHERE ID_order = ?";
        BillDTO bill = null;

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

        	stmt.setInt(1, code);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	bill = new BillDTO();
                	bill.setId_order(code);
                	bill.setTotal(rs.getFloat("total"));
                	bill.setBillDate(rs.getDate("billDate").toLocalDate());
                }
            }
        }

        return bill;
    }
    

    // Metodo per recuperare tutte le fatture
    public List<BillDTO> findAll() throws SQLException {
        List<BillDTO> bills = new ArrayList<>();
        String query = "SELECT * FROM Bills";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) { 
                
                BillDTO bill = new BillDTO();
                bill.setId_order(rs.getInt("ID_order"));
                bill.setTotal(rs.getFloat("total"));
                bill.setBillDate(rs.getDate("billDate").toLocalDate());
                
                bills.add(bill);
            }
        }

        return bills;
    }
    
}
