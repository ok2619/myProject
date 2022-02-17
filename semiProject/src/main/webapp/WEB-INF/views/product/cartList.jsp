<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

$(function(){
	//장바구니 상품 주문 수량 변경
	$('.cart-modify').on('click',function(){
		let input_quantity = $(this).parent().find('input[name="cart_count"]');
		if(input_quantity.val()==''){
			alert('수량을 입력하세요');
			input_quantity.focus();
			return;
		}
		
		if(input_quantity.val()<1){
			alert('상품의 최소수량은 1입니다.');
			input_quantity.val(input_quantity.attr('value')); 
			return;
		}
		
		//ajax처리 
		$.ajax({
			url:'modifyCart.do',
			type:'post',
			data:{cart_num:$(this).attr('data-cartnum'),product_num:$(this).attr('data-itemnum'),cart_count:input_quantity.val()},
			dataType: 'json',
			cache:false,
			timeout:30000,
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요')
				}else if(param.result == 'noQuantity'){
					alert('수량이 부족합니다.');
					location.href='cartList.do';
				}else if(param.result == 'success'){
					alert('수량 변경 완료');
					location.href='cartList.do';
				}else{
					alert('수정시 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생')
			}
		});
	}); //end of 수량변경

}); 

</script>
 <style>
    #btn-1{width:300px;margin:auto;}
    #w1{width:500px;margin:auto;} 
</style> 
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="page-main">
	<%-- <form id="cart_order" method="post" 
	action="${pageContext.request.contextPath}/order/orderForm.do">  --%>
	<table class="table">
		<tr>
			<!-- <th>번호</th> -->
			<th>이미지</th>
			<th>상품정보</th>			
			<th>판매가</th>
			<th>수량</th>
			<th>합계</th>
			<th>&nbsp;</th>
		</tr>			
		<c:set var="totalPrice" value="0"/>
		<c:set var="totalCount" value="0"/>
		<c:forEach var="product" items="${product}">
		<tr>
			<%-- <td>${product.cart_num}</td> --%>			
			<td><img src="../upload/${product.product.image}" height="85" width="85"></td>
			<td>${product.product.product_name}</td>

			<!-- 판매가 -->
			<td><fmt:formatNumber value="${product.product.price}" pattern="#,###" /></td>
			<!-- 수량 -->
			<td>								
				<input type="number" name="cart_count" min="1" max="99999"
					value="${product.product.cart_count}" class="quantity-width">
				<input type="button" value="변경" data-cartnum="${product.cart_num}" data-itemnum="${product.product_num}" class="btn btn-default btn-sm cart-modify">
			</td>			
			<!-- 합계 -->
			<td><fmt:formatNumber value="${product.product.price * product.product.cart_count}" pattern="#,###" /> 원</td>			
			<td>			
			<%-- <fmt:formatNumber value="${product.sub_total}"/>원
					<br> --%>		
			<input type="button" value="삭제" onclick="location.href='cartDelete.do?cart_num=${product.cart_num}'" class="btn btn-sm">
			</td>
		</tr>
									
		<c:set var="Price" value="${Price+product.product.price * product.product.cart_count}"/> 
		
		<c:if test="${Price < 150000}">
		<c:set var="ship" value="3000"/>
		<c:set var="totalPrice" value="${Price + ship}"/> 
		</c:if>
		
		<c:if test="${Price >= 150000}">
		<c:set var="ship" value="0"/>
		<c:set var="totalPrice" value="${Price}"/> 
		</c:if>	
		
		<c:set var="totalCount" value="${totalCount + product.cart_count}"/>
		</c:forEach>
	</table>
	<hr>
	<span class="cart_text"><b>*15만원 이상 구매시 무료배송</b></span>
	<p>
	<table class="table align-center" >
	<tr class="active">
	<td>총 상품금액</td>
	<td>총 배송비</td>
	<td><b>결제예정금액</b></td>
	</tr>
	<tr>
	<td><br><fmt:formatNumber value="${Price}" pattern="#,###" />원</td>
	<td><br>+ <fmt:formatNumber value="${ship}" pattern="#,###" /> 원</td>
	<td><br><fmt:formatNumber value="${totalPrice}" pattern="#,###" />원</td>
	</tr>
	</table>	
	<hr size="1" width="100%" noshade="noshade">
	<div class="blank_50"></div>
	<c:choose>
	<c:when test="${totalPrice <= 0}">
	<div id="w1">
		<p style="font-size:2em;">장바구니에 담은 물건이 없습니다.</p>
	</div>
	</c:when>
	<c:when test="${totalPrice > 0}">
	<div id="btn-1">
	<button type="button" class="btn btn-secondary go_right" style="background-color:black; color:white"
	onclick="location.href='${pageContext.request.contextPath}/product/cartBuyForm.do'">전체상품주문</button>
	<%-- <button type="button" class="btn btn-secondary btn-lg" style="background-color:black; color:white"
	onclick="location.href='${pageContext.request.contextPath}/product/cartBuyForm.do'">총 <fmt:formatNumber value="${totalPrice}" pattern="#,###" />원 결제</button> --%>				
	</div>
	</c:when>
	</c:choose>
	<!-- </form> -->
</div>
	<div class="blank_100"></div>

</body>
</html>