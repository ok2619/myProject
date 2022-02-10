<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
${product.product_num}
<img src="../upload/${product.image}" height="180" width="180">
${product.product_name}
${product.stock}
${product.sort}
${product.price}
${product.content}
${product.reg_date}

<input type="button" value="수정" onclick="location.href='productUpdateForm.do?product_num=${product.product_num}'">

</div>
</body>
</html>