<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/m_sub/m_mypage_sub_menu.jsp"%>
<article>
	<div class="goodsBox">
		<h1>${title}</h1>
		<c:choose>
			<c:when test="${empty allGoodsOrderList}">
				<div class="emptyGoodsCart">
					<img src="/goods_images/sub_images/emptyOrder.png">
					<h3>주문 내역이 없습니다.</h3>
				</div>
				<div class="goodsCartButton">
					<input type="button" value="쇼핑하러 가기" class="goodsButton1"
						onClick="location.href='goodsMain'">
				</div>
			</c:when>
			<c:otherwise>
				<div class="goodsCart">
					<table>
						<tr>
							<th colspan="2">상품명</th>
							<th>결제금액</th>
						</tr>
						<c:forEach items="${allGoodsOrderList}" var="govo">
							<tr>
								<td>
									<a href="m_goodsOrderDetail?goseq=${govo.GOSEQ}">
										<img src="/goods_images/${govo.IMAGE}">
									</a>		
								</td>
								<td>
									<a href="m_goodsOrderDetail?goseq=${govo.GOSEQ}">
										${govo.GNAME}
									</a>
								</td>
								<td><fmt:formatNumber value="${govo.TOTALPRICE2}" type="currency" />
								</td>
							</tr>
						</c:forEach>
					</table>
					<br>
					<jsp:include page="../include/paging/paging.jsp">
						<jsp:param value="m_allGoodsOrderList" name="command" />
					</jsp:include>
					<br>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</article>
<%@ include file="../include/footer.jsp"%>