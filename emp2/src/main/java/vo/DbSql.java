package vo;

public class DbSql {
	
	private String sql;
	private String cntSql;
	
	public String sqlQuery(String noSort, String sort, String word) { //word가 입력되었을때,
		sql = null;
		
		if(word == null) {
			if(noSort.equals("DESC")) {
				sql = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender gender, CONCAT(first_name,' ',last_name) name FROM employees ORDER BY emp_no DESC LIMIT ?, ?";
				if(sort.equals("DESC")) {
					sql = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender gender, CONCAT(first_name,' ',last_name) name FROM employees ORDER BY CONCAT(first_name,' ',last_name) DESC, emp_no DESC LIMIT ?, ?";
				} else if(sort.equals("ASC")){
					sql = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender gender, CONCAT(first_name,' ',last_name) name FROM employees ORDER BY CONCAT(first_name,' ',last_name), emp_no DESC LIMIT ?, ?";
				}
		
			} else {
				sql = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender gender, CONCAT(first_name,' ',last_name) name FROM employees ORDER BY emp_no ASC LIMIT ?, ?";
				if(sort.equals("DESC")) {
					sql = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender gender, CONCAT(first_name,' ',last_name) name FROM employees ORDER BY CONCAT(first_name,' ',last_name) DESC, emp_no ASC LIMIT ?, ?";
				} else if(sort.equals("ASC")){
					sql = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender gender, CONCAT(first_name,' ',last_name) name FROM employees ORDER BY CONCAT(first_name,' ',last_name), emp_no ASC LIMIT ?, ?";
				}
			}
		} else {
			if(noSort.equals("DESC")) {
				sql = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender gender, CONCAT(first_name,' ',last_name) name FROM employees WHERE CONCAT(first_name,' ',last_name) LIKE ? ORDER BY emp_no DESC LIMIT ?, ?";
				if(sort.equals("DESC")) {
					sql = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender gender, CONCAT(first_name,' ',last_name) name FROM employees WHERE CONCAT(first_name,' ',last_name) LIKE ? ORDER BY CONCAT(first_name,' ',last_name) DESC, emp_no DESC LIMIT ?, ?";
				} else if(sort.equals("ASC")){
					sql = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender gender, CONCAT(first_name,' ',last_name) name FROM employees WHERE CONCAT(first_name,' ',last_name) LIKE ? ORDER BY CONCAT(first_name,' ',last_name), emp_no DESC LIMIT ?, ?";
				}
		
			} else {
				sql = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender gender, CONCAT(first_name,' ',last_name) name FROM employees WHERE CONCAT(first_name,' ',last_name) LIKE ? ORDER BY emp_no ASC LIMIT ?, ?";
				if(sort.equals("DESC")) {
					sql = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender gender, CONCAT(first_name,' ',last_name) name FROM employees WHERE CONCAT(first_name,' ',last_name) LIKE ? ORDER BY CONCAT(first_name,' ',last_name) DESC, emp_no ASC LIMIT ?, ?";
				} else if(sort.equals("ASC")){
					sql = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender gender, CONCAT(first_name,' ',last_name) name FROM employees WHERE CONCAT(first_name,' ',last_name) LIKE ? ORDER BY CONCAT(first_name,' ',last_name), emp_no ASC LIMIT ?, ?";
				}
			}
		}
		return sql;
	}
	
	public String cntSql(String word) {
		cntSql = null;
		if(word == null) {
			cntSql = "SELECT COUNT(*) cnt From employees";
		} else {
			cntSql = "SELECT COUNT(*) cnt From employees WHERE CONCAT(first_name,' ',last_name) LIKE ?";
		}
		return cntSql;
	}
}
