<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import = "vo.*" %>
<%
	TeacherDao dao = new TeacherDao();

	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	
	Teacher teacher = dao.selectTeacherOne(teacherNo);
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
			<th class="table-warning">Teacher No</th>
			<td><%=teacher.getTeacherNo() %></td>
		</tr>
		<tr>
			<th class="table-warning">Teacher Id</th>
			<td><%=teacher.getTeacherId() %></td>
		</tr>
		<tr>
			<th class="table-warning">Teacher Name</th>
			<td><%=teacher.getTeacherName() %></td>
		</tr>
		<tr>
			<th class="table-warning">Teacher History</th>
			<td><%=teacher.getTeacherHistory() %></td>
		</tr>
		<tr>
			<th class="table-warning">Createdate</th>
			<td><%=teacher.getCreatedate() %></td>
		</tr>
		<tr> 
			<th class="table-warning">Updatedate</th>
			<td><%=teacher.getUpdatedate() %></td>
		</tr>
	</table>
	<a href="<%=request.getContextPath()%>/teacher/modifyTeacher.jsp?teacherNo=<%=teacher.getTeacherNo() %>"><button type="button" class="btn btn-warning">수정</button></a>
	<a href="<%=request.getContextPath()%>/teacher/removeTeacher.jsp?teacherNo=<%=teacher.getTeacherNo() %>"><button type="button" class="btn btn-warning">삭제</button></a>
</div>
</body>
</html>