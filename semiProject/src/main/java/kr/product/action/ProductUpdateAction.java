package kr.product.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import kr.board.vo.BoardVO;
import kr.controller.Action;
import kr.product.dao.ProductDAO;
import kr.product.vo.ProductVO;
import kr.util.FileUtil;

public class ProductUpdateAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		MultipartRequest multi = FileUtil.createFile(request);
		int product_num = Integer.parseInt(multi.getParameter("product_num"));
		String image = multi.getFilesystemName("image");
		
		ProductDAO dao = ProductDAO.getInstance();
		ProductVO db_product = dao.getProduct(product_num);
		
		ProductVO product = new ProductVO();
		product.setProduct_num(product_num);
		product.setProduct_name(multi.getParameter("product_name"));
		product.setPrice(Integer.parseInt(multi.getParameter("price")));
		product.setSort(multi.getParameter("sort"));
		product.setStock(Integer.parseInt(multi.getParameter("stock")));
		product.setContent(multi.getParameter("content"));
		product.setImage(image);
		
		dao.updateProduct(product);
		
		if(image!=null) {
			FileUtil.removeFile(request, db_product.getImage());
		}
		
		
		return "redirect:/product/productDetail.do?product_num="+product_num;
	}

}
