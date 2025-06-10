package model.Order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import model.DataSourceManager;
import model.Status;

public class OrderDAO {
    private DataSource dataSource;
	
	public OrderDAO() {
        this.dataSource = DataSourceManager.getDataSource();
        if (this.dataSource == null) {
            throw new IllegalStateException("OrderDAO: DataSource is null! Check DataSourceManager.");
        }
    }

 // Metodo per salvare un ordine nel database
    public void save(OrderDTO order) throws SQLException {
        String query = "INSERT INTO Orders (ID_user, orderDate, status) VALUES (?, ?, ?)";
        
        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, order.getId_user());
            stmt.setDate(2, java.sql.Date.valueOf(order.getOrderDate()));
            stmt.setString(3, order.getStatus().name());
          
            stmt.executeUpdate();

            // Recupera l'ID generato automaticamente (se presente)
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    order.setId(generatedKeys.getInt(1)); // Imposta l'ID nel DTO
                }
            }

        } catch (SQLException e) {
            System.out.println("Errore durante il salvataggio dell'utente: " + e.getMessage());
            throw e; // rilancia l'eccezione se necessario
        }
    }


    // Metodo per recuperare un ordine per codice
    public OrderDTO findByCode(int code) throws SQLException {
        String query = "SELECT * FROM Orders WHERE ID = ?";
        OrderDTO order = null;

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

        	stmt.setInt(1, code);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	order = new OrderDTO();
                	order.setId(rs.getInt("ID"));
                	order.setId_user(rs.getInt("ID_user"));
                	order.setOrderDate(rs.getDate("orderDate").toLocalDate());
                	order.setStatus(Status.valueOf(rs.getString("status")));
                }
            }
        }

        return order;
    }

    // Metodo per recuperare tutti gli ordini
    public List<OrderDTO> findAll() throws SQLException {
        List<OrderDTO> orders = new ArrayList<>();
        String query = "SELECT * FROM Orders";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
    	
            while (rs.next()) { 
           
                OrderDTO order = new OrderDTO();
                order.setId(rs.getInt("ID"));
                order.setId_user(rs.getInt("ID_user"));
            	order.setOrderDate(rs.getDate("orderDate").toLocalDate());
            	order.setStatus(Status.valueOf(rs.getString("status")));
                
                orders.add(order);
            }
        }
       
        return orders;
    }

    public List<OrderDTO> findByUserCode(int u_code) throws SQLException {
        String query = "SELECT * FROM Orders WHERE ID_user = ?"; // filtro per utente, non per ID ordine
        List<OrderDTO> orders = new ArrayList<>();

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, u_code);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    OrderDTO order = new OrderDTO();
                    order.setId(rs.getInt("ID"));
                    order.setId_user(rs.getInt("ID_user"));
                    order.setOrderDate(rs.getDate("orderDate").toLocalDate());
                    order.setStatus(Status.valueOf(rs.getString("status")));

                    orders.add(order);
                }
            }
        }
        return orders;
    }


    // Metodo per aggiornare un ordine nel database
    public boolean update(OrderDTO order) throws SQLException {
        String query = "UPDATE Orders SET ID_user=?, orderDate=?, status=? WHERE ID=?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

        	stmt.setInt(1, order.getId_user());
            stmt.setDate(2, java.sql.Date.valueOf(order.getOrderDate()));
            stmt.setString(3, order.getStatus().name());
            stmt.setInt(4, order.getId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
    
    // Metodo per aggiornare lo stato di un ordine nel database
    public boolean updateStatus(int idOrder, Status newStatus) throws SQLException {
        String query = "UPDATE Orders SET status=? WHERE ID=?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, newStatus.name());
            stmt.setInt(2, idOrder);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public List<OrderDTO> getFilteredOrders(LocalDate from, LocalDate to, Integer userId) {
        List<OrderDTO> orders = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM orders WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (from != null) {
            query.append(" AND orderDate >= ?");
            params.add(from);
        }

        if (to != null) {
            query.append(" AND orderDate <= ?");
            params.add(to);
        }

        if (userId != null) {
            query.append(" AND ID_user = ?");
            params.add(userId);
        }

        try (Connection connection = dataSource.getConnection();
                PreparedStatement stmt = connection.prepareStatement(query.toString())) {
        	
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
            	OrderDTO order = new OrderDTO();
                order.setId(rs.getInt("ID"));
                order.setId_user(rs.getInt("ID_user"));
            	order.setOrderDate(rs.getDate("orderDate").toLocalDate());
            	order.setStatus(Status.valueOf(rs.getString("status")));
                
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }
}
