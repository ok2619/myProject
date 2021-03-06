package kr.member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.board.vo.BoardVO;
import kr.member.vo.MemberVO;
import kr.order.vo.OrderDetailVO;
import kr.order.vo.OrderVO;
import kr.util.DBUtil;
import kr.util.StringUtil;

public class MemberDAO {
	
	private static MemberDAO instance = new MemberDAO();
	public static MemberDAO getInstance() {
		return instance;
	}
	private MemberDAO() {}
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ		
	//회원가입
	public void insertMember(MemberVO member)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null; 
		PreparedStatement pstmt3 = null;
		ResultSet rs = null;
		String sql = null;
		int num = 0;
		
		try {
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			
			sql = "select qmember_seq.nextval from dual";			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				num = rs.getInt(1);
			}
			
			sql = "insert into qmember (user_num,id) values (?,?)";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, num);
			pstmt2.setString(2, member.getId());
			pstmt2.executeUpdate();
			
			sql = "insert into qmember_detail (user_num,name,passwd,phone,zipcode,address1,address2) values (?,?,?,?,?,?,?)";
			pstmt3 = conn.prepareStatement(sql);		
			pstmt3.setInt(1, num);
			pstmt3.setString(2, member.getName());
			pstmt3.setString(3, member.getPasswd());
			pstmt3.setString(4, member.getPhone());
			pstmt3.setString(5, member.getZipcode());
			pstmt3.setString(6, member.getAddress1());
			pstmt3.setString(7, member.getAddress2());
			pstmt3.executeUpdate();
			
			conn.commit();
			
		}catch(Exception e) {
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(null, pstmt3, null);
		}
	}
	
	//ID중복 체크 및 로그인 처리
	public MemberVO checkMember(String id)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO member = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "select * from qmember m left outer join qmember_detail d on m.user_num=d.user_num where m.id=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member = new MemberVO();
				member.setUser_num(rs.getInt("user_num"));
				member.setId(rs.getString("id"));
				member.setAuth(rs.getInt("auth"));
				member.setPasswd(rs.getString("passwd"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return member;
	}

	
	//회원상세정보
	public MemberVO getMember(int user_num)throws Exception{
		Connection conn=null;
		PreparedStatement pstmt =null;
		ResultSet rs=null;
		MemberVO member = null;
		String sql=null;
		
		try {
			//커넥션풀로부터 커넥션을 할당받음 
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "SELECT * FROM qmember m JOIN qmember_detail d "
					+ "ON m.user_num=d.user_num WHERE m.user_num=?";	
			
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, user_num);
			
			//SQL문을 테이블에 반영하고 결과행(한가지)을 ResultSet에 담는다
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member = new MemberVO(); //자바빈(VO)객체 생성
								
				member.setUser_num(rs.getInt("user_num"));
				member.setId(rs.getString("id"));
				member.setAuth(rs.getInt("auth"));
				member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
				member.setPhone(rs.getString("phone"));
				member.setZipcode(rs.getString("zipcode"));
				member.setAddress1(rs.getString("address1"));
				member.setAddress2(rs.getString("address2"));
				member.setReg_date(rs.getDate("reg_date"));
			}
		}catch(Exception e) {
			throw new Exception(e); 
		}finally {
			//자원정리
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return member; 
	}
	
	//회원정보수정
	public void updateMember(MemberVO member)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			//커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문
			sql = "UPDATE qmember_detail SET name=?,phone=?,zipcode=?,address1=?,address2=? WHERE user_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getName());
			pstmt.setString(2, member.getPhone());
			pstmt.setString(3, member.getZipcode());
			pstmt.setString(4, member.getAddress1());
			pstmt.setString(5, member.getAddress2());
			pstmt.setInt(6, member.getUser_num());
			//SQL실행
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			//자원정리
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//비밀번호수정
	public void updatePassword(String passwd, int user_number)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "update qmember_detail set passwd=? where user_num=?";
			
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, passwd);
			pstmt.setInt(2, user_number);
			
			pstmt.executeUpdate();			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
		
	//회원탈퇴(회원정보 삭제)
	public void deleteMember(int user_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		String sql = null;
		
		try{
			//커넥션 할당
			conn = DBUtil.getConnection();
			//오토커밋 해제
			conn.setAutoCommit(false);
			
			//qmember auth값 변경
			sql = "UPDATE qmember SET auth=0 WHERE user_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, user_num);
			//SQL 실행
			pstmt.executeUpdate();
			
			//qmember_dtail 레코드 삭제
			sql = "DELETE FROM qmember_detail WHERE user_num=?";
			//PreparedStatement 객체 생성
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, user_num);
			//SQL 실행
			pstmt2.executeUpdate();
			
			//sql문 모두 성공하면 커밋
			conn.commit();
		}catch(Exception e) {
			//sql문 실패하면 롤백
			conn.rollback();
			throw new Exception(e);
		}finally {
			//자원정리
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(null, pstmt, conn);
		}
	 }
	
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ		
	//[관리자]
	//총 회원 수
		public int getMemberCountByAdmin(String keyfield, String keyword)throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			String sub_sql = "";
			int count = 0;

			try {
				//커넥션풀로부터 커넥션을 할당
				conn = DBUtil.getConnection();
				
				if(keyword != null && !"".equals(keyword)) {
					//검색글 처리
					if(keyfield.equals("1")) sub_sql = "WHERE m.id LIKE ?";
					else if(keyfield.equals("2")) sub_sql = "WHERE d.name LIKE ?";
				}

				//전체 또는 검색 레코드 갯수
				sql = "SELECT COUNT(*) FROM qmember m "
						+ "LEFT OUTER JOIN qmember_detail d USING(user_num)" + sub_sql;
				//PreparedStatement 객체 생성
				pstmt = conn.prepareStatement(sql);
				if(keyword != null && !"".equals(keyword)) {
					pstmt.setString(1, "%" + keyword + "%");
				}
		
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
		
		//회원 목록
		public List<MemberVO> getListMemberByAdmin(int startRow, int endRow,String keyfield, String keyword)throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<MemberVO> list = null;
			String sql = null;
			String sub_sql = "";
			int cnt = 0;

			try {
				//커넥션풀로부터 커넥션 할당
				conn = DBUtil.getConnection();
				
				if(keyword != null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql = "WHERE m.id LIKE ?";
					else if(keyfield.equals("2")) sub_sql = "WHERE d.name LIKE ?";
				}

			//SQL문 작성
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM "
				+ "(SELECT * FROM qmember m LEFT OUTER JOIN qmember_detail d "
				+ "USING(user_num) " + sub_sql + " ORDER BY reg_date DESC NULLS LAST)a) "
				+ "WHERE rnum >= ? AND rnum <= ?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			if(keyword != null && !"".equals(keyword)) {
				pstmt.setString(++cnt, "%" + keyword + "%");
			}
			pstmt.setInt(++cnt, startRow);
			pstmt.setInt(++cnt, endRow);

			//SQL문을 테이블에 반영하고 결과행들을 ResultSet에 담음
			rs = pstmt.executeQuery();
			list = new ArrayList<MemberVO>();
			while(rs.next()) {
				MemberVO member = new MemberVO();
				member.setUser_num(rs.getInt("user_num"));
				member.setId(rs.getString("id"));
				member.setAuth(rs.getInt("auth"));
				member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
				member.setPhone(rs.getString("phone"));
				member.setZipcode(rs.getString("zipcode"));
				member.setAddress1(rs.getString("address1"));
				member.setAddress2(rs.getString("address2"));
				member.setReg_date(rs.getDate("reg_date"));

				//자바빈(VO)를 리스트에 저장
				list.add(member);
			}

		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			//자원정리
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	//(관리자)회원 정보 수정
		public void updateMemberByAdmin(MemberVO member)throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			PreparedStatement pstmt2 = null;
			String sql = null;

			try {
				//커넥션풀로부터 커넥션을 할당
				conn = DBUtil.getConnection();
				//오토 커밋 해제
				conn.setAutoCommit(false);

				sql = "UPDATE qmember SET auth=? WHERE user_num=?";
				//PreparedStatement 객체 생성
				pstmt = conn.prepareStatement(sql);
				//?에 데이터 바인딩
				pstmt.setInt(1, member.getAuth());
				pstmt.setInt(2, member.getUser_num());
				//SQL문 실행
				pstmt.executeUpdate();

				sql ="UPDATE qmember_detail SET name=?,phone=?,zipcode=?,address1=?,address2=? WHERE user_num=?";
				//PreparedStatement 객체 생성
				pstmt2 = conn.prepareStatement(sql);
				//?에 데이터 바인딩
				pstmt2.setString(1, member.getName());
				pstmt2.setString(2, member.getPhone());
				pstmt2.setString(3, member.getZipcode());
				pstmt2.setString(4, member.getAddress1());
				pstmt2.setString(5, member.getAddress2());
				pstmt2.setInt(6, member.getUser_num());
				//SQL 실행
				pstmt2.executeUpdate();

				//모든 SQL문이 정상적으로 실행
				conn.commit();
			}catch(Exception e) {
				//SQL문이 하나라도 실패하면
				conn.rollback();
				throw new Exception(e);
			}finally {
				//자원정리
				DBUtil.executeClose(null, pstmt2, null);
				DBUtil.executeClose(null, pstmt, conn);
			}
		}


//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ			
		//레코드 수
		//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
		// 총 레코드 수(검색 레코드 수)
		public int getOrderCount(int user_num) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int count = 0;

			try {
				conn = DBUtil.getConnection();
				sql = "SELECT COUNT(*) FROM qboard b JOIN qmember m USING(user_num) where user_num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, user_num);

				rs = pstmt.executeQuery();
				if (rs.next()) {
					count = rs.getInt(1);
				}
			} catch (Exception e) {
				throw new Exception(e);
			} finally {
				DBUtil.executeClose(rs, pstmt, conn);
			}
			return count;
		}
		
		//내 주문 목록 보기
		public List<OrderVO> getMyOrder(int startRow, int endRow, String keyfield, String keyword, int user_number)
				throws Exception {

			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<OrderVO> list = null;
			String sql = null;
			int cnt = 0;

			try {
				// 커넥션풀로부터 커넥션을 할당
				conn = DBUtil.getConnection();

				// SQL문 작성 
				sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM "
						+ "(SELECT * FROM qorder b JOIN qmember m "
						+ "USING(user_num) where user_num = ?"
						+ "ORDER BY b.order_num DESC)a) WHERE rnum >= ? AND rnum <= ?";

				// preparedStatement 객체 생성
				pstmt = conn.prepareStatement(sql);
				// sub_sql의 ?에 데이터 매핑위해 조건체크 (new)
				if (keyword != null && !"".equals(keyword)) {
					pstmt.setString(++cnt, "%" + keyword + "%");
				}

				// ?에 데이터 바인딩
				pstmt.setInt(++cnt, user_number);
				pstmt.setInt(++cnt, startRow);
				pstmt.setInt(++cnt, endRow);

				// SQL문을 테이블에 반영해 결과행들을 ResultSet에 담음
				rs = pstmt.executeQuery();
				// ArrayList 객체 생성
				list = new ArrayList<OrderVO>();
				// 반복문을 이용해 반복, 자바빈을 생성하고 정보를 저장
				while (rs.next()) {
					// 하나의 레코드 정보를 담기 위해 BoardVO 객체(자바빈)를 생성
					OrderVO order = new OrderVO();
					order.setOrder_num(rs.getInt("order_num"));
					order.setProduct_name(rs.getString("product_name"));
					order.setShipping(rs.getInt("shipping"));
					order.setReg_date(rs.getDate("reg_date"));
					order.setPayment(rs.getInt("payment"));

					// VO를 ArrayList에 등록(저장해줘야함)
					list.add(order);
				}
			} catch (Exception e) {
				throw new Exception(e);
			} finally {
				DBUtil.executeClose(rs, pstmt, conn);
			}
			return list;
		}
		//개별 상품 목록
				public List<OrderDetailVO> getListOrderDetail(int order_num)throws Exception{
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					List<OrderDetailVO> list = null;
					String sql = null;
					
					try {
						//커넥션풀로부터 커넥션을 할당
						conn = DBUtil.getConnection();
						//SQL문
						sql = "SELECT * FROM qorder_detail WHERE order_num=? ORDER BY product_num DESC";
						//PreparedStatement 객체 생성
						pstmt = conn.prepareStatement(sql);
						//?에 데이터를 바인딩
						pstmt.setInt(1, order_num);
						
						//SQL문을 실행해서 결과행들을 ResultSet에 담음
						rs = pstmt.executeQuery();
						
						list = new ArrayList<OrderDetailVO>();
						while(rs.next()) {
							OrderDetailVO detail = new OrderDetailVO();
							detail.setProduct_num(rs.getInt("product_num"));
							detail.setProduct_name(rs.getString("product_name"));
							detail.setProduct_price(rs.getInt("product_price"));
							detail.setProduct_total(rs.getInt("product_total"));
							detail.setCart_count(rs.getInt("cart_count"));
							
							list.add(detail);
						}
						
					}catch(Exception e) {
						throw new Exception(e);
					}finally {
						//자원정리
						DBUtil.executeClose(rs, pstmt, conn);
					}
					return list;
				}
		///////////주문취소
		public String cencelMyOrder(OrderVO order) throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			PreparedStatement pstmt2 = null;
			String sql = null;
			try {
				conn = DBUtil.getConnection();
				
				conn.setAutoCommit(false);
				
				sql = "UPDATE qorder SET shipping=? WHERE order_num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, order.getShipping());
				pstmt.setInt(2, order.getOrder_num());

				pstmt.executeUpdate();
				
				//주문취소일 경우만 상품갯수 조정
				if(order.getShipping() == 5) {
					//주문번호에 해당하는 상품 정보 구하기
					List<OrderDetailVO> detailList = getListOrderDetail(order.getOrder_num());
					
					//sql문 작성
					sql = "UPDATE qproduct SET stock = stock + ? WHERE product_num = ?";
					//PreparedStatement 객체 생성
					pstmt2 = conn.prepareStatement(sql);
					for(int i = 0; i<detailList.size(); i++) {
						OrderDetailVO detail = detailList.get(i);
						pstmt2.setInt(1, detail.getCart_count());
						pstmt2.setInt(2, detail.getProduct_num());
						pstmt2.addBatch();
						
						//계속 추가하면 outOfMemory 발생, 1000개 단위로 executeDatch()
						if(i % 1000 == 0) {
							pstmt2.executeBatch();
						}
					}//end of for
					pstmt2.executeBatch();
				}//end of if
				
				conn.commit();
			}catch(Exception e) {
				conn.rollback();
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(null, pstmt2, null);
				DBUtil.executeClose(null, pstmt, conn);
			}
			return "cencel";
		}
}

