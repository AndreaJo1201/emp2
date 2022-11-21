package dao;
import java.sql.*;
import java.util.*;

import util.DBUtil;
import vo.*;

public class EmpDao {

	public ArrayList<Employee> selectEmpList (int currentPage, final int ROW_PER_PAGE, String noSort, String sort, String word) throws Exception {
		ArrayList<Employee> list = new ArrayList<Employee>();

		
		int beginRow = ROW_PER_PAGE * (currentPage-1);
		
		/**************************************************************************************/
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		/*****************************SET PAGE LIST********************************************/
		DbSql dbSql = new DbSql();
		
		String sql = dbSql.sqlSelectList(noSort, sort, word);
		PreparedStatement stmt = null;
			
		if(word == null) {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, ROW_PER_PAGE);
		} else {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1,"%"+word+"%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, ROW_PER_PAGE);
		}
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Employee e = new Employee();
			e.setEmpNo(rs.getInt("empNo"));
			e.setBirthDate(rs.getString("birthDate"));
			e.setHireDate(rs.getString("hireDate"));
			e.setGender(rs.getString("gender"));
			e.setName(rs.getString("name"));
			list.add(e);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	
	public Page countPageList(int currentPage, final int ROW_PER_PAGE, String word) throws Exception {
		Page page = new Page();
		
		/**************************************************************************************/
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		/*****************************COUNT PAGE LIST******************************************/
		DbSql dbSql = new DbSql();
		String cntSql = dbSql.sqlCnt(word);
		PreparedStatement cntStmt = null;
		
		if(word == null) {
			cntStmt = conn.prepareStatement(cntSql);
		} else {
			cntStmt = conn.prepareStatement(cntSql);
			cntStmt.setString(1,"%"+word+"%");
		}
		
		ResultSet cntRs = cntStmt.executeQuery();
		int cnt = 0;
		if(cntRs.next()){
			cnt = cntRs.getInt("cnt");
			if(cnt == 0) {
				cnt = 1;
			}
		}
		
		int lastPage = cnt / ROW_PER_PAGE;
		if(cnt % ROW_PER_PAGE != 0) {
			lastPage = lastPage + 1;
		}
		
		String stringMsg = null;
		if(currentPage > lastPage) { // 페이지를 넘어선 다른 수를 입력했을 때 예외(에러) 처리
			stringMsg = "존재하지 않는 페이지입니다.";
			currentPage = lastPage;
			System.out.println("go to lastPage");
		} else if(currentPage < 1) {
			stringMsg = "존재하지 않는 페이지입니다.";
			currentPage = 1;
			System.out.println("go to firstPage");
		}
		
		page.setLastPage(lastPage);
		page.setStringMsg(stringMsg);
		page.setCurrentPage(currentPage);
		
		cntRs.close();
		cntStmt.close();
		conn.close();
		
		return page;
	}
}
