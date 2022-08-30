<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<article class="article">
<form method="post" name="cartlist" action="m_ticketing">

<br><br><br><br>
<div id="m_ticketingCart">

	<div id="m_ticketingCartheader">
		<div id="m_t_top" style="font-weight:bold; background-color: #90a1b0;" align="center">
			<font color="#a6a6a6">step1</font><br><font color="white">티켓선택</font></div>
		<div id="m_t_top" style="font-weight:bold; background-color: white; " align="center">
			<font color="skyblue">step2</font><br>할인/결제<br>▶▷▶▷</div>
		<div id="m_t_top" style="font-weight:bold; background-color: #74818d;" align="center">
			<font color="#a6a6a6">step3</font><br><font color="white">예매 확인</font></div>
	</div>
	<div id="m_ticketingCartbody">
		<div id="t_main">
			<div id="m_t_title" align="center">${tpvo.NAME}</div>
			<div id="t_img" align="center">
				<img src="/ticket_image/${tpvo.IMAGE}" width="300" style="margin-top: 12px;"/></div>
			<div id="m_t_menu" align="center">
				<div id="t_menu1" style="background-color: #9B9B9B">티켓 선택</div>
				<table>
					<tr><th>${choisDay}<input type="hidden" name="choisDay" value="${choisDay}"></th></tr>
					<tr>
					<!-- PRICE3 금액이 설정되어있는지를 검수하는 코드 -->
					<c:choose>
						<c:when test="${tpvo.PRICE3 == 0}"> 
							<th>할인쿠폰이 없습니다. </th>
						</c:when>
						<c:when test="${tpvo.PRICE3 > 0}">
							<th>예매가 할인</th><td>${tpvo.PRICE3} 원 </td>
						</c:when>
					</c:choose>
					</tr>
					<tr>
					<c:choose>
						<c:when test="${tpvo.PRICE3 == 0}"> 
							<td></td><input type="hidden" name="selectevent" value="0">
						</c:when>
						<c:when test="${tpvo.PRICE3 > 0}">
							<td></td>
							<td>
							<!-- PRICE3 금액이 있다면 설정된 값에 맞춰 onchange 를사용해 값이 바로 적용될수있도록 코딩 -->
							<select id="select" name="selectevent" onchange="quantity(${totalPrice3},${tpvo.PRICE3})">
								<option value="0">0</option>
								<option value="${tpvo.PRICE3 * selecttotal}">${selecttotal}</option>
							</select> 매</td>
						</c:when>
					</c:choose>
					</tr>
				</table>
			<div id="m_t_step3font">※ 주의사항) 할인은 자동선택 되지 않으니, 적용 받고자 하는 할인이 있는 경우 직접 선택해주시기 바랍니다.</div>
			</div>
			<div id="m_t_menubox" align="center">
			<div id="m_t_point">
				<div id="t_ticket_point">
					<c:choose>
						<c:when test="${tpvo.PRICE3 == null}">
					&nbsp;사용가능한 포인트 : ${userPoint.MPOINT} p<br>
									<div style="display: inline;">
										&nbsp;<input type="number" name="use_pnt" id="use_pnt" value="0"
											min="0" max="${totalPrice3}"
											onchange="ticket_changePoint_PRICE3_null('${totalPrice3}','${userPoint.MPOINT}',1000,100)">
									</div> p  
					&nbsp;<input type="checkbox" id="chk_point"
										onclick="ticket_chkPoint_PRICE3_null('${totalPrice3}','${userPoint.MPOINT}',1000,100)"> 전부 사용 (100p단위) <br> 
					&nbsp;( 남은포인트 : <div name="left_pnt" id="left_pnt"
										style="display: inline;">${userPoint.MPOINT}</div>p )<br>
									&nbsp;<font style="color: gray;">최소 적립금 1000원 이상일 때 사용 가능합니다.</font>
									<br>
								</c:when>
								<c:when test="${tpvo.PRICE3 > 0}">
					&nbsp;사용가능한 포인트 : ${userPoint.MPOINT}p<br>
									<div style="display: inline;">
										&nbsp;<input type="number" name="use_pnt" id="use_pnt" value="0"
											min="0" max="${totalPrice3}"
											onchange="ticket_changePoint('${totalPrice3}','${userPoint.MPOINT}',1000,100)">
									</div> p 
					&nbsp;<input type="checkbox" id="chk_point"
										onclick="ticket_chkPoint('${totalPrice3}','${userPoint.MPOINT}',1000,100)"> 전부 사용 (100p단위) <br> 
					&nbsp;( 남은포인트 : <div name="left_pnt" id="left_pnt"
										style="display: inline;">${userPoint.MPOINT}</div>p )<br>
									&nbsp;<font style="color: gray;">최소 적립금 1000원 이상일 때 사용 가능합니다.</font>
									<br>
								</c:when>
							</c:choose>
						</div>
					</div><br>
			
				<div id="m_t_menuboxx">
					<table class="m_t_tablemenubox">
						<tr><th colspan="2" style="background-color: #4d6375">선택된 내용</th></tr>
						<tr><th>날　짜</th><td>${choisDay}</td></tr>
						<tr><th>공연시간</th><td>${tpvo.SHOWTIME}</td></tr>
						<tr><th>시작시간</th><td>${tpvo.DAYTIME}</td></tr>
						<tr><th>일　반</th><td>${quantity1} 매
						<input type="hidden" name="quantity1" value="${quantity1}"></td></tr>
						<tr><th>어린이</th><td>${quantity2} 매
						<input type="hidden" name="quantity2" value="${quantity2}"></td></tr>
					</table>
				</div>
				<div id="m_t_menuboxx">
					<table class="m_t_tablemenubox" id="t_tablemenubox_select1">
						<tr><th colspan="2" style="background-color: #4d6375">결제내역</th></tr>
						<tr><th>일　반</th><td>${totalPrice1} 원</td></tr>
						<tr><th >어린이</th><td>${totalPrice2} 원</td></tr>
						<tr><th>할인금액</th>
							<c:choose>				
							<c:when test="${totalPrice3 == totalPrice4}"> 
							<td>${tpvo.PRICE3} 원</td></c:when>
							<c:when test="${totalPrice3 > totalPrice4}">
							<!-- onchange 값이 적용되는 div 박스 생성. 값이 변경되면 div 박스에 설정된 id="view" 값도 자동으로 변경됨. -->
							<td><div id="view" style="display:inline;">0</div> 원</td></c:when>	
							</c:choose>	
							</tr>
						<tr><th>사용된 포인트</th><td><div id="view_point" style="display:inline;">0</div> p&nbsp;</td></tr>
					</table>
				</div>
				<div id="m_t_menuboxx">
					<table class="m_t_tablemenubox">
						<tr><th style="background-color: #4d6375" width="50%">최종 결제금액</th>
						<c:choose>
							<c:when test="${totalPrice3 == totalPrice4}"><td>${totalPrice3} 원</td></c:when>
							<c:when test="${totalPrice3 > totalPrice4}">
								<!-- onchange 값이 적용되는 div 박스 생성. 값이 변경되면 div 박스에 설정된 id="view2" 값도 자동으로 변경됨. -->
								<td>
									<div id="result_pnt" style="display: inline;">${totalPrice3}</div> 원</td>
							</c:when>
						</c:choose>
						</tr>
						<tr><th>적립 예정 포인트</th>
						<td><div id="result_point" style="display:inline;">
						<fmt:formatNumber type="number" maxFractionDigits="0"  value="${Mpoint}" />0</div> p&nbsp;</td></tr>
					</table>
				</div>
			</div>
		</div>
		<div id="m_t_bottom" align="center">
		<table>
			<tr><th>유의사항</th></tr><tr><td>
				- 안내되어 있는 잔여석은 결제 진행 중인 좌석을 포함하고 있어 예매 가능 좌석과 다를 수 있습니다.<br>
				- 할인은 자동선택 되지 않으니, 적용 받고자 하는 할인이 있는 경우 직접 선택해주시기 바랍니다.<br>
				- 장애인, 국가유공자, 학생 할인 등 증빙서류가 필요한 경우 현장수령만 가능하며, 현장에서 증빙서류 미지참 시 차액 지불하셔야 합니다.<br>
				- 관람 당일 공연 예매 시에는 변경/취소/환불이 불가합니다.<br>
				- 경우에 따라 ATM 기기에서 가상계좌 입금이 안 될 수 있으니 가급적 인터넷/폰뱅킹 등을 이용해주시기 바랍니다.<br>
				- 예매 취소 시 예매수수료는 예매 당일 밤 12시 이전까지 환불되며, 그 이후 기간에는 환불되지 않습니다.<br>
				- 예매 취소 시점에 따라 취소수수료가 부과될 수 있습니다. 예매 후 취소마감시간과 함께 취소수수료를 꼭 확인해주시기 바랍니다.<br>
			</td></tr>
		</table>
		</div>
	</div>
	<div id="m_t_button" align="center">
		<input type="button" value="이전단계" id="btn_ticket1" onClick="history.go(-1);">
		<input type="submit" value="결제하기" id="btn_ticket1" >
		<input type="hidden" name="tpseq" value="${tpvo.TPSEQ}">
		<input type="hidden" name="totalPrice_cc" value="${totalPrice3}">
	</div>
</div>
<br><br><br><br>
</form>
</article>

<%@ include file="../include/footer.jsp" %>