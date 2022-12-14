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
	<div id="login_Box">
	<form method="post" name="loginFrm" action="login">
		<div id="login_logo">
			<a href="/"><img src="ticket_image/logo.png"/></a>
		</div>
		<fieldset id="login_file">
        	<input type="text" name="id" placeholder="๐ก๋ก๊ทธ์ธ" style="width:400px; height:45px; border:none; border-bottom:1px dotted silver"><br>
        	<input type="password" name="pwd" placeholder="๐๋น๋ฐ๋ฒํธ" style="width:400px; height:45px; border:none; border-bottom:1px dotted silver"><br>
        	<div>${message}</div>
        	<div id="login_buttons">
      			<input type="submit" value="Login" class="login_btn">
    		</div>
    	</fieldset>
    	<div id="login_opt">
	    	<ul>
	    		<li><a href="#" onClick="findAccount('id');">์์ด๋ ์ฐพ๊ธฐ</a></li>
	    		<li><a href="#" onClick="findAccount('pwd');">๋น๋ฐ๋ฒํธ ์ฐพ๊ธฐ</a></li>
	    		<li><a href="termsAndConditions">ํ์๊ฐ์</a></li>
	    	</ul>
	    </div>
	</form>
</div>
</body>
</html>