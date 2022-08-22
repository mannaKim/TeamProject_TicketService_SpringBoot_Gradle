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
<h2 align="center">비밀번호 재설정 완료</h2>
  	<div id="complet_pwd">
	    <table>
	      	<tr>
	        	<td>
	          		<h3>비밀번호 재설정이 완료되었습니다.</h3>
	          		<div id="completpwd_btn">
	          			<input type="button" value="로그인 페이지로" onClick="go_login_after_FindAccount();" style="width:130px; height:30px;">
	          		</div>
	        	</td>
	      	</tr>
	    </table>
    </div>
</body>
</html>