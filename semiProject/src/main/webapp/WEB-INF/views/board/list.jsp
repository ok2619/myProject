<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰게시판 메인(글목록)</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script> 
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
	<h3 class="align-center common_title">상품 후기</h3>
		
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
	<p>
	</c:if>
	<p>
	<div class="list-space align-right">
		<input type="button" value="글쓰기" onclick="location.href='writeForm.do'" 
		<c:if test="${empty user_number}">disabled="disabled"</c:if>> <!-- 로그인 안된상태-> 글쓰기버튼 비활성화 -->
		<input type="button" value="목록" onclick="location.href='list.do'">		
	</div>
	
	<form id="search_form" action="list.do" method="get">
		<ul class="search">
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
				<input type="submit" value="검색">
			</li>
		</ul>
	</form>
	
	<div class="align-center">
		${pagingHtml}
	</div>	
	
</div>
</body>
</html>