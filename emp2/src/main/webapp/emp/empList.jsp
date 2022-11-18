<%@page import="java.net.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import ="java.util.*" %>

<%
	//1) Controller

	//session 유효성 검증 코드
	if(session.getAttribute("loginEmp") == null) {
		String msg = "로그인 후 접속해주세요.";
		response.sendRedirect(request.getContextPath()+"/login/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	
	//전달받은 msg 출력
	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
	}
	
	//session 값 저장
	Object objLoginEmp = session.getAttribute("loginEmp");
	Employee loginEmp = (Employee)objLoginEmp;
	
	
	//현재 페이지 확인
	int currentPage = 1;
	if(request.getParameter("currentPage") != null && !request.getParameter("currentPage").equals("")) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	//페이지 당 출력할 사이즈
	final int ROW_PER_PAGE = 10;
	
	System.out.println("debug currentPage : "+currentPage);
	
	
	//오름차순 내림차순 정렬 선택
	String sort = "null";
	String noSort = "ASC";
	if(request.getParameter("sort") != null && request.getParameter("sort").equals("DESC")) {
		sort = "DESC";
		if(request.getParameter("noSort") != null && request.getParameter("noSort").equals("DESC")) {
			noSort = "DESC";
		}
	} else if(request.getParameter("sort") != null && request.getParameter("sort").equals("ASC")) {
		sort = "ASC";
		if(request.getParameter("noSort") != null && request.getParameter("noSort").equals("DESC")) {
			noSort = "DESC";
		}
	} else {
		if(request.getParameter("noSort") != null && request.getParameter("noSort").equals("DESC")) {
			noSort = "DESC";
		}
	}
	
	System.out.println("debug sort & noSort : "+sort+","+noSort);
	
	//검색 단어 확인
	String word = null;
	if(request.getParameter("word") != null && !request.getParameter("word").equals("") && !request.getParameter("word").equals("null")) {
		word = request.getParameter("word");
	}
	System.out.println("debug word : "+word);
	
	/*
	//sql 문구 캡슐화 및 정보은닉한 class
	DbSql dbSql = new DbSql();
	*/
	
	//2) Model
	EmpDao selectEmpList = new EmpDao();
	ArrayList<Employee> list = selectEmpList.selectEmpList(currentPage, ROW_PER_PAGE, noSort, sort, word);
	ArrayList<Paging> pageList = selectEmpList.countPageList(currentPage, ROW_PER_PAGE, word);
	
	

	/*
	if(list.getStringMsg() != null) {
		out.println("<script>alert('"+paging.getStringMsg()+"');</script>");
	}
	*/

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
			
			<div class="clearfix">
				<br>
				<a href="<%=request.getContextPath()%>/emp/myEmpData.jsp" class="btn btn-info text-light float-start">내 정보</a>
				<a href="<%=request.getContextPath()%>/login/logout.jsp" class="btn btn-dark float-end">로그아웃</a>
			</div>
			
			<div class="mt-4 p-5 bg-light text-dark rounded">
				<h1>EMP LIST</h1>
			</div>
			
			<div>
				<table class="table text-center table-bordered table-light">
					<tr>
						<th colspan="5" class="col-sm-12 bg-dark text-light">사원목록</th>
					</tr>
					<tr>
						<th class="col-sm-2">
							사원번호
							<%
								if(noSort.equals("ASC")) {
							%>
									<a href="<%=request.getContextPath()%>/emp/empList.jsp?&currentPage=<%=currentPage%>&sort=<%=sort %>&noSort=DESC&word=<%=word%>"> [내림차순]</a>
							<%
								} else {
							%>
									<a href="<%=request.getContextPath()%>/emp/empList.jsp?&currentPage=<%=currentPage%>&sort=<%=sort %>&noSort=ASC&word=<%=word%>"> [오름차순]</a>
							<%
								}
							%>
						</th>
						<th class="col-sm-3">
							사원이름
							<%
								if(sort.equals("ASC")) {
							%>
									<a href="<%=request.getContextPath()%>/emp/empList.jsp?&currentPage=<%=currentPage%>&sort=DESC&noSort=<%=noSort%>&word=<%=word%>"> [내림차순]</a>
							<%
								} else {
							%>
									<a href="<%=request.getContextPath()%>/emp/empList.jsp?&currentPage=<%=currentPage%>&sort=ASC&noSort=<%=noSort%>&word=<%=word%>"> [오름차순]</a>
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
			
			<div class="d-flex justify-content-between">
			
				<div>
					<a href="<%=request.getContextPath()%>/index.jsp" class="btn btn-dark text-white text-end">Insert</a>
				</div>
				
				<!-- paging code -->
				<div class="text-center">
					<a class="btn btn-light" href="<%=request.getContextPath()%>/emp/empList.jsp?currentPage=1&sort=<%=sort %>&noSort=<%=noSort%>&word=<%=word%>">처음</a>
					<%
						if(currentPage>1) {
					%>
							<a class="btn btn-light" href="<%=request.getContextPath()%>/emp/empList.jsp?currentPage=<%=currentPage-1%>&sort=<%=sort %>&noSort=<%=noSort%>&word=<%=word%>">이전</a>
					<%
						}
					%>
					<span style="text-align:center" class="text-center"><%=currentPage %> / <%=p.getLastPage()%></span>
					<%
						if(currentPage<paging.getLastPage()) {
					%>
							<a class="btn btn-light" href="<%=request.getContextPath()%>/emp/empList.jsp?currentPage=<%=currentPage+1%>&sort=<%=sort %>&noSort=<%=noSort%>&word=<%=word%>">다음</a>
					<%		
						}
					%>
					<a class="btn btn-light" href="<%=request.getContextPath()%>/emp/empList.jsp?currentPage=<%=paging.getLastPage()%>&sort=<%=sort %>&noSort=<%=noSort%>&word=<%=word%>">끝</a>
				</div>
				
				<div>
					<a href="<%=request.getContextPath()%>/index.jsp" class="btn btn-dark text-white text-end">Back</a>
				</div>
			</div>
				
			<br>
				
			<div class="text-center">
				<form action="<%=request.getContextPath()%>/emp/empList.jsp?&sort=<%=sort%>&noSort=<%=noSort %>" method="post" class="text-center">
					<input type="text" name="currentPage" value="" placeholder="이동하려는 page 번호" style="width:200px" class="text-center">
					<button class="btn btn-dark" type="submit">이동</button>
				</form>
			</div>
			
			<div class="text-center">
				<form action="<%=request.getContextPath()%>/emp/empList.jsp?&noSort=<%=noSort%>" method="post" class="text-center">
					<input type="text" name="word" value="" placeholder="검색 단어" style="width:200px" class="text-center" id="word">
					<button class="btn btn-dark" type="submit">검색</button>
				</form>
			</div>
			
		</div>
	</body>
</html>