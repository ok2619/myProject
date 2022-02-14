<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰게시판 | 리뷰작성</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	//유효성 체크
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
		
		//첨부 사진 미리보기
		$("#filename").change(
			function(){
				if (this.files && this.files[0]){
					var reader = new FileReader;
					reader.onload = function(data){
						$(".select_img img").attr("src", data.target.result).width(100);
					}
					reader.readAsDataURL(this.files[0]);
				}
				$('#photo_delete').show(); 
			});		
		
		//이미지 첨부 취소 (파일삭제 버튼 클릭)
		$('#delete_btn').click(function(){			
			$('.select_img img').attr('src',''); 
			$('#filename').val('');
			$('#photo_delete').hide();
		});		
		
	});
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="page-main">
	<h3 class="align-center common_title"><a href="list.do">상품 후기</a></h3>	
	<form id="write_form" action="write.do" method="post" enctype="multipart/form-data">	
		<table class="go_left">
		<tr>
			<td class="align-center"><label for="title">제목</label></td>
			<td><input type="text" name="title" id="title" maxlength="50" class="form-control"><p></td>			
			<td rowspan="2">
				<div class="select_img margin_left">
					<img src="" />
				</div>
			</td>
		</tr>
		<tr>
			<td rowspan="2" class="align-center"><label for="b_content">내용</label></td>
			<td rowspan="2"><textarea rows="5" cols="30" name="b_content" id="b_content" class="form-control"></textarea></td>
		</tr>
		<tr>
			<td>
			<div class="form-group"> 
			
				<div id="photo_delete" style="display:none;" class="col-xs-4">
				<input type="button" value="파일 삭제" id="delete_btn">
				</div>
				<div class="col-xs-8">
				<input type="file" name="filename" id="filename" 
				accept="image/gif,image/png,image/jpeg">		
				</div>
			</div>			
			</td>
		</tr>
		</table>	
		
		<div class="form-group"> 
		<div class="col-sm-offset-3 col-sm-9"> 
		</div> 
		</div> 
		
		<div class="form-group"> 
			<div class="col-sm-offset-3 col-sm-2"> 
				<button type="submit" class="btn btn-info">등록</button> 
			</div> 
			<div class="col-sm-7">
				<button type="button" class="btn" onclick="location.href='list.do'">			
				취소
				</button> 
			</div> 
		</div>
		
	</form>
</div>
	
	<!-- <ul>
			<li>
				<label for="title">제목</label>
				<input type="text" name="title" id="title" maxlength="50">
			</li>		
			<li>
				<label for="b_content">내용</label>
				<textarea rows="5" cols="30" name="b_content" id="b_content"></textarea>
			</li>
			<li>
				<label for="filename">사진</label>
				<div class="uploadDiv">
					<input type="file" name="filename" id="filename" 
							accept="image/gif,image/png,image/jpeg"> 파일선택 버튼
					이미지 미리보기 영역
					<div class="select_img">
						<img src="" />
					</div>
				</div>					
				
			</li>	 
		</ul>
		<div class="align-center">
			<input type="submit" value="등록">
			<input type="button" value="취소" onclick="location.href='list.do'">
		</div> -->
			
</body>
</html>