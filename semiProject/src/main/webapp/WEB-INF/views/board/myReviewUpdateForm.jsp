<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script> 
<script type="text/javascript">
	//유효성 체크
	$(function(){		
		//첨부 사진 미리보기
		$("#filename").change( //파일선택 버튼 누르고 이미지가 올라가면
			function(){
				if (this.files && this.files[0]){
					var reader = new FileReader;
					reader.onload = function(data){
						$(".select_img_update img").attr("src", data.target.result).width(100);
					}
					reader.readAsDataURL(this.files[0]);
				}					
				 $('#file_detail').hide();
			});		
		
		//이미지 첨부 취소 (파일삭제 버튼 클릭)
		$('#delete_btn').click(function(){			
			$('.select_img_update img').attr('src',''); 
			$('#filename').val('');
			$('#photo_delete').hide();			
		});		
		
		
	});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h3 class="align-center common_title"><a href="myReview.do">MY BOARD</a></h3>
	<form id="update_form" action="myReviewUpdate.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="board_num" value="${board.board_num}"> 
		
		<table class="go_left">
			<tr>
				<td class="align-center"><label for="title">제목</label></td>
				<td><input type="text" name="title" id="title" value="${board.title}" maxlength="50" class="form-control"><p></td>			
			</tr>
			<tr>
				<td class="align-center"><label for="b_content">내용</label></td>
				<td><textarea rows="5" cols="30" name="b_content" id="b_content" class="update_content form-control">${board.b_content}</textarea></td>
			</tr>
			
			<tr>
				<td>
					
				</td>
				<td><p>
					<div class="select_img_update margin_right">
							<img src="" />
					</div>
					<p>
					<div class="form-group"> 											
						<div id="photo_delete" class="float_left"><!--  class="col-xs-3" -->
						<input type="button" value="파일 삭제" id="delete_btn">
						</div>
						
						<div class="float_left margin_left_10"><!--  class="col-xs-9" -->
						<input type="file" name="filename" id="filename" 
						accept="image/gif,image/png,image/jpeg"><span id="file_detail">${board.filename}</span> 				
						</div>					
							
					</div>	
				</td>
			</tr>
		</table>				
<c:if test="${!empty board.filename}">			
 <script type="text/javascript">
	$(function(){
		$('#delete_btn').click(function(){
			let choice = confirm('삭제하시겠습니까?');
			if(choice){ //true일 경우 ajax 통신한다.
				$.ajax({
					url:'deleteFile.do',
					type:'post',
					data:{board_num:${board.board_num}},
					dataType:'json',
					cache:false,
					timeout:30000,
					success:function(param){
						if(param.result == 'logout'){
							alert('로그인 후 사용하세요!');
						}else if(param.result == 'success'){
							$('#file_detail').hide();
						}else if(param.result == 'wrongAccess'){
							alert('잘못된 접속입니다.');
						}else{
							alert('파일 삭제 오류 발생');
						}
					},
					error:function(){
						alert('네트워크 오류 발생!');
					}
				});
			}
		});
		
	});
</script>  
</c:if>
		<div class="form-group"> 
		<div class="col-sm-offset-3 col-sm-9"> 
		</div> 
		</div> 
		
		<div class="blank_50"></div>
		
		<div class="form-group"> 
			<div class="col-sm-offset-3 col-sm-2"> 
				<button type="submit" class="btn btn-info">수정</button> 
			</div> 
			<div class="col-sm-7">
				<button type="button" class="btn" onclick="location.href='myReview.do'">			
				취소
				</button> 
			</div> 
		</div>		
	</form>
</div>
<div class="blank_100"></div>
</body>
</html>