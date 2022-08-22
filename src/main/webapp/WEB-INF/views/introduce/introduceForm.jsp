<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<article class="introatc">
	<form id="introForm">
	<table id="intro">
			<tr>
				<th width="1200" height="75" colspan="2">${introduce.title}</th>
			</tr>
			<tr>
				<th width="1200" height="45" style="text-align:left; font-size:16px;">작성자 : ${introduce.id}</th>
			</tr>
			<tr>
				<th width="1200" height="45" style="text-align:left; font-size:16px;">작성일 : <fmt:formatDate value="${introduce.indate}" pattern="YYYY/MM/dd EEEE"></fmt:formatDate></th>
			</tr>
			<tr>
				<th colspan="3" align="center"><img src="/ticket_image/intro.png" style="width:900px; height:500px" /></th>
			</tr>
	</table><br><br>
	<div id="intro_buttons">
		<input type="button" value="돌아가기" class="submit" onClick="location.href='/'">
	</div>
	</form>
</article>
    
<%@ include file="../include/footer.jsp"%>