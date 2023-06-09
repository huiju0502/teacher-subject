<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import="dao.*"%>
<%@ page import = "vo.*" %>
<%
	//현재 페이지 
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	//클래스 객체 생성
	TeacherDao dao = new TeacherDao();
	// 전체행의 수 
	int totalRow = dao.selectTeacherCnt();
	// 페이지당 행의 수
	int rowPerPage = 10;
	// 시작 행 번호
	int beginRow = (currentPage-1) * rowPerPage;
	int endRow = beginRow + (rowPerPage - 1);
	if(endRow > totalRow) {
			endRow = totalRow;
	}
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
		
	ArrayList<HashMap<String, Object>> list  = dao.selectTeacherListByPage(beginRow, rowPerPage);
	
	// 페이지 네비게이션 페이징
	int pagePerPage = 10;
			
	int minPage = (((currentPage-1) / pagePerPage) * pagePerPage) + 1;
	int maxPage = minPage + (pagePerPage - 1);
	if(maxPage > lastPage) {
		maxPage = lastPage;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container mt-3 text-center" >
	<table class="table">
	<thead class="table-warning">
		<tr>
			<th>Teacher No</th>
			<th>Teacher ID</th>
			<th>Teacher Name</th>
			<th>Subject Name</th>
		</tr>
	</thead>
		<%
			for(HashMap<String, Object> t : list) {
		%>
		<tr>
			<td><%=t.get("teacherNo") %></td>
			<td><%=t.get("teacherId") %></td>
			<td><a href="<%=request.getContextPath() %>/teacher/teacherListOne.jsp?teacherNo=<%=t.get("teacherNo") %>"><%=t.get("teacherName") %></a></td>
			<td><%=t.get("subjectName") %></td>
		</tr>
		<%
			}
		%>
	</table>
	
	<%
		if(minPage > 1) {
	%>
			<a href="<%=request.getContextPath() %>/teacher/teacherList.jsp?currentPage=<%=minPage-pagePerPage%>">이전</a>	
	<%
		}
		
		for(int i = minPage; i<=maxPage; i=i+1) {
			if(i == currentPage) {
	%>
				<span><%=i%></span>&nbsp;
	<%			
			} else {		
	%>
				<a href="<%=request.getContextPath() %>/teacher/teacherList.jsp?currentPage=<%=i%>"><%=i%></a>&nbsp;	
	<%	
			}
		}
		
		if(maxPage != lastPage) {
	%>
			<!--  maxPage + 1 -->
			<a href="<%=request.getContextPath() %>/teacher/teacherList.jsp?currentPage=<%=minPage+pagePerPage%>">다음</a>
	<%
		}
   	%>
</div>

</body>
</html>