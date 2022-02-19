package kr.order.vo;

public class OrderDetailVO {
	private int orderdetail_num; //pk
	private int order_num; //fk
	private int product_num; //fk
	private int cart_count; //이름변경	
	private String product_name; // 추가
	private int product_price;//추가
	private int product_total;//추가
		
	public int getOrderdetail_num() {
		return orderdetail_num;
	}
	public void setOrderdetail_num(int orderdetail_num) {
		this.orderdetail_num = orderdetail_num;
	}
	public int getOrder_num() {
		return order_num;
	}
	public void setOrder_num(int order_num) {
		this.order_num = order_num;
	}
	public int getProduct_num() {
		return product_num;
	}
	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}
	public int getCart_count() {
		return cart_count;
	}
	public void setCart_count(int cart_count) {
		this.cart_count = cart_count;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public int getProduct_price() {
		return product_price;
	}
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	public int getProduct_total() {
		return product_total;
	}
	public void setProduct_total(int product_total) {
		this.product_total = product_total;
	}
	
	
	
}
