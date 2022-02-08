package kr.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface Action {
	//추상메서드
	public String execute(HttpServletRequest request, 
			                    HttpServletResponse response)throws Exception;
}
