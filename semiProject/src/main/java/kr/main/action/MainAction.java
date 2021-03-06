package kr.main.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.product.dao.ProductDAO;
import kr.product.vo.ProductVO;
import kr.util.PagingUtil;

public class MainAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		/////////////////////////////////////////////////////////////////////////////
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) pageNum = "1";
		
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		
		if(keyfield == null) keyfield = "";
		if(keyword == null) keyword = "";
		
		ProductDAO dao = ProductDAO.getInstance();
		int count = dao.getBoardCount(keyfield, keyword);
		
		//페이지 처리
		//keyfield,keyword,currentPage,count,rowCount,pageCount,url
		PagingUtil page = new PagingUtil(keyfield,keyword,
				          Integer.parseInt(pageNum),count,30,20,"productList.do");
		
		List<ProductVO> list = null;
		String pageSort = request.getParameter("page");
		if(pageSort == null) {
		if(count > 0) {
			list = dao.getListBoard(page.getStartCount(), page.getEndCount(), 
					                                     keyfield, keyword);
			}
		}else if(pageSort != null) {
			list = dao.getListBoard2(page.getStartCount(), page.getEndCount(), 
                    keyfield, keyword,pageSort);
		}
		
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("pagingHtml", page.getPagingHtml());
		/////////////////////////////////////////////////////////////////////////////
		
		
		//JSP 경로 반환
		return "/WEB-INF/views/main/main.jsp";
	} 

}
