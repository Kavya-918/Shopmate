package hk.shoppingcart.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	private static Connection connection = null;

	public static Connection getConnection() throws ClassNotFoundException, SQLException {
		if (connection == null || connection.isClosed()) {
			// Load MySQL JDBC Driver
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/shoppingcart", "root", "9418");
			System.out.println("Connected to the database");
		}
		return connection;
	}
}
