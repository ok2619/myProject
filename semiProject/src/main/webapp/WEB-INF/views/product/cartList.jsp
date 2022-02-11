<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
</head>
<body>
	<table class="table">
		<tr>
			<th>번호</th>
			<th>사진(상품명)</th>
			<th>상품종류</th>
			<th>판매가</th>
			<th>수량</th>
		</tr>
		<tr>
			<td>1</td>
			<td>사진 신발</td>
			<td>신발</td>
			<td>40,000</td>
			<td>2</td>
		</tr>
		<tr>
			<td>총가격</td>
			<td>180,000</td>
			<td></td>
			<td>총개수</td>
			<td>11</td>
		</tr>		
	</table>
	<span>총개수 : </span></br>
	<input type="button" value="총 40,000원 결제">
</body>
</html>