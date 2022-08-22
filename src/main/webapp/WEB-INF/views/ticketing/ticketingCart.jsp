<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<article class="article">

<form method="post" name="cartlist" action="ticketingCart">
<br><br><br><br>
<div id="ticketingCart">
	<div id="ticketingCartheader">
		<div id="t_top" style="font-weight:bold; background-color: white;" align="center">
			<font color="skyblue">step1</font><br>티켓선택<br>▶▷▶▷</div>
		<div id="t_top" style="font-weight:bold; background-color: #5b5b5b;" align="center">
			<font color="#a6a6a6">step2</font><br><font color="white">할인/결제</font></div>
		<div id="t_top" style="font-weight:bold; background-color: #74818d;" align="center">
			<font color="#a6a6a6">step3</font><br><font color="white">예매 확인</font></div>
	</div>
	<div id="ticketingCartbody">
		<div id="t_main">
			<div id="t_title">${tpvo.NAME}</div>
			<div id="t_menu">
				<div id="t_menu1">티켓 선택</div>
				<table>
					<tr><th>${choisDay}<input type="hidden" name="choisDay" value="${choisDay}"></th></tr>
					<tr><th>일　반</th><td>${tpvo.PRICE1} 원</td></tr>
					<!-- select 문안에 넣을 티켓 수량 선택 코드 -->
					<tr><td></td><td><select id="select" name="quantity1">
						<option>0</option><option>1</option><option>2</option><option>3</option><option>4</option>
						<option>5</option><option>6</option><option>7</option><option>8</option><option>9</option><option>10</option>
					</select> 매</td></tr>
					<tr><th>어린이</th><td>${tpvo.PRICE2} 원</td></tr>
					<tr><td></td><td><select id="select" name="quantity2">
						<option>0</option><option>1</option><option>2</option><option>3</option><option>4</option>
						<option>5</option><option>6</option><option>7</option><option>8</option><option>9</option><option>10</option>
					</select> 매</td></tr>
				</table>
			</div>
			<div id="t_bottom">
			<table><tr><th>유의사항</th></tr><tr><td>
				- 안내되어 있는 잔여석은 결제 진행 중인 좌석을 포함하고 있어 예매 가능 좌석과 다를 수 있습니다.<br>
				- 할인은 자동선택 되지 않으니, 적용 받고자 하는 할인이 있는 경우 직접 선택해주시기 바랍니다.<br>
				- 장애인, 국가유공자, 학생 할인 등 증빙서류가 필요한 경우 현장수령만 가능하며, 현장에서 증빙서류 미지참 시 차액 지불하셔야 합니다.<br>
				- 관람 당일 공연 예매 시에는 변경/취소/환불이 불가합니다.<br>
				- 경우에 따라 ATM 기기에서 가상계좌 입금이 안 될 수 있으니 가급적 인터넷/폰뱅킹 등을 이용해주시기 바랍니다.<br>
				- 예매 취소 시 예매수수료는 예매 당일 밤 12시 이전까지 환불되며, 그 이후 기간에는 환불되지 않습니다.<br>
				- 예매 취소 시점에 따라 취소수수료가 부과될 수 있습니다. 예매 후 취소마감시간과 함께 취소수수료를 꼭 확인해주시기 바랍니다.<br>
			</td></tr></table>
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
					<tr><th>일　반</th><td>0 매</td></tr>
					<tr><th>어린이</th><td>0 매</td></tr>
				</table>
			</div>
			<div id="t_menuboxx1">
				<table class="t_tablemenubox">
				<tr><th colspan="2">결제내역</th></tr>
				<tr><th>일　반</th><td>0 원</td></tr>
				<tr><th >어린이</th><td>0 원</td></tr>
				<tr><th>할인금액</th><td>0 원</td></tr>
			</table>
			</div>
			</div>
			<div id="t_menuboxx2"><table class="t_tablemenubox"><tr><th>최종 결제금액</th><td>0 원</td></tr></table></div>
			<div id="t_button">
				<input type="button" value="다음단계" id="btn_ticket" onclick="return go_CartList()">
				<input type="hidden" name="tpseq" value="${tpvo.TPSEQ}">
			</div>
		</div>
	</div>	
</div>
<br><br><br><br>
</form>

</article>

<%@ include file="../include/footer.jsp" %>