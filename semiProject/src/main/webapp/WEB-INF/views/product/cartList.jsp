<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<style>
    #btn-1{width:300px;margin:auto;}
</style>
</head>
<body>
	<table class="table">
		<tr>
			<th>번호</th>
			<th>사진</th>
			<th>상품명</th>
			<th>상품종류</th>
			<th>판매가</th>
			<th>수량</th>
			<th></th>
		</tr>
		
		
		<c:set var="totalPrice" value="0"/>
		<c:set var="totalCount" value="0"/>
		<c:forEach var="product" items="${product}">
		<tr>
			<td>${product.product_num}</td>
			<td><img src="../upload/${product.image}" height="100" width="100"></td>
			<td>${product.product_name}</td>
			<td>${product.sort}</td>
			<td>${product.price}</td>
			<td>${product.cart_count}</td>
			<td><input type="button" value="삭제" onclick="location.href='cartDelete.do?product_num=${product.product_num}'">
		</tr>
		<c:set var="totalPrice" value="${totalPrice + product.price * product.cart_count}"/>
		<c:set var="totalCount" value="${totalCount + product.cart_count}"/>
		</c:forEach>
		
		<tr>
			<td>총가격</td>
			<td><c:out value="${totalPrice}"/></td>
			<td></td>
			<td>총개수</td>
			<td><c:out value="${totalCount}"/></td>
		</tr>
	</table>
	<div id="btn-1">
	<button type="button" class="btn btn-secondary btn-lg" style="background-color:black; color:white">총 ${totalPrice}원 결제</button>
	</div>
</body>
</html>