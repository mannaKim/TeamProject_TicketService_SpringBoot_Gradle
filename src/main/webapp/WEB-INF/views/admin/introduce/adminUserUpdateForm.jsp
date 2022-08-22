<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="admin/admin.js"></script>
<link href="admin/admin.css" rel="stylesheet">
</head>
<body>
<h2 align="center">정보 수정</h2>
  	<form method="post" name="frm" action="pointUpdate" id="userpoint_box">
    	<table>
      		<tr>
        		<td id="findid_name" class="userpoint_id">
          			<h3>아이디 : ${member.ID}</h3>
          			<input type="hidden" name="id" value="${member.ID}">
        		</td>
      		</tr>
      		<tr>
      			<td class="userpoint_id">
          			<h3>이름 : ${member.NAME}</h3>
          			<input type="hidden" name="name" value="${member.NAME}">
        		</td>
      		</tr>
      		<tr>
      			<td class="userpoint_id">
          			<h3>전화번호 : ${member.PHONE}</h3>
          			<input type="hidden" name="phone" value="${member.PHONE}">
        		</td>
      		</tr>
      		<tr>
      			<td class="userpoint_id">
          			<h3>이메일 : ${member.EMAIL}</h3>
          			<input type="hidden" name="email" value="${member.EMAIL}">
        		</td>
      		</tr>
      		<tr>
      			<td class="userpoint_id">
          			<h3>가입일 : <fmt:formatDate value="${member.INDATE}" pattern="yy/MM/dd (E)"></fmt:formatDate></h3>
        		</td>
      		</tr>
      		<tr>
      			<td class="userpoint_id">
          			<h3>포인트 : <fmt:formatNumber value="${member.MPOINT}" type="number"></fmt:formatNumber></h3>
          			<input type="text" name="mpoint" value="${member.MPOINT}" style="width:380px; height:35px; font-size:18px; margin-top:7px;">
        		</td>
      		</tr>
      		<tr>
        		<td align="center">
          			<h3><input type="submit" value="수정하기" style="width:150px; height:35px;"></h3>
        		</td>
      		</tr>
    	</table>
	</form>
</body>
</html>