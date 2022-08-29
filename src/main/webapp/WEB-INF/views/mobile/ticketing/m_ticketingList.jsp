<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<article class="article">
<form name="formm" method="post">
<div id="m_t_listBox">
<br><br><br>
<h2>진행중인 프로그램</h2><hr>
<c:forEach items="${ticketList}" var="tpvo">
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate pattern="yyyy/MM/dd" value="${now}" var="today"/><!-- 오늘날짜 -->	
<fmt:parseDate var="sdate" value="${tpvo.SDATE}" pattern="yyyy-MM-dd HH:mm:ss"/>
<fmt:parseDate var="edate" value="${tpvo.EDATE}" pattern="yyyy-MM-dd HH:mm:ss"/>
<fmt:formatDate	pattern="yyyy/MM/dd" value="${sdate}" var="stdate" />
<fmt:formatDate	pattern="yyyy/MM/dd" value="${edate}" var="enddate" />

<table id="m_t_list">
	<tr>
		<th >
			<img src="ticket_image/${tpvo.IMAGE}" width="180">
		</th>
	</tr>
	<tr>
		<td>
			<table>
				<tr>
					<td colspan="2">
					<c:choose>
						<c:when test="${ today < enddate }">
							<c:choose>
								<c:when test="${ today <= stdate }">
									<font color="gray">● ${tpvo.NAME} (준비중)</font>
								</c:when>
								<c:otherwise>
									<a href="m_ticketshow?tpseq=${tpvo.TPSEQ}" style="font-weight:bold;">
							● ${tpvo.NAME}</a>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise >
							<c:if test="${ today >= enddate }">
								<font color="gray">● ${tpvo.NAME} (행사종료)</font>
							</c:if>
						</c:otherwise>
					</c:choose>
					</td>
					
				</tr>
				<tr>
					<td id="m_t_line"> 일정</td>
					<td>
						<fmt:formatDate pattern="yyyy/MM/dd" value="${sdate}" type="date" /> ~ 
						<fmt:formatDate	pattern="yyyy/MM/dd" value="${edate}" type="date" />
					</td>
				</tr>
				<tr>
					<td id="m_t_line"> 장소</td>
					<td>${tpvo.PLACE}</td>
				</tr>
				<tr>
					<td id="m_t_line"> 공연정보</td>
					<td>공연시간 : ${tpvo.SHOWTIME}<br>
						시작시간 : ${tpvo.DAYTIME}</td>
				</tr>
				<tr>
					<td id="m_t_line"> 가격</td>
					<td>일　반 : ${tpvo.PRICE1} 원<br>
						어린이 : ${tpvo.PRICE2} 원</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
					<c:choose>
						<c:when test="${ today < enddate }">
							<c:choose>
								<c:when test="${ today <= stdate }">
									<a class="startbtnCancel">예매준비중</a>
								</c:when>
								<c:otherwise>
									<a href="m_ticketshow?tpseq=${tpvo.TPSEQ}"
										class="btnCancel">상세정보</a>
									<a href="m_ticketingForm?tpseq=${tpvo.TPSEQ}"
										class="btnCancel">예매하기</a>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise >
							<c:if test="${ today >= enddate }">
								<a class="endbtnCancel">종료</a>
							</c:if>
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

</c:forEach>
</div>

<div class="clear"></div>
<br><br><br><br>


</form>
</article>

<%@ include file="../include/footer.jsp" %>