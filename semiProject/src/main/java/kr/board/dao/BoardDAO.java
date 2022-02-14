package kr.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.board.dao.BoardDAO;
import kr.board.vo.BoardReplyVO;
import kr.board.vo.BoardVO;
import kr.util.DBUtil;
import kr.util.DurationFromNow;
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
				board.setFilename(rs.getString("filename"));
				
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
		public void updateBoard(BoardVO board)throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			String sql = null;
			String sub_sql = "";
			int cnt = 0;

			try {
				//커넥션풀로부터 커넥션을 할당
				conn = DBUtil.getConnection();
				//파일 업데이트는 파일이 있을때만 해줘야하기 때문에 sub_sql로 처리한다.
				if(board.getFilename()!=null) {
					sub_sql = ",filename=?";
				}
				//SQL문 작성
				sql ="UPDATE qboard SET title=?,b_content=?,modify_date=SYSDATE" 
						+ sub_sql + ",ip=? WHERE board_num=?";
				//preparedStatement 객체 생성
				pstmt = conn.prepareStatement(sql); 
				//?에 데이터 바인딩
				pstmt.setString(++cnt, board.getTitle());
				pstmt.setString(++cnt, board.getB_content());
				if(board.getFilename()!=null) {
					pstmt.setString(++cnt, board.getFilename());
				}
				pstmt.setString(++cnt, board.getIp());
				pstmt.setInt(++cnt, board.getBoard_num());

				//SQL문 반영
				pstmt.executeUpdate();
				
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(null, pstmt, conn);
			}
		}
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
		//파일 삭제
		public void deleteFile(int board_num)throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			String sql = null;
			
			try {
				//커넥션풀로부터 커넥션을 할당
				conn = DBUtil.getConnection();
				//SQL문 작성
				sql = "UPDATE qboard SET filename='' WHERE board_num=?";
				//preparedStatement 객체 생성
				pstmt = conn.prepareStatement(sql); 
				//?에 데이터 바인딩
				pstmt.setInt(1, board_num);
				//SQL문 실행
				pstmt.executeUpdate();
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(null, pstmt, conn);
			}
		}
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
		//글삭제
		public void deleteBoard(int board_num)throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			PreparedStatement pstmt2 = null; 
			String sql = null;
			
			try {
				//커넥션풀로부터 커넥션을 할당
				conn = DBUtil.getConnection();
				//오토커밋 해제
				conn.setAutoCommit(false);	
				//1.댓글삭제
				sql ="DELETE FROM qboard_reply WHERE board_num=?";
				//preparedStatement 객체 생성
				pstmt = conn.prepareStatement(sql); 
				//?에 데이터 바인딩
				pstmt.setInt(1, board_num);
				//SQL문 반영
				pstmt.executeUpdate();
				
				//2.글 삭제
				sql ="DELETE FROM qboard WHERE board_num=?";
				//preparedStatement 객체 생성
				pstmt2 = conn.prepareStatement(sql); 
				//?에 데이터 바인딩
				pstmt2.setInt(1, board_num);
				//SQL문 반영
				pstmt2.executeUpdate();
				
				//정삭적으로 모든 SQL문을 실행->커밋
				conn.commit();
				
			}catch(Exception e) {
				//예외발생시 ->롤백
				conn.rollback();
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(null, pstmt2, null);
				DBUtil.executeClose(null, pstmt, conn);
			}
		}

//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	//댓글 등록
	public void insertReplyBoard(BoardReplyVO boardReply)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문
			sql = "INSERT INTO qboard_reply (re_num,re_content,re_ip,user_num,board_num) VALUSE (qreply_seq.nextval,?,?,?,?)";
			//PreparedStatement객체 생성
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, boardReply.getRe_content());
			pstmt.setString(2, boardReply.getRe_ip());
			pstmt.setInt(3, boardReply.getUser_num());
			pstmt.setInt(4, boardReply.getBoard_num());
			//SQL실행
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			//자원정리
			DBUtil.executeClose(null, pstmt, conn);
		}
	
	}

//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	//댓글 갯수
	 public int getReplyBoardCount(int board_num)throws Exception{
		 Connection conn = null;
		 PreparedStatement pstmt = null;
		 ResultSet rs = null;
		 String sql = null;
		 int count = 0;
		 
		 try {
			 //커넥션 할당
			 conn = DBUtil.getConnection();
			 //SQL문
			 sql = "SELECT COUNT(*) FROM qboard_reply b JOIN qmember m USING(user_num) WHERE b.board_num=?";
			 
			 //PreparedStatement 객체 생성
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setInt(1, board_num);
			 
			 //SQL문 결과행 ResultSet에 담음
			 rs = pstmt.executeQuery();
			 if(rs.next()) {
				 count = rs.getInt(1);
			 }
		 }catch(Exception e) {
			 throw new Exception(e);
		 }finally {
			 //자원정리
			 DBUtil.executeClose(rs, pstmt, conn);
		 }
		 
		 return count;
	 }
	 //댓글 목록
	 public List<BoardReplyVO> getListReplyBoard(int startRow, int endRow, int board_num) throws Exception{
		 Connection conn = null;
		 PreparedStatement pstmt = null;
		 ResultSet rs = null;
		 List<BoardReplyVO> list = null;
		 String sql = null;
		 
		 try {
			 //커넥션 할당
			 conn = DBUtil.getConnection();
			 //SQL문 작성
			 sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM "
			 	+ "(SELECT b.re_num, TO_CHAR(b.re_date,'YYYY-MM-DD HH24:MI:SS') re_date,"
			 	+ "TO_CHAR(b.re_modifydate,'YYYY-MM-DD HH24:MI:SS') re_modifydate,"
			 	+ "b.re_content,b.board_num,mem_num,m.id FROM qboard_reply b "
			 	+ "JOIN qmember m USING(user_num) WHERE b.board_num=? "
			 	+ "ORDER BY b.re_num DESC)a) "
			 	+ "WHERE rnum >= ? AND rnum <= ?";
			 
			 //PreparedStatement 객체 생성
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setInt(1, board_num);
			 pstmt.setInt(2, startRow);
			 pstmt.setInt(3, endRow);
			 
			 //SQL 결과행 ResultSet에 담음
			 rs = pstmt.executeQuery();
			 list = new ArrayList<BoardReplyVO>();
			 while(rs.next()) {
				 BoardReplyVO reply = new BoardReplyVO();
				 reply.setRe_num(rs.getInt("re_num"));
				 //날짜 -> 1분전, 1시간전, 1일전 형식의 문자열로 변환
				 reply.setRe_date(DurationFromNow.getTimeDiffLabel(rs.getString("re_date")));
				 if(rs.getString("re_modifydate")!=null) {
					 reply.setRe_modifydate(DurationFromNow.getTimeDiffLabel(rs.getString("re_modifydate")));
				 }
				 reply.setRe_content(StringUtil.useBrNoHtml(rs.getString("re_content")));
				 reply.setBoard_num(rs.getInt("board_num"));
				 reply.setUser_num(rs.getInt("user_num"));
				 reply.setId(rs.getString("id"));
				 
				 list.add(reply);
			 }
			 
		 }catch(Exception e) {
			 throw new Exception(e);
		 }finally {
			 //자원정리
			 DBUtil.executeClose(rs, pstmt, conn);
		 }
		 return list;
	 }
	 //댓글 상세
	 public BoardReplyVO getReplyBoard(int re_num)throws Exception{
		 Connection conn = null;
		 PreparedStatement pstmt = null;
		 ResultSet rs = null;
		 BoardReplyVO reply = null;
		 String sql = null;
		 
		 try {
			 //커넥션을 할당
			 conn = DBUtil.getConnection();
			 //SQL문 작성
			 sql = "SELECT * FROM qboard_reply r JOIN qmember USING(user_num) WHERE re_num = ?";
			 //PreparedStament 객체 생성
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setInt(1, re_num);
			 //SQL문을 실행해서 결과행을 ResultSet에 담음
			 rs = pstmt.executeQuery();
			 if(rs.next()) {
				 reply = new BoardReplyVO();
				 reply.setRe_num(rs.getInt("re_num"));
				 reply.setBoard_num(rs.getInt("board_num"));
				 reply.setUser_num(rs.getInt("user_num"));
				 reply.setId(rs.getString("id"));
			 }
		 }catch(Exception e) {
			 throw new Exception(e);
		 }finally{
			 //자원정리
			 DBUtil.executeClose(rs, pstmt, conn);
		 }
		 return reply;
	 }
	//댓글 수정
	//댓글 삭제
	
	
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ	
	//myPage-내가쓴글

	public List<BoardVO> getMyReview(int startRow, int endRow, String keyfield, String keyword, String id)throws Exception{
				
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
							+ "(SELECT * FROM qboard b JOIN qmember m USING(user_num) where m.id=?"
							+ sub_sql + "ORDER BY b.board_num DESC)a) "
							+ "WHERE rnum >=? AND rnum <= ?";		
					
					//preparedStatement 객체 생성
					pstmt = conn.prepareStatement(sql); 
					//sub_sql의 ?에 데이터 매핑위해 조건체크 (new)
					if(keyword != null && !"".equals(keyword)) {
						pstmt.setString(++cnt, "%" + keyword + "%");
					}
					
					//?에 데이터 바인딩
					pstmt.setString(++cnt, id);		
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
						board.setFilename(rs.getString("filename"));
						
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
}
