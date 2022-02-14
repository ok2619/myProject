<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글상세</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/board-reply.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="page-main">
	<h3 class="align-center common_title"><a href="list.do">상품 후기</a></h3>
	<ul>
		<li>번호 : ${board.board_num}</li>
		<li>제목 : ${board.title}</li>
		<li>작성자 : ${board.id}</li>
		<li>조회수 : ${board.hit}</li>
		<li>작성일 : ${board.reg_date}</li>
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
		최근 수정일 : ${board.modify_date}&nbsp;&nbsp;
		</c:if>
			
		<%--로그인한 회원번호와 작성자 회원번호가 일치해야 수정,삭제 가능 --%>
		<c:if test="${user_number == board.user_num}">
		<input type="button" value="수정" 
		onclick="location.href='updateForm.do?board_num=${board.board_num}'" class="btn btn-default btn-sm">
		<input type="button" value="삭제" id="delete_btn" class="btn btn-sm">
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
		<%--수정/삭제 기능 끝 --%>		
		<input type="button"  class="btn btn-default btn-sm" value="목록" onclick="location.href='list.do'">
	</div>
</div>
<div class="blank_50"></div>
<!-- 댓글 시작 -->
	<!-- 댓글 시작 -->
	<div id="reply_div">
		<span class="re-title">댓글 달기</span>
		<form id="re_form">
			<input type="hidden" name="board_num" value="${board.board_num}" id="board_num">
			<textarea rows="5" cols="50" name="re_content" id="re_content" class="rep-content" placeholder="댓글을 입력하세요."
			<c:if test="${empty user_number}">disabled="disabled"</c:if>
			><c:if test="${empty user_number}">댓글작성을 위해 로그인이 필요합니다.</c:if></textarea>
		<c:if test="${!empty user_number}">
		<div id="re_first">
			<span class="letter-count">300/300</span>
		</div>
		<div id="re_second" class="align-right">
			<input type="submit" value="전송">
		</div>
		</c:if>
		</form>
	</div>
	<!-- 댓글 목록 출력 시작 -->
	<div id="output"></div>
	<div class="paging-button" style="display:none;">
		<input type="button" value="다음글 보기">
	</div>
	<!-- 댓글 목록 출력 끝 -->
<!-- 댓글 끝 -->
</body>
</html>










