<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰게시판 메인(글목록)</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">

<script type="text/javascript">
	$(function(){
		$('#search_form').submit(function(){
			if($('#keyword').val().trim()==''){
				alert('검색어를 입력하세요!');
				$('#keyword').val('').focus();
				return false;			
			}			
		});		
	});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h3 class="align-center common_title"><a href="list.do">상품 후기</a></h3>
		
	<c:if test="${count == 0 }">
	<table>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회</th>
		</tr>		
		<tr>
			<td colspan="5" class="align-center">			
			<p>
			표시할 게시물이 없습니다.		
			<p>
			</td>				
		</tr>			
	</table>	
	</c:if>
	
	<c:if test="${count > 0 }">
	<table>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회</th>
		</tr>
		<c:forEach var="board" items="${list}">
		<tr>
			<td>${board.board_num}</td>
			<td><a href="detail.do?board_num=${board.board_num}">${board.title}</a></td>
			<td>${board.id}</td>
			<td>${board.reg_date}</td>
			<td>${board.hit}</td>
		</tr>
		</c:forEach>
	</table>
	</c:if>
	<p>
	
	<!-- <p class="clear"></p> -->
	
	<!-- 검색창 -->
	<div id="review_search">
		<form id="review_search" action="list.do" method="get">
			<ul class="review_search">
				<li>
					<select name="keyfield">
						<option value="1">제목</option>
						<option value="2">아이디</option>
						<option value="3">내용</option>
					</select>
				</li>
				<li>
					<input type="search" size="16" name="keyword" id="keyword" 
													value="${param.keyword}">
				</li>
				<li>
					<input type="submit" value="검색" class="btn btn-default btn-sm">
				</li>
			</ul>
		</form>
	</div>
	<!-- 검색창 끝 -->
	
	<!-- 글쓰기버튼 -->
	<p>
	<div class="align-right" id="write_btn">
		<input type="button" value="글쓰기" onclick="location.href='writeForm.do'" class="btn btn-info"
		<c:if test="${empty user_number}">disabled="disabled"</c:if>> <!-- 로그인 안된상태-> 글쓰기버튼 비활성화 -->		
	</div>
	<!-- 글쓰기버튼 끝-->
	
	<p class="clear"></p>
	<p>
	<div class="align-center">
		${pagingHtml}
	</div>	
	
</div>
<script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
</body>
</html>