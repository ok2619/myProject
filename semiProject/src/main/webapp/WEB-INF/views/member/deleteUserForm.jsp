<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial_scale=1.0">
<title>회원탈퇴</title>
<link rel="stylesheet" href="../css/bootstrap.min.css" type="text/css">
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
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
			}//submit끝
			
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
<div class="container">
	<h3>회원탈퇴</h3>
		<form action="deleteUser.do" method="post" id="delete_form">
			<div  class="form-group">
				<label for="id" class="form-label mt-4">아이디</label>
				<input type="text" id="id" maxlength="12" >
			</div>
			<div  class="form-group">
				<label for="passwd">비밀번호</label>
				<input type="password" name="passwd" id="passwd" maxlength="12">
			</div>
			<div  class="form-group">
				<label for="cpasswd">비밀번호 확인</label>
				<input type="password" name="cpasswd" id="cpasswd" maxlength="12">
				<span id="message_id"></span>
			</div>
			<div>
			<input type="submit" value="회원탈퇴">
			<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
			</div>
		</form>
	</div>
</body>
</html>