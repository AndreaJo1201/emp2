package vo;

public class DbSql {
	
	public String sqlSelectList(String noSort, String sort, String word) { //word가 입력되었을때,
		String sqlSelectList = null;
		
		if(word == null) {
			if(noSort.equals("DESC")) {
				sqlSelectList = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender gender, CONCAT(first_name,' ',last_name) name FROM employees ORDER BY emp_no DESC LIMIT ?, ?";
				if(sort.equals("DESC")) {
					sqlSelectList = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender gender, CONCAT(first_name,' ',last_name) name FROM employees ORDER BY CONCAT(first_name,' ',last_name) DESC, emp_no DESC LIMIT ?, ?";
				} else if(sort.equals("ASC")){
					sqlSelectList = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender gender, CONCAT(first_name,' ',last_name) name FROM employees ORDER BY CONCAT(first_name,' ',last_name), emp_no DESC LIMIT ?, ?";
				}
		
			} else {
				sqlSelectList = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender gender, CONCAT(first_name,' ',last_name) name FROM employees ORDER BY emp_no ASC LIMIT ?, ?";
				if(sort.equals("DESC")) {
					sqlSelectList = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender gender, CONCAT(first_name,' ',last_name) name FROM employees ORDER BY CONCAT(first_name,' ',last_name) DESC, emp_no ASC LIMIT ?, ?";
				} else if(sort.equals("ASC")){
					sqlSelectList = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender gender, CONCAT(first_name,' ',last_name) name FROM employees ORDER BY CONCAT(first_name,' ',last_name), emp_no ASC LIMIT ?, ?";
				}
			}
		} else {
			if(noSort.equals("DESC")) {
				sqlSelectList = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender gender, CONCAT(first_name,' ',last_name) name FROM employees WHERE CONCAT(first_name,' ',last_name) LIKE ? ORDER BY emp_no DESC LIMIT ?, ?";
				if(sort.equals("DESC")) {
					sqlSelectList = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender gender, CONCAT(first_name,' ',last_name) name FROM employees WHERE CONCAT(first_name,' ',last_name) LIKE ? ORDER BY CONCAT(first_name,' ',last_name) DESC, emp_no DESC LIMIT ?, ?";
				} else if(sort.equals("ASC")){
					sqlSelectList = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender gender, CONCAT(first_name,' ',last_name) name FROM employees WHERE CONCAT(first_name,' ',last_name) LIKE ? ORDER BY CONCAT(first_name,' ',last_name), emp_no DESC LIMIT ?, ?";
				}
		
			} else {
				sqlSelectList = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender gender, CONCAT(first_name,' ',last_name) name FROM employees WHERE CONCAT(first_name,' ',last_name) LIKE ? ORDER BY emp_no ASC LIMIT ?, ?";
				if(sort.equals("DESC")) {
					sqlSelectList = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender gender, CONCAT(first_name,' ',last_name) name FROM employees WHERE CONCAT(first_name,' ',last_name) LIKE ? ORDER BY CONCAT(first_name,' ',last_name) DESC, emp_no ASC LIMIT ?, ?";
				} else if(sort.equals("ASC")){
					sqlSelectList = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender gender, CONCAT(first_name,' ',last_name) name FROM employees WHERE CONCAT(first_name,' ',last_name) LIKE ? ORDER BY CONCAT(first_name,' ',last_name), emp_no ASC LIMIT ?, ?";
				}
			}
		}
		return sqlSelectList;
	}
	
	public String sqlCnt(String word) {
		String sqlCnt = null;
		if(word == null) {
			sqlCnt = "SELECT COUNT(*) cnt From employees";
		} else {
			sqlCnt = "SELECT COUNT(*) cnt From employees WHERE CONCAT(first_name,' ',last_name) LIKE ?";
		}
		return sqlCnt;
	}
	
	/*
	public String sqlLogin(int empNo, String firstName, String lastName) {
		String sqlLogin = null;
	}
	*/
}
