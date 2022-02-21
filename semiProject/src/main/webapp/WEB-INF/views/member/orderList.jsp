<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ABCshop :: 주문조회</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="js/bootstrap/bootstrap-dropdown.js"></script>
<script>
     $(document).ready(function(){
        $('.dropdown-toggle').dropdown()
    });
</script>
<script type="text/javascript">
	$(function(){			
		 $('#delete_btn').on('click',function(){
			alert('주문취소 완료');
			location.href='orderList.do';						
		});	
	});
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="page-main">
<h3 class="align-center common_title">주문조회</h3>
	<table class="table table-striped">
	  <thead>
	    <tr>
	      <th scope="col">주문번호</th>
	      <th scope="col">상품명</th>
	      <th scope="col">배송상태</th>
	      <th scope="col">주문날짜</th>
	      <th></th>
	    </tr>
	  </thead>
	  <tbody>
	  <c:forEach var="order" items="${list}">
	    <tr>
	      <th scope="row">${order.order_num}</th>
	      <td>${order.product_name}</td>

	      <td>
	      <c:choose>
	      <c:when test="${order.shipping == 1}">배송대기</c:when>
	      <c:when test="${order.shipping == 2}">배송준비중</c:when>
	      <c:when test="${order.shipping == 3}">배송중</c:when>
	      <c:when test="${order.shipping == 4}">배송완료</c:when>
	      <c:when test="${order.shipping == 5}"><p id="cancel_text">주문취소</p></c:when>
	      </c:choose>
		  </td>
	      <td>${order.reg_date}</td>
	      <td>	 
    	  <c:choose>
				<c:when test="${order.shipping == 5}"><span id="cencel_span"></span></c:when>
				<c:when test="${order.shipping != 5}">
				<input type="button" id="delete_btn" value="주문취소" class="btn btn-danger btn-sm"
				onclick="location.href='${pageContext.request.contextPath}/member/myOrderModify.do?order_num=${order.order_num}&shipping=${order.shipping}'">
				</c:when>
				</c:choose>
	      </td>
	    </tr>
	    </c:forEach>
	  </tbody>
	</table>
</div>	
</body>
</html>