package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Teacher;

public class TeacherDao {
	// 1) 강사목록
	public ArrayList<HashMap<String, Object>> selectTeacherListByPage(
			int beginRow, int rowPerPage) throws Exception{
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 리스트 불러오기
		/*
		SELECT 
				t.teacher_no teacherNo,
				t.teacher_id teacherId,
				t.teacher_name teacherName, 
				ts.subject_no subjectNo,
				nvl(GROUP_CONCAT(s.subject_name),'') subjectName
		FROM teacher t LEFT OUTER JOIN teacher_subject ts
							ON t.teacher_no = ts.teacher_no
								LEFT OUTER JOIN subject s
								ON ts.subject_no = s.subject_no
		GROUP BY t.teacher_no, t.teacher_id, t.teacher_name
		limit 0, 10
		 */
		String teacherListSql = "SELECT t.teacher_no teacherNo, t.teacher_id teacherId, t.teacher_name teacherName, ts.subject_no subjectNo, nvl(GROUP_CONCAT(s.subject_name),'') subjectName, t.createdate createdate, t.updatedate updatedate FROM teacher t LEFT OUTER JOIN teacher_subject ts ON t.teacher_no = ts.teacher_no LEFT OUTER JOIN subject s ON ts.subject_no = s.subject_no GROUP BY t.teacher_no, t.teacher_id, t.teacher_name limit ?, ?";
		PreparedStatement teacherListStmt = conn.prepareStatement(teacherListSql);
		teacherListStmt.setInt(1, beginRow);
		teacherListStmt.setInt(2, rowPerPage);
		ResultSet teacherListRs = teacherListStmt.executeQuery();
		
		 ArrayList<HashMap<String, Object>> list 
		 	= new ArrayList<HashMap<String, Object>>();
		 while(teacherListRs.next()) {
			 HashMap<String, Object> t = new HashMap<String, Object>();
			 t.put("teacherNo", teacherListRs.getInt("teacherNo"));
			 t.put("teacherId", teacherListRs.getString("teacherId"));
			 t.put("teacherName", teacherListRs.getString("teacherName"));
			 t.put("subjectrNo", teacherListRs.getInt("subjectNo"));
			 t.put("subjectName", teacherListRs.getString("subjectName"));
			 list.add(t);
		 }	
		return list;
	}
	
	// 2) 강사전체row
			public int selectTeacherCnt() throws Exception {
				// db 연결
				DBUtil dbUtil = new DBUtil();
				Connection conn = dbUtil.getConnection();
				
				// 전체 행수 구하기
				int row = 0;
				String totalRowSql ="SELECT count(*) FROM teacher";
				PreparedStatement totalRowStmt = conn.prepareStatement(totalRowSql);
				ResultSet totalRowRs = totalRowStmt.executeQuery();
				if(totalRowRs.next()) {
					row = totalRowRs.getInt("count(*)");
				}
				return row;
			}
	
	// 3) 강사 한명 상세
		public Teacher selectTeacherOne(int teacherNo) throws Exception {
			// db연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			// 상세정보 불러오기
			Teacher teacher = null;
			String teacherOneSql = "SELECT * FROM teacher WHERE teacher_no = ?";
			PreparedStatement teacherOneStmt = conn.prepareStatement(teacherOneSql);
			teacherOneStmt.setInt(1, teacherNo);
			ResultSet teacherOneRs = teacherOneStmt.executeQuery();
			
			if(teacherOneRs.next()) {
				teacher = new Teacher();
				teacher.setTeacherNo(teacherOneRs.getInt("teacher_no"));
				teacher.setTeacherId(teacherOneRs.getString("teacher_id"));
				teacher.setTeacherName(teacherOneRs.getString("teacher_name"));
				teacher.setTeacherHistory(teacherOneRs.getString("teacher_history"));
				teacher.setCreatedate(teacherOneRs.getString("createdate"));
				teacher.setUpdatedate(teacherOneRs.getString("updatedate"));
			}
			return teacher;
		}
	
	// 4) 강사추가
	public int insertTeacher(Teacher teacher) throws Exception {
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 추가(insert into) SQL
		String insertSql = "INSERT INTO teacher(teacher_id, teacher_name, teacher_history, createdate, updatedate) VALUES(?, ?, ?, now(), now())";
		PreparedStatement insertStmt = conn.prepareStatement(insertSql);
		insertStmt.setString(1, teacher.getTeacherId());
		insertStmt.setString(2, teacher.getTeacherName());
		insertStmt.setString(3, teacher.getTeacherHistory());
		int row = insertStmt.executeUpdate();
			
		return row;
	}

	// 5) 강사삭제
	public int deleteTeacher(int teacherNo) throws Exception {
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 삭제(delete) SQL
		String deleteSql ="DELETE FROM teacher WHERE teacher_no = ?";
		PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
		deleteStmt.setInt(1, teacherNo);
		int row = deleteStmt.executeUpdate();
				
		return row;
	}

	// 6) 강사수정
	public int updateTeacher(Teacher teacher) throws Exception {
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 수정(update) SQL
		String updateSql = "UPDATE teacher SET teacher_id = ?, teacher_name = ?, teacher_history = ?, updatedate = now() WHERE teacher_no = ?";
		PreparedStatement updateStmt = conn.prepareStatement(updateSql);
		updateStmt.setString(1, teacher.getTeacherId());
		updateStmt.setString(2, teacher.getTeacherName());
		updateStmt.setString(3, teacher.getTeacherHistory());
		updateStmt.setInt(4, teacher.getTeacherNo());
		int row = updateStmt.executeUpdate();
		
		return row;
	}
}
