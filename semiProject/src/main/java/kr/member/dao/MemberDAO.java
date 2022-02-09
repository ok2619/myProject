package kr.member.dao;

public class MemberDAO {
	
	private static MemberDAO instance = new MemberDAO();
	public static MemberDAO getInstance() {
		return instance;
	}
	private MemberDAO() {}
	
	//회원가입
	//ID중복 체크 및 로그인 처리
	//회원상세정보
	//회원정보수정
	//비밀번호수정
	//회원탈퇴(회원정보 삭제)
	
	
	//관리자
	//총 회원 수
	//회원 목록
	//회원 정보 수정
}
