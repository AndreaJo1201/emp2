<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	session.invalidate();
	String msg = "๋ก๊ทธ์์";
	response.sendRedirect(request.getContextPath()+"/login/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
%>