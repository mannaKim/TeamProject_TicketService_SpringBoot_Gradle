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
  	<div id="complet_id">
	    <table>
	    	<tr>
	        	<td>
	          		<h3>조회한 회원의 아이디는 <span>[ ${memberVO.id} ]</span> 입니다.</h3>
	          		<div id="complet_btn">
		          		<input type="button" class="submit" value="로그인창으로" onClick="go_login_after_FindAccount();" style="width:130px; height:30px;">
		          		<input type="button" class="submit" value="비밀번호 찾기" 
		          		onClick="location.href='findPwdForm?id=${MemberVO.id}'" style="width:130px; height:30px;">
		          	</div>
	        	</td>
	      	</tr>
	    </table>
	  </div>
</body>
</html>