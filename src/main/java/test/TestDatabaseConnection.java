package test;

import com.mysql.cj.jdbc.MysqlDataSource;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class TestDatabaseConnection {

    public static void main(String[] args) {
    	DataSource dataSource = new MysqlDataSource();
        ((MysqlDataSource) dataSource).setURL("jdbc:mysql://localhost:3306/storage");
        ((MysqlDataSource) dataSource).setUser("user");
        ((MysqlDataSource) dataSource).setPassword("12345678");

        try (Connection connection = dataSource.getConnection()) {
            System.out.println("Connessione al database riuscita!");
        } catch (SQLException e) {
            System.out.println("Errore nella connessione al database: " + e.getMessage());
        }
    }
}