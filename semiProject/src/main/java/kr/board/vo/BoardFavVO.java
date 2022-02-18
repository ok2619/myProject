package kr.board.vo;

import java.sql.Date;

public class BoardFavVO {
	private int fav_num;
	private int board_num;
	private int user_num;
	private Date fav_date;
	public int getFav_num() {
		return fav_num;
	}
	public void setFav_num(int fav_num) {
		this.fav_num = fav_num;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	public Date getFav_date() {
		return fav_date;
	}
	public void setFav_date(Date fav_date) {
		this.fav_date = fav_date;
	}
	
	
}
