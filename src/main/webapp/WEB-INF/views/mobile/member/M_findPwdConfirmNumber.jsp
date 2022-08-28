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
  	<form method="post" name="frm" action="MfindPwdStep2" id="findStep_box">
  	<h2 align="center">비밀번호 찾기</h2>
    	<table>
      		<tr>
        		<td class="findStep_opt">
          			<h3>아이디 : ${memberVO.id}</h3>
          			<input type="hidden" name="id" value="${memberVO.id}">
        		</td>
      		</tr>
      		<tr>
        		<td class="findStep_opt">
         			<h3>성명 : ${memberVO.name}</h3>
         			<input type="hidden" name="name" value="${memberVO.name}">
        		</td>
      		</tr>
      		<tr>
        		<td class="findStep_opt">
          			<h3>전화번호 : ${memberVO.phone}</h3>
          			<input type="hidden" name="phone" value="${memberVO.phone}">
        		</td>
      		</tr>
      		<tr>
        		<td id="fintStep_num">
          			<h3>인증번호</h3>
          			<input type="text" name="confirmNum" id="m_fintpwd2" style="margin-top:7px;">
          			<br>전송받은 번호를 입력하세요
          			<br>${message}<br>
          			<div id="fintStep_btn">
          				<input type="submit" value="인증번호 확인" style="width:150px; height:35px;">
          			</div>
       			</td>
      		</tr>
    	</table>
	</form>
</body>
</html>