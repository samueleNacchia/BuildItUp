package model;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DataSourceManager {
	private static DataSource dataSource;
	

    // Metodo per ottenere il DataSource
	public static synchronized DataSource getDataSource() {
        if (dataSource == null) {
            try {
                Context initCtx = new InitialContext();
                Context envCtx = (Context) initCtx.lookup("java:comp/env");
                dataSource = (DataSource) envCtx.lookup("jdbc/storage");
                if (dataSource == null) {
                    throw new IllegalStateException("DataSource non trovato nel JNDI!");
                }
            } catch (NamingException e) {
                throw new IllegalStateException("Errore nella configurazione del DataSource: " + e.getMessage(), e);
            }
        }
        return dataSource;
    }

    // Metodo per ottenere una connessione dal DataSource
    public static Connection getConnection() throws SQLException {
        DataSource dataSource = getDataSource();
        if (dataSource != null) {
            System.out.println("Connessione al database riuscita!");
            return dataSource.getConnection(); // Restituisce una connessione al database
        }
        throw new SQLException("DataSource non trovato!");
    }
}