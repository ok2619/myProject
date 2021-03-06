<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ABCshop :: 비밀번호 변경</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#password_form').submit(function(){
			if($('#id').val().trim()==''){
				alert('아이디를 입력하세요!');
				$('#id').val('').focus();
				return false;
			}
			if($('#origin_passwd').val().trim()==''){
				alert('현재 비밀번호를 입력하세요!');
				$('#origin_passwd').val('').focus();
				return false;
			}
			if($('#passwd').val().trim()==''){
				alert('새비밀번호를 입력하세요!');
				$('#passwd').val('').focus();
				return false;
			}
			if($('#cpasswd').val().trim()==''){
				alert('새비밀번호 확인을 입력하세요!');
				$('#cpasswd').val('').focus();
				return false;
			}
			if($('#passwd').val()!=$('#cpasswd').val()){
				alert('새비밀번호와 새비밀번호 확인이 불일치');
				$('#cpasswd').val('').focus();
				return false;
			}
		});

		$('#passwd').keyup(function(){
			$('#cpasswd').val('');
			$('#message_cpasswd').text('');
		});

		$('#cpasswd').keyup(function(){
			if($('#passwd').val()==$('#cpasswd').val()){
				$('#message_cpasswd').text('새비밀번호 일치');
			}else{
				$('#message_cpasswd').text('');
			}
		});
		
	});
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="page-main">
	<h3 class="align-center common_title">비밀번호 변경</h3>
	<form action="modifyPassword.do" method="post" id="password_form" class="form-inline">
		<div class="form-group">
			<label for="id" class="control-label font4">아이디</label>
		</div>
		<div class="form-group">
    		<input type="text" class="form-control" id="id" name="id" placeholder="id"aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
    	</div>
    	<p>
    	
    	<div class="form-group">
    		<label for="origin_passwd" class="control-label font4">현재 비밀번호</label>
    	</div>
    	<div class="form-group">
    		<input type="password" class="form-control" id="origin_passwd" name="origin_passwd" placeholder="password" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
    	</div>
    	<p>
    	
    	<div class="form-group">
    		<label for="passwd" class="control-label font4">새 비밀번호</label>
    	</div>
    	<div class="form-group">
    		<input type="password" class="form-control" id="passwd" name="passwd" placeholder="new password"aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
    	</div>
    	<p>
    	
    	<div class="form-group">
    		<label for="cpasswd" class="control-label font4">새 비밀번호 확인</label>
    	</div>
    	<div class="form-group">
    		<input type="password" class="form-control" id="cpasswd" name="cpasswd" placeholder="confirm new password"aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
    		<span id="message_cpasswd"></span>
		</div>
		<p>
		
		<div class="blank_50"></div>
		<div class="align-center go_left_70">
			<input type="submit" class="btn btn-info font4" value="확인">
			<input type="button" class="btn btn-defualt font4 margin_left_10"value="취소" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
		
	</form>
</div>
</body>
</html>




