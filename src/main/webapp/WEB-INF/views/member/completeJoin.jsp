<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<article id="comjoin_box">
	<div id="comjoin_top">
			<div id="comjoin_logo">
				<a href="/"><img src="ticket_image/logo.png"></a>
			</div>
			<div id="comjoin_icon">
				<ul>
					<li>1. 약관동의</li>
					<li>2. 정보입력</li>
					<li>3. 가입완료</li>
				</ul>
			</div>
	</div>
	<div id="comjoin_box">
		<c:choose>
			<c:when test="${suc!=0}">
				<h2 align="center">회원가입이 완료되었습니다.</h2>
				<div class="comjoin_btn">
					<input type="button" value="메인으로" onClick="location.href='/'" style="width:140px; height:30px;">
					<input type="button" value="로그인" onClick="location.href='loginForm'" style="width:140px; height:30px;">
				</div>
			</c:when>
			<c:otherwise>
				<h2 align="center">회원가입이 실패하였습니다.(관리자에게 문의하세요.)</h2>
				<div class="comjoin_btn">
					<input type="button" value="메인으로" onClick="location.href='/'" style="width:140px; height:30px;">
					<input type="button" value="회원가입" onClick="location.href='termsAndConditions'" style="width:140px; height:30px;">
				</div>
			</c:otherwise>
		</c:choose>	
	</div>
</article>
</body>
</html>