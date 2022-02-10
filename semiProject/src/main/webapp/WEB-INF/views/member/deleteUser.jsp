<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<c:if test="${check}">  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
</head>
<body>
<div class="container">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h2>회원탈퇴</h2>
	<div class="result-display">
		<div class="align-center">
			회원탈퇴가 완료되었습니다.
			<p>
			<input type="button" value="홈으로" 
		onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
	</div>
</div>
</body>
</html>
</c:if>
<c:if test="${!check}">
	<script type="text/javascript">
		alert('아이디 또는 비밀번호 불일치');
		history.go(-1);
	</script>
</c:if>