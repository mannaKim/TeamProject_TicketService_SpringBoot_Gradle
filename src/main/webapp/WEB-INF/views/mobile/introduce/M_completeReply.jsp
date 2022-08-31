<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Login</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name='viewport' content='width=device-width, initial-scale=1'>
	<link href="/css/mobile/mobilemember.css" rel="stylesheet">
	<script src="/script/mobile/mobileintro.js"></script>	
</head>
<body>
<h2 align="center">댓글 수정 완료</h2>
  	<div id="complet_pwd">
	    <table>
	      	<tr>
	        	<td>
	          		<h3>댓글 수정이 완료되었습니다.</h3>
	          		<div id="completpwd_btn">
	          			<input type="button" value="돌아가기" onClick="go_MeventDetail('${reply.evnum}');" style="width:130px; height:30px;">
	          		</div>
	        	</td>
	      	</tr>
	    </table>
	   </div>
</body>
</html>