<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/admin_header.jsp"%>
<article id="admin_event">
<h2 align="center">이벤트목록</h2>
	<div id="adminEvent_btn">
		<input type="button" class="adminbtn" value="이벤트등록" onClick="go_evwrt();" style="width:150px; height:35px;">
	</div>
	<table>
		<tr>
			<th width="20" height="40">No.</th>
    		<th width="200" height="40">서브이미지</th>
    		<th width="70" height="40">관리자</th>
    		<th width="170" height="40">제목</th>
    		<th width="230" height="40">이벤트기간</th>
    		<th width="100" height="40">당첨자발표일</th>
    		<th width="200" height="40">업로드날짜</th>
		</tr>
		<c:forEach items="${eventList}" var="eventVO">
    				<tr>
    					<td height="90">${eventVO.EVNUM}</td>
    					<td height="90">
    						<img src="ticket_image/${eventVO.EIMAGE}" style="width:200px; height:70px;" />
    					</td>
    					<td height="90">${eventVO.ID}</td>
    					<td height="90">
    						<a href="adminEventView?evnum=${eventVO.EVNUM}">${eventVO.TITLE}</a>
    					</td>
    					<td height="90">${eventVO.EVDATE}</td>
    					<td height="90">${eventVO.EVPERSON}</td>
    					<td height="90"><fmt:formatDate value="${eventVO.INDATE}" pattern="YYYY/MM/dd EEEE"></fmt:formatDate></td>
    				</tr>
    			</c:forEach>
	</table>
	<br>
	<!-- 여기서 부터 페이지 -->
	<div id="paging" align="center"
		style="font-size: 110%; font-weight: bold;">
		<c:url var="action" value="adminEvent" />
		<c:if test="${paging.prev}">
			<a href="${action}?page=${paging.beginPage-1}">◀</a>&nbsp;
    </c:if>
		<c:forEach begin="${paging.beginPage}" end="${paging.endPage}"
			var="index">
			<c:choose>
				<c:when test="${paging.page==index}">
					<span style="color:#3CB371">${index}&nbsp;</span>
				</c:when>
				<c:otherwise>
					<a href="${action}?page=${index}&key=${key}">${index}</a>&nbsp;
        </c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.next}">
			<a href="${action}?page=${paging.endPage+1}">▶</a>&nbsp;
    </c:if>
	</div>
</article>


<%@ include file="../../include/admin_footer.jsp"%>