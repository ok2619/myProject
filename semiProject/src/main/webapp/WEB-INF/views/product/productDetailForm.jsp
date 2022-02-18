<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script> 
  function submit2(frm) { 
    frm.action='buyForm.do?product_num=${product.product_num}'; /* 해당 주소로 이동 */
    frm.submit(); 
    return true; 
  } 
</script> 
<link rel="stylesheet" href="../css/bootstrap.min.css" type="text/css">
 	<style>
      table {height: 1000px;width: 1200px;}
      th, td {padding: 10px;}
  		thead{width:1000px;height:500px;}
  		tbody{height:400px;}
  		thead .first{width:50%;}
  		thead .second{width:50%;}
  		span {
display: table-cell;
padding-left: 10px;
text-align: left;
vertical-align: middle;
}
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="page-main2">
 <table style="padding-top:100px" class="go_left_120">
      <thead>
        <tr>
          <th class="first">
          <div style="text-align : center;">
          <img src="../upload/${product.image}" height="400" width="400">
          </div>
         
          <th class="second">
	          <span style="font-size:19px; padding-bottom:20px;">제품정보</span></br>
	          <span>상품명 : ${product.product_name}</span></br>
	          <span>상품종류 : ${product.sort}</span></br>
	          <span>판매가 : <fmt:formatNumber value="${product.price}" pattern="#,###" /> 원</span></br>
          
          <div class="align-left">
          <form action="cartInsert.do" method="post" style="padding:0; margin:auto;">
          <input type="hidden" id="product_num" name="product_num" value="${product.product_num}">
          
          <span>개수 : <input type="number" id="cart_count" value="1" name="cart_count" 
          						min="0" max="10" required></span></br>
          <div style="padding:15px 0px 0px 9px;">
          <c:if test="${product.stock > 0}">
          <input type='button' class="btn btn-default btn-sm" value='구매' onclick='return submit2(this.form);'> <!-- 한개의 form에 두 공간에 데이터를 보내야 하기 때문에 자바스크립트 활용 -->
          </c:if>
          <c:if test="${product.stock <= 0 }">
          <p style="font-size:3em">품절</p>	
          </c:if>
          <input type="submit" class="btn btn-default btn-sm" value="장바구니담기">
          
          <c:if test="${!empty user_number && user_auth == 3}">
          <input type="button" class="btn btn-default btn-sm" value="상품수정" onclick="location.href='productUpdateForm.do?product_num=${product.product_num}'">
          <input type="button" class="btn btn-default btn-sm" value="상품삭제" onclick="location.href='productDelete.do?product_num=${product.product_num}'">
          </c:if>
          </div>
          </form>
          </div>
          </th>
        </tr>       
      </thead>
      <tbody>
      	<tr style="height:50px; border-top: 1px solid black; ">
      		<th colspan="2">제품상세정보</th>
      	</tr>
        <tr>
          	<td colspan="2" style="font-size:15px;">${product.content}</td>
        </tr>
      </tbody>
    </table>
    </div>
</body>
</html>