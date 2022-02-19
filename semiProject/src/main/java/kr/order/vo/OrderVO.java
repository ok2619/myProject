package kr.order.vo;

import java.sql.Date;

public class OrderVO {
	private int order_num; //주문 번호
	private int user_num; //구매자 회원번호
	private String product_name; //주문 상품명 (이름변경:item_name->product_name)
	private int order_total; //총 구매 금액 (productDAO의 getTotalByMem_num()으로 구할수있다.)
	private int payment; //지불 방식 1.통장입금, 2.카드결제
	private int shipping; //배송 상태 1.배송대기, 2.배송준비중, 3.배송중, 4.배송완료, 5.주문취소
	private Date reg_date; //주문 날짜
	//컬럼 추가
	private String order_name; //이름
	private String order_post; //우편번호
	private String order_address1; //주소
	private String order_address2; //상세주소
	private String order_phone; //전화번호
	//컬럼 외 추가
	private String id;//구매자 아이디 (관리자-주문관리 페이지에서 id보기 위해)
			
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getOrder_name() {
		return order_name;
	}
	public void setOrder_name(String order_name) {
		this.order_name = order_name;
	}
	public String getOrder_post() {
		return order_post;
	}
	public void setOrder_post(String order_post) {
		this.order_post = order_post;
	}
	public String getOrder_address1() {
		return order_address1;
	}
	public void setOrder_address1(String order_address1) {
		this.order_address1 = order_address1;
	}
	public String getOrder_address2() {
		return order_address2;
	}
	public void setOrder_address2(String order_address2) {
		this.order_address2 = order_address2;
	}
	public String getOrder_phone() {
		return order_phone;
	}
	public void setOrder_phone(String order_phone) {
		this.order_phone = order_phone;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getOrder_num() {
		return order_num;
	}
	public void setOrder_num(int order_num) {
		this.order_num = order_num;
	}
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	
	public int getOrder_total() {
		return order_total;
	}
	public void setOrder_total(int order_total) {
		this.order_total = order_total;
	}
	public int getPayment() {
		return payment;
	}
	public void setPayment(int payment) {
		this.payment = payment;
	}
	public int getShipping() {
		return shipping;
	}
	public void setShipping(int shipping) {
		this.shipping = shipping;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	
	
}
 