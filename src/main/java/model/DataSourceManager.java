package model;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DataSourceManager {

    // Metodo per ottenere il DataSource
    public static DataSource getDataSource() {
        DataSource dataSource = null;
        try {
            // Creazione del contesto JNDI per recuperare il DataSource
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env"); // Ambiente JNDI

            // Recupera il DataSource dal contesto JNDI
            dataSource = (DataSource) envCtx.lookup("jdbc/storage"); // Nome del DataSource definito in web.xml

        } catch (NamingException e) {
            System.out.println("Errore nella configurazione del DataSource: " + e.getMessage());
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