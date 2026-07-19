package com.proqik.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {
    
    private static String ORACLE_DRIVER = "oracle.jdbc.driver.OracleDriver";
    private static String DB_HOST;
    private static String DB_PORT;
    private static String DB_SERVICE;
    private static String DB_USER;
    private static String DB_PASSWORD;
    private static String WALLET_PATH;
    private static String WALLET_PASSWORD;
    
    private static Connection connection = null;
    private static boolean initialized = false;
    
    private static void initConfig() {
        if (initialized) return;
        
        // Load from environment variables or properties file
        Properties props = new Properties();
        try (InputStream is = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (is != null) {
                props.load(is);
            }
        } catch (Exception e) {
            System.out.println("Could not load db.properties: " + e.getMessage());
        }
        
        // Environment variables take priority
        DB_HOST = System.getenv("DB_HOST") != null ? System.getenv("DB_HOST") : 
                  (props.getProperty("DB_HOST", "adb.ap-hyderabad-1.oraclecloud.com"));
        DB_PORT = System.getenv("DB_PORT") != null ? System.getenv("DB_PORT") : 
                  (props.getProperty("DB_PORT", "1522"));
        DB_SERVICE = System.getenv("DB_SERVICE") != null ? System.getenv("DB_SERVICE") : 
                     (props.getProperty("DB_SERVICE", "gf466db25af47b2_nebula_tp.adb.oraclecloud.com"));
        DB_USER = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : 
                  (props.getProperty("DB_USER", ""));
        DB_PASSWORD = System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : 
                       (props.getProperty("DB_PASSWORD", ""));
        
        // Wallet path - check environment, then properties, then resolve from classpath
        String walletProp = props.getProperty("WALLET_PATH", "wallet");
        WALLET_PATH = System.getenv("WALLET_PATH");
        if (WALLET_PATH == null) {
            WALLET_PATH = walletProp;
            try {
                java.net.URL walletUrl = DBConnection.class.getClassLoader().getResource("wallet/truststore.jks");
                if (walletUrl != null) {
                    String absPath = java.net.URLDecoder.decode(walletUrl.getPath(), "UTF-8");
                    if (absPath.startsWith("/") && absPath.charAt(2) == ':') absPath = absPath.substring(1);
                    WALLET_PATH = absPath.replace("/truststore.jks", "").replace("\\truststore.jks", "");
                    System.out.println("Wallet path resolved: " + WALLET_PATH);
                } else {
                    System.out.println("Wallet URL null, using default: " + WALLET_PATH);
                }
            } catch (Exception e) {
                System.out.println("Wallet resolution error: " + e.getMessage());
            }
        }
        
        // Wallet password from environment or properties
        WALLET_PASSWORD = System.getenv("WALLET_PASSWORD") != null ? System.getenv("WALLET_PASSWORD") : 
                          (props.getProperty("WALLET_PASSWORD", ""));
        
        initialized = true;
    }
    
    static {
        initConfig();
        try {
            Class.forName(ORACLE_DRIVER);
            System.out.println("Oracle JDBC Driver loaded");
        } catch (ClassNotFoundException e) {
            System.out.println("Oracle JDBC Driver not found: " + e.getMessage());
        }
    }
    
    public static Connection getConnection() throws SQLException {
        initConfig();
        if (connection == null || connection.isClosed()) {
            
            String url = "jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCPS)(PORT=1522)(HOST=" + DB_HOST + "))(CONNECT_DATA=(SERVICE_NAME=" + DB_SERVICE + "))(SECURITY=(SSL_SERVER_DN_MATCH=yes)))";
            
            System.out.println("Connecting to Oracle Cloud DB...");
            
            Properties props = new Properties();
            props.setProperty("user", DB_USER);
            props.setProperty("password", DB_PASSWORD);
            
            if (WALLET_PATH != null && !WALLET_PATH.isEmpty()) {
                props.setProperty("javax.net.ssl.trustStore", WALLET_PATH + "/truststore.jks");
                props.setProperty("javax.net.ssl.trustStorePassword", WALLET_PASSWORD);
                props.setProperty("javax.net.ssl.keyStore", WALLET_PATH + "/keystore.jks");
                props.setProperty("javax.net.ssl.keyStorePassword", WALLET_PASSWORD);
            }
            
            connection = DriverManager.getConnection(url, props);
            System.out.println("✓ Database connected successfully!");
        }
        return connection;
    }
    
    public static void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("Database connection closed.");
            }
        } catch (SQLException e) {
            System.out.println("Error closing connection: " + e.getMessage());
        }
    }
    
    public static boolean testConnection() {
        try {
            Connection conn = getConnection();
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            System.out.println("Connection test failed: " + e.getMessage());
            return false;
        }
    }
}
