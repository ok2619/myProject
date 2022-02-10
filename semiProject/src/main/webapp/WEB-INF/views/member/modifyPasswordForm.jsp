<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호수정</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
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
<div class="page-main">
	<h2>비밀번호수정</h2>
	<form action="modifyPassword.do" method="post" id="password_form">
		<div class="input-group input-group-sm mb-3" style="width:80px">
		
			<label for="ID">아이디</label><br>
    		<input type="text" class="form-control" id="id" name="id" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
    		<label for="ORIGIN_PASSWD">현재비밀번호</label><br>
    		<input type="password" class="form-control" id="origin_passwd" name="origin_passwd" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
    		<label for="PASSWD">새비밀번호</label><br>
    		<input type="password" class="form-control" id="passwd" name="passwd" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
    		<label for="CPASSWD">새비밀번호 확인</label><br>
    		<input type="password" class="form-control" id="cpasswd" name="cpasswd" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
    		<span id="message_cpasswd"></span>
		</div>
		<input type="submit" value="변경">
		<input type="button" value="메인으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
	</form>
</div>
</body>
</html>




