<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import="dao.*"%>
<%@ page import = "vo.*" %>
<%
	// 현재 페이지 
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	// 클래스 객체 생성
	SubjectDao dao = new SubjectDao();
	// 전체행의 수 
	int totalRow = dao.selectSubjectCnt();
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
	
	ArrayList<Subject> list = dao.selectSubjectListByPage(beginRow, rowPerPage);
	
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
<div class="container mt-3">
	<a href="<%=request.getContextPath() %>/subject/addSubject.jsp"><button type="button" class="btn btn-warning">추가</button></a>
	<table class="table text-center">
	<thead class="table-warning">
		<tr>
			<th>Subject No</th>
			<th>Subject Name</th>
			<th>Subject Time</th>
		</tr>
	</thead>
	<tbody>
		<%
			for(Subject s : list) {
		%>
		<tr>
			<td><%=s.getSubjectNo() %></td>
			<td><a href="<%=request.getContextPath() %>/subject/subjectListOne.jsp?subjectNo=<%=s.getSubjectNo() %>"><%=s.getSubjectName() %></a></td>
			<td><%=s.getSubjectTime() %></td>
		</tr>
		<%		
			}
		%>
	</tbody>
	</table>
	
 	<%
		if(minPage > 1) {
	%>
			<a href="<%=request.getContextPath() %>/subject/subjectList.jsp?currentPage=<%=minPage-pagePerPage%>">이전</a>	
	<%
		}
		
		for(int i = minPage; i<=maxPage; i=i+1) {
			if(i == currentPage) {
	%>
				<span><%=i%></span>&nbsp;
	<%			
			} else {		
	%>
				<a href="<%=request.getContextPath() %>/subject/subjectList.jsp?currentPage=<%=i%>"><%=i%></a>&nbsp;	
	<%	
			}
		}
		
		if(maxPage != lastPage) {
	%>
			<!--  maxPage + 1 -->
			<a href="<%=request.getContextPath() %>/subject/subjectList.jsp?currentPage=<%=minPage+pagePerPage%>">다음</a>
	<%
		}
   	%>
</div>
</body>
</html>