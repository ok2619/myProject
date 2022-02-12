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
<style>
	#btn-1{width:300px;margin:auto;}
	.main2{width:900px;margin:0 auto;}
</style>
</head>
<body>
<div class="main2">
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
<input type="text" value="상세주소 입력"><br>

<hr class="mt-2 mb-3"/>
<div class="row">
	<div class="col-xs-6 col-md-3">
    	<a href="#" class="thumbnail">
      		<img src="../upload/NO.png" alt="no">
    	</a>
	</div>
  모델명 : </br>
  상품종류 : </br>
  수량 : </br>
  총금액 : </br>
  <hr class="mt-2 mb-3"/>
</div>
<input type="button" class="btn btn-outline-danger" value="계좌이체">
<input type="button" class="btn btn-outline-danger" value="카드결제"></br>
<hr class="mt-2 mb-3"/>
</div>


<div id="btn-1">
	<button type="button" class="btn btn-secondary btn-lg" style="background-color:black; color:white">총 ${totalPrice}원 결제</button>
</div>

</body>
</html>