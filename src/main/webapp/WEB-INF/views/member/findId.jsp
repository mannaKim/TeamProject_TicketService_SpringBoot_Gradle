<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Login</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name='viewport' content='width=device-width, initial-scale=1'>
	<link href="/css/member.css" rel="stylesheet">
	<script src="/script/member.js"></script>	
</head>
<body>
<h2 align="center">아이디 찾기</h2>
  	<form method="post" name="frm" action="findId" id="findid_box">
    	<table>
      		<tr>
        		<td id="findid_name" class="find_id">
          			<h3>이름</h3>
          			<input type="text" name="name" value="${name}" style="width:380px; height:35px; font-size:18px; margin-top:7px;">
        		</td>
      		</tr>
      		<tr>
      			<td class="find_id">
          			<h3>전화번호</h3>
          			<input type="text" name="phone" value="${phone}" style="width:380px; height:35px; font-size:18px; margin-top:7px;">
        		</td>
      		</tr>
      		<tr>
        		<td align="center">
          			<h3><input type="submit" value="아이디 찾기" style="width:150px; height:35px;"></h3>
          			${message}
        		</td>
      		</tr>
    	</table>
	</form>
</body>
</html>