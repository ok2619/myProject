<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
var IMP = window.IMP;
IMP.init("imp62760166");
IMP.request_pay({
    pg: "kakaopay", // PG사 선택
    pay_method: "kakaopay", // 지불 수단
    merchant_uid: 'merchant_' + new Date().getTime(), //가맹점에서 구별할 수 있는 고유한id
    name: "book", // 상품명
    amount: 1, // 가격
    buyer_email: "test@gmail.com",
    buyer_name: "tester", // 구매자 이름
    buyer_tel: "010-132-132", // 구매자 연락처  
    buyer_addr: "서울특별시",// 구매자 주소지
    buyer_postcode: "01181", // 구매자 우편번호
    m_redirect_url : 'https://example.com/mobile/complete', // 모바일 결제시 사용할 url
    digital: true, // 실제 물품인지 무형의 상품인지(핸드폰 결제에서 필수 파라미터)
    app_scheme : '' // 돌아올 app scheme
  }, function(rsp) {
	    if ( rsp.success ) {
	        alert('결제성공');
	        location.href= "stockMinus.do";
	    } else {
      alert("결제에 실패하였습니다. 에러 내용: " +  rsp.error_msg);
    }
  });

</script>
</head>
<body>

</body>
</html>