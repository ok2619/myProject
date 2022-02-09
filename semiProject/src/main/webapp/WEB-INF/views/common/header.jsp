<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- header 시작 -->
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial_scale=1.0"> <!-- ?? -->
<title>bootstrap</title>
<link rel="stylesheet" href="../css/bootstrap.min.css" type="text/css">
</head>
<body>
	<!-- 상단 고정 네이게이션 시작 -->
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">Project World</a>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li class="active"><a href="#">Home</a></li>
					<li><a href="#">Home</a></li>
					<li><a href="#">Home</a></li>
					
				</ul>
			</div>
		</div>
	</div>
	<!-- 상단 고정 네이게이션 끝 -->
	<!-- 전체 화면 점보트론 시작 -->
	<div class="jumbotron">
		<div class="container">
			<h1>Hello, Bootstrap!</h1>
			<p>부트스트랩을 이용해서 다양한 화면을 구성하고 반응형으로 문서를 작성할 수 있습니다. 부트스트랩은 주로 사용되는 버전이 3,4,5 버전이며 주기적으로 버전업이 되기 때문에 향상된 기능을 사용할 수 있습니다.</p>
			<p>
				<a class="btn btn-success btn-lg">Learn more</a>
			</p>
		</div>
	</div>
	<!-- 전체 화면 점보트론 끝 -->

		<!-- footer시작 -->
		<hr>
		<div id="footer">
			<p class="text-center">&copy; Project World</p>
		</div>
		<!-- footer끝 -->
	</div>
	<script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script> <!-- 제이쿼리는 왜 넣지? -->
	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
</body>
</html>
<!-- header 끝 -->







