<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sub/mypage_sub_menu.jsp"%>
<article>
	<div class="goodsBox">
		<h1>주문 내역</h1>
		<div class="goodsCart">
			<table>
				<tr>
					<th colspan="2">상품명</th>
					<th>가격</th>
					<th>수량</th>
					<th>주문일</th>
					<th>진행상태</th>
				</tr>
				<c:forEach items="${goodsOrderList}" var="govo">
					<tr>
						<td width="300px">
							<a href="goodsDetail?gseq=${govo.GSEQ}">
								<img src="/goods_images/${govo.IMAGE}">
							</a>
						</td>
						<td><a href="goodsDetail?gseq=${govo.GSEQ}">
								${govo.GNAME} </a></td>
						<td><fmt:formatNumber value="${govo.PRICE*govo.QUANTITY}"
								type="currency" /></td>
						<td>${govo.QUANTITY}</td>
						<td><fmt:formatDate value="${govo.INDATE}" type="date" /></td>
						<td>처리 진행 중</td>
					</tr>
				</c:forEach>
				<tr>
					<th>결제 금액</th>
					<th><fmt:formatNumber value="${totalGoods.TOTALPRICE2}" type="currency" /></th>
					<th>결제 방법</th>
					<th>${payment}</th>
					<th colspan="2">주문 완료</th>
				</tr>
			</table>
		</div>
		<div class="goodsCartButton">
			<input type="button" value="쇼핑하러 가기" class="goodsButton1"
				onClick="location.href='goodsMain'">
		</div>
	</div>
</article>
<%@ include file="../include/footer.jsp"%>