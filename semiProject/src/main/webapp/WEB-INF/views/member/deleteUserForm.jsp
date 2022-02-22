<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ABCshop :: 회원탈퇴</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function(){
		//이벤트 연결
		$('#delete_form').submit(function(){
			if($('#id').val().trim()==''){
				alert('아이디를 입력하세요');
				$('#id').val('').focus();
				return false;
			}
			if($('#passwd').val().trim()==''){
				alert('비밀번호를 입력하세요');
				$('#passwd').val('').focus();
				return false;
			}
			if($('#cpasswd').val().trim()==''){
				alert('비밀번호 확인을 입력하세요');
				$('#cpasswd').val('').focus();
				return false;
			}
			if($('#passwd').val()!=$('#cpasswd').val()){
				alert('비밀번호 불일치');
				$('#cpasswd').val('').focus();
				return false;
			}
		});//submit끝
		
		//비밀번호 확인 후 비밀번호를 재수정시 비밀번호 확인 및 메시지 초기화
		$('#passwd').keyup(function(){
			$('#cpasswd').val('');
			$('#message_id').text('');
		});
			
		//비밀번호 일치 여부 확인
		$('#cpasswd').keyup(function(){
			if($('#passwd').val() == $('#cpasswd').val()){
				$('#message_id').text('비밀번호 일치');
			}else{
				$('#message_id').text('');
			}
		});
	});
</script>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h3 class="align-center common_title">회원탈퇴</h3>		
		<form action="deleteUser.do" method="post" id="delete_form" class="form-inline">
			<div class="form-group">
				<label for="id">아이디</label>
			</div>
			<div class="form-group">
	    		<input type="text" class="form-control" id="id" name="id" placeholder="id"aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
	    	</div>
	    	<p>
		
			<div class="form-group">
    			<label for="passwd">비밀번호</label>
	    	</div>
	    	<div class="form-group">
	    		<input type="password" class="form-control" id="passwd" name="passwd" placeholder="password" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
	    	</div>
	    	<p>
			
			<div class="form-group">
    			<label for="cpasswd">비밀번호 확인</label>
	    	</div>
	    	<div class="form-group">
	    		<input type="password" class="form-control" id="cpasswd" name="cpasswd" placeholder="confirm new password"aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
	    		<span id="message_cpasswd"></span>
			</div>
			<p>
			<div class="blank_50"></div>			
			<div class="align-center go_left_60">
				<input type="submit" class="btn btn-danger" value="회원탈퇴">
				<input type="button" class="btn btn-defualt margin_left_10" value="취소" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
			</div>
			
		</form>

</body>
</html>