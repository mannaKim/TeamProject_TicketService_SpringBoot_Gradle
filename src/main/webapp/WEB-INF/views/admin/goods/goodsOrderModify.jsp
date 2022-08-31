<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/admin_header.jsp"%>
<article id="admin_goods">
	<h2>주문 처리</h2>
	<br>
	<form name="frm" method="post" action="adminChangeOrderResult">
		<table id="goods_table">
			<tr>
				<th colspan="2">상품명</th>
				<th width="50">수량</th>
				<th width="90">가격</th>
				<th width="90">처리상태</th>
				<th width="150">처리상태 변경</th>
			</tr>
			<c:forEach items="${goodsOrderList}" var="govo">
				<input type="hidden" name="goseq" value="${govo.GOSEQ}">
				<input type="hidden" name="godseq" value="${govo.GODSEQ}">
				<input type="hidden" name="result" value="${govo.RESULT}">
				<tr>
					<td>
						<a href="goodsDetail?gseq=${govo.GSEQ}">
							<img src="/goods_images/${govo.IMAGE}" width="200">
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
						<c:if test="${govo.RESULT=='1'}">처리중</c:if>
						<c:if test="${govo.RESULT=='0'}">처리완료</c:if>
					</td>
					<td>
						<c:choose>
							<c:when test="${govo.RESULT=='1'}">
								<input type="button" class="adminbtn" value="처리완료로 변경"
									onClick="changeResult()" /> 
								<!-- <input type="submit" class="adminbtn" value="처리완료로 변경"/> -->
							</c:when>
							<c:otherwise>
								<input type="submit" class="adminbtn" value="처리중으로 변경" 
									onClick="changeResult()" />
								<!-- <input type="submit" class="adminbtn" value="처리중으로 변경"/> -->
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
			<tr>
				<th colspan="4" style="border-top: 1px dotted gray;">해당 주문 처리상태 일괄 변경</th>
				<td colspan="2">
					<input type="button" class="adminbtn" value="전체 처리완료"
						onClick="changeResultAll()" />
				</td>
			</tr>
		</table>
	</form>
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
	<br>
	<br>
	<h2>결제 정보</h2>
	<table id="goods_table">
		<tr>
			<th>총 결제 금액</th>
			<th>결제 수단</th>
		</tr>
		<tr>
			<td><fmt:formatNumber value="${goodsOrderDetail.TOTALPRICE2}" type="currency" /></td>
			<td>${payment}</td>
		</tr>
	</table>
	<div class="goods_buttonBox">
		<input type="button" class="adminbtn" value="목록으로"
			onClick="location.href='adminGoodsOrderList'">
	</div>
</article>
<%@ include file="../../include/admin_footer.jsp"%>