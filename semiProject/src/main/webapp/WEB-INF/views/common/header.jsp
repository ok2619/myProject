<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- header 시작 -->
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial_scale=1.0"> <!-- ?? -->
<title>bootstrap</title>
<link rel="stylesheet" href="../css/bootstrap.min.css" type="text/css">
</head>
<body>
	<!-- 상단 고정 네이게이션 시작 -->
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">ABC shop</a>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li><a href="${pageContext.request.contextPath}/main/main.do">Home</a></li>
					
					<c:if test="${empty user_number}">
					<li><a href="${pageContext.request.contextPath}/member/loginForm.do">login</a></li>
					<li><a href="${pageContext.request.contextPath}/member/signUpForm.do">join</a></li>
					</c:if>
					
					<c:if test="${!empty user_number && user_auth == 2}">
					<li><a href="#">cart</a></li>
					<li><a href="${pageContext.request.contextPath}/member/logout.do">logout</a></li>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">my page</a>
						<ul class="dropdown-menu">
							<li><a href="${pageContext.request.contextPath}/member/modifyUserForm.do">개인정보수정</a></li>
							<li><a href="#">주문내역</a></li>
							<li><a href="#">내가쓴글</a></li>
						</ul>
					</li>
					</c:if>
					
					<c:if test="${!empty user_number && user_auth == 3}">
						<li><a href="${pageContext.request.contextPath}/member/memberList.do">회원관리</a></li>
						<li><a href="#">상품등록</a></li>
						<li><a href="${pageContext.request.contextPath}/member/logout.do">logout</a></li>
					</c:if>
										
					<li><a href="${pageContext.request.contextPath}/board/list.do">review</a></li>
				</ul>
				<form class="navbar-form pull-right" role="search">
            		<div class="input-group">
               			<input type="text" class="form-control" placeholder="Search">
               			<div class="input-group-btn">
                  			<button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search"></span></button>
               			</div>
            		</div>
         		</form>
			</div>
		</div>
	</div>
	<!-- 상단 고정 네이게이션 끝 -->



	<script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
</body>
</html>
<!-- header 끝 -->







