<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%
	// 요청값 유효성 검사
	if(request.getParameter("subjectNo") == null
		|| request.getParameter("subjectNo").equals("")) {
		
		response.sendRedirect(request.getContextPath()+"/subjec/subjecList.jsp");
		return;	
	}

	if(request.getParameter("ckSubjectNo") == null
		|| request.getParameter("ckSubjectNo").equals("")) {
	
		response.sendRedirect(request.getContextPath()+"/subject/subjectListOne.jsp?subjectNo=" + request.getParameter("subjectNo"));
		return;	
	}

	// 요청값 변수에 저장
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	int ckSubjectNo = Integer.parseInt(request.getParameter("ckSubjectNo"));

	// 디버깅
	System.out.println(subjectNo + " <-- subjectNo");
	System.out.println(ckSubjectNo + " <-- ckSubjectNo");
	
	// 확인용 문구가 틀리면 
	if(ckSubjectNo != subjectNo) {
		response.sendRedirect(request.getContextPath()+"/subject/subjectListOne.jsp?subjectNo=" + request.getParameter("subjectNo"));
		return;
	} 
	
	// sql 클래스의 객체 생성
	SubjectDao dao = new SubjectDao();
	
	// delete 메서드 호출
	int remove = dao.deleteSubject(subjectNo);
	
	if(remove == 1){
		System.out.println("subject 삭제 성공");
		
	} 
	
	response.sendRedirect(request.getContextPath() + "/subject/subjectList.jsp");
	
%>