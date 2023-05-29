<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>  
<%
	// 인코딩
	request.setCharacterEncoding("UTF-8");

	// 요청값 유효성 검사
	if(request.getParameter("subjectNo") == null
		|| request.getParameter("subjectNo").equals("")) {
		
		response.sendRedirect(request.getContextPath()+"/subjec/subjecList.jsp");
		return;	
	}

	if(request.getParameter("subjectName") == null
		|| request.getParameter("subjectTime") == null
		|| request.getParameter("subjectName").equals("")
		|| request.getParameter("subjectTime").equals("")) {
		
		response.sendRedirect(request.getContextPath()+"/subject/subjectListOne.jsp?subjectNo=" + request.getParameter("subjectNo"));
		return;	
		}
	
	// 요청값 변수에 저장
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	String subjectName = request.getParameter("subjectName");
	int subjectTime = Integer.parseInt(request.getParameter("subjectTime"));
	
	// 디버깅
	System.out.println(subjectNo + " <-- subjectNo");
	System.out.println(subjectName + " <-- subjectName");
	System.out.println(subjectTime + " <-- subjectTime");
	
	// sql 클래스의 객체 생성
	SubjectDao dao = new SubjectDao();
	
	// subject객체 생성해 요청값 저장
	Subject subject = new Subject();
	subject.setSubjectNo(subjectNo);
	subject.setSubjectName(subjectName);
	subject.setSubjectTime(subjectTime);
	
	// update 메서드 호출
	int modify = dao.updateSubject(subject);

	if(modify == 1){
		System.out.println("subject 수정 성공");
		
	} 
	
	response.sendRedirect(request.getContextPath() + "/subject/subjectList.jsp");

%>
