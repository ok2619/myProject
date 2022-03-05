<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
<c:when test="${auth == 1}"> <%--1:정지회원--%>
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<title>ABCshop :: 로그인</title>
	<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>	
	</head>
	<body>
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>		
	<div class="page-main">
		<div class="blank_100"></div> 
		<div class="result-display">		
			<div class="align-center"><div class="blank_30"></div> 
				<p>
				정지된 아이디입니다.			
				<p>
				<div class="blank_30"></div> 
				<input type="button" value="메인으로 이동" class="btn btn-default btn-sm"
				onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
			</div>
		</div>
	</div>
	</body>
	</html>
</c:when>
<c:otherwise>
	<script type="text/javascript">
		alert('아이디 또는 비밀번호가 불일치합니다.');
		history.go(-1); 
	</script>
</c:otherwise>
</c:choose>