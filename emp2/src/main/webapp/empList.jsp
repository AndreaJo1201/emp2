<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import ="java.util.*" %>

<%
	// session 유효성 검증 코드
	//1) Controller
	if(session.getAttribute("loginEmp") == null) {
		String msg = "로그인 후 접속해주세요.";
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}

	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
	}
	
	Object objLoginEmp = session.getAttribute("loginEmp");
	Employee loginEmp = (Employee)objLoginEmp;
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null && !request.getParameter("currentPage").equals("")) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	String sort = "ASC";
	if(request.getParameter("sort") != null && request.getParameter("sort").equals("DESC")) {
		sort = "DESC";
	}
	
	//2) Model	
	String Driver = "org.mariadb.jdbc.Driver";
	Class.forName(Driver);
	
	String url = "jdbc:mariadb://localhost:3306/employees";
	String user = "root";
	String password = "java1234";
	Connection conn = DriverManager.getConnection(url, user, password);
	
	
/***********************************************페이징***************************************/
	String cntSql = "SELECT COUNT(*) cnt From employees";
	PreparedStatement cntStmt = conn.prepareStatement(cntSql);
	ResultSet cntRs = cntStmt.executeQuery();
	int cnt = 0;
	if(cntRs.next()){
		cnt = cntRs.getInt("cnt");
		if(cnt == 0) {
			cnt = 1;
		}
	}
	
	final int ROW_PER_PAGE = 10;
	
	//lastPage 알고리즘
	int lastPage = cnt / ROW_PER_PAGE;
	if(cnt % ROW_PER_PAGE != 0) {
		lastPage = lastPage + 1;
	}
	
	if(currentPage > lastPage) { // 페이지를 넘어선 다른 수를 입력했을 때 예외(에러) 처리
		String stringMsg = "존재하지 않는 페이지입니다.";
		out.println("<script>alert('"+stringMsg+"');</script>"); // 스크립트 alert(경고메시지) 출력
		currentPage = lastPage;
		System.out.println("go to lastPage");
	} else if(currentPage < 1) {
		String stringMsg = "존재하지 않는 페이지입니다.";
		out.println("<script>alert('"+stringMsg+"');</script>");
		currentPage = 1;
		System.out.println("go to firstPage");
	}
	
	int beginRow = ROW_PER_PAGE * (currentPage-1); //brginRow 알고리즘
	
/**********************************************************************************************/
	//List 출력	
	String sql = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender, CONCAT(first_name,' ',last_name) name FROM employees ORDER BY first_name ASC LIMIT ?, ?";
	if(sort.equals("DESC")) {
		sql = "SELECT emp_no empNo, birth_date birthDate, hire_date hireDate, gender, CONCAT(first_name,' ',last_name) name FROM employees ORDER BY first_name DESC LIMIT ?, ?";
	}
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, beginRow);
	stmt.setInt(2, ROW_PER_PAGE);
	
	ResultSet rs = stmt.executeQuery();
	
	ArrayList<Employee> list = new ArrayList<Employee>();
	int count = 0;
	
	while(rs.next()) {
		Employee e = new Employee();
		e.setEmpNo(rs.getInt("empNo"));
		e.setBirthDate(rs.getString("birthDate"));
		e.setHireDate(rs.getString("hireDate"));
		e.setGender(rs.getString("gender"));
		e.setName(rs.getString("name"));
		list.add(e);
	}
	

%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
		<title>EMP LIST</title>
	</head>

	<body>
		<div class="container">
			
			<div class="text-end">
				<br>
				<a href="<%=request.getContextPath()%>/logout.jsp" class="btn btn-dark">로그아웃</a>
			</div>
			<div class="mt-4 p-5 bg-light text-dark rounded">
				<h1>EMP LIST</h1>
				<br>
				<h6><%=loginEmp.getName()%> (<%=loginEmp.getEmpNo()%>)님 반갑습니다.</h6>
			</div>
			
			<div>
				<table class="table text-center table-bordered table-light">
					<tr>
						<th colspan="5" class="col-sm-12 bg-dark text-light">사원목록</th>
					</tr>
					<tr>
						<th class="col-sm-2">사원번호</th>
						<th class="col-sm-3">
							사원이름
							<%
								if(sort.equals("ASC")) {
							%>
									<a href="<%=request.getContextPath()%>/empList.jsp?&currentPage=<%=currentPage%>&sort=DESC"> [내림차순]</a>
							<%
								} else {
							%>
									<a href="<%=request.getContextPath()%>/empList.jsp?&currentPage=<%=currentPage%>&sort=ASC"> [오름차순]</a>
							<%
								}
							%>
						</th>
						<th class="col-sm-3">입사일</th>
						<th class="col-sm-1">성별</th>
						<th class="col-sm-3">생일</th>
					</tr>
					
					<%
						for(Employee e : list) {
					%>
							<tr>
								<td class="col-sm-2"><%=e.getEmpNo() %></td>
								<td class="col-sm-3"><%=e.getName() %></td>
								<td class="col-sm-3"><%=e.getHireDate() %></td>
								<td class="col-sm-1"><%=e.getGender() %></td>
								<td class="col-sm-3"><%=e.getBirthDate() %></td>
							</tr>
					<%		
						}
					%>
				</table>
			</div>
			
			<div class="d-flex justify-content-center">
				
				<%
					if(sort.equals("ASC")){
				%>
						<!-- paging code -->
						<div class="text-center">
							<a class="btn btn-light" href="<%=request.getContextPath()%>/empList.jsp?currentPage=1&sort=ASC">처음</a>
							<%
								if(currentPage>1) {
							%>
									<a class="btn btn-light" href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=currentPage-1%>&sort=ASC">이전</a>
							<%
								}
							%>
							<span style="text-align:center" class="text-center"><%=currentPage %> / <%=lastPage %></span>
							<%
								if(currentPage<lastPage) {
							%>
									<a class="btn btn-light" href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=currentPage+1%>&sort=ASC">다음</a>
							<%		
								}
							%>
							<a class="btn btn-light" href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=lastPage%>&sort=ASC">끝</a>
						</div>
				<%
					} else {
				%>
						<div class="text-center">
							<a class="btn btn-light" href="<%=request.getContextPath()%>/empList.jsp?currentPage=1&sort=DESC">처음</a>
							<%
								if(currentPage>1) {
							%>
									<a class="btn btn-light" href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=currentPage-1%>&sort=DESC">이전</a>
							<%
								}
							%>
							<span style="text-align:center" class="text-center"><%=currentPage %> / <%=lastPage %></span>
							<%
								if(currentPage<lastPage) {
							%>
									<a class="btn btn-light" href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=currentPage+1%>&sort=DESC">다음</a>
							<%		
								}
							%>
							<a class="btn btn-light" href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=lastPage%>&sort=DESC">끝</a>
						</div>
				<%		
					}
				%>
					
			</div>
				
			<div class="text-center">
				<%
					if(sort.equals("ASC")) {
				%>
						<form action="<%=request.getContextPath()%>/empList.jsp?&sort=ASC" method="post" class="text-center">
							<input type="text" name="currentPage" value="" placeholder="이동하려는 page 번호" style="width:200px" class="text-center">
							<button class="btn btn-dark" type="submit">이동</button>
						</form>
				<%
					} else {
				%>
						<form action="<%=request.getContextPath()%>/empList.jsp?&sort=DESC" method="post" class="text-center">
							<input type="text" name="currentPage" value="" placeholder="이동하려는 page 번호" style="width:200px" class="text-center">
							<button class="btn btn-dark" type="submit">이동</button>
						</form>
				<%
					}
				%>
				
			</div>
			
		</div>
	</body>
</html>