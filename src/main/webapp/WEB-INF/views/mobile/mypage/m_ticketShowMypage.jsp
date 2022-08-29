<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/m_sub/m_mypage_sub_menu.jsp"%>
<article>
	<div class="goodsBox">
		<div class="goodsCart">
			<br><br>
			<h1>상세 정보</h1>	
			<input type="button" value="목록으로" class="goodsButton3"
				onClick="location.href='m_ticketCartList'">
			<table>
				<tr><th>${tpvo.NAME}</th></tr>
				<tr>
					<td>
						<img src="ticket_image/${tpvo.IMAGE}" style="height: 400px; width: 300px;">
					</td>
				</tr>
			</table>
			<table>
				<tr>
					<th>기간</th>
					<td><fmt:formatDate value="${tpvo.SDATE}" pattern="YYYY/MM/dd" /> ~
						<fmt:formatDate value="${tpvo.EDATE}" pattern="YYYY/MM/dd" /></td>
				</tr>
				<tr>
					<th>시작시간</th><td>${tpvo.DAYTIME}</td>
				</tr>
				<tr>
					<th>장소</th><td>${tpvo.PLACE}</td>
				</tr>
				<tr>
					<th>연령</th><td>${tpvo.AGE}세이상</td>
				</tr>
				<tr>
					<th>관람시간</th><td>${tpvo.SHOWTIME}</td>
				</tr>
				<tr>
					<th>금액</th><td>성인 ${tpvo.PRICE1}, 어린이 ${tpvo.PRICE2}</td>
				</tr>
				<tr>
					<th>설명</th><td colspan="5">${tpvo.CONTENT}</td>
				</tr>
			</table>
		</div>
	</div>
	<br><br>
</article>
<%@ include file="../include/footer.jsp"%>