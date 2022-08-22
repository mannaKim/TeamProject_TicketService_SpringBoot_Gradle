<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="admin/admin.js"></script>
</head>
<body>
<div id="wrap" align="center" style="width:100%">
	<form name="frm" action="evimgupload2" method="post" enctype="multipart/form-data">
		<h1>메인파일선택</h1>
		<input type="file" name="evimage2" onchange="selectedimage2();">
	</form>
</div>
</body>
</html>