<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- header 시작 -->
	<!-- 상단 고정 네비게이션 시작 -->
	<div class="navbar navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<%-- <a class="navbar-brand" href="${pageContext.request.contextPath}/main/main.do">ABC shop</a> --%>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav navbar-right">
					<%-- <li><a href="${pageContext.request.contextPath}/main/main.do">Home</a></li>   --%>
					
					<%-- 비회원(로그아웃) --%>
					<c:if test="${empty user_number}">
					<li><a href="${pageContext.request.contextPath}/member/loginForm.do">login</a></li>
					<li><a href="${pageContext.request.contextPath}/member/signUpForm.do">join</a></li>					
					</c:if>
					<%-- 회원(로그인) --%>
					<c:if test="${!empty user_number && user_auth == 2}">
					<li><a href="${pageContext.request.contextPath}/member/logout.do">logout</a></li>					
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">my page</a>
						<ul class="dropdown-menu">
							<li><a href="${pageContext.request.contextPath}/member/modifyUserForm.do">회원정보</a></li>
							<li><a href="${pageContext.request.contextPath}/member/orderList.do">주문조회</a></li>									
							<li><a href="${pageContext.request.contextPath}/board/myReview.do">게시물관리</a></li>					
						</ul>
					</li>
					</c:if>
					<%-- 관리자(로그인) --%>
					<c:if test="${!empty user_number && user_auth == 3}">
						<li><a href="${pageContext.request.contextPath}/member/memberList.do">회원관리</a></li>
						<li><a href="${pageContext.request.contextPath}/order/list.do">주문관리</a></li>
						<li><a href="${pageContext.request.contextPath}/product/productWriteForm.do">상품등록</a></li>							
						<li><a href="${pageContext.request.contextPath}/product/productList.do">상품목록</a></li>
						<li><a href="${pageContext.request.contextPath}/member/logout.do">logout</a></li>
					</c:if>
					<%-- 비회원,회원,관리자 공통메뉴 --%>								
					<li><a href="${pageContext.request.contextPath}/product/cartList.do?uesr_number=${user_number}">cart</a></li>			
					<li><a href="${pageContext.request.contextPath}/board/list.do">review</a></li>
					</ul>
								
				<!-- 서치창 (보류) -->
				<!-- <form class="navbar-form pull-right" role="search">
            		<div class="input-group">
               			<input type="text" class="form-control" placeholder="Search">
               			<div class="input-group-btn">
                  			<button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search"></span></button>
               			</div>
            		</div>
         		</form> -->
         		
			</div>
		</div>
	</div>
	<!-- 상단 고정 네비게이션 끝 -->
	<%-- 사이트 로고 이미지 --%>
	<div class="align-center" >
		<a href="${pageContext.request.contextPath}/main/main.do">
		<img src="${pageContext.request.contextPath}/upload/logo.png" id="logo" >
		</a>
	</div>
	<%-- 카테고리 메뉴 --%>
	<div class="align-center blank common_title menu_font">   
		<div class="col-md-offset-4 col-md-1"><a href="${pageContext.request.contextPath}/main/main.do?page=outer"><h4>&nbsp;&nbsp;OUTER</h4></a></div>
		<div class="col-md-1"><a href="${pageContext.request.contextPath}/main/main.do?page=top"><h4>TOP</h4></a></div>
		<div class="col-md-1"><a href="${pageContext.request.contextPath}/main/main.do?page=bottom"><h4>BOTTOM</h4></a></div>
		<div class="col-md-1"><a href="${pageContext.request.contextPath}/main/main.do?page=etc"><h4>etc</h4></a></div>
		<div class="col-md-offset-4"></div>				
	</div>








