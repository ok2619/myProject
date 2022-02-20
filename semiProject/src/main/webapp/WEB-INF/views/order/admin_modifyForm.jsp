<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문정보수정</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#order_modify').submit(function(){
			if($('#order_name').val().trim()==''){
				alert('구매자를 입력하세요!');
				$('#order_name').val('').focus();
				return false;
			}
			if($('#order_post').val().trim()==''){
				alert('우편번호를 입력하세요!');
				$('#order_post').val('').focus();
				return false;
			}
			if($('#order_address1').val().trim()==''){
				alert('주소를 입력하세요!');
				$('#order_address1').val('').focus();
				return false;
			}
			if($('#order_address2').val().trim()==''){
				alert('상세 주소를 입력하세요!');
				$('#order_address2').val('').focus();
				return false;
			}
			if($('#order_phone').val().trim()==''){
				alert('전화번호를 입력하세요!');
				$('#order_phone').val('').focus();
				return false;
			}
		});
	});
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="page-main">	
	<h3 class="align-center common_title">주문 정보 수정</h3>
	<hr size="1" noshade="noshade" width="100%">
	<h4 class="font3 blank_20"><b>[주문 상품 정보]</b></h4>
	
	<table class="table table-bordered">
		<tr class="active font">
			<th class="align-center">상품명</th>
			<th class="align-center">수량</th>
			<th class="align-center">상품가격</th>
			<th class="align-center">합계</th>
		</tr>
		<c:forEach var="detail" items="${detailList}">
		<tr>
			<td class="align-center">${detail.product_name}</td>
			<td class="align-center"><fmt:formatNumber value="${detail.cart_count}"/></td>
			<td class="align-center"><fmt:formatNumber value="${detail.product_price}"/>원</td>
			<td class="align-center"><fmt:formatNumber value="${detail.product_total}"/>원</td>
		</tr>
		</c:forEach>
		<tr>
			<td colspan="3" class="align-right"><b>총구매금액</b></td>
			<td class="align-center"><b><fmt:formatNumber value="${order.order_total}"/>원</b></td>
		</tr>
	</table>
	<div class="blank_40"></div>
	<h4 class="font3 blank_20"><b>[배송 및 주문 정보]</b></h4>
	<div class="panel panel-default">
		<form action="modify.do" method="post" id="order_modify" class="form-inline go_left2">
			<input type="hidden" name="order_num" value="${order.order_num}">
			
			<div class="form-group">
				<label for="order_name" class="control-label">구매자</label>
			</div>
			<div class="form-group">
				<input type="text" name="order_name" id="order_name"
					                 value="${order.order_name}" maxlength="10" class="form-control">						
			</div><p>
			 
			<div class="form-group">
				<label for="zipcode" class="control-label">우편번호</label>
			</div>
			<div class="form-group">
				<input type="text" name="order_post" id="zipcode"
					       value="${order.order_post}" maxlength="5" class="form-control">
					<!-- <input type="button" onclick="sample2_execDaumPostcode()"
					                              value="우편번호">  -->  
				<button type="button" onclick="sample2_execDaumPostcode()" class="btn btn-default btn-xs margin_left_10">우편번호 〉</button>  					
			</div><p>	 
			 
			<div class="form-group">
				<label for="address1" class="control-label">주소</label>
			</div>
			<div class="form-group">
				<input type="text" name="order_address1" id="address1"
					            value="${order.order_address1}" maxlength="30" class="form-control">  					
			</div><p>
			
			<div class="form-group">
				<label for="address2" class="control-label">상세 주소</label>
			</div>
			<div class="form-group">
				<input type="text" name="order_address2" id="address2"
					            value="${order.order_address2}" maxlength="30" class="form-control">  					
			</div><p>
			
			<div class="form-group">
				<label for="order_phone" class="control-label">전화번호</label>
			</div>
			<div class="form-group">
				<input type="text" name="order_phone" id="order_phone"
					          value="${order.order_phone}" maxlength="15" class="form-control"> 					
			</div><p> 
			<div class="form-group">
				<label class="control-label">결제수단</label>
			</div>
			<div class="form-group">
				<input type="radio" name="payment" id="payment1" value="1"
					      <c:if test="${order.payment == 1}">checked</c:if>>통장입금
					      &nbsp;
					<input type="radio" name="payment" id="payment2" value="2"
					      <c:if test="${order.payment == 2}">checked</c:if>>카드결제       					
			</div><p>
				
			<div class="form-group">
				<label class="control-label">배송상태</label>
			</div>
			<div class="form-group">
				<c:if test="${order.shipping != 5}">
					<input type="radio" name="shipping" id="shipping1" value="1"
					     <c:if test="${order.shipping == 1}">checked</c:if>>배송대기&nbsp;
					<input type="radio" name="shipping" id="shipping2" value="2"
					     <c:if test="${order.shipping == 2}">checked</c:if>>배송준비중&nbsp;
					<input type="radio" name="shipping" id="shipping3" value="3"
					     <c:if test="${order.shipping == 3}">checked</c:if>>배송중&nbsp;
					<input type="radio" name="shipping" id="shipping4" value="4"
					     <c:if test="${order.shipping == 4}">checked</c:if>>배송완료&nbsp;           
					</c:if>
					<input type="radio" name="shipping" id="shipping5" value="5"
					     <c:if test="${order.shipping == 5}">checked</c:if>>주문취소 					
			</div><p> 	
			
			<div class="blank_40"></div>
			<div class="float_right go_right2">
				<c:if test="${order.shipping != 5}">
				<input type="submit" value="수정" class="btn btn-info margin_left_40">
				</c:if>				
				<input type="button" value="주문 정보 삭제" class="btn btn-danger margin_left_10"
				 onclick="location.href='deleteOrder.do?order_num=${order.order_num}'">
				 <input type="button" value="취소" class="btn margin_left_10"
				  onclick="location.href='list.do'">				
			</div>		
		</form>
	</div>
	
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
</div>
<div class="blank_100"></div>
</body>
</html>







