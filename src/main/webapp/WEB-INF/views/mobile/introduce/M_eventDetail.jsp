<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<article class="introatc">
<form id="eventform" name="frm">
	<table>
		<tr>
			<th class="m_eventView" id="m_event_title" height="70px">${eventView.TITLE}</th>
		</tr>
		<tr>
			<th class="m_eventView" id="m_event_date" >
			<fmt:formatDate value="${eventView.INDATE}" pattern="YYYY/MM/dd EEEE"></fmt:formatDate></th>
		</tr>	
		<tr>
			<th class="m_eventView">이벤트 기간 : ${eventView.EVDATE}<br>
			~ 당첨자 발표일 : ${eventView.EVPERSON}</th>
		</tr>
		<tr>
			<th align="center" id="m_eventImg">
				<img src="ticket_image/${eventView.EIMAGE2}">
			</th>
		</tr>
	</table>
	</form><br><br>
	
	<br><br>
	<div id="intro_buttons" style="margin-bottom:40px;">
		<input type="button" class="submit" value="목록으로" onClick="location.href='Mevent'">
	</div>
	<c:set var="now" value="<%= new java.util.Date() %>"></c:set>
	<form action="MeventReply" method="post" name="frm_event" id="frm_event">
		<input type="hidden" name="evnum" value="${eventView.EVNUM}">
		<table>
			<tr>
				<td id="m_reply_rate">
					<select id="m_select" name="rate">
					    <option value="0">평점선택</option>
					    <option value="1">★</option>
					    <option value="2">★★</option>
					    <option value="3">★★★</option>
					    <option value="4">★★★★</option>
					    <option value="5">★★★★★</option>
					</select>
				</td>
			</tr>
			<tr align="center">
				<td id="m_reply_id" >
				<span style="text-align:center;">${loginUser.id}<input type="hidden" name="id" value="${loginUser.id}"></span>
				<input type="text" id="m_reply" name="content" size="25" placeholder="댓글을 입력하세요!">
				<input type="submit" class="reply_event" value="댓글작성" onClick="return Mreply_check();"></td>
			</tr>
			<c:forEach items="${ereply}" var="ereply">
			<tr>
				<td id="m_ereply_rate">
					<c:if test="${ereply.RATE==1}">
            			<font color="#E5BE43">★</font>
            		</c:if>
            		<c:if test="${ereply.RATE==2}">
           				<font color="#E5BE43">★★</font>
           		 	</c:if>
            		<c:if test="${ereply.RATE==3}">
            			<font color="#E5BE43">★★★</font>
            		</c:if>
            		<c:if test="${ereply.RATE==4}">
           				<font color="#E5BE43">★★★★</font>
            		</c:if>
            			<c:if test="${ereply.RATE==5||ereply.RATE==0}">
           			<font color="#E5BE43">★★★★★</font>
            		</c:if>
					</td>
			</tr>
				<tr align="center">
					<td id="m_ereply">
						<div id="m_rid" class="m_reply_rep">${ereply.ID}</div>|<div id="m_con" class="m_reply_rep">${ereply.CONTENT}</div>|
						<div id="m_rbtn" class="m_reply_rep"><c:if test="${ereply.ID == loginUser.id}">
							<input type="button" class="reply_bnt" value="수정" onClick="MupdateReply('Mupdate', '${ereply.REPLYNUM}');">
							<input type="button" class="reply_bnt" value="삭제" onClick="location.href='MdelRep?replynum=${ereply.REPLYNUM}&evnum=${ereply.EVNUM}'">
						</c:if>
						</div></td>	
				</tr>
			</c:forEach>
		</table>
	</form>
</article>    
    
<%@ include file="../include/footer.jsp"%>