<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 | 회원관리</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
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
	<h3 class="align-center common_title">회원관리</h3>
	<c:if test="${count==0 }">
	<table class="table table-hover">
	  <thead>
		<tr class="info font2">
			<th>ID</th>
			<th>이름</th>
			<th>주소</th>
			<th>전화번호</th>
			<th>가입일</th>
			<th>등급</th>  
		</tr>
	  </thead>
	  <tbody>			
		<tr>
			<td colspan="6" class="align-center">			
			<p>
			<div class="blank_20"></div>
			표시할 회원이 없습니다.
			<div class="blank_20"></div>		
			<p>
			</td>				
		</tr>
	  </tbody>
	  </table>				
	</c:if>
	
	<c:if test="${count > 0 }">
	<table class="table table-hover">
		<tr class="info font2">
			<th>ID</th>
			<th>이름</th>
			<th>주소</th>
			<th>전화번호</th>
			<th>가입일</th>
			<th>등급</th>  
		</tr>
		<c:forEach var="member" items="${list}">
		<tr>
			<td>
				<c:if test="${member.auth > 0}">
				<a href="detailUserForm.do?user_num=${member.user_num}">${member.id}</a>
				</c:if>
				<c:if test="${member.auth == 0}">${member.id}</c:if>
			</td>
			<td><a href="detailUserForm.do?user_num=${member.user_num}">${member.name}</a></td>
			<td>${member.address1}</td>
			<td>${member.phone}</td>
			<td>${member.reg_date}</td>
			<td>
			<c:if test="${member.auth == 0}">탈퇴</c:if>
			<c:if test="${member.auth == 1}">정지</c:if>
			<c:if test="${member.auth == 2}">일반</c:if>
			<c:if test="${member.auth == 3}">관리</c:if>
			</td>
		</tr>
		</c:forEach>
	</table>
	</c:if>
	
	<p>
	
	<!-- 검색창 -->
		<form id="search_review" action="memberList.do" method="get">
			<ul class="search_review">
				<li>
					<select name="keyfield">
						<option value="1">ID</option>
						<option value="2">이름</option>
					</select>
				</li>
				<li>
					<input type="search" size="16" name="keyword" id="keyword">
				</li>
				<li>
					<input type="submit" value="검색" class="btn btn-default btn-sm">
				</li>
			</ul>
		</form>
	<!-- 검색창 끝 -->
	
	<!-- <input type="button"  class="btn btn-default btn-sm margin_left" value="목록" onclick="location.href='memberList.do'">
	 -->
	<p class="clear"></p>
	<div class="blank_50"></div>	
	<div class="align-center">
		${pagingHtml}
	</div>	
	<div class="blank_50"></div>	
</div>
</body>
</html>