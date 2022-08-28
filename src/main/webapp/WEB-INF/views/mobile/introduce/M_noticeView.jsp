<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<article class="introatc">
    <form id="noticeView">
    	<table>
	    	<tr>
	    		<td class="m_noticeView1">${noticeView.title}</td>
	    	</tr>
	    	<tr>
	    		<td class="m_noticeView2">작성일 : <fmt:formatDate value="${noticeView.indate}" pattern="YYYY/MM/dd EEEE"></fmt:formatDate></td>	
	    	</tr>
	    	<tr>
	    		<td class="m_noticeView3">${noticeView.content}</td>
	    	</tr>
    	</table><br><br>
    	<div id="intro_buttons">
    	<input type="button" class="submit" value="목록으로" onClick="location.href='Mnotice'">
    	</div>
    </form>
    </article>

<%@ include file="../include/footer.jsp"%>