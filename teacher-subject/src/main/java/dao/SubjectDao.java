package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Subject;

public class SubjectDao {
	// 1) 과목목록
	public ArrayList<Subject> selectSubjectListByPage(int beginRow, int rowPerPage) throws Exception {
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 리스트 불러오기
		String subjectListSql ="SELECT subject_no, subject_name, subject_time, createdate, updatedate FROM subject LIMIT ?, ?";
		PreparedStatement subjectListStmt = conn.prepareStatement(subjectListSql);
		subjectListStmt.setInt(1, beginRow);
		subjectListStmt.setInt(2, rowPerPage);
		ResultSet subjectListRs = subjectListStmt.executeQuery();
		
		ArrayList<Subject> list = new ArrayList<>();
		while(subjectListRs.next()) {
			Subject s = new Subject();
			s.setSubjectNo(subjectListRs.getInt("subject_no"));
			s.setSubjectName(subjectListRs.getString("subject_name"));
			s.setSubjectTime(subjectListRs.getInt("subject_time"));
			s.setCreatedate(subjectListRs.getString("createdate"));
			s.setUpdatedate(subjectListRs.getString("updatedate"));
			list.add(s);
			
		}
		
		return list;
	}
	
	// 2) 과목추가
	public int insertSubject(Subject subject) throws Exception {
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String insertSql = "INSERT INTO subject(subject_name, subject_time, createdate, updatedate) VALUES(?, ?, now(), now())";
		PreparedStatement insertStmt = conn.prepareStatement(insertSql);
		insertStmt.setString(1, subject.getSubjectName());
		insertStmt.setInt(2, subject.getSubjectTime());
		int row = insertStmt.executeUpdate();
		
		return row;
	}
	// 3) 과목삭제
	public int deleteSubject(int subjectNo) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String deleteSql ="DELETE FROM subject WHERE subject_no = ?";
		PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
		deleteStmt.setInt(1, subjectNo);
		int row = deleteStmt.executeUpdate();
		
		return row;
	}
	// 4) 과목수정
	public int updateSubject(Subject subject) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String updateSql = "UPDATE subject SET subject_name = ?, subject_time = ?, updatedate = now() WHERE subject_no = ?";
		PreparedStatement updateStmt = conn.prepareStatement(updateSql);
		updateStmt.setString(1, subject.getSubjectName());
		updateStmt.setInt(2, subject.getSubjectTime());
		updateStmt.setInt(3, subject.getSubjectNo());
		int row = updateStmt.executeUpdate();
		
		return row;
	}
	
	// 5) 과목 하나 상세
	public Subject selectSubjectOne(int subjectNo) throws Exception{
		Subject subject = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String subjectOneSql = "SELECT * FROM subject WHERE sbject_no = ?";
		PreparedStatement subjectOneStmt = conn.prepareStatement(subjectOneSql);
		subjectOneStmt.setInt(1, subjectNo);
		ResultSet subjectOneRs = subjectOneStmt.executeQuery();
		
		if(subjectOneRs.next()) {
			subject = new Subject();
			subject.setSubjectNo(subjectOneRs.getInt("subject_no"));
			subject.setSubjectName(subjectOneRs.getString("subject_name"));
			subject.setSubjectTime(subjectOneRs.getInt("subject_time"));
			subject.setCreatedate(subjectOneRs.getString("createdate"));
			subject.setUpdatedate(subjectOneRs.getString("updatedate"));
			
		}
		return subject;
	}
	
	// 6) 과목전체row
	public int selectSubjectCnt() throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		int row = 0;
		String totalRowSql ="SELECT count(*) FROM subject";
		PreparedStatement totalRowStmt = conn.prepareStatement(totalRowSql);
		ResultSet totalRowRs = totalRowStmt.executeQuery();
		if(totalRowRs.next()) {
			row = totalRowRs.getInt("count(*)"); // totalRowRs.getInt("count(*)")
		}
		
		return row;
		
	}

}
