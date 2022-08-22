<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<article class="introatc">
	<div id="eventBox">
		<h1 class="introtitle">이벤트</h1>
		<c:forEach items="${event}" var="eventVO">
			<div id="event_imgbox">
				<a href="eventDetail?evnum=${eventVO.evnum}">
					<img src="ticket_image/${eventVO.eimage}" style="width: 500px;height:185px;" />
				</a>
				<div id="event_text">
					<h2 style="margin-top: 15px;">${eventVO.title}</h2>
					<h3 style="margin-top: 15px;">이벤트 기간 : ${eventVO.evdate}</h3>
					<h3 style="margin-top: 5px;">당첨자 발표일 : ${eventVO.evperson}</h3>
				</div>
			</div>
		</c:forEach>
	</div>
</article>
<%@ include file="../include/footer.jsp"%>