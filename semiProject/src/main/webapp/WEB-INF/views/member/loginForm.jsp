<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h3 class="align-center common_title">로그인</h3>
	
<%--로그인 화면 샘플 1 --%>	
	<form action="login.do" method="post" class="form-horizontal" role="form"> 
		<div class="form-group"> 
			<label for="id" class="col-sm-3 control-label font4">아이디</label> 
			<div class="col-sm-9"> 
				<input type="text" class="form-control" id="id" name="id" placeholder="id"> 
			</div> 
		</div> 
		
		<div class="form-group"> 
			<label for="passwd" class="col-sm-3 control-label font4">비밀번호</label> 
			<div class="col-sm-9"> 
				<input type="password" class="form-control" id="passwd" name="passwd" placeholder="Password"> 
			</div> 
		</div> 
		<div class="blank_30"></div> 
		<div class="form-group"> 
		<div class="col-sm-offset-3 col-sm-9"> 
		</div> 
		</div> 
		
		<div class="form-group margin_left"> 
			<div class="col-sm-offset-3 col-sm-2"> 
				<button type="submit" class="btn btn-info font4 margin_left">로그인</button> 
			</div> 
			<div class="col-sm-7">
				<button type="button" class="btn font4 margin_left_10" onclick="location.href='${pageContext.request.contextPath}/member/signUpForm.do'">			
				회원가입
				</button> 
			</div> 
		</div> 	
	</form>  


<%--로그인 화면 샘플 2 --%>
<%-- <div class="page-main">
  <form action="login.do" method="post">
 	 <div class="row">
	    <div class="input-group">
	      <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
	      <input type="text" id="id" name="id" placeholder="아이디" class="form-control input-lg">
	    </div>
	    <p>
	    <div class="input-group">
	      <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
	      <input type="password" id="passwd" name="passwd" placeholder="비밀번호"  class="form-control input-lg" >
	    </div>
	    <br>   
	    <div class="login_btn">
	    	<button type="submit" class="btn btn-primary">
	    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;로그인&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    	</button>
	    	<p><p><p>
			<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/member/signUpForm.do'">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;회원가입&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</button>
		</div>
	</div>	
  </form>
</div> --%>

<%--로그인 기본 설정 --%>
<%-- <div class="page-main">
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h2 class="align-center common_title">로그인</h2>
<form action="login.do" method="post">
	<div class="input-group input-group-sm mb-3" style="width:80px">
	 
	    <label for="ID">아이디</label><br>
	  	<input type="text" class="form-control" id="id" name="id" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
	
		<label for="PASSWD">비밀번호</label><br>
	    <input type="password" class="form-control" id="passwd" name="passwd" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
	</div>

<button type="submit" class="btn btn-primary">로그인</button>
<button type="button" onclick="location.href='${pageContext.request.contextPath}/member/signUpForm.do'" class="btn btn-primary">회원가입</button>
</form>
</div> --%>
</body>
</html>