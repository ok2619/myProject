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
<div class="input-group input-group-sm mb-3" style="width:80px">
    <label for="ID">아이디</label><br>
  	<input type="text" class="form-control" id="user_id" name="user_id" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
	<button type="button" class="btn btn-primary">중복체크</button>
	
	<label for="PASSWD">비밀번호</label><br>
    <input type="password" class="form-control" id="passwd" name="passwd" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
    <label for="CPASSWD">비밀번호 확인</label><br>
    <input type="password" class="form-control" id="cpasswd" name="cpasswd" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
    <label for="NAME">이름</label><br>
  	<input type="text" class="form-control" id="name" name="name" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
  	<label for="PHONE">연락처</label><br>
  	<input type="text" class="form-control" id="phone" name="phone" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
  	
  	<label for="zipcode">우편번호</label><br>
  	<input type="text" class="form-control" id="zipcode" name="zipcode" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
  	<button type="button" onclick="sample2_execDaumPostcode()" class="btn btn-primary">우편번호 찾기</button>
  	
  	<label for="address1">주소</label><br>
  	<input type="text" class="form-control" id="address1" name="address1" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
  	<label for="address2">상세주소</label><br>
  	<input type="text" class="form-control" id="address2" name="address2" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
  	
  	<input type="submit" value="가입">
</div>

</form>
</body>
</html>