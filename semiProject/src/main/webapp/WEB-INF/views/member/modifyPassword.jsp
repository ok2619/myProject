<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${check}">
	<script type="text/javascript">
		alert('비밀번호 수정 완료');
		location.href='${pageContext.request.contextPath}/main/main.do';
	</script>
</c:if>
<c:if test="${!check}">
	<script type="text/javascript">
		alert('아이디 또는 비밀번호 불일치');
		history.go(-1);
	</script>
</c:if>