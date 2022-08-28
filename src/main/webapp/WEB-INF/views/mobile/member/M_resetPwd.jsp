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
	<script src="/script/mobile/mobilemember.js"></script>	
</head>
<body>

  	<form method="post" name="frm" action="MresetPwd" id="resetpwd_box">
  	<h2 align="center">비밀번호 재설정</h2>
    	<input type="hidden" name="id" value="${id}">
    	<table>
      		<tr>
        		<td id="resetpwd_pass" class="reset_opt">
          			<h3>비밀번호</h3>
          			<input type="password" name="pwd" class="m_resetpwd" style="margin-top:7px;">
        		</td>
      		</tr>
      		<tr>
        		<td class="reset_opt">
          			<h3>비밀번호 확인</h3>
          			<input type="password" name="pwd_chk" class="m_resetpwd" style="margin-top:7px;">
        		</td>
      		</tr>
      		<tr>
        		<td align="center">
          			<input type="submit" value="비밀번호 재설정" style="width:150px; height:35px;"><br>
        		${message}
        		</td>
      		</tr>
    	</table>
  	</form>
</body>
</html>