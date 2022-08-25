<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sub/mypage_sub_menu.jsp"%>
<article>
	<div class="goodsBox">
		<br><br>
		<div class="goodsCart">
		<h1>주문 상세</h1>
		<input type="button" value="목록으로" class="goodsButton3"
				onClick="location.href='allGoodsOrderList'">
			<table>
				<tr>
					<th colspan="2">상품명</th>
					<th>수량</th>
					<th>가격</th>
					<th>처리상태</th>
				</tr>
				<c:forEach items="${goodsOrderList}" var="govo">
					<tr>
						<td width="300px">
							<a href="goodsDetail?gseq=${govo.GSEQ}">
								<img src="/goods_images/${govo.IMAGE}">
							</a>
						</td>
						<td>
							<a href="goodsDetail?gseq=${govo.GSEQ}">${govo.GNAME}</a>
						</td>
						<td>${govo.QUANTITY}</td>
						<td>
							<fmt:formatNumber value="${govo.PRICE*govo.QUANTITY}" type="currency" />
						</td>
						<td>
							<c:if test="${govo.RESULT=='1'}">배송 준비중</c:if> 
							<c:if test="${govo.RESULT=='0'}">배송 완료</c:if>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<h1>배송지 정보</h1>
		<div class="goodsCart">
			<table>
				<tr>
					<th>수령인</th>
					<th>휴대폰</th>
					<th>주소지</th>
				</tr>
				<tr>
					<td>${goodsOrderDetail.NAME}</td>
					<td>${goodsOrderDetail.PHONE}</td>
					<td>
						[${goodsOrderDetail.ZIP_NUM}]&nbsp;
						${goodsOrderDetail.ADDRESS1}&nbsp;
						${goodsOrderDetail.ADDRESS2}&nbsp;
						${goodsOrderDetail.ADDRESS3}
					</td>
				</tr>
			</table>
		</div>
		<h1>결제 정보</h1>
		<div class="goodsCart">
			<table>
				<tr>
					<th>총 결제 금액</th>
					<th>결제 수단</th>
				</tr>
				<tr>
					<td><fmt:formatNumber value="${goodsOrderDetail.TOTALPRICE2}" type="currency" /></td>
					<td>${payment}</td>
				</tr>
			</table>
		</div>
	</div>
	<br><br>
</article>
<%@ include file="../include/footer.jsp"%>