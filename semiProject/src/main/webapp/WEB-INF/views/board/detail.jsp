<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글상세</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/board-reply.js"></script>

<script type="text/javascript">
	$(function(){ // 게시물을 조회했을때 ajax
		var status; //noFav or yesFav
		function selectData(board_num){ //77라인 초기값 세팅
		   $.ajax({
		      type:'post',
		      data:{board_num:board_num}, //초기값 세팅에서 매개변수로 받아서 el 안씀
		      url:'getFav.do', //LikecountAction
		      dataType:'json',
		      cache:false,
		      timeout:30000,
		      success:function(data){
		         if(data.result=='success'){
		            displayFav(data);
		         }else{
		            alert('좋아요 읽기 오류');
		         }
		      },
		      error:function(){
		         alert('네트워크 오류');
		      }
		   });
		}

			$('#output_fav').click(function(){ //좋아요를 클릭했을때 실행되는 ajax
				$.ajax({
					url:'like.do',
					type:'post',
					data:{board_num:${board.board_num}},
					dataType:'json',
					cache:false,
					timeout:30000,
					success:function(data){
						if(data.result=='logout'){
				               alert('로그인 후 좋아요를 눌러주세요!');
				            }else if(data.result=='success'){ //추천하트 표시
				            	displayFav(data);
				            }else{
				               alert('등록시 오류 발생!');
				            }
					},
					error:function(){
						alert('네트워크 오류 발생');
					}
				});
			});
			//좋아요 표시
		   function displayFav(data){
		      status = data.status;
		      var count = data.count;
		      var output;
		      if(status=='noFav'){
		         output = '../image/heart1.png';
		      }else{
		         output = '../image/heart2.png';
		      }         
		      //문서 객체에 추가
		      $('#output_fav').attr('src',output); //id가 output_fav인 태그 src에 output 저장
		      $('#output_fcount').text(count); //id가 output_fcount인 태그 text에 count(좋아요 총 개수)저장
		   }
			//초기값 셋팅
			selectData(${board.board_num});
			
	});
</script>


</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="page-main">
	<h3 class="align-center common_title"><a href="list.do">상품 후기</a></h3>
	<ul>		
		<li><p class="font">제목 : ${board.title}</p></li>
		<li><p class="font">작성자 : ${board.id}</p></li>		
		<li><p class="font">작성일 : ${board.reg_date}</p></li>
	</ul>
	<hr size="1" width="100%" noshade="noshade">
	<c:if test="${!empty board.filename}">
	<!-- <div class="align-center"> -->
		<img src="${pageContext.request.contextPath}/upload/${board.filename}" class="detail-img">
	<!-- </div> -->
	</c:if>
	<div class="blank_20"></div>
	<p class="font">
		${board.b_content}
	</p>
	<div class="blank_20"></div>
	<br>
	<hr size="1" width="100%" noshade="noshade">
	
	<div class="align-right view_font">
	<p class="float_left view_font2">조회수 : ${board.hit}</p>
		<p class="float_left view_font2 margin_left_10">
		<c:if test="${!empty board.modify_date}">
		| &nbsp;최근 수정일 : ${board.modify_date}&nbsp;&nbsp;
		</c:if>	
		</p>
		<!-- 좋아요 기능 시작-->		
		<img id="output_fav" src="../image/heart1.png">
      	<span id="output_fcount" class="margin_right_10"></span>
      	<!-- 좋아요 기능 끝-->
		<%--로그인한 회원번호와 작성자 회원번호가 일치해야 수정,삭제 가능 --%>
		<c:if test="${user_number == board.user_num}">
		<input type="button" value="수정" 
		onclick="location.href='updateForm.do?board_num=${board.board_num}'" class="btn btn-default btn-sm">
		<input type="button" value="삭제" id="delete_btn" class="btn btn-sm">
		<script type="text/javascript">
			let delete_btn = document.getElementById('delete_btn');
			//삭제버튼에 이벤트 연결
			delete_btn.onclick=function(){
				let choice = confirm('삭제하시겠습니까?');
				if(choice){
					location.replace('delete.do?board_num=${board.board_num}');
				}
			};
		</script>		
		</c:if>	
		<%--수정/삭제 기능 끝 --%>		
		<input type="button"  class="btn btn-default btn-sm" value="목록" onclick="location.href='list.do'">

	</div>
 <div class="blank_30"></div> 

<!-- 댓글 시작 -->
	<div id="reply_div">
		<span class="re-title">댓글</span>
		<form id="re_form">
			<input type="hidden" name="board_num" value="${board.board_num}" id="board_num">
			<textarea rows="3" cols="50" name="re_content" id="re_content" class="rep-content form-control" placeholder="댓글을 입력하세요."
			<c:if test="${empty user_number}">disabled="disabled"</c:if>
			><c:if test="${empty user_number}">회원에게만 댓글 작성 권한이 있습니다.</c:if></textarea>
		<c:if test="${!empty user_number}">
		
		<div id="re_second" > <!-- class="align-right" -->
			<input type="submit" value="전송"  class="btn btn-default btn-sm margin_left_10">
		</div>
		<div class="clear"></div>
		<div id="re_first">
			<span class="letter-count">300/300</span>
		</div>
		</c:if>
		</form>
	</div>
	<p>
	<!-- 댓글 목록 출력 시작 -->
	<div id="output"></div>
	<div class="paging-button" style="display:none;">
		<input type="button" value="다음글 보기">
	</div>	
	<!-- 댓글 목록 출력 끝 -->
<!-- 댓글 끝 -->
<div class="blank_50"></div>
</div>
</body>
</html>









