package jdbc;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class GetConnection {
	public static Connection connect() throws IOException {
		Connection connection = null;
		
		 // Load properties file
        Properties props = new Properties();
        InputStream input = GetConnection.class.getClassLoader().getResourceAsStream("config.properties");

        props.load(input);
        String url = props.getProperty("db.url");
        String driver = props.getProperty("db.Driver");
        String username = props.getProperty("db.username");
        String password = props.getProperty("db.password");

            // Load MySQL JDBC Driver
            try {
				Class.forName(driver);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

            if (input == null) {
                throw new IOException("Sorry, unable to find config.properties");
            }


            try {
				connection = DriverManager.getConnection(url, username, password);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return connection;
		// TODO Auto-generated method stub

	}
}