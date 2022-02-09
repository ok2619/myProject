<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<form action="#" method="post">
<div>
<div class="input-group input-group-sm mb-3" style="width:80px">
 
    <label for="ID">아이디</label><br>
  	<input type="text" class="form-control" id="user_id" name="user_id" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">

	<label for="PASSWD">비밀번호</label><br>
    <input type="password" class="form-control" id="passwd" name="passwd" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
</div>

<button type="submit" class="btn btn-primary">로그인</button>
<button type="button" onclick="location.href='${pageContext.request.contextPath}/member/signUpForm.do'" class="btn btn-primary">회원가입</button>
</div>
</form>
</body>
</html>