<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<article class="introatc">
    <form id="noticeView">
    	<table>
    	<tr>
    		<th colspan="4" width="1200" height="75">${noticeView.title}</th>
    	</tr>
    	<tr>
    		<th height="50" colspan="4" style="text-align:left; font-size:16px;">작성자 : ${noticeView.id}</th>
    	</tr>
    	<tr>
    		<th height="50" style="text-align:left; font-size:16px;">작성일 : <fmt:formatDate value="${noticeView.indate}" pattern="YYYY/MM/dd EEEE"></fmt:formatDate></th>	
    		<th width="100">조회수 : ${noticeView.readcount}</th>
    	</tr>
    	<tr>
    		<th colspan="4" height="300">${noticeView.content}</th>
    	</tr>
    	</table><br><br>
    	<div id="intro_buttons">
    	<input type="button" class="submit" value="목록으로" onClick="location.href='notice'">
    	</div>
    </form>
    </article>

<%@ include file="../include/footer.jsp"%>