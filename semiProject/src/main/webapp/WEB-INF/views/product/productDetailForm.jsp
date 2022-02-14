<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script> 
  function submit2(frm) { 
    frm.action='buyForm.do?product_num=${product.product_num}'; /* 해당 주소로 이동 */
    frm.submit(); 
    return true; 
  } 
</script> 
<link rel="stylesheet" href="../css/bootstrap.min.css" type="text/css">
 	<style>
      table {height: 900px;width: 1200px;border: 1px solid #444444;}
      th, td {border: 1px solid #444444;padding: 10px;}
  		thead{width:1000px;height:500px;}
  		tbody{height:400px;}
  		thead .first{width:50%;}
  		thead .second{width:50%;}
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
 <table style="padding-top:100px">
      <thead>
        <tr>
          <th class="first"><img src="../upload/${product.image}" height="400" width="400" style="padding-top:70px;padding-left:30px"></th>
          <th class="second">
          제품정보</br>
          상품명 : ${product.product_name}</br>
          상품종류 : ${product.sort}</br>
          판매가 : ${product.price}</br>
          
          
          <form action="cartInsert.do" method="post">
          <input type="hidden" id="product_num" name="product_num" value="${product.product_num}">
          
          개수 : <input type="number" id="cart_count" value="1" name="cart_count" 
          						min="0" max="10" required></br>
          
          <c:if test="${product.stock > 0}">
          <input type='button' value='구매' onclick='return submit2(this.form);'> <!-- 한개의 form에 두 공간에 데이터를 보내야 하기 때문에 자바스크립트 활용 -->
          </c:if>
          <c:if test="${product.stock <= 0 }">
          <span>품절</span>	
          </c:if>
          <input type="submit" value="장바구니담기"><br>
          </form>
          
          
          
          <c:if test="${!empty user_number && user_auth == 3}">
          <input type="button" value="상품수정" onclick="location.href='productUpdateForm.do?product_num=${product.product_num}'">
          <input type="button" value="상품삭제" onclick="location.href='productDelete.do?product_num=${product.product_num}'">
          </c:if>
          </th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td colspan="2">상세정보상세정보상세정보상세정보상세정보상세정보상세정보상세정보상세정보</td>
        </tr>
      </tbody>
    </table>
</body>
</html>