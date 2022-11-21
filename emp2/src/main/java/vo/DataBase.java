package vo;

public class DataBase {
	private String url = "jdbc:mariadb://localhost:3306/employees";
	private String user = "root";
	private String password = "java1234";
	private String driver = "org.mariadb.jdbc:Driver";
	
	
	public String getUrl() {
		return url;
	}

	public String getUser() {
		return user;
	}
	public String getPassword() {
		return password;
	}

	public String getDriver() {
		return driver;
	}

}
