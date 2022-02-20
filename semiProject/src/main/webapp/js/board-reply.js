$(function(){
	let currentPage;
	let count;
	let rowCount;
	
	//댓글 목록
	function selectData(pageNum){
		currentPage = pageNum;

		$.ajax({
			type:'post',
			data:{pageNum:pageNum,board_num:$('#board_num').val()},
			url:'listReply.do',
			dataType:'json',
			cache:false,
			timeout:3000,
			success:function(param){
				
				count = param.count;
				rowCount = param.rowCount;
				
				if(pageNum == 1){
					//처음 호출시는 해당 ID의 div의 내부 내용물을 제거
					$('#output').empty();
				}
				
				$(param.list).each(function(index,item){
					let output = '<div class="item">';
					output += '<h4 class="user_font">' + item.id + '</h4>';
					output += '<div class="sub-item">';
					output += '<p class="content_font">' + item.re_content + '</p>';
					
					if(item.re_modifydate){
						output += '<span class="modify-date modify_letter">최근 수정일 : ' + item.re_modifydate + '</span>';	
					}else{
						output += '<span class="modify-date modify_letter">등록일 : ' + item.re_date + '</span>';
					}
					
					//로그인한 회원번호와 작성자의 회원번호 일치 여부 체크
					if(param.user_num == item.user_num){
						//로그인한 회원번호와 작성자 회원번호 일치
						output += ' <input type="button" data-renum="'+item.re_num+'" value="수정" class="margin_left_10 modify-btn btn btn-default btn-xs">';
						output += ' <input type="button" data-renum="'+item.re_num+'" value="삭제" class="delete-btn btn btn-default btn-xs">';
					}
					
					output += '<hr size="1" noshade width="100%">';
					output += '</div>';
					output += '</div>';
					
					//문서 객체에 추가
					$('#output').append(output);					
				});
				
				//page button 처리
				if(currentPage>=Math.ceil(count/rowCount)){
					//다음 페이지가 없음
					$('.paging-button').hide();
				}else{
					//다음 페이지가 존재
					$('.paging-button').show();
				}
			},
			error:function(){
				alert('네트워크 오류 발생!');
			}
		});
	}
	
	//페이지 처리 이벤트 연결(다음 댓글 보기 버튼 클릭시 데이터 추가)
	$('.paging-button input').click(function(){
		selectData(currentPage + 1);
	});
	
	//댓글 등록
	$('#re_form').submit(function(event){
		if($('#re_content').val().trim()==''){
			alert('내용을 입력하세요');
			$('#re_content').val('').focus();
			return false;
		}
		//form 이하의 태그에 입력한 데이터를 모두 읽어옴
		let form_data = $(this).serialize();
		
		//데이터 전송
		$.ajax({
			url:'writeReply.do',
			type:'post',
			data:form_data,
			dataType:'json',
			cache:false,
			timeout:30000,
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인후 작성할 수 있습니다.');
				}else if(param.result == 'success'){
					//폼 초기화
					initForm();
					//댓글 작성이 성공하면 새로 입력한 글을 포함해서 첫번째 페이지의 게시글을
					//다시 호출함
					selectData(1);
					alert('등록되었습니다.');
				}else{
					alert('등록시 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생!');
			}
		});
		//기본 이벤트 제거
		event.preventDefault();
	});
	//댓글 작성 폼 초기화
	function initForm(){
		$('textarea').val('');
		$('#re_first .letter-count').text('300/300');
	}
	//textarea에 내용 입력시 글자수 체크
	$(document).on('keyup','textarea',function(){
		//입력한 글자수를 구함
		let inputLength = $(this).val().length;
		
		if(inputLength > 300){//300자를 넘어선 경우
			$(this).val($(this).val().substring(0,300));
		}else{//300자 이하인 경우
			let remain = 300 - inputLength;
			remain += '/300';
			if($(this).attr('id') == 're_content'){
				//등록폼 글자수
				$('#re_first .letter-count').text(remain);
			}else{
				//수정폼 글자수
				$('#mre_first .letter-count').text(remain);
			}
		}
	});
	//댓글 수정 버튼 클릭시 수정폼 노출
	$(document).on('click','.modify-btn',function(){
		//댓글 번호
		let re_num = $(this).attr('data-renum');
		//댓글 내용
		let content = $(this).parent().find('p').html().replace(/<br>/gi,'\n');
		                                        //g:지정 문자열 모두,i:대소문자 무시
		
		//댓글 수정폼 UI
		let modifyUI = '<form id="mre_form" class="go_left_70">';
		   modifyUI += '  <input type="hidden" name="re_num" id="mre_num" value="' + re_num + '">';
		   modifyUI += '  <textarea rows="2" cols="50" name="re_content" id="mre_content" class="form-control rep-contents">' + content + '</textarea>';
           modifyUI += '  <div id="mre_first"><span class="letter-count">300/300</span></div>';
           modifyUI += '  <div id="mre_second" class="align-right">';
           modifyUI += '    <input type="submit" value="수정" class="btn btn-info btn-sm">';
           modifyUI += '    <input type="button" value="취소" class="re-reset btn btn-default btn-sm">';
           modifyUI += '  </div>';
           /*modifyUI += '  <hr size="1" noshade width="96%">';*/
           modifyUI += '</form>';
		
		//이전에 이미 수정하는 댓글이 있을 경우 수정 버튼을 클릭하면 숨김
		//sub-item을 환원시키고 수정폼 초기화
		initModifyForm();
		//지금 클릭해서 수정하고자 하는 데이터는 감추기
		//수정 버튼을 감싸고 있는 div
		$(this).parent().hide();
		//수정폼을 수정하고자 하는 데이터가 있는 div에 노출
		$(this).parents('.item').append(modifyUI);
		
		//입력한 글자수 셋팅
		let inputLength = $('#mre_content').val().length;
		let remain = 300 - inputLength;
		remain += '/300';
		
		//문서 객체에 반영
		$('#mre_first .letter-count').text(remain);
	});
	//수정폼에서 취소 버튼 클릭시 수정폼 초기화
	$(document).on('click','.re-reset',function(){
		initModifyForm();
	});
	//댓글 수정 폼 초기화
	function initModifyForm(){
		$('.sub-item').show();
		$('#mre_form').remove();
	}
	//댓글 수정
	$(document).on('submit','#mre_form',function(event){
		if($('#mre_content').val().trim()==''){
			alert('내용을 입력하세요');
			$('#re_content').val('').focus();
			return false;
		}
		
		//폼에 입력한 데이터 반환
		let form_data = $(this).serialize();
		
		//서버와 통신
		$.ajax({
			url:'updateReply.do',
			type:'post',
			data:form_data,
			dataType:'json',
			cache:false,
			timeout:30000,
			success:function(param){
				if(param.result=='logout'){
					alert('로그인후 수정 가능합니다.');
				}else if(param.result == 'success'){
					$('#mre_form').parent().find('p').html($('#mre_content').val().replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/\n/g,'<br>'));
					$('#mre_form').parent().find('.modify-date').text('최근 수정일 : 5초미만');
					//수정폼 삭제 및 초기화
					initModifyForm();
				}else if(param.result == 'wrongAccess'){
					alert('타인의 글을 수정할 수 없습니다.');
				}else{
					alert('수정시 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
		//기본 이벤트 제거
		event.preventDefault();
	});
	//댓글 삭제
	$(document).on('click','.delete-btn',function(){
		//댓글 번호
		let re_num = $(this).attr('data-renum');
		
		$.ajax({
			url:'deleteReply.do',
			type:'post',
			data:{re_num:re_num},
			dataType:'json',
			cache:false,
			timeout:30000,
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인후 삭제 가능합니다.');
				}else if(param.result == 'success'){
					alert('댓글이 삭제되었습니다');
					selectData(1);
				}else if(param.result == 'wrongAccess'){
					alert('타인의 글을 삭제할 수 없습니다.');
				}else{
					alert('삭제시 오류 발생!');
				}
			},
			error:function(){
				alert('네트워크 오류 발생!');
			}
		});
		
	});
//초기 데이터(목록) 호출
	selectData(1);
});