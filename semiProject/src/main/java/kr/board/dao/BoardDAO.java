package kr.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.board.dao.BoardDAO;
import kr.board.vo.BoardVO;
import kr.util.DBUtil;
import kr.util.StringUtil;

public class BoardDAO {
	private static BoardDAO instance = new BoardDAO();
	public static BoardDAO getInstance() {
		return instance;
	}
	private BoardDAO() {}

	
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ	 
	//글등록
	public void insertBoard(BoardVO board)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "INSERT INTO qboard (board_num,title,b_content,filename,ip,"
					+ "user_num) VALUES (qboard_seq.nextval,?,?,?,?,?)";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getB_content());
			pstmt.setString(3, board.getFilename());
			pstmt.setString(4, board.getIp());
			pstmt.setInt(5, board.getUser_num());
						
			//SQL문 실행
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	//총 레코드 수(검색 레코드 수)
	public int getBoardCount(String keyfield,String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;
		
		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();			
			
			if(keyword !=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql = "WHERE b.title LIKE ?";
				else if(keyfield.equals("2")) sub_sql = "WHERE m.id LIKE ?";
				else if(keyfield.equals("3")) sub_sql = "WHERE b.b_content LIKE ?"; //이름검색은 일단 안하는걸로 할게요! (필요하면 추후에 추가)
			}
			sql = "SELECT COUNT(*) FROM qboard b JOIN qmember m USING(user_num) " + sub_sql;
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			
			//sub_sql의 ?에 데이터 매핑위해 조건체크
			if(keyword != null && !"".equals(keyword)) {
				pstmt.setString(1, "%" + keyword + "%");
			}
			
			//SQL문을 실행하고 결과행을 ResultSet에 담음
			rs=pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1); //컬럼인덱스사용
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return count;		
	}
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	//목록
	public List<BoardVO> getListBoard(int startRow, int endRow, String keyfield, String keyword)throws Exception{
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BoardVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		
		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			
			if(keyword !=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql = "WHERE b.title LIKE ?";
				else if(keyfield.equals("2")) sub_sql = "WHERE m.id LIKE ?";
				else if(keyfield.equals("3")) sub_sql = "WHERE b.b_content LIKE ?";
			}
			
			//SQL문 작성
			sql ="SELECT * FROM (SELECT a.*, rownum rnum FROM "
					+ "(SELECT * FROM qboard b JOIN qmember m USING(user_num) "
					+ sub_sql + " ORDER BY b.board_num DESC)a) "
					+ "WHERE rnum >=? AND rnum <= ?";		
			
			//preparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql); 
			//sub_sql의 ?에 데이터 매핑위해 조건체크 (new)
			if(keyword != null && !"".equals(keyword)) {
				pstmt.setString(++cnt, "%" + keyword + "%");
			}
			
			//?에 데이터 바인딩
			pstmt.setInt(++cnt, startRow);
			pstmt.setInt(++cnt, endRow);	
			
			//SQL문을 테이블에 반영해 결과행들을 ResultSet에 담음
			rs = pstmt.executeQuery();
			//ArrayList 객체 생성
			list = new ArrayList<BoardVO>();
			//반복문을 이용해 반복, 자바빈을 생성하고 정보를 저장
			while(rs.next()) {
				//하나의 레코드 정보를 담기 위해 BoardVO 객체(자바빈)를 생성
				BoardVO board = new BoardVO();
				board.setBoard_num(rs.getInt("board_num"));
				//제목엔 HTML태그를 허용하지 않음(줄바꿈등 모두 안먹음)
				board.setTitle(StringUtil.useNoHtml(rs.getString("title")));
				board.setHit(rs.getInt("hit"));
				board.setReg_date(rs.getDate("reg_date"));
				board.setId(rs.getString("id"));
				
				//VO를 ArrayList에 등록(저장해줘야함)
				list.add(board);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ	
	//글상세
	public BoardVO getBoard(int board_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		BoardVO board = null;

		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql ="SELECT * FROM qboard b JOIN qmember m "
					+ "ON b.user_num=m.user_num WHERE b.board_num=?"; 
			//preparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql); 
			//?에 데이터 바인딩
			pstmt.setInt(1, board_num);
			//SQL문을 테이블에 반영해 결과행(1개)을 ResultSet에 담음
			rs = pstmt.executeQuery();

			if(rs.next()) {//하나의 레코드(데이터들)를 자바빈에 담는다.
				board = new BoardVO(); 
				board.setBoard_num(rs.getInt("board_num"));
				board.setTitle(rs.getString("title"));
				board.setB_content(rs.getString("b_content"));
				board.setHit(rs.getInt("hit"));
				board.setReg_date(rs.getDate("reg_date"));
				board.setModify_date(rs.getDate("modify_date"));
				board.setFilename(rs.getString("filename"));
				board.setUser_num(rs.getInt("user_num"));
				board.setId(rs.getString("id"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}

		return board;
	}
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	//조회수 증가
	public void updateReadcount(int board_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			
			//SQL문 작성
			sql ="UPDATE qboard SET hit=hit+1 WHERE board_num=?";
			//preparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql); 
			//?에 데이터 바인딩
			pstmt.setInt(1, board_num);

			//SQL문 반영
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	//글수정
	//파일삭제
	//글삭제
	//댓글 등록
	//댓글 갯수
	//댓글 목록
	//댓글 상세
	//댓글 수정
	//댓글 삭제
}
