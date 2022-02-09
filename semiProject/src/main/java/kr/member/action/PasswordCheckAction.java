package kr.member.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;

public class PasswordCheckAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");

		String passwd = request.getParameter("passwd");
		String cpasswd = request.getParameter("cpasswd");

		Map<String,String> mapAjax = new HashMap<String,String>();

		if(passwd.equals(cpasswd)) {
			mapAjax.put("result", "agreement");
		}else{
			mapAjax.put("result", "disagreement");
		}
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);

		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
