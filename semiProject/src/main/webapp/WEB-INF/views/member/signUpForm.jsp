<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		let idChecked = 0;
		
		$('#id_check').click(function(){
			if($('#id').val().trim()==''){
				alert('아이디를 입력하세요!');
				$('#id').val('').focus();
				return;
			}
			
			$.ajax({
				url:'checkId.do',
				type:'post',
				data:{id:$('#id').val()},
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){
					if(param.result == 'idNotFound'){
						idChecked = 1;
						$('#message_id').css('color','#000000').text('등록 가능 ID');
					}else if(param.result == 'idDuplicated'){
						idChecked = 0;
						$('#message_id').css('color','red').text('중복된 ID');
						$('#id').val('').focus();
					}else{
						idChecked = 0;
						alert('아이디 중복 체크 오류 발생');
					}
				},
				error:function(){
					idChecked = 0;
					alert('네트워크 오류 발생');
				}
			});
		});
		
		$('#signUp_form #id').keyup(function(){
			idChecked = 0;
			$('#message_id').text('');
		});
		
		$('#signUp_form').submit(function(){
			if($('#id').val().trim()==''){
				alert('아이디를 입력하세요');
				$('#id').val('').focus();
				return false;
			}
			if(idChecked==0){
				alert('아이디 중복 체크 필수!');
				return false;
			}
			if($('#passwd').val().trim()==''){
				alert('비밀번호를 입력하세요');
				$('#passwd').val('').focus();
				return false;
			}
			if($('#name').val().trim()==''){
				alert('이름을 입력하세요');
				$('#name').val('').focus();
				return false;
			}
			if($('#phone').val().trim()==''){
				alert('연락처를 입력하세요');
				$('#phone').val('').focus();
				return false;
			}
			if($('#zipcode').val().trim()==''){
				alert('우편번호를 입력하세요');
				$('#zipcode').val('').focus();
				return false;
			}
			if($('#address1').val().trim()==''){
				alert('주소를 입력하세요');
				$('#address1').val('').focus();
				return false;
			}
			if($('#address2').val().trim()==''){
				alert('상세 주소를 입력하세요');
				$('#address2').val('').focus();
				return false;
			}
			 
		});
	});
	
</script>
</head>
<body>

<form id="signUp_form" action="signUp.do" method="post">
<div class="input-group input-group-sm mb-3" style="width:80px">
    <label for="ID">아이디</label><br>
  	<input type="text" class="form-control" id="id" name="id" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
	<button type="button" id="id_check" class="btn btn-primary">중복체크</button>
	<span id="message_id"></span>
	
	<label for="PASSWD">비밀번호</label><br>
    <input type="password" class="form-control" id="passwd" name="passwd" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
    <label for="CPASSWD">비밀번호 확인</label><br>
    <input type="password" class="form-control" id="cpasswd" name="cpasswd" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
    <label for="NAME">이름</label><br>
  	<input type="text" class="form-control" id="name" name="name" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
  	<label for="PHONE">연락처</label><br>
  	<input type="text" class="form-control" id="phone" name="phone" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
  	
  	<label for="zipcode">우편번호</label><br>
  	<input type="text" class="form-control" id="zipcode" name="zipcode" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
  	<button type="button" onclick="sample2_execDaumPostcode()" class="btn btn-primary">우편번호 찾기</button>
  	
  	<label for="address1">주소</label><br>
  	<input type="text" class="form-control" id="address1" name="address1" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
  	<label for="address2">상세주소</label><br>
  	<input type="text" class="form-control" id="address2" name="address2" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
  	
  	<input type="submit" value="가입">
</div>

</form>
</body>
</html>