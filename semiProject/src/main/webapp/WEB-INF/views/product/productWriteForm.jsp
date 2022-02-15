<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 | 상품등록</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#write_form').submit(function(){
		if($('#product_name').val().trim()==''){
			alert('상품명을 입력하세요!');
			$('#product_name').val('').focus();
			return false;
		}
		if($('#sort').val().trim()==''){
			alert('상품종류 입력하세요!');
			$('#sort').val('').focus();
			return false;
		}
		if($('#price').val().trim()==''){
			alert('가격을 입력하세요!');
			$('#price').val('').focus();
			return false;
		}
		if($('#stock').val().trim()==''){
			alert('재고를 입력하세요!');
			$('#stock').val('').focus();
			return false;
		}
		if($('#content').val().trim()==''){
			alert('상품내용 입력하세요!');
			$('#content').val('').focus();
			return false;
		}
		if($('#image').val().trim()==''){
			alert('상품이미지 입력하세요!');
			$('#image').val('').focus();
			return false;
		}
	});
});
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="page-main">
	<h3 class="align-center common_title">상품 등록</h3>
<div class="col-md-12 go_right" style="margin-top:-50px">
    <div class="col-md-4">
        <form id="write_form" action="productWrite.do" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="product_name">상품명</label>
                <input type="text" class="form-control" name="product_name" id="product_name" placeholder="상품명을 입력하세요">
            </div>
             <div class="form-group">
                <label for="sort">상품종류</label>
                <input type="text" class="form-control" name="sort" id="sort" placeholder="상품종류를 입력하세요">
            </div>
            <div class="form-group">
            <label for="price">가격</label>
                <input type="text" class="form-control" name="price" id="price" placeholder="가격" style="width:100px">
              </div> 
              <div class="form-group">
               <label for="stock">개수</label>
                <input type="text" class="form-control" name="stock" id="stock" placeholder="개수" style="width:100px">
            </div>
            <div class="form-group">
                <label for="content">내용</label>
                <textarea class="form-control" name="content" id="content" placeholder="내용을 입력하세요"></textarea>
            </div> 
            <div class="form-group">
				  <input type="file" class="form-control" name="image" id="image" accept="image/gif,image/png,image/jpeg">
			</div>
			
			<div class="form-group"> 
						<div class="col-sm-offset-3 col-sm-9"> 
						</div> 
					</div> 
					<div class="blank_50"></div>	
					
			<!-- 버튼 -->
			<div class="align-center margin_right_10">
			<input type="submit" class="btn btn-info" value="등록">
            <input type="button" class="btn" value="목록" onclick="location.href='${pageContext.request.contextPath}/product/productList.do'">
    		</div>
			<!-- 버튼 끝-->			
             </form>
        
    </div>
</div>
</div>
</body>
</html>