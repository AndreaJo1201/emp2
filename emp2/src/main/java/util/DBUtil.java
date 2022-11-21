package util;

import java.sql.Connection;
import java.sql.DriverManager;

import vo.DataBase;

public class DBUtil {
	public Connection getConnection() throws Exception {
		DataBase db = new DataBase();
		
		Class.forName(db.getDriver());
		System.out.println("Driver Loading COMPLETE!");
		
		Connection conn = DriverManager.getConnection(db.getUrl(), db.getUser(), db.getPassword());
		System.out.println("DB Connection COMPLETE");
		
		return conn;
	}
}
