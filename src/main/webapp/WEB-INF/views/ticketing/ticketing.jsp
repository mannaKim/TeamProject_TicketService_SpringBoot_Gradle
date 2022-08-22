<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<article class="article">


<form name="cartlist" action="ticketCartList">
<br><br><br><br>
<div id="ticketingCart">

	<div id="ticketingCartheader">
		<div id="t_top" style="font-weight:bold; background-color: #90a1b0;" align="center">
			<font color="#a6a6a6">step1</font><br><font color="white">티켓선택</font></div>
		<div id="t_top" style="font-weight:bold; background-color: #5b5b5b;" align="center">
			<font color="#a6a6a6">step2</font><br><font color="white">할인/결제</font></div>
		<div id="t_top" style="font-weight:bold; background-color: white;" align="center">
			<font color="skyblue">step3</font><br>예매 확인<br>▶▷▶▷</div>
	</div>
	<div id="ticketingCartbody">
		<div id="t_main">
			<div id="t_title">${tpvo.NAME}</div>
			<div id="t_menu">
				<div id="t_menu1">예매내역</div>
				<table>
					<tr><th>${choisDay}<input type="hidden" name="choisDay" value="${choisDay}"></th></tr>
					<tr><td>일　반</td><td>${tpvo.PRICE1} 원</td></tr>
					<tr><td></td><td>${select1} 매</td></tr>
					<tr><td>어린이</td><td>${tpvo.PRICE2} 원</td></tr>
					<tr><td></td><td>${select2} 매</td></tr>
				</table>
			</div>
			<div id="t_bottom">
			<table>
			<tr><th width="180">내용</th><th width="180">취소수수료</th><th width="192">비고</th></tr>
			<tr><td>예매 후 7일 이내</td><td>없음</td><td rowspan="5">
			- 취소 시 예매수수료는 예매 당일 밤 12시 이전까지만 환불됩니다.
			- 예매 후 7일 이내라도 취소시점이 관람일로부터 10일 이내라면 그에 해당하는 취소수수료가 부과됩니다.
			- 관람 당일 취소 가능 상품의 경우 관람 당일 취소 시 티켓금액의 90%가 취소수수수료로 부과됩니다.</td>
			<tr><td>예매 후 8일 ~ 관람일 10일 전까지</td><td>뮤지컬, 콘서트, 클래식 등: 장당 4,000원 / 연극, 전시 등: 장당 2,000원(단, 티켓 금액의 10% 이내)</td></tr>
			<tr><td>관람일 9일 전 ~ 관람일 7일 전까지</td><td>티켓금액의 10%</td></tr>
			<tr><td>관람일 6일 전 ~ 관람일 3일 전까지</td><td>티켓금액의 20%</td></tr>
			<tr><td>관람일 2일 전 ~ 관람일 1일 전까지</td><td>티켓금액의 30%</td></tr>
			</table>
			</div>
		</div>
		<div id="t_menubox">
			<div id="t_menumini_box">
			<div id="t_img"><img src="/ticket_image/${tpvo.IMAGE}" height="240" style="margin-top: 12px;"/></div>
			<div id="t_menuboxx">
				<table class="t_tablemenubox">
					<tr><th colspan="2">선택된 내용</th></tr>
					<tr><th>날　짜</th><td>${choisDay}</td></tr>
					<tr><th>공연시간</th><td>${tpvo.SHOWTIME}</td></tr>
					<tr><th>시작시간</th><td>${tpvo.DAYTIME}</td></tr>
					<tr><th>일　반</th><td>${quantity1} 매</td></tr>
					<tr><th>어린이</th><td>${quantity2} 매</td></tr>
				</table>
			</div>
			<div id="t_menuboxx1">
				<table class="t_tablemenubox">
				<tr><th colspan="3">결제내역</th></tr>
				<tr><th>일　반</th><td colspan="2">${totalPrice1} 원</td></tr>
				<tr><th>어린이</th><td colspan="2">${totalPrice2} 원</td></tr>
				<tr><th>할인금액</th>
					<td>
					<c:choose>				
						<c:when test="${selectevent == 0}"><td>${selectevent} 원</td></c:when>
						<c:when test="${selectevent > 0}"><td>- ${selectevent} 원</td></c:when>
					</c:choose>
					</td>
				</tr>
			</table>
			</div>
			</div>
			<div id="t_menuboxx2"><table class="t_tablemenubox"><tr><th>최종 결제금액</th><td>${setotal} 원</td></tr></table></div>
			<div id="t_button">
				<input type="submit" value="완료" id="btn_ticket">
				<input type="hidden" name="tpseq" value="${tpvo.TPSEQ}">
			</div>
		</div>
	</div>	
</div>
<br><br><br><br>
</form>
</article>

<%@ include file="../include/footer.jsp" %>