<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<article class="article">

<form method="post" name="frm">
<div id="t_showBox">
	<img src="ticket_image/back1.png"style="width:100%;" >
</div>
<div id="t_showBox1">
<table id="t_showBox">
	<tr id="t_btnn1">
		<th colspan="3" id="title">${tpvo.NAME}</th>
		<td rowspan="8" id="img"><img src="ticket_image/${tpvo.IMAGE}" style="width:230px;"><br>
		
		<a href="ticketingForm?tpseq=${tpvo.TPSEQ}" class="btnCancel2">예매하기</a>
		
		</td>
	</tr>
	<tr>
		<th id="t-boxline">기간</th>
		<td colspan="2"><fmt:formatDate value="${tpvo.SDATE}" pattern="YYYY/MM/dd"/> ~ 
		<fmt:formatDate value="${tpvo.EDATE}" pattern="YYYY/MM/dd"/>
	</td>
	</tr>
	<tr>
		<th>시작시간</th>
		<td colspan="2">${tpvo.DAYTIME}</td>
	</tr>
	<tr>
		<th id="t-boxline">장소</th>
		<td colspan="2">${tpvo.PLACE}</td>
	</tr>
	<tr>
		<th>연령</th>
		<c:choose>
			<c:when test="${tpvo.AGE > 0}"> 
				<td colspan="2">만 ${tpvo.AGE} 세 이상 </td>	
			</c:when>
			<c:when test="${tpvo.AGE <= 0}">
				<td colspan="2">전체관람가</td>	
			</c:when>
		</c:choose>
	</tr>
	<tr>
		<th id="t-boxline">관람시간</th>
		<td colspan="2">${tpvo.SHOWTIME}</td>
	</tr>
	<tr>
		<th>금액</th>
		<td colspan="2">일 반 : ${tpvo.PRICE1} / 어린이 ${tpvo.PRICE2}</td>
	</tr>
	<tr>
		<th id="t-boxline">설명</th>
		<td colspan="2">${tpvo.CONTENT}</td>
	</tr>
</table>
</div>
</form>

</article>
<%@ include file="../include/footer.jsp" %>