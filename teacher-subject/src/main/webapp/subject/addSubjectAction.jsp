<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%

	// 인코딩
	request.setCharacterEncoding("utf-8");

	// 요청값 유효성 검사
	if(request.getParameter("subjectName") == null 
		|| request.getParameter("subjectTime") == null 
		|| request.getParameter("subjectName").equals("")
		|| request.getParameter("subjectTime").equals("")) {
		// insertSubject.jsp으로
		response.sendRedirect(request.getContextPath() + "/subject/addSubject.jsp");
		return;
	}

	// 요청값 변수에 저장
	String subjectName = request.getParameter("subjectName");
	int subjectTime = Integer.parseInt(request.getParameter("subjectTime"));
	
	SubjectDao dao = new SubjectDao();
	Subject subject = new Subject();
	subject.setSubjectName(subjectName);
	subject.setSubjectTime(subjectTime);
	
	int row = dao.insertSubject(subject);
	
	response.sendRedirect(request.getContextPath() + "/subject/subjectList.jsp");



%>