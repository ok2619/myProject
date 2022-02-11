package kr.product.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.board.vo.BoardVO;
import kr.product.vo.ProductVO;
import kr.util.DBUtil;
import kr.util.StringUtil;

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
					sql ="update qproduct set product_name=?,price=?,sort=?,stock=?,content=?,reg_date=SYSDATE"   
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
		 
	}

