<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.sql.*" %>
<%@ page import = "vo.*" %>

<% // session 유효성 검증 코드
	if(session.getAttribute("loginEmpNo") == null) {
		String msg = "로그인 후 접속해주세요.";
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}

	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
	}
%>

<%
	
	Object objLoginEmp = session.getAttribute("loginEmpNo");
	Employee loginEmp = (Employee)objLoginEmp;

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
				<h3><%=loginEmp.getLastName()%>(<%=loginEmp.getEmpNo()%>)님 반갑습니다.</h3>
				
			</div>
			
		</div>
	</body>
</html>