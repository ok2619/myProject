package kr.board.vo;

import java.sql.Date;

public class BoardVO {
	private int board_num; //글번호
	private String title; //제목
	private String b_content; //내용
	private int hit; //조회수
	private Date reg_date; //등록일
	private Date modify_date; //수정일
	private String filename; //파일명
	private String ip; //ip주소
	private int user_num; //회원번호(작성자)
	private String id; //회원아이디 ->qboard 테이블엔 없지만 qmember 테이블과 조인해서 id정보 보여주기 위해 담는다
	
	
	///////////////////
	private int good;
	
	
	public int getGood() {
		return good;
	}
	public void setGood(int good) {
		this.good = good;
	}
	
	/////////////////
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getB_content() {
		return b_content;
	}
	public void setB_content(String b_content) {
		this.b_content = b_content;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public Date getModify_date() {
		return modify_date;
	}
	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	
}
 