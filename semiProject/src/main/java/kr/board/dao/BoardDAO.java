package kr.board.dao;

import kr.board.dao.BoardDAO;

public class BoardDAO {
	private static BoardDAO instance = new BoardDAO();
	public static BoardDAO getInstance() {
		return instance;
	}
	private BoardDAO() {}
	
	
	//글등록
	//총 레코드 수(검색 레코드 수)
	//목록
	//글상세
	//조회수 증가
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
