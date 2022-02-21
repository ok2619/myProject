<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰게시판 | 리뷰작성</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
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
			if($('#b_content').val().length < 10){
				 alert("10자 이상 입력해주세요");		
				return false;
			}				
		});		
		
		//첨부 사진 미리보기
		$("#filename").change(function(){//파일선택 버튼 누르고 이미지가 올라가면
				if (this.files && this.files[0]){
					var reader = new FileReader;
					reader.onload = function(data){
						$(".select_img img").attr("src", data.target.result).width(120);
					}
					reader.readAsDataURL(this.files[0]);
				}
				$('#photo_delete').show();  //파일 삭제 버튼 나타내기
				$('#sample_img').hide();							
			});		
		
		//이미지 첨부 취소 (파일삭제 버튼 클릭)
		$('#delete_btn').click(function(){			
			$('.select_img img').attr('src',''); 
			$('#filename').val('');
			$('#photo_delete').hide();
			$('#sample_img').show();
		});			
				
	});
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="page-main">
	<h3 class="align-center common_title"><a href="list.do">상품 후기</a></h3>	
	<form id="write_form" action="write.do" method="post" enctype="multipart/form-data">	
		<table class="go_left_update">
		<tr>
			<td class="align-center"><label for="title">제목</label></td>
			<td><input type="text" name="title" id="title" maxlength="50" class="form-control"><p></td>			
			<td rowspan="2">
				<div class="select_img">
					<img src="" />
				</div>
				<p>
				<div id="sample_img">
				<img src="${pageContext.request.contextPath}/upload/preview.JPG" class="sample_img">
				</div>
			</td>
		</tr>
		<tr>
			<td rowspan="2" class="align-center"><label for="b_content">내용</label></td>
			<td rowspan="2">
			<textarea rows="5" cols="30" name="b_content" id="b_content" class="update_content form-control" placeholder="10자 이상 입력해주세요"></textarea>
			</td>
		</tr>
		<tr>
			<td>
			<div class="form-group"> 
				<div class="margin_left" />
				<div id="photo_delete" style="display:none;" class="col-xs-4">
				<input type="button" value="파일 삭제" id="delete_btn">
				</div>
				<div class="col-xs-7">
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
		<div class="blank_50"></div>
		
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
	
	
			
</body>
</html>