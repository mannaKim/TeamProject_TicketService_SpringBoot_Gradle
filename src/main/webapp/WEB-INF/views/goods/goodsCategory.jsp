<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<article class="underHeader">
	<%@ include file="../include/sub/goods_sub_menu.jsp"%>
	<div class="goodsBox">
		<h1>${goodsKind}</h1>
		<hr>
		<c:forEach items="${goodsCategoryList}" var="gvo">
			<div class="goodsCategory">
				<a href="goodsDetail?gseq=${gvo.GSEQ}">
					<img src="/goods_images/${gvo.IMAGE}">
				</a>
				<a href="goodsDetail?gseq=${gvo.GSEQ}">
					<h2>${gvo.NAME}</h2>
				</a>
				<h3>
					<fmt:formatNumber value="${gvo.PRICE2}" type="currency" />
				</h3>
				<span>${gvo.CONTENT}</span>
			</div>
		</c:forEach>
		<jsp:include page="../include/paging/goods_paging.jsp">
			<jsp:param value="goodsCategory?kind=${kind}" name="command" />
		</jsp:include>
		<br>
	</div>
</article>
<%@ include file="../include/footer.jsp"%>