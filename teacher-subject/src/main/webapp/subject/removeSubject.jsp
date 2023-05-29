<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import = "vo.*" %>
<%
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	
	SubjectDao dao = new SubjectDao();
	
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
	<form action="<%=request.getContextPath() %>/subject/removeSubjectAction.jsp" method="post">
		<table class="table">
			<tr>
				<th class="table-warning">Subject No</th>
				<td><input type="text" name="subjectNo" value="<%=subject.getSubjectNo() %>" readonly="readonly"></td>
			</tr>
			<tr>
				<th class="table-warning">삭제 확인용 Subject No</th>				
				<td><input type="number" name="ckSubjectNo"></td>
			</tr>
		</table>
		<button type="submit" class="btn btn-warning">확인</button>
	</form>
</div>
</body>
</html>