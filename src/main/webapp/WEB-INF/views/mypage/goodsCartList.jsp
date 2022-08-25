<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sub/mypage_sub_menu.jsp"%>
<article>
	<div class="goodsBox">
		<form name="goodsCartFrm" method="post">
			<c:choose>
				<c:when test="${empty goodsCartList}">
					<h1>장바구니</h1>
					<div class="emptyGoodsCart">
						<img src="/goods_images/sub_images/emptyCart.png">
						<h3>장바구니가 비었습니다.</h3>
					</div>
					<div class="goodsCartButton">
						<input type="button" value="쇼핑하러 가기" class="goodsButton1"
							onClick="location.href='goodsMain'">
					</div>
				</c:when>
				<c:otherwise>
					<div class="goodsCart">
						<br><br>
						<h1>장바구니</h1>
						<input type="button" value="선택상품 삭제" class="goodsButton3"
							onClick="go_Gcart_delete();">
						<table>
							<tr>
								<th colspan="2">상품명</th>
								<th>가격</th>
								<th>수량</th>
								<th>선택</th>
							</tr>
							<c:forEach items="${goodsCartList}" var="gcvo">
								<tr>
									<td width="300">
										<a href="goodsDetail?gseq=${gcvo.GSEQ}">
											<img src="/goods_images/${gcvo.IMAGE}">
										</a>
									</td>
									<td width="500">
										<a href="goodsDetail?gseq=${gcvo.GSEQ}">
											<c:choose>
												<c:when test="${gcvo.NUM_INVENTORY==0}">
													<del>[품절] ${gcvo.GNAME}</del>
													<input type="hidden" name="soldout" value="1">
												</c:when>
												<c:when test="${gcvo.NUM_INVENTORY<gcvo.QUANTITY}">
													${gcvo.GNAME}<br>
													<span style="color: red;">
														남은 재고 : ${gcvo.NUM_INVENTORY}<br>
														재고에 맞게 구매 수량을 조절하세요.
													</span>
													<input type="hidden" name="soldout" value="1">
												</c:when>
												<c:otherwise>
													${gcvo.GNAME}
													<input type="hidden" name="soldout" value="0">
												</c:otherwise>
											</c:choose>
										</a>
									</td>
									<td width="100">
										<fmt:formatNumber value="${gcvo.PRICE*gcvo.QUANTITY}" type="currency" />
									</td>
									<td>
										<button type="button" class="goodsQuantity"
											onClick="changeQuantity(-1,${gcvo.GSEQ},${gcvo.QUANTITY},${gcvo.NUM_INVENTORY});">-</button>
										<input type="text" name="quantity" size="2" value="${gcvo.QUANTITY}" readonly>
										<button type="button" class="goodsQuantity"
											onClick="changeQuantity(1,${gcvo.GSEQ},${gcvo.QUANTITY},${gcvo.NUM_INVENTORY});">+</button>
									</td>
									<td>
										<input type="checkbox" name="gcseq" value="${gcvo.GCSEQ}" checked>
									</td>
								</tr>
							</c:forEach>
							<tr>
								<th colspan="3">결제 금액</th>
								<th colspan="2">
									<fmt:formatNumber value="${totalPrice}" type="currency" />
									<input type="hidden" name="totalPrice1" value="${totalPrice}" onKeyup="cal()"><br>
								</th>
							</tr>
							<tr>
								<th colspan="3">적립금 사용(보유 적립금) : ${userPoint.MPOINT}</th>
								<th colspan="2">
									<input type="text" name="dpoint" placeholder="0" onKeyup="cal();">
									<input type="button" value="사용" onClick="pointCheck('${userPoint.MPOINT}');">
								</th>
							</tr>
							<tr>
								<th colspan="3">결제 금액</th>
								<th colspan="2">
									<input type="text" name="totalPrice2">
								</th>
							</tr>
							<tr>
								<th colspan="3">적립 예정 포인트</th>
								<th colspan="2">
									<fmt:formatNumber value="${Mpoint}" type="currency"></fmt:formatNumber>
									<input type="hidden" value="${Mpoint}" name="Mpoint">
								</th>
							</tr>
						</table>
						<div class="goodsCartButton">
							<input type="button" value="계속 쇼핑하기" class="goodsButton2"
								onClick="location.href='goodsMain'">
							<input type="button" value="선택한 상품 주문하기" class="goodsButton1"
								onClick="go_Gorder_insert('${Mpoint}');">
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</form>
	</div>
</article>
<%@ include file="../include/footer.jsp"%>