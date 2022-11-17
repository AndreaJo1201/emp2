<%@page import="java.net.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="vo.*" %>

<%	
	// 1) controller
	//session 유효성 검증 코드 후 필요하다면 sendRedirect()
	
	if(session.getAttribute("loginEmpNo") != null) {
		response.sendRedirect(request.getContextPath()+"/empList.jsp");
		return;
	}
	
	if(request.getParameter("empNo") == null ||
		request.getParameter("empNo").equals("") ||
		request.getParameter("firstName") == null ||
		request.getParameter("firstName").equals("") ||
		request.getParameter("lastName") == null ||
		request.getParameter("lastName").equals("")) {
			String msg = "로그인 정보를 입력해주세요.";
			response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
			return;
	}
	
	int empNo = Integer.parseInt(request.getParameter("empNo"));
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	
	Employee employee = new Employee();
	employee.setEmpNo(empNo);
	employee.setFirstName(firstName);
	employee.setLastName(lastName);
	
	
	//2) model
	String driver = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://localhost:3306/employees";
	String user = "root";
	String password = "java1234";
	
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(url, user, password);
	/*
		SELECT emp_no empNo, last_name lastName
		FROM employee
		WHERE emp_no = ? AND first_name = ? AND last_name = ?
	
	*/
	String sql = "SELECT emp_no empNo, last_name lastName FROM employees WHERE emp_no = ? AND first_name = ? AND last_name = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, employee.getEmpNo());
	stmt.setString(2, employee.getFirstName());
	stmt.setString(3, employee.getLastName());
	
	ResultSet rs = stmt.executeQuery();
	String targetUrl = "/loginForm.jsp?&msg=";
	String msg = "로그인 실패";
	
	if(rs.next()) {
		//로그인 성공
		Employee loginEmp = new Employee();
		loginEmp.setEmpNo(rs.getInt("empNo"));
		loginEmp.setLastName(rs.getString("lastName"));
		
		session.setAttribute("loginEmpNo", loginEmp); // 키 : "loginEmpNo", 값 : Object object = loginEmp;
		targetUrl = "/empList.jsp?&msg=";
		msg = "로그인 성공";
	}
	
	rs.close();
	stmt.close();
	conn.close();
	response.sendRedirect(request.getContextPath()+targetUrl+URLEncoder.encode(msg,"UTF-8"));
	
	
	//3) view
%>