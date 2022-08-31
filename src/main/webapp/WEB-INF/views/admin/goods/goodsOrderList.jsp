<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/admin_header.jsp"%>
<article id="admin_goods">
	<h2 align="center">굿즈 주문 리스트</h2>
	<table id="goods_orderTable">
		<tr>
			<th width="100">주문일자</th>
			<th width="70">주문번호</th>
			<th width="100">주문회원</th>
			<th colspan="2">상품명</th>
		    <th width="100">결제금액</th>
		    <th width="70">처리상태</th>
		    <th width="70">주문처리</th>
		</tr>
		<c:forEach items="${goodsOrderList}" var="govo">
			<tr>
				<td>
			   		<fmt:formatDate value="${govo.INDATE}" type="date"/>
			   	</td>
			   	<td>
			   		${govo.GOSEQ}
			   	</td>
			   	<td>
			   		${govo.ID}
			   	</td>
			   	<td>
			   		<img src="/goods_images/${govo.IMAGE}" width="200">
			   	</td>
			   	<td>
			   		${govo.GNAME}
			   	</td>
			   	<td>
			   		<fmt:formatNumber value="${govo.TOTALPRICE2}" type="currency"/>
			   	</td>
			   	<td>
			   		<c:if test="${govo.RESULT=='1'}">처리중</c:if>
		            <c:if test="${govo.RESULT=='0'}">완료</c:if>
			   	</td>
			   	<td>
			   		<a href="adminGoodsOrderModify?goseq=${govo.GOSEQ}">이동</a>
			   	</td> 
			</tr>  
		</c:forEach>
	</table>
	<br><br>
  	<jsp:include page="../../include/paging/paging.jsp">
  		<jsp:param value="adminGoodsOrderList" name="command" />
	</jsp:include>
</article>
<%@ include file="../../include/admin_footer.jsp"%>