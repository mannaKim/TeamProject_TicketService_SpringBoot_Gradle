<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<article class="underHeader">
	<%@ include file="../include/m_sub/m_goods_sub_menu.jsp"%>
	<div class="goodsBox">
		<h1>'${key}'에 대한 검색 결과</h1>
		<c:choose>
			<c:when test="${empty goodsSearchList}">
				<div class="goodsEmpty">
					<h3>'${key}'에 대한 검색 결과가 없습니다.</h3>
					<h3>입력한 검색어의 철자 또는 띄어쓰기가 정확한지 다시 한번 확인해 주세요.</h3>
					<h3>검색어의 단어 수를 줄이거나, 보다 일반적인 검색어를 사용하여 검색해 보세요.</h3>
				</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="${goodsSearchList}" var="gvo">
					<div class="goodsCategory">
						<a href="m_goodsDetail?gseq=${gvo.GSEQ}">
							<img src="/goods_images/${gvo.IMAGE}">
						</a> 
						<a href="m_goodsDetail?gseq=${gvo.GSEQ}">
							<c:choose>
								<c:when test="${gvo.NUM_INVENTORY==0}">
									<h2 style="text-decoration: line-through;">[품절] ${gvo.NAME}</h2>
								</c:when>
								<c:otherwise><h2>${gvo.NAME}</h2></c:otherwise>
							</c:choose>
						</a>
						<h3>
							<fmt:formatNumber value="${gvo.PRICE2}" type="currency" />
						</h3>
						<span>${gvo.CONTENT}</span>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<jsp:include page="../include/paging/goods_paging.jsp">
			<jsp:param value="m_goodsSearch?key=${key}" name="command" />
		</jsp:include>
		<br>
	</div>
</article>
<%@ include file="../include/footer.jsp"%>