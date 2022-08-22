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
	<script src="/script/intro.js"></script>	
</head>
<body>
<h2 align="center">댓글 수정</h2>
  	<form method="post" name="frm" action="updRep" id="resetpwd_box">
    	<input type="hidden" name="replynum" value="${reply.replynum}">
    	<input type="hidden" name="evnum" value="${reply.evnum}">
    	<table>
      		<tr>
        		<td id="resetpwd_pass" class="reset_opt">
          			<h3>내용</h3>
          			<input type="text" name="content" style="width:380px; height:35px; font-size:18px; margin-top:7px;" value="${reply.content}">
        		</td>
        	</tr>
        	<tr>
        		<td>
        			<input type="text" name="updaterate" value="${reply.rate}" readonly style="width:380px; height:35px; font-size:18px; margin-top:7px;">
        		</td>
        	</tr>
        	<tr>
        		<td>
					<select name="rate" style="width:380px; height:35px; font-size:18px; margin-top:7px;">
					    <option value="0">평점선택</option>
					    <option value="1">★</option>
					    <option value="2">★★</option>
					    <option value="3">★★★</option>
					    <option value="4">★★★★</option>
					    <option value="5">★★★★★</option>
					</select>
				</td>
      		</tr>
      		<tr>
        		<td align="center">
          			<input type="submit" value="수정 완료" style="width:150px; height:35px;"><br>
        		${message}
        		</td>
      		</tr>
    	</table>
  	</form>
</body>
</html>