<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@page import="java.sql.*" %>

<% // session 유효성 검증 코드
	if(session.getAttribute("loginEmpNo") != null) {
		response.sendRedirect(request.getContextPath()+"/empList.jsp");
		return;
	}
%>

<%
	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>	
		<title>LOGIN</title>
	</head>

	<body>
		<div class="container text-center">
			<div class="mt-4 p-5 bg-light text-dark rounded">
				<h1>Employee LogIn</h1>
			</div>
			<form action="<%=request.getContextPath()%>/login/loginAction.jsp" class="align_middle">
				<table class="table table-sm table-borderless">
					<tr class="text-center">
						<td>사원번호(empNo)</td>
						<td><input type="text" name="empNo"></td>
					</tr>
					
					<tr class="text-center">
						<td>이름(firstName)</td>
						<td><input type="text" name="firstName"></td>
					</tr>
					
					<tr class="text-center">
						<td>성(lastName)</td>
						<td><input type="text" name="lastName"></td>
					</tr>
				</table>
				<button type="submit" class="btn btn-dark">로그인</button>
			</form>
			
		</div>
	</body>
</html>