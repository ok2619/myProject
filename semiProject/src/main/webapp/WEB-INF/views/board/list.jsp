<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰게시판 메인(글목록)</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrap/bootstrap-dropdown.js"></script>
<script>
     $(document).ready(function(){
        $('.dropdown-toggle').dropdown()
    });
</script>
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
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="page-main">
	<h3 class="align-center common_title"><a href="list.do">상품 후기</a></h3>
		
	<c:if test="${count == 0 }">
	<table class="table table-hover">
	  <thead>
		<tr>
			<th>글번호</th>
			<th>상품정보</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회</th>
		</tr>
	  </thead>
	  <tbody>			
		<tr>
			<td colspan="6" class="align-center">			
			<p>
			표시할 게시물이 없습니다.		
			<p>
			</td>				
		</tr>
	  </tbody>			
	</table>	
	</c:if>
	
	<c:if test="${count > 0 }">
	<table class="table table-hover">
	  <thead>
		<tr class="active">
			<th>번호</th>
			<th>상품정보</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회</th>
		</tr>
	  </thead>
	  <tbody>	
		<c:forEach var="board" items="${list}">
		<tr>
			<td>${board.board_num}</td>			
			<td>
			<c:if test="${!empty board.filename}">
			<div>
				<img src="${pageContext.request.contextPath}/upload/${board.filename}" class="list-img">
			</div>
			</c:if>
			</td>
			<td><a href="detail.do?board_num=${board.board_num}">${board.title}</a></td>
			<td>${board.id}</td>
			<td>${board.reg_date}</td>
			<td>${board.hit}</td>
		</tr>
		</c:forEach>
	  </tbody>
	</table>
	</c:if>
	<p>
	
	<!-- 검색창 -->
	<form id="search_review" action="list.do" method="get">
		<ul class="search_review">
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
	<!-- 검색창 끝 -->
	<input type="button" value="추천순으로 보기" class="btn btn-default btn-sm" id="like_btn_list" 
											onclick="location.href='list.do?order=desc'">
	
	<!-- 글쓰기버튼 -->
	<p>
	<div class="align-right" id="write_btn">
		<input type="button" value="글쓰기" onclick="location.href='writeForm.do'" class="btn btn-info"
		<c:if test="${empty user_number}">disabled="disabled"</c:if>> <!-- 로그인 안된상태-> 글쓰기버튼 비활성화 -->		
	</div>
	<!-- 글쓰기버튼 끝-->
	
	<p class="clear"></p>
	<div class="blank_50"></div>	
	<div class="align-center">
		${pagingHtml}
	</div>	
	<div class="blank_50"></div>	
</div>
</body>
</html>