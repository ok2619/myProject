<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>

<script type="text/javascript">
	$(function(){
		let idChecked = 0;
		let pass = 0;

//ㅡㅡㅡㅡㅡ비밀번호 확인ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
		
		//[비밀번호]와 [비밀번호 확인] 일치 여부 체크(방법1)
		$('#cpasswd').keyup(function(){
			if($('#passwd').val()==$('#cpasswd').val()){
				$('#message_passwd').css('color','blue').text('비밀번호가 일치합니다');
			}else{
				$('#message_passwd').css('color','red').text('비밀번호가 불일치합니다');
				
			}
		});
		
		//[비밀번호 확인] 입력 후 다시 [비밀번호] 수정 시 [비밀번호 확인]에 입력한 내용을 초기화
		$('#passwd').keyup(function(){ //비번 수정을 위해 입력시
			$('#cpasswd').val(''); 	//내용 초기화
			$('#message_passwd').text(''); //확인 문구 초기화
		});
		
		//ㅡㅡㅡㅡㅡ비밀번호 확인(방법2)
		/* $('#passwd_check').click(function(){
			$.ajax({
				url:'passwordCheck.do',
				type:'post',
				data:{passwd:$('#passwd').val(),
					  cpasswd:$('#cpasswd').val()},
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){
					if(param.result == 'agreement'){
						$('#message_passwd').css('color','blue').text('비밀번호가 일치합니다');
						pass = 1;
					}else if(param.result == 'disagreement'){
						pass = 0;
						$('#message_passwd').css('color','red').text('비밀번호가 불일치합니다');
						$('#cpasswd').val('').focus();
					}else{
						alert('비밀번호 확인 오류');
					}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});
		}); */
		
//ㅡㅡㅡㅡㅡ아이디 중복 확인ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
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
						$('#message_id').css('color','blue').text('사용 가능한 ID 입니다');
					}else if(param.result == 'idDuplicated'){
						idChecked = 0;
						$('#message_id').css('color','red').text('이미 사용 중인 ID 입니다');
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
		
//ㅡㅡㅡㅡㅡ회원가입 유효성 체크ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
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
			if($('#cpasswd').val().trim()==''){
				alert('비밀번호 확인을 입력하세요');
				$('#cpasswd').val('').focus();
				return false;
			}
			/* if(pass==0){
				alert('비밀번호 확인 필수!');
				return false;
			} */
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
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="page-main">
	<h3 class="align-center common_title">회원가입</h3>		
	<form id="signUp_form" action="signUp.do" method="post" class="form-inline">
	
		<div class="form-group">
			<label for="ID" class="control-label font4">아이디</label>
		</div>
		<div class="form-group">
			<input type="text" class="form-control" id="id" name="id" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">			
		</div>       		
		<button type="button" id="id_check" class="btn btn-danger btn-sm">중복체크</button>
		<span id="message_id"></span>	
		 <p>	
		 	
		 <div class="form-group">
			<label for="PASSWD" class="control-label font4">비밀번호</label> 
		</div>
		<div class="form-group">
			<input type="password" class="form-control" id="passwd" name="passwd" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">			
		</div>       		
		<p>		
				
		<div class="form-group">
			<label for="CPASSWD" class="control-label font4">비밀번호 확인</label> 
		</div>
		<div class="form-group">
			<input type="password" class="form-control" id="cpasswd" name="cpasswd" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">			
		</div>       				
		<!-- <button type="button" id="passwd_check" class="btn btn-default btn-sm">확인</button> -->
		<span id="message_passwd"></span>	
		<p>   
		
		<div class="form-group">
			<label for="NAME" class="control-label font4">이름</label>
		</div>
		<div class="form-group">
			<input type="text" class="form-control" id="name" name="name" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">						
		</div>       		
		 <p>
		 
		 <div class="form-group">
			<label for="phone" class="control-label font4">연락처</label>
		</div>
		<div class="form-group">
			<input type="text" class="form-control" id="phone" name="phone" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">			
		</div>       		
		 <p>
		 
		 <div class="form-group">
			<label for="zipcode" class="control-label font4">주소</label>
		</div>
		<div class="form-group">
			<input type="text" class="form-control" id="zipcode" name="zipcode" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">			
		</div>  
		<button type="button" onclick="sample2_execDaumPostcode()" class="btn btn-default btn-xs">우편번호 〉</button>     		
		 <p>
				
		<div class="form-group">
			<label for="address1" class="control-label"></label>
		</div>
		<div class="form-group">
			<input type="text" class="form-control" id="address1" name="address1" placeholder="기본주소" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">			
		</div>       		
		 <p>
		
		<div class="form-group">
			<label for="address2" class="control-label"></label>
		</div>
		<div class="form-group">
			<input type="text" class="form-control" id="address2" name="address2" placeholder="상세주소" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">			
		</div>       		
		<p><p><p>
		<div class="align-center">
			<input type="submit" class="btn btn-info btn-lg font4" value="&nbsp;&nbsp;&nbsp;회원가입&nbsp;&nbsp;&nbsp;" id="submit_btn"> <!-- &nbsp; :공백 -->
		</div>  
	</form>	

</div>

<!-- 우편번호 스크립트 시작 -->
<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    //(주의)address1에 참고항목이 보여지도록 수정
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    //(수정) document.getElementById("address2").value = extraAddr;
                
                } 
                //(수정) else {
                //(수정)    document.getElementById("address2").value = '';
                //(수정) }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode;
                //(수정) + extraAddr를 추가해서 address1에 참고항목이 보여지도록 수정
                document.getElementById("address1").value = addr + extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("address2").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>
<!-- 우편번호 스크립트 끝 -->
</body>
</html>