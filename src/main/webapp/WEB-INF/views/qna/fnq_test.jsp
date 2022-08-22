<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="fna_sub_menu.jsp"%>

<article>
	<div class="clear"></div>
	<div class="qna_px">
	<div class="box_content" style="margin-top: 50px;">
	<form name="formm" method="post">
	<c:forEach items="${faqList}" var="faqVO">
		<div class="faq-content">
			<button class="question" id="que-${faqVO.FAQNUM}">
				<span id="que-${faqVO.FAQNUM}-toggle">+</span><span class="m_kind">
				<c:choose>
					<c:when test="${fnqVO.KIND==1}">
						전시
					</c:when>
					<c:when test="${faqVO.KIND==2}">
						회원안내
					</c:when>
					<c:when test="${faqVO.KIND==3}">
						관람/예약
					</c:when>
					<c:otherwise>
						굿즈
					</c:otherwise>
				</c:choose></span><span>${faqVO.CON_Q}</span>
			</button>
			<div class="answer" id="ans-${faqVO.FAQNUM}">${faqVO.CON_A}</div>
		</div>
		</c:forEach>
		</form>
	</div>
</div>
</article>
<script src="qna/fnq.js"></script>
<%@ include file="../include/footer.jsp" %>

