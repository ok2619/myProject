<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품등록</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="col-md-12">
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
                <label for="stock">개수</label>
                <input type="text" class="form-control" name="stock" id="stock" placeholder="개수" style="width:100px">
            </div>
            <div class="form-group">
                <label for="content">내용</label>
                <textarea class="form-control" name="content" id="content" placeholder="내용을 입력하세요"></textarea>
            </div> 
            <div class="form-group">
				  <input type="file" class="form-control" name="filename" id="filename" accept="image/gif,image/png,image/jpeg">
			</div>
			
            <input type="submit" value="등록">
        </form>
        
    </div>
</div>
</body>
</html>