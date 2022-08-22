<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<h1>ID 중복확인</h1>
  	<form method="post" name="idCheckForm" action="idCheckForm" id="idcheck_box">
    	<div id="idcheck_join" class="id_box">
	    	<h3>아이디</h3>
	    	<input type="text" name="id" value="${id}" style="width:310px; height:35px; font-size:18px;"><input type="submit" value="검색" class="idc_btn" style="margin-left:10px;">
    	</div>
    	<br><br>
    	<div id="idcheck_msg" class="id_box">
	     	 <c:if test="${result==1}">
	        	<script type="text/javascript">opener.document.joinFrm.id.value="";</script>
	       	 	<span style="font-size:18px;">${id}는 이미 사용중인 ID입니다.</span>
	      	</c:if>
	      	<c:if test="${result==-1}">
	      		<span style="font-size:18px;">${id}는 사용 가능한 ID입니다.</span>
	        	<input type="button" value="사용" class="idc_btn" onClick="useId('${id}');">
	      	</c:if>
		</div>
  </form>
</body>
</html>