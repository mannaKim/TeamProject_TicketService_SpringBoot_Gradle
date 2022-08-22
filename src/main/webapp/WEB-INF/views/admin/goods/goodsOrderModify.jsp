<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../admin_header.jsp"%>
<article id="admin_goods">
	<h2>주문 처리</h2>
	<br>
	<table id="goods_table">
		<tr>
			<th colspan="2">상품명</th>
			<th width="50">수량</th>
			<th width="90">가격</th>
			<th width="90">처리상태</th>
			<th width="150">처리상태 변경</th>
		</tr>
		<c:forEach items="${goodsOrderList}" var="govo">
			<tr>
				<td><a href="ticket.do?command=goodsDetail&gseq=${govo.gseq}">
						<img src="goods/goods_images/${govo.image}" width="200">
				</a></td>
				<td><a href="ticket.do?command=goodsDetail&gseq=${govo.gseq}">
						${govo.gname} </a></td>
				<td>${govo.quantity}</td>
				<td><fmt:formatNumber value="${govo.price*govo.quantity}"
						type="currency" /></td>
				<td><c:if test="${govo.result=='1'}">처리중</c:if> <c:if
						test="${govo.result=='0'}">처리완료</c:if></td>
				<td><c:choose>
						<c:when test="${govo.result=='1'}">
							<input type="button" class="adminbtn" value="처리완료로 변경"
								onClick="changeResult(${govo.oseq},${govo.odseq},'${govo.result}');" />
						</c:when>
						<c:otherwise>
							<input type="button" class="adminbtn" value="처리중으로 변경"
								onClick="changeResult(${govo.oseq},${govo.odseq},'${govo.result}')" />
						</c:otherwise>
					</c:choose></td>
			</tr>
		</c:forEach>
		<tr>
			<th colspan="4" style="border-top: 1px dotted gray;">해당 주문 처리상태 일괄 변경</th>
			<td colspan="2"><input type="button" class="adminbtn" value="전체 처리완료"
				onClick="changeResultAll(${goodsOrderList[0].oseq})" /></td>
		</tr>
	</table>
	<br>
	<br>
	<h2>배송지 정보</h2>
	<table id="goods_table">
		<tr>
			<th>수령인</th>
			<th>휴대폰</th>
			<th>주소지</th>
		</tr>
		<tr>
			<td>${goodsOrderList[0].mname}</td>
			<td>${goodsOrderList[0].phone}</td>
			<td>[${goodsOrderList[0].zip_num}]&nbsp;
				${goodsOrderList[0].address1}&nbsp; ${goodsOrderList[0].address2}</td>
		</tr>
	</table>
	<br>
	<br>
	<h2>결제 정보</h2>
	<table id="goods_table">
		<tr>
			<th>결제 금액</th>
		</tr>
		<tr>
			<td><fmt:formatNumber value="${totalPrice}" type="currency" /></td>
		</tr>
	</table>

	<div class="goods_buttonBox">

		<input type="button" class="adminbtn" value="목록으로"
			onClick="location.href='ticket.do?command=adminGoodsOrderList&page=1'">
	</div>
</article>
<%@ include file="../admin_footer.jsp"%>