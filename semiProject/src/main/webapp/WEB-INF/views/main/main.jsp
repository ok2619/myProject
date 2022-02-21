<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial_scale=1.0">
<title>ABCshop :: main</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<!-- <style>
.all{width:900px;margin:0 auto;}
.row2{width:33%;float:left;}
</style> -->
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</head>
<body>
<script type="text/javascript">
 $(function(){
	$('.cart-in').on('click',function(){
		$.ajax({
			url:'../product/cartIn.do',
			type:'post', 
			data:{product_num:$(this).attr('data-num')},
			dataType:'json',
			cache:false,
			timeout:30000,
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요!');
					location.href='main.do';
				}else if(param.result == 'noQuantity'){
					alert('상품의 수량이 부족합니다.');
					location.href='main.do';
				}else if(param.result == 'success'){
					alert('장바구니에 담겼습니다.');
					location.href='main.do';
				}else if(param.result == 'success2'){
					alert('장바구니에 담겼습니다.');
					location.href='main.do';
				}else{
					alert('장바구니 담기 오류 발생');
				}
			},
			error:function(){
				alert('네크워크 오류 발생');
			}
		});
	});
}); 
  
</script>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<c:forEach var="product" items="${list}">
<div class="all">
	<div class="row2">
  		<div class="col-sm-4 col-md-2" style="width:300px;">
   			<div class="thumbnail">
        		<a href="${pageContext.request.contextPath}/product/productDetail.do?product_num=${product.product_num}"><img src="../upload/${product.image}"></a>
				     <div class="caption">
				     	<h4 class="font2"><a href="${pageContext.request.contextPath}/product/productDetail.do?product_num=${product.product_num}">${product.product_name}</a></h4>
				        	<p><fmt:formatNumber value="${product.price}" pattern="#,###" />원</p>				        	
				        	<p>	        	
				        		<c:if test="${product.stock > 0 }">		        	
				        	<a href="${pageContext.request.contextPath}/product/buyForm.do?product_num=${product.product_num}&cart_count=1" id="per" class="btn btn-default btn-sm btn_a" role="button">구매하기</a>
				        	</c:if>
				        	<c:if test="${product.stock <= 0 }">
				        	<span>품절</span>
				        	</c:if>
				        		<a href="#"><img src="../upload/cart.png" class="cart-in btn_b" id="img1" data-num="${product.product_num}"></a>				        								
				        	</p>
				     </div>
    			</div>
  			</div>
		</div>
	</div> 
</c:forEach>
</body>
</html>