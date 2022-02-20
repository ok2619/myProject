<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script type="text/javascript">
	alert('${notice_msg}');
	location.href='${notice_url}';
</script> 