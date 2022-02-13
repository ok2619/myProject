<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰게시판 | 리뷰작성</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script> 
<script type="text/javascript">
	$(function(){
		$('#write_form').submit(function(){
			if($('#title').val().trim()==''){
				alert('제목을 입력하세요');
				$('#title').val('').focus();
				return false;
			}
			if($('#b_content').val().trim()==''){
				alert('내용을 입력하세요');
				$('#b_content').val('').focus();
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
	<form id="write_form" action="write.do" method="post" enctype="multipart/form-data"> 
		<ul>
			<li>
				<label for="title">제목</label>
				<input type="text" name="title" id="title" maxlength="50">
			</li>		
			<li>
				<label for="b_content">내용</label>
				<textarea rows="5" cols="30" name="b_content" id="b_content"></textarea>
			</li>
			<li>
				<label for="filename">파일</label>
				<input type="file" name="filename" id="filename" 
						accept="image/gif,image/png,image/jpeg"> 
			</li>	 
		</ul>
		<div class="align-center">
			<input type="submit" value="등록">
			<input type="button" value="취소" onclick="location.href='list.do'">
		</div>
	</form>
</div>
</body>
</html>