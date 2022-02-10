package kr.product.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import kr.product.vo.ProductVO;
import kr.util.DBUtil;

public class ProductDAO {
	private static ProductDAO instance = new ProductDAO();
	public static ProductDAO getInstance() {
		return instance;
	}
	private ProductDAO() {}
	
	public void insertBoard(ProductVO product) throws Exception {
		// TODO Auto-generated method stub
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {

			conn = DBUtil.getConnection();
			sql = "insert into qproduct (product_num,stock,product_name,sort,price,image,content,reg_date) values (qproduct_seq.nextval,?,?,?,?,?,?,SYSDATE)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, product.getStock());
			pstmt.setString(2, product.getProduct_name());
			pstmt.setString(3, product.getSort());
			pstmt.setInt(4, product.getStock());
			pstmt.setString(5, product.getSort());
			pstmt.setString(6, product.getSort());

			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);;
		}
	}
	
		
	}

