<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial_scale=1.0">
<title>abc shop</title>
<link rel="stylesheet" href="../css/bootstrap.min.css" type="text/css">
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<style>
.all{width:900px;margin:0 auto;}
.row2{width:33%;float:left;}

</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<c:forEach var="product" items="${list}">
<div class="all">
	<div class="row2">
  		<div class="col-sm-4 col-md-2" style="width:300px;">
   			<div class="thumbnail">
        		<img src="../upload/${product.image}">
				     <div class="caption">
				     	<h3>${product.product_name}</h3>
				        	<p><fmt:formatNumber value="${product.price}" pattern="#,###" /></p>				        	
				        	<p>
				        	<a href="${pageContext.request.contextPath}/product/productDetail.do?product_num=${product.product_num}" class="btn btn-primary" role="button">상품보기</a>
							<a href="${pageContext.request.contextPath}/product/mainCart.do?product_num=${product.product_num}" class="btn btn-default" role="button">장바구니</a>
				        	</p>
				     </div>
    			</div>
  			</div>
		</div>
	</div> 
</c:forEach>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</body>
</html>