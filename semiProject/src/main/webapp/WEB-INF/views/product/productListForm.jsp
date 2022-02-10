<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<form id="search_form" action="productList.do" method="get">
		<ul class="search">
			<li>
				<select name="keyfield">
					<option value="1">상품명</option>
					<option value="2">상풍종류</option>
				</select>
			</li>
			<li>
				<input type="search" size="16" name="keyword" id="keyword"
				                                   value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="검색">
			</li>
		</ul>
	</form>

	<c:if test="${count == 0}">
	<div class="result-display">
		표시할 게시물이 없습니다.
	</div>	
	</c:if>
	<c:if test="${count > 0}">
	<table class="table">
		<tr>
			<th>상품명</th>
			<th>사진</th>
			<th>상품종류</th>
			<th>가격</th>
			<th>재고</th>
			<th>등록일</th>
		</tr>
		<c:forEach var="product" items="${list}">
		<tr>
			<td>${product.product_name}</td>
			<c:choose>
			<c:when test="${product.image == null}">
			<td><img src="../upload/NO.png" height="180" width="180"></td>
			</c:when>
			<c:when test="${product.image != null}">
			<td><img src="../upload/${product.image}" height="180" width="180"></td>
			</c:when>
			</c:choose>
			<%-- <td><a href="boardListDetailForm.do?board_num=${product.board_num}">${board.title}</a></td> --%>
			<td>${product.sort}</td>
			<td>${product.price}</td>
			<td>${product.stock}</td>
			<td>${product.reg_date}</td>
		</tr>	
		</c:forEach>
	</table>
	<div class="align-center">
		${pagingHtml}
	</div>
	</c:if>
</body>
</html>
</body>
</html>