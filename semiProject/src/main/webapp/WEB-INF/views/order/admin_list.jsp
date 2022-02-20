<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 목록</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#search_review').on('submit',function(){
			if($('#keyword').val().trim()==''){
				alert('검색어를 입력하세요!');
				$('#keyword').val('').focus();
				return false;
			}
			if($('#keyfield').val() == 1 && isNaN($('#keyword').val())){
				alert('주문번호는 숫자만 입력하세요!');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="page-main">	
	<h3 class="align-center common_title">구매 목록</h3>
	<c:if test="${count == 0}">
		<table class="table table-hover">
		  <thead>
			<tr class="info font2">
		 		<th>주문번호</th>
				<th>구매자ID</th>
				<th>상품명</th>
				<th>총구매금액</th>
				<th>주문날짜</th>
				<th>배송상태</th>
			</tr>
		 	</thead>
		    <tbody>			
			  <tr>
				<td colspan="6" class="align-center">			
				<p>
				<div class="blank_20"></div>
				표시할 주문내역이 없습니다.	
				<div class="blank_20"></div>	
				<p>
				</td>				
			 </tr>
		  </tbody>			
		</table>
	</c:if>
	<c:if test="${count > 0}">
		<table class="table">
			<tr class="info font2">
				<th>주문번호</th>
				<th>구매자ID</th>
				<th>상품명</th>
				<th>총구매금액</th>
				<th>주문날짜</th>
				<th>배송상태</th>
			</tr>
			<c:forEach var="order" items="${list}">
			<tr>
				<td><a href="modifyForm.do?order_num=${order.order_num}">${order.order_num}</a></td>
				<td>${order.id}</td>
				<td><a href="modifyForm.do?order_num=${order.order_num}">${order.product_name}</a></td>
				<td><fmt:formatNumber value="${order.order_total}"/>원</td>
				<td>${order.reg_date}</td>
				<td>
					<c:if test="${order.shipping == 1}">배송대기</c:if>
					<c:if test="${order.shipping == 2}">배송준비중</c:if>
					<c:if test="${order.shipping == 3}">배송중</c:if>
					<c:if test="${order.shipping == 4}">배송완료</c:if>
					<c:if test="${order.shipping == 5}">주문취소</c:if>
				</td>
			</tr>
			</c:forEach>
		</table>
	</c:if>
	<form action="list.do" method="get" id="search_review">
		<ul class="search_review">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>주문번호</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>ID</option>
					<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>상품명</option>
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
	<p class="clear"></p>
		<div class="blank_50"></div>	
		<div class="align-center">
			${pagingHtml}
		</div>	
		<div class="blank_50"></div>	
	</div>	
</body>
</html>





