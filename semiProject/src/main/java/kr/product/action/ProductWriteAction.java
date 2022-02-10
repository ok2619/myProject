package kr.product.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.controller.Action;
import kr.product.dao.ProductDAO;
import kr.product.vo.ProductVO;
import kr.util.FileUtil;

public class ProductWriteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Integer user_number = (Integer)session.getAttribute("user_number");
		if(user_number == null) {//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		MultipartRequest multi = FileUtil.createFile(request);
		ProductVO product = new ProductVO();
		product.setProduct_name(multi.getParameter("product_name"));
		product.setSort(multi.getParameter("sort"));
		product.setPrice(Integer.parseInt(multi.getParameter("price")));
		product.setContent(multi.getParameter("content"));
		product.setImage(multi.getFilesystemName("image"));
		
		ProductDAO dao = ProductDAO.getInstance();
		dao.insertBoard(product);
		
		return "/WEB-INF/views/product/productWrite.jsp";
	}

}
