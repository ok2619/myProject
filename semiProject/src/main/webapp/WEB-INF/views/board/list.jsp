<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ABCshop :: Review</title>
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
		 $('#write_btn').on('click',function(){
			if(${empty user_number}){
				alert('회원에게만 글쓰기 권한이 있습니다.');
				location.href='loginForm.do';			
			}			
		});	
	});
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="page-main">
	<a href="list.do"><h3 class="align-center common_title">Review</h3></a>
		
	<c:if test="${count == 0 }">
	<table class="table table-hover">
	  <thead>
		<tr class="info  font4">
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
			<div class="blank_20"></div>
			표시할 게시물이 없습니다.	
			<div class="blank_20"></div>	
			<p>
			</td>				
		</tr>
	  </tbody>			
	</table>	
	</c:if>
	
	<c:if test="${count > 0 }">
	<table class="table table-hover">
	  <thead>
		<tr class="active font4">
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
				<img src="${pageContext.request.contextPath}/upload/${board.filename}" class="list-img font">
			</div>
			</c:if>
			</td>
			<td class="font4"><a href="detail.do?board_num=${board.board_num}">${board.title}</a></td>
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

	<!-- 글쓰기버튼 -->
	<div class="align-right " id="write_btn">
		<input type="button" value="글쓰기" onclick="location.href='writeForm.do'" class="btn btn-info" id="write_btn">
		<%-- <c:if test="${empty user_number}">disabled="disabled"</c:if>> --%> <!-- 로그인 안된상태-> 글쓰기버튼 비활성화 :disabled="disabled" -->		
	</div>
	<!-- 글쓰기버튼 끝-->
	
	<!-- <form action="list.do" method="post" class="align-right ">
	<input type="submit" value="추천순으로 보기" class="btn btn-default btn-sm" id="like_btn_list" 
											onclick="location.href='list.do?order=desc'">
	</form> -->
	<p class="clear"></p>
	<div class="blank_50"></div>	
	<div class="align-center">
		${pagingHtml}
	</div>	
	<div class="blank_50"></div>	
</div>
</body>
</html>