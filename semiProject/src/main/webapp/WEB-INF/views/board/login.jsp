<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
<c:when test="${auth == 1}"> <%--1:정지회원--%>
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<title>로그인 정보</title>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>		
	</head>
	<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<h2>회원 정보</h2>
		<div class="result-display">
			<div class="align-center">
				회원님의 아이디가 정지되었습니다.
				<p>
				<input type="button" value="홈으로"
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