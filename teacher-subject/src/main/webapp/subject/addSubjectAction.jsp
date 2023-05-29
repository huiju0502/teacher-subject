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
	
	// 디버깅
	System.out.println(subjectName + " <-- subjectName");
	System.out.println(subjectTime + " <-- subjectTime");
	
	// sql 클래스의 객체 생성
	SubjectDao dao = new SubjectDao();
	
	// subject객체 생성해 요청값 저장
	Subject subject = new Subject();
	subject.setSubjectName(subjectName);
	subject.setSubjectTime(subjectTime);
	
	// insert 메서드 호출
	int add = dao.insertSubject(subject);
	
	if(add == 1){
		System.out.println("subject 추가 성공");
		
	} 
	
	response.sendRedirect(request.getContextPath() + "/subject/subjectList.jsp");

%>