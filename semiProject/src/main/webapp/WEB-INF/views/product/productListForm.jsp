<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 | 상품 목록</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="page-main">	
	<h3 class="align-center common_title">상품 목록</h3>
		<c:if test="${count == 0}">
			<table class="table table-hover">
			  	<thead>
					<tr class="info font2">
						<th>상품 번호</th>
						<th>상품명</th>
						<th>사진</th>
						<th>상품 종류</th>
						<th>가격</th>
						<th>재고</th>
						<th>등록일</th>
					</tr>
			 	 </thead>
			 	 <tbody>			
					<tr>
						<td colspan="7" class="align-center">			
						<p><div class="blank_20"></div>
						표시할 상품이 없습니다.		
						<p><div class="blank_20"></div>
						</td>				
					</tr>
				  </tbody>			
			</table>
		</c:if>
		<c:if test="${count > 0}">
			<table class="table">
				<tr class="info font4">
					<th>상품 번호</th>
					<th>상품명</th>
					<th>사진</th>
					<th>상품 종류</th>
					<th>가격</th>
					<th>재고</th>
					<th>등록일</th>
				</tr>
				<c:forEach var="product" items="${list}">
				<tr>
					<td>${product.product_num}</td>
					<td><a href="productUpdateForm.do?product_num=${product.product_num}">${product.product_name}</a></td>
					<c:choose>
					<c:when test="${product.image == null}">
					<td><img src="../upload/NO.png" class="list-img"></td>
					</c:when>
					<c:when test="${product.image != null}">
					<td><a href="productDetail.do?product_num=${product.product_num}"><img src="../upload/${product.image}" height="100" width="100" ></a></td>
					</c:when>
					</c:choose>
					
					<td>${product.sort}</td>
					<td><fmt:formatNumber value="${product.price}" pattern="#,###" /></td>
						
					<c:choose>
					<c:when test="${product.stock <= 0}">
					<td>품절</td>
					</c:when>
					<c:when test="${product.stock > 0}">
					<td>${product.stock}</td>
					</c:when>
					</c:choose>				
					<td>${product.reg_date}</td>				
				</tr>	
				</c:forEach>
			</table>
		</c:if>
		<!-- 검색창 시작 -->
		<form id="search_review" action="productList.do" method="get">
			<ul class="search_review">
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
					<input type="submit" value="검색" class="btn btn-default btn-sm">
				</li>
			</ul>
		</form>
		<!-- 검색창 끝 -->
		<p class="clear"></p>
		<div class="blank_50"></div>	
		<div class="align-center">
			${pagingHtml}
		</div>	
		<div class="blank_50"></div>	
	</div>	
</body>
</html>