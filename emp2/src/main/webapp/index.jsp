<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.net.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="util.*" %>

<%
	// session 유효성 검증 코드
	//1) Controller
	if(session.getAttribute("loginEmp") == null) {
		String msg = "로그인 후 접속해주세요.";
		response.sendRedirect(request.getContextPath()+"/login/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	
	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
	}
	
	Object objLoginEmp = session.getAttribute("loginEmp");
	Employee loginEmp = (Employee)objLoginEmp;
	
	//2) Model
/*
	DBUtil dbUtil = new DBUtil();
	Connection conn = dbUtil.getConnection();
	
	conn.close();
*/
	

%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
		<title>index</title>
	</head>

	<body>
		<div class="container">
			
			<div class="text-end">
				<br>
				<a href="<%=request.getContextPath()%>/logout.jsp" class="btn btn-dark">로그아웃</a>
			</div>
		
			<div class="mt-4 p-5 bg-primary text-white rounded">
				<h1>INDEX</h1>
				<br>
				<h6><%=loginEmp.getName()%> (<%=loginEmp.getEmpNo()%>)님 반갑습니다.</h6>
			</div>
			
			<div>
				<jsp:include page="/inc/menu.jsp"></jsp:include>
			</div>
			
			<div>
				<ul class="list-group list-group-numbered">
					<li><a href="<%=request.getContextPath()%>/emp/empList.jsp" class="list-group-item list-group-item-action">사원 목록</a></li>
				</ul>
			</div>
		</div>
	</body>
</html> 