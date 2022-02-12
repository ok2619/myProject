<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial_scale=1.0">
<title>abc shop</title>
<link rel="stylesheet" href="../css/bootstrap.min.css" type="text/css">
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<style>
.all{
	width:900px;
	margin:0 auto;
	}
.row2{
	width:33%;
	float:left;
	}
</style>
</head>
<body>
	
	<div>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<!-- <div class="container-fluid">
			<div class="container">
				<h3>3개 컬럼</h3>
				<div class="row">
					<div class="col-md-3"><a href="#">outer</a></div>
					<div class="col-md-3"><a href="#">top</a></div>
					<div class="col-md-3"><a href="#">bottom</a></div>
					<div class="col-md-3"><a href="#">ect</a></div>
				</div>
			</div>
		</div> -->
    </div>
    
    <!--//////////////////////////////////////////////////////////////////////////////////-->

<div class="all">
	<div class="row2">
  		<div class="col-sm-4 col-md-2" style="width:300px;">
   			<div class="thumbnail">
        		<img src="../upload/NO.png" alt="no">
				     <div class="caption">
				     	<h3>하의1</h3>
				        	<p>...</p>
				        	<p>
				        	<a href="#" class="btn btn-primary" role="button">상품보기</a> 
				        	<a href="#" class="btn btn-default" role="button">장바구니</a>
				        	</p>
				     </div>
    			</div>
  			</div>
		</div>
		<div class="row2">
  		<div class="col-sm-4 col-md-2" style="width:300px;">
   			<div class="thumbnail">
        		<img src="../upload/NO.png" alt="no">
				     <div class="caption">
				     	<h3>하의2</h3>
				        	<p>...</p>
				        	<p>
				        	<a href="#" class="btn btn-primary" role="button">상품보기</a> 
				        	<a href="#" class="btn btn-default" role="button">장바구니</a>
				        	</p>
				     </div>
    			</div>
  			</div>
		</div>
		<div class="row2">
  		<div class="col-sm-4 col-md-2" style="width:300px;">
   			<div class="thumbnail">
        		<img src="../upload/NO.png" alt="no">
				     <div class="caption">
				     	<h3>하의3</h3>
				        	<p>...</p>
				        	<p>
				        	<a href="#" class="btn btn-primary" role="button">상품보기</a> 
				        	<a href="#" class="btn btn-default" role="button">장바구니</a>
				        	</p>
				     </div>
    			</div>
  			</div>
		</div>
	</div>

		
    <!--//////////////////////////////////////////////////////////////////////////////////-->
    <div class="all">
	<div class="row2">
  		<div class="col-sm-4 col-md-2" style="width:300px;">
   			<div class="thumbnail">
        		<img src="../upload/NO.png" alt="no">
				     <div class="caption">
				     	<h3>신발1</h3>
				        	<p>...</p>
				        	<p>
				        	<a href="#" class="btn btn-primary" role="button">상품보기</a> 
				        	<a href="#" class="btn btn-default" role="button">장바구니</a>
				        	</p>
				     </div>
    			</div>
  			</div>
		</div>
		<div class="row2">
  		<div class="col-sm-4 col-md-2" style="width:300px;">
   			<div class="thumbnail">
        		<img src="../upload/NO.png" alt="no">
				     <div class="caption">
				     	<h3>상의1</h3>
				        	<p>...</p>
				        	<p>
				        	<a href="#" class="btn btn-primary" role="button">상품보기</a> 
				        	<a href="#" class="btn btn-default" role="button">장바구니</a>
				        	</p>
				     </div>
    			</div>
  			</div>
		</div>
		<div class="row2">
  		<div class="col-sm-4 col-md-2" style="width:300px;">
   			<div class="thumbnail">
        		<img src="../upload/NO.png" alt="no">
				     <div class="caption">
				     	<h3>상의2</h3>
				        	<p>...</p>
				        	<p>
				        	<a href="#" class="btn btn-primary" role="button">상품보기</a> 
				        	<a href="#" class="btn btn-default" role="button">장바구니</a>
				        	</p>
				     </div>
    			</div>
  			</div>
		</div>
	</div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

</body>
</html>