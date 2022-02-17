package kr.product.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.product.vo.CartVO;
import kr.product.vo.ProductVO;
import kr.util.DBUtil;

public class ProductDAO {
	private static ProductDAO instance = new ProductDAO();
	public static ProductDAO getInstance() {
		return instance;
	}
	private ProductDAO() {} 
	
	public void insertProduct(ProductVO product) throws Exception {
		// TODO Auto-generated method stub
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {

			conn = DBUtil.getConnection();
			sql = "insert into qproduct (product_num,stock,product_name,sort,price,image,content,reg_date) "
					+ "values (qproduct_seq.nextval,?,?,?,?,?,?,SYSDATE)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, product.getStock());
			pstmt.setString(2, product.getProduct_name());
			pstmt.setString(3, product.getSort());
			pstmt.setInt(4, product.getPrice());
			pstmt.setString(5, product.getImage());
			pstmt.setString(6, product.getContent());

			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);;
		}
	}
	
	//총 레코드 수(검색 레코드 수)
		 public int getBoardCount(String keyfield,String keyword)throws Exception{
			 Connection conn = null;
			 PreparedStatement pstmt = null;
			 ResultSet rs = null;
			 String sql = null;
			 String sub_sql = "";
			 int count = 0;
			 
			 try {
				 //커넥션풀로부터 커넥션 할당
				 conn = DBUtil.getConnection();
				 
				 if(keyword != null && !"".equals(keyword)) {
					 if(keyfield.equals("1")) sub_sql = "WHERE product_name LIKE ?";
					 else if(keyfield.equals("2")) sub_sql = "WHERE sort LIKE ?";
				 }
				 
				 sql = "SELECT COUNT(*) FROM qproduct " + sub_sql;
				 
				 pstmt = conn.prepareStatement(sql);
				 if(keyword != null && !"".equals(keyword)) {
					 pstmt.setString(1, "%"+keyword+"%");
				 }
				 
				 //SQL문을 실행하고 결과행을 ResultSet에 담음
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
		 //목록
		 public List<ProductVO> getListBoard(int startRow, int endRow, 
				                  String keyfield, String keyword)throws Exception{
			 Connection conn = null;
			 PreparedStatement pstmt = null;
			 ResultSet rs = null;
			 List<ProductVO> list = null;
			 String sql = null;
			 String sub_sql = "";
			 int cnt = 0;
			 
			 try {
				 conn = DBUtil.getConnection();
				 
				 if(keyword != null && !"".equals(keyword)) {
					 if(keyfield.equals("1")) sub_sql = "WHERE product_name LIKE ?";
					 else if(keyfield.equals("2")) sub_sql = "WHERE sort LIKE ?";
				 }
				 
				 sql = "select * from (select rownum rn,product_num ,product_name,sort, stock, price,image,reg_date from "
				 		+ "(select * from qproduct " 
						+ sub_sql + " order by product_num desc)) where rn between ? and ?";
				 
				 pstmt = conn.prepareStatement(sql);
				 if(keyword != null && !"".equals(keyword)) {
					 pstmt.setString(++cnt, "%"+keyword+"%");
				 }
				 pstmt.setInt(++cnt, startRow);
				 pstmt.setInt(++cnt, endRow);
				 
				 rs = pstmt.executeQuery();
				 list = new ArrayList<ProductVO>();
				 while(rs.next()) {
					 ProductVO product = new ProductVO();
					 product.setProduct_num(rs.getInt("product_num"));
					 product.setImage(rs.getString("image"));
					 product.setProduct_name(rs.getString("Product_name"));
					 product.setSort(rs.getString("sort"));
					 product.setPrice(rs.getInt("price"));
					 product.setStock(rs.getInt("stock"));
					 product.setReg_date(rs.getDate("reg_date"));
					 
					 list.add(product);
				 }
				 
			 }catch(Exception e) {
				 throw new Exception(e);
			 }finally {
				 //자원정리
				 DBUtil.executeClose(rs, pstmt, conn);
			 }
			 return list;
		 }
		 //////////////////////////////////////////카테고리 리스트
		 public List<ProductVO> getListBoard2(int startRow, int endRow, 
				 			String keyfield, String keyword,String pageSort)throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<ProductVO> list = null;
			String sql = null;
			int cnt = 0;
			try {
			conn = DBUtil.getConnection();		
			
			sql = "select * from (select rownum rn,product_num ,product_name,sort, stock, price,image,reg_date from "
					+ "(select * from qproduct " 
					+ "WHERE sort LIKE ?" + " order by product_num desc)) where rn between ? and ?";

			pstmt = conn.prepareStatement(sql);	
			pstmt.setString(++cnt, "%"+pageSort+"%");
			pstmt.setInt(++cnt, startRow);
			pstmt.setInt(++cnt, endRow);

			rs = pstmt.executeQuery();
			list = new ArrayList<ProductVO>();
			while(rs.next()) {
				 ProductVO product = new ProductVO();
				 product.setProduct_num(rs.getInt("product_num"));
				 product.setImage(rs.getString("image"));
				 product.setProduct_name(rs.getString("Product_name"));
				 product.setSort(rs.getString("sort"));
				 product.setPrice(rs.getInt("price"));
				 product.setStock(rs.getInt("stock"));
				 product.setReg_date(rs.getDate("reg_date"));
				 
				 list.add(product);
			}
			
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				//자원정리
				DBUtil.executeClose(rs, pstmt, conn);
			}
				return list;
			}
		 //////////////////////////////////////////카테고리리스트
		
		 //상품상세보기
		 public ProductVO getProduct(int product_num) throws Exception{
			 Connection conn = null;
			 PreparedStatement pstmt = null;
			 ResultSet rs = null;
			 String sql = null;
			 ProductVO product = null;
			 
			try {
				conn = DBUtil.getConnection();
				sql = "select * from qproduct where product_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, product_num);
			    rs = pstmt.executeQuery();
			    
			    if(rs.next()) {
			    	product = new ProductVO();
			    	product.setProduct_num(rs.getInt("product_num"));
			    	product.setStock(rs.getInt("stock"));
			    	product.setProduct_name(rs.getString("product_name"));
			    	product.setSort(rs.getString("sort"));
			    	product.setPrice(rs.getInt("price"));
			    	product.setImage(rs.getString("image"));
			    	product.setContent(rs.getString("content"));
			    	product.setReg_date(rs.getDate("reg_date"));
			    }
				 
				 
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(rs, pstmt, conn);
			}
			 
			 return product;	 
		 }
		 //상품 수정
		 public void updateProduct(ProductVO product)throws Exception{
				Connection conn = null;
				PreparedStatement pstmt = null;
				String sql = null;
				String sub_sql = "";
				int cnt = 0;

				try {
					conn = DBUtil.getConnection();
					if(product.getImage()!=null) {
						sub_sql = ",image=?";
					}
					sql ="update qproduct set product_name=?,price=?,sort=?,stock=?,content=?,reg_date=SYSDATE "   
							+ sub_sql + "WHERE product_num=?";
					
					pstmt = conn.prepareStatement(sql); 
					pstmt.setString(++cnt, product.getProduct_name());
					pstmt.setInt(++cnt, product.getPrice());
					pstmt.setString(++cnt, product.getSort());
					pstmt.setInt(++cnt, product.getStock());
					pstmt.setString(++cnt, product.getContent());
					if(product.getImage()!=null) {
						pstmt.setString(++cnt, product.getImage());
					}
					pstmt.setInt(++cnt, product.getProduct_num());
					pstmt.executeUpdate();
					
				}catch(Exception e) {
					throw new Exception(e);
				}finally {
					DBUtil.executeClose(null, pstmt, conn);
				}
			}
		 //상품삭제
		 public void deleteProduct(int product_num) throws Exception{
			 Connection conn = null;
			 PreparedStatement pstmt = null;
			 String sql = null;
			 
			 try {
				 conn = DBUtil.getConnection();
				 sql = "delete from qproduct where product_num = ?";
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setInt(1, product_num);
				 pstmt.executeUpdate();
				 
			 }catch(Exception e) {
				 throw new Exception(e);
			 }finally {
				 DBUtil.executeClose(null, pstmt, conn);
			 }
		 }
		 
//ㅡㅡㅡㅡ[카트]ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ	
		 
		 //카트담기
		 public void cartInsert(CartVO cart) throws Exception{
			 Connection conn = null;
			 PreparedStatement pstmt = null;
			 ResultSet rs = null;
			 String sql = null;
			 
			 try {
				 conn = DBUtil.getConnection();
				 sql = "insert into qcart(cart_num,product_num,user_num,cart_count) values (qcart_seq.nextval,?,?,?)";
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setInt(1, cart.getProduct_num());
				 pstmt.setInt(2, cart.getUser_num());
				 pstmt.setInt(3, cart.getCart_count());
				 pstmt.executeUpdate();
				 
			 }catch(Exception e) {
				 throw new Exception(e);
			 }finally {
				 DBUtil.executeClose(rs, pstmt, conn);
			 }
		 }
		 
		 //카트 리스트
		 //카트에서 회원번호에 해당하는 컬럼을 모두 구한다음에
		 //프로덕트에서 모든컬럼 조회
		 public List<CartVO> cartList(int user_number) throws Exception{
			 Connection conn = null;
			 PreparedStatement pstmt = null;
			 ResultSet rs = null;
			 String sql = null;
			 List<CartVO> list = null;
			 
			 try {
				 conn = DBUtil.getConnection();
				 sql = "SELECT * FROM qcart c JOIN qproduct i "
				 		+ "ON c.product_num = i.product_num WHERE c.user_num = ? "
				 		+ "ORDER BY i.product_num ASC";
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setInt(1, user_number);
				 rs= pstmt.executeQuery();
				 
				 list = new ArrayList<CartVO>();
				 
				 while(rs.next()) {
					CartVO cart = new CartVO();
					cart.setCart_num(rs.getInt("cart_num"));
					cart.setProduct_num(rs.getInt("product_num"));
					cart.setCart_count(rs.getInt("cart_count"));
					cart.setUser_num(rs.getInt("user_num"));
					 
					 ProductVO product = new ProductVO();
					 product.setProduct_num(rs.getInt("product_num"));
					 product.setProduct_name(rs.getString("product_name"));
					 product.setSort(rs.getString("sort"));
					 product.setImage(rs.getString("image"));
					 product.setPrice(rs.getInt("price"));
					 product.setCart_count(rs.getInt("cart_count"));
					 product.setCart_num(rs.getInt("cart_num"));
					 
					 cart.setProduct(product);
						
						//sub total 연산하기
					 cart.setSub_total(cart.getCart_count()*product.getPrice());
						
					 list.add(cart);			
					 
				 }
			 }catch(Exception e) {
				 throw new Exception(e);
			 }finally {
				 DBUtil.getConnection();
			 }
			 return list;
		 }
		 
		 public CartVO getCart(CartVO cart)throws Exception{
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				CartVO cartSaved = null;
				String sql = null;
				
				try {
					//커넥션풀로부터 커넥션을 할당
					conn = DBUtil.getConnection();
					//SQL문 작성
					sql = "SELECT * FROM qcart WHERE product_num = ? AND user_num = ?";
					//PreparedStatement 객체 생성
					pstmt = conn.prepareStatement(sql);
					//?에 데이터 바인딩
					pstmt.setInt(1, cart.getProduct_num());
					pstmt.setInt(2, cart.getUser_num());
					//SQL문을 실행해서 결과행을 ResultSet에 담음
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						cartSaved = new CartVO();
						cartSaved.setCart_num(rs.getInt("cart_num"));
						cartSaved.setProduct_num(rs.getInt("product_num"));
						cartSaved.setCart_count(rs.getInt("cart_count"));
					}
					
				}catch(Exception e) {
					throw new Exception(e);
				}finally {
					//자원정리
					DBUtil.executeClose(rs, pstmt, conn);
				}
				return cartSaved;
			}
		//장바구니 수정
			//장바구니 회원번호별 수정
			public void updateCartByItem_num(CartVO cart)throws Exception{
				Connection conn = null;
				PreparedStatement pstmt = null;
				String sql = null;
				
				try {
					//커넥션풀로부터 커넥션 할당
					conn = DBUtil.getConnection();
					//SQL문 작성
					sql = "UPDATE qcart SET cart_count=? WHERE product_num=? AND user_num=?";
					//PreparedStatement 객체 생성
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, cart.getCart_count());
					pstmt.setInt(2, cart.getProduct_num());
					pstmt.setInt(3, cart.getUser_num());
					//SQL문 실행
					pstmt.executeUpdate();
					
				}catch(Exception e) {
					throw new Exception(e);
				}finally {
					//자원정리
					DBUtil.executeClose(null, pstmt, conn);
				}
			}
		 
		 //카트삭제
		 public void cartDelete(int cart_num) throws Exception{
			 Connection conn = null;
			 PreparedStatement pstmt = null;
			 String sql = null;
			 
			 try {
				conn = DBUtil.getConnection();
				sql = "delete from qcart where cart_num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, cart_num);
				pstmt.executeUpdate();
				
				
			 }catch(Exception e) {
				throw new Exception(e); 
			 }finally {
				 DBUtil.executeClose(null, pstmt, conn);
			 }
		 }
		 
		 
		 //재고 마이너스
		 //재고 마이너스 값 조정ㅇ
		 public void StockAll(int product_num,int cart_count) throws Exception{
			 Connection conn = null;
			 PreparedStatement pstmt = null;
			 String sql = null;
			
			 try {
				 conn = DBUtil.getConnection();				
				 
				 sql = "update qproduct set stock = stock-? where product_num=?";
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setInt(1, cart_count);
				 pstmt.setInt(2, product_num);
				 pstmt.executeUpdate();
				 
			 }catch(Exception e) {
				 throw new Exception(e);
			 }finally {
				 DBUtil.executeClose(null, pstmt, conn);
			 }
		 }
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
	}

