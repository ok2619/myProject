<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ABCshop :: Order</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#write_form2').submit(function(){
		if($('#order_name').val().trim()==''){
			alert('수령자를 입력하세요!');
			$('#order_name').val('').focus();
			return false;
		}
		if($('#phone').val().trim()==''){
			alert('전화번호를 입력하세요!');
			$('#phone').val('').focus();
			return false;
		}
		if($('#zipcode').val().trim()==''){
			alert('우편번호를 입력하세요!');
			$('#zipcode').val('').focus();
			return false;
		}
		if($('#address1').val().trim()==''){
			alert('주소를 입력하세요!');
			$('#address1').val('').focus();
			return false;
		}
		if($('#address2').val().trim()==''){
			alert('상세주소 입력하세요!');
			$('#address2').val('').focus();
			return false;
		}
		if($('input[type=radio]:checked').length < 1){
			alert('결제 수단을 선택하세요!');
			return false;
		}		
		if($('input[type=radio]:checked').length < 1){
			alert('결제 수단을 선택하세요!');
			return false;
		}
	});
});
</script> 
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="page-main">
	<h3 class="align-center common_title">order</h3>	
	
	<h4 class="order_font">주문 내역</h4>
	<p>
	<table class="table">
		<tr class="align-center">
			<!-- <th>번호</th> -->
			<td>이미지</td>
			<td>상품정보</td>			
			<td>판매가</td>
			<td>수량</td>
			<td>합계</td>

		</tr>			

		<c:set var="totalPrice" value="0"/>
		<c:set var="totalCount" value="0"/>
		<c:set var="Price"  value="${cart_count * product.price}"/> 
		
		<c:if test="${Price < 150000}">
		<c:set var="ship" value="3000"/>
		<c:set var="totalPrice" value="${Price + ship}"/> 
		</c:if>
		
		<c:if test="${Price >= 150000}">
		<c:set var="ship" value="0"/>
		<c:set var="totalPrice" value="${Price}"/> 
		</c:if>			
		<c:set var="totalCount" value="${totalCount + product.cart_count}"/>
		<tr class="align-center">
			<td><img src="../upload/${product.image}" height="85" width="85"></td>
			<td>${product.product_name}</td>
			<td><fmt:formatNumber value="${product.price}" pattern="#,###" />원</td>
			<td>${cart_count}</td>
			<td><fmt:formatNumber value="${cart_count * product.price}" pattern="#,###" />원</td>			
		</tr>
		<tr>
		<td colspan="5" class="align-right">
		상품구매금액 <fmt:formatNumber value="${Price}" pattern="#,###" /> + 배송비 <fmt:formatNumber value="${ship}" pattern="#,###" /> = 합계 : <b><fmt:formatNumber value="${totalPrice}" pattern="#,###" />원</b>
		</td>		
		</tr>		
		<tr>
		<td colspan="5">
		<span class="cart_text">* 상품의 옵션 및 수량 변경은 상품상세 또는 장바구니에서 가능합니다.</span>
		</td>		
		</tr>
	</table>
	<p>
	<div class="blank_50"></div>
	<hr size="1" width="100%" noshade="noshade">
	
	<h4 class="order_font">배송 정보</h4>	
	</div>	
	<form id="write_form2" action="paymentDirect.do" method="post" class="form-inline">
	<input type="hidden" id="product_name" name="product_name" value="${product.product_name}"><!-- 세션에 저장하기 위해 히든으로 넘김 -->
	<input type="hidden" id="price" name="price" value="${product.price}"><!-- 세션에 저장하기 위해 히든으로 넘김 -->
	<input type="hidden" id="product_num" name="product_num" value="${product.product_num}"><!-- 세션에 저장하기 위해 히든으로 넘김 -->
	<input type="hidden" id="cart_count" name="cart_count" value="${cart_count}"><!-- 세션에 저장하기 위해 히든으로 넘김 -->	
	
	<div class="page-main">
		<table class="table buy_form">
		<tr>
			<td class="bg1">받으시는 분</td>
			<td>
				<input type="text" name="order_name" id="order_name" maxlength="10" value="${member.name}" class="input_color">
			</td>
		</tr>
		
		<tr>
			<td class="bg1">주소</td>
			<td>
			<input type="text" name="zipcode" id="zipcode"
				       maxlength="5" value="${member.zipcode}" class="input_color">		
			<button type="button" onclick="sample2_execDaumPostcode()" class="btn btn-default btn-xs margin_left_10">우편번호 〉</button><p>
			<p>
			<input type="text" name="address1" id="address1" maxlength="30" value="${member.address1}" class="input_color float_left">
			<span class="view_font2 float_left margin_left_10"> 기본주소</span ><br>
			<p>
			<div class="clear"></div>
			<p>	             
			<input type="text" name="address2" id="address2" maxlength="30"  value="${member.address2}" class="input_color  float_left">
			<span class="view_font2 float_left margin_left_10"> 나머지주소</span >
			</td>
		</tr>
		
		<tr>
			<td class="bg1">휴대전화</td>
			<td>
				<input type="text" name="phone" id="phone" maxlength="15" value="${member.phone}" class="input_color"> 
			</td>
		</tr>	
		<tr>
			<td class="bg1">결제 수단</td>
			<td>
				<input type="radio" name="payment" id="payment1" value="1">통장입금 &nbsp;
				<input type="radio" name="payment" id="payment2" value="2">카드결제
			</td>
		</tr>
		</table> 		
	</div>
	<div class="blank_100"></div>
	<div class="buy_form">
		<h4 class="order_font">결제 예정 금액</h4>	
		<div class="page-main align-center">	
			<table class="table">
				<tr class="active">
					<td>총 상품금액</td>
					<td>총 배송비</td>
					<td><b>최종결제금액</b></td>
				</tr>
				<tr>
					<td><br><fmt:formatNumber value="${Price}" pattern="#,###" />원</td>
					<td><br>+ <fmt:formatNumber value="${ship}" pattern="#,###" /> 원</td>
					<td><br><b>= <fmt:formatNumber value="${totalPrice}" pattern="#,###" />원</b></td>
				</tr>
			</table>	
		</div>												
	</div>	
	<div class="blank_70"></div>	
	<input type="submit" id="order_btn" class="btn align-center go_right4" value="결제하기" >		
</form>	
<!-- 	<div class=align-center">
<div class="form-group">
	<label class="control-label">결제수단</label>
</div>
<div class="form-group">
	<input type="radio" name="payment" id="payment1" value="1">계좌이체
      &nbsp;
<input type="radio" name="payment" id="payment2" value="2">카드결제       					
</div><p>
	</div> -->

	<%-- <div class="form-group">
		<label for="name" class="control-label">주문자명</label>
	</div>
	<div class="form-group">
		<input type="text" name="order_name" id="order_name"
			               maxlength="10" class="form-control" value="${member.name}">			
	</div><p>
	 
	<div class="form-group">
		<label for="phone" class="control-label">전화번호</label>
	</div>
	<div class="form-group">
		<input type="text" name="phone" id="phone"
			           maxlength="15" class="form-control" value="${member.phone}"> 					
	</div><p> 
	 
	<div class="form-group">
		<label for="zipcode" class="control-label">우편번호</label>
	</div>
	<div class="form-group">
		<input type="text" name="zipcode" id="zipcode"
			       maxlength="5" class="form-control" value="${member.zipcode}" >		
		<button type="button" onclick="sample2_execDaumPostcode()" class="btn btn-default btn-xs margin_left_10">우편번호 〉</button>  					
	</div><p>	 
	 
	<div class="form-group">
		<label for="address1" class="control-label">주소</label>
	</div>
	<div class="form-group">
		<input type="text" name="address1" id="address1"
			             maxlength="30" class="form-control" value="${member.address1}">  					
	</div><p>
	
	<div class="form-group">
		<label for="address2" class="control-label">상세 주소</label>
	</div>
	<div class="form-group">
		<input type="text" name="address2" id="address2"
			            maxlength="30" class="form-control" value="${member.address2}">  					
	</div><p>
	 --%>
  <!-- 
  <hr class="mt-2 mb-3"/>
</div>
</div> -->


	<!-- <button type="button" class="btn btn-secondary btn-lg" 
									style="background-color:black; color:white">계좌이체</button>
	<input type="submit" class="btn btn-secondary btn-lg" 				 
										style="background-color:black; color:white" value="카드결제"> -->	



<!-- 우편번호 스크립트 시작 -->
<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    //(주의)address1에 참고항목이 보여지도록 수정
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    //(수정) document.getElementById("address2").value = extraAddr;
                
                } 
                //(수정) else {
                //(수정)    document.getElementById("address2").value = '';
                //(수정) }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode;
                //(수정) + extraAddr를 추가해서 address1에 참고항목이 보여지도록 수정
                document.getElementById("address1").value = addr + extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("address2").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>
<!-- 우편번호 스크립트 끝 -->
<div class="blank_100"></div>	
</body>
</html>