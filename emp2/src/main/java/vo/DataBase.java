package vo;

public class DataBase {
	private String url = "jdbc:mariadb://localhost:3306/employees";
	private String user = "root";
	private String password = "java1234";
	
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
}
