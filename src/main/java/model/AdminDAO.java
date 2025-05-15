package model;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;

public class AdminDAO {

    private DataSource dataSource;
	
	public AdminDAO() {
        this.dataSource = DataSourceManager.getDataSource();
    }

    // Metodo per verificare le credenziali di un admin
    public boolean isAdmin(AdminDTO admin) throws SQLException {
        String query = "SELECT * FROM Users WHERE username = ? AND password = ?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

        	stmt.setString(1, admin.getUsername());
        	stmt.setString(2, admin.getPassword());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	return true;
                }
            }
        }

        return false;
    }

    // Metodo per recuperare tutti gli admin
    public List<AdminDTO> findAll() throws SQLException {
        List<AdminDTO> admins = new ArrayList<>();
        String query = "SELECT * FROM Admin";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
    	
            while (rs.next()) { 
           
            	AdminDTO admin = new AdminDTO();
                admin.setUsername(rs.getString("username"));
                admin.setPassword(rs.getString("password"));
                
                admins.add(admin);
            }
        }
        return admins;
    }
}
