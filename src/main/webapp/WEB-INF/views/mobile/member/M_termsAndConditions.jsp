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
	<link href="/css/mobile/mobilemember.css" rel="stylesheet">
	<script src="/script/mobile/mobilemember.js"></script>
</head>
<body>
<div class="clear"></div>
<article id="teams_One">
	<div id="teams_top">
		<div id="teams_logo">
			<a href="/"><img src="ticket_image/logo.png"></a>
		</div>
		<div id="teams_icon">
			<ul>
				<li>1. 약관동의</li>
				<li>2. 정보입력</li>
				<li>3. 가입완료</li>
			</ul>
		</div>
	</div>
	<form name="termFrm" id="termFrm">
		<div id="teams_terms">
			<h2>
				<span>약관에 동의해주세요</span>
			</h2>
		</div>
		<div id="teams_checkBox">
			<ul>
				<li>
					<span>
						<input id="termAll" name="termAll" type="checkbox" onclick="checkAll();">
						<label>모두 동의</label>
					</span>
				</li>
				<li>
					<span>
						<input name="term_agreement" type="checkbox" onclick="checkAllList();">
						<label>이용약관 (필수)</label>
					</span>
					<a href="#" onclick="MshowTerm(1)">내용보기</a>
				</li>
				<li>
					<span class="yesChk">
						<input name="term_agreement" type="checkbox" onclick="checkAllList();">
						<label>개인정보 수집 및 이용 동의 (필수)</label>
					</span>
					<a href="#" onclick="MshowTerm(2)">내용보기</a>
				</li>
				<li>
					<span class="yesChk">
						<input name="term_agreement" type="checkbox" onclick="checkAllList();">
						<label>개인정보 수집 및 이용 동의 (선택)</label>
					</span>
					<a href="#" onclick="MshowTerm(3)">내용보기</a>
				</li>
			</ul>
		</div>
		<div class="clear"></div>
		<div id="teams_buttons">
			<input type="button" value="회원가입" class="teams_btn" onClick="go_MjoinForm();">
			<input type="button" value="돌아가기" class="teams_btn" onClick="location.href='/'">
		</div>
	</form>
</article>
</body>
</html>