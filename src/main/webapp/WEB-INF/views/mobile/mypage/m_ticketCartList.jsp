<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/m_sub/m_mypage_sub_menu.jsp"%>
<article>
<div class="goodsBox">
	<h1>관람 정보</h1>
	<c:choose>
		<%-- 로그인유저의 tclist 확인후 list 비어있다면 아래코드 실행 --%>
		<c:when test="${ empty tclist }">
			<div class="emptyGoodsCart">
				<img src="/goods_images/sub_images/emptyOrder.png">
				<h3>예매 내역이 없습니다.</h3>
			</div>
			<div class="goodsCartButton">
				<input type="button" value="예매하러 가기" class="goodsButton1"
					onClick="location.href='m_ticketingList'">
			</div>
		</c:when>
		<%-- tclist 가 비어있지 않다면 아래코드로 실행. --%>
		<c:otherwise>
			<div class="goodsCart">
				<table>
					<tr>
						<th>공연명</th><th>관람일시</th><th>매수</th><th>예매상태</th>
					</tr>
					<c:forEach items="${ tclist }" var="tcvo">
						<jsp:useBean id="now" class="java.util.Date" />
						<%-- 오늘날짜 --%>
						<fmt:formatDate pattern="yyyy.MM.dd" value="${now}" var="today" />
						<%-- 선택날짜 --%>
						<fmt:formatDate pattern="yyyy.MM.dd" value="${tcvo.CHOISDATE}" type="date" var="choisdate" />
						<tr>
							<td><a href="m_ticketShowMypage?tpseq=${tcvo.TPSEQ}">${ tcvo.PNAME } </a></td>
							<td>${ choisdate } - ${ tcvo.DAYTIME }</td>
							<td>${ tcvo.QUANTITY1 + tcvo.QUANTITY2 }매<br>
								(일반:${ tcvo.QUANTITY1 } 어린이:${ tcvo.QUANTITY2 })
							</td>
							<td><c:if test="${ choisdate > today }">
									<a href="m_ticketShowMypage?tpseq=${tcvo.TPSEQ}">예매완료</a>
								</c:if> 
								<c:if test="${ choisdate <= today }">관람기간 종료</c:if>
							</td>
						</tr>
					</c:forEach>
				</table><br>
				<jsp:include page="../include/paging/paging.jsp">
					<jsp:param name="command" value="m_ticketCartList"/>
				</jsp:include><br>
			</div>
		</c:otherwise>
	</c:choose>	
</div>
</article>
<%@ include file="../include/footer.jsp"%>