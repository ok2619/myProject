<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ABCshop :: 안내</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="page-main">
		<div class="align-center">		
	<div class="panel panel-default blank_50">
			<c:if test="${!empty accessMsg}">
			<div class="blank_50"></div>
				${accessMsg}
			<div class="blank_50"></div>	
			</c:if>
			<c:if test="${empty accessMsg}">
				잘못된 접속입니다.
			</c:if>
			<p>
			<c:if test="${!empty accessUrl}">
				<%-- <input type="button" value="이동" 
				              onclick="location.href='${accessUrl}'"> --%>
			</c:if>
			<c:if test="${empty accessUrl}">
				<input type="button" value="홈으로" 
			onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
			</c:if>
		</div>
	</div>
</div> 
</body>
</html>






