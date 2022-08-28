<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<article class="introatc">
	<form id="introForm">
	<table id="intro">
			<tr>
				<th class="m_intro_title" colspan="2">${introduce.title}</th>
			</tr>
			<tr>
				<th class="m_intro_form" style="text-align:left; font-size:16px;">작성자 : ${introduce.id}</th>
			</tr>
			<tr>
				<th class="m_intro_form" style="text-align:left; font-size:16px;">작성일 : <fmt:formatDate value="${introduce.indate}" pattern="YYYY/MM/dd EEEE"></fmt:formatDate></th>
			</tr>
			<tr>
				<th class="m_intro_img" colspan="3" align="center"><img src="/ticket_image/intro.png" /></th>
			</tr>
	</table><br><br>
	<div id="intro_buttons">
		<input type="button" value="돌아가기" class="submit" onClick="location.href='/'">
	</div>
	</form>
</article>
    
<%@ include file="../include/footer.jsp"%>