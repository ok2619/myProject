<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
회원가입 완료
<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
</body>
</html> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
 alert('가입이 완료되었습니다.');
 location.href='${pageContext.request.contextPath}/main/main.do';
</script>