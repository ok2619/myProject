<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글상세</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/js/board-reply.js"></script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h3 class="align-center common_title">상품 후기</h3>
	<ul>
		<li>글번호 : ${board.board_num}</li>
		<li>글제목 : ${board.title}</li>
		<li>작성자 : ${board.id}</li>
		<li>조회수 : ${board.hit}</li>
	</ul>
	<hr size="1" width="100%" noshade="noshade">
	<c:if test="${!empty board.filename}">
	<div class="align-center">
		<img src="${pageContext.request.contextPath}/upload/${board.filename}" class="detail-img">
	</div>
	</c:if>
	<p>
		${board.b_content}
	</p>
	<hr size="1" width="100%" noshade="noshade">
	<div class="align-right">
		<c:if test="${!empty board.modify_date}">
		최근 수정일 : ${board.modify_date}
		</c:if>
		작성일 : ${board.reg_date}
		<%--로그인한 회원번호와 작성자 회원번호가 일치해야 수정,삭제 가능 --%>
		<c:if test="${user_number == board.user_num}">
		<input type="button" value="수정" 
		onclick="location.href='updateForm.do?board_num=${board.board_num}'">
		<input type="button" value="삭제" id="delete_btn">
		<script type="text/javascript">
			let delete_btn = document.getElementById('delete_btn');
			//삭제버튼에 이벤트 연결
			delete_btn.onclick=function(){
				let choice = confirm('삭제하시겠습니까?');
				if(choice){
					location.replace('delete.do?board_num=${board.board_num}');
				}
			};
		</script>		
		</c:if>
		<input type="button" value="목록" onclick="location.href='list.do'">
	</div>
</div>
</body>
</html>










