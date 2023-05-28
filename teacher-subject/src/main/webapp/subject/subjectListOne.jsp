<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import = "vo.*" %>
<%
	SubjectDao dao = new SubjectDao();
	
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	
	Subject subject = dao.selectSubjectOne(subjectNo);
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
<div class="container mt-3 text-center">
	<table class="table">
		<tr>
			<th class="table-warning">Subject No</th>
			<td><%=subject.getSubjectNo() %></td>
		</tr>
		<tr>
			<th class="table-warning">Subject Name</th>
			<td><%=subject.getSubjectName()%></td>
		</tr>
		<tr>
			<th class="table-warning">Subject time</th>
			<td><%=subject.getSubjectTime() %></td>
		</tr>
		<tr>
			<th class="table-warning">Createdate</th>
			<td><%=subject.getCreatedate() %></td>
		</tr>
		<tr>
			<th class="table-warning">Updatedate</th>
			<td><%=subject.getUpdatedate() %></td>
		</tr>
	</table>
	<a href="<%=request.getContextPath()%>/subject/modifySubject.jsp?subjectNo=<%=subject.getSubjectNo() %>"><button type="button" class="btn btn-warning">수정</button></a>
	<a href="<%=request.getContextPath()%>/subject/removeSubject.jsp?subjectNo=<%=subject.getSubjectNo() %>"><button type="button" class="btn btn-warning">삭제</button></a>
</div>
</body>
</html>