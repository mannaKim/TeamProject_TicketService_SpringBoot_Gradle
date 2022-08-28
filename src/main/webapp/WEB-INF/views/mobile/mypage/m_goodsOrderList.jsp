<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/m_sub/m_mypage_sub_menu.jsp"%>
<article>
	<div class="goodsBox">
		<h1>주문 내역</h1>
		<div class="goodsCart">
			<c:forEach items="${goodsOrderList}" var="govo">
				<div class="goodsCartBox">
					<a href="m_goodsDetail?gseq=${govo.GSEQ}">
						<img src="/goods_images/${govo.IMAGE}">
					</a>
					<br>
					<a href="m_goodsDetail?gseq=${govo.GSEQ}"> 
							${govo.GNAME}		
					</a><br><br>
					${govo.QUANTITY} 개 <br>
					<fmt:formatNumber value="${govo.PRICE*govo.QUANTITY}" type="currency" />
					<hr>
				</div>
			</c:forEach>
			<table>
				<tr>
					<th>결제 금액</th>
					<th><fmt:formatNumber value="${totalGoods.TOTALPRICE2}" type="currency" /></th>
				</tr>
				<tr>
					<th>결제 방법</th>
					<th>${payment}</th>
				</tr>
			</table>
		</div>
		<div class="goodsCartButton">
			<input type="button" value="쇼핑하러 가기" class="goodsButton1"
				onClick="location.href='m_goodsMain'">
		</div>
	</div>
</article>
<%@ include file="../include/footer.jsp"%>