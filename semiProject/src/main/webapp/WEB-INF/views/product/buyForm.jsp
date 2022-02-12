<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
</head>
<body>
<h4>주문 / 결제</h4>
<span>수령자 정보</span></br>

<label for="name" class="control-label">수령자</label>
<input type="text" value="수령자 입력"></br>
<label for="phone" class="control-label">전화번호</label>
<input type="text" value="전화번호 입력"></br>
<label for="address1" class="control-label">주소</label>
<input type="text" value="주소 입력">
<input type="button" value="주소찾기" class="btn btn-default btn-xs"></br>
<label for="address2" class="control-label"></label>
<input type="text" value="상세주소 입력">

</body>
</html>