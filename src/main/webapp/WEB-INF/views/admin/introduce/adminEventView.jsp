<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/admin_header.jsp"%>
<article id="adminEvent_View">
<form name="frm">
	<table>
		<tr>
			<td style="text-align:center;" height="50">${event.TITLE}
			<span style="float:right;"><fmt:formatDate value="${event.INDATE}" pattern="YYYY/MM/dd EEEE"></fmt:formatDate></span></td>
		</tr>
		<tr>
			<td height="50">이벤트 기간 : ${event.EVDATE}</td>
		</tr>
		<tr>
			<td height="50">당첨자 발표일 : ${event.EVPERSON}</td>
		</tr>
		<tr>
		<td colspan="5" align="center">
			<img src="ticket_image/${event.EIMAGE2}" style="width:950px; min-height:900px;">
		</td>
	</tr>
	</table>
	<br>
	<div id="adminEventView_btn">
		<input type="button" class="adminbtn" value="수정하기" onClick="EventCheck('update','${event.EVNUM}');" style="width:70px; height:30px;">
		<input type="button" class="adminbtn" value="삭제하기" onClick="EventCheck('delete','${event.EVNUM}');" style="width:70px; height:30px;">
		<input type="button" class="adminbtn" value="목록으로" onClick="location.href='adminEvent'" style="width:100px; height:30px;">
	</div>
	</form>
</article>
<%@ include file="../../include/admin_footer.jsp"%>