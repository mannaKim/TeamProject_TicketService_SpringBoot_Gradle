<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="m_fna_sub_menu.jsp"%>
<style>    
.menu a{cursor:pointer;}    
.menu .hide{display:none;}
</style>

<article>
	<div class="clear"></div>
	<div class="qna_px" style="height:auto; overflow:hidden;">
	<div class="box_content" style="margin-top: 50px;">
	<c:forEach items="${faqList}" var="faqVO">
	 <div class="faq-content">
			<button class="question" id="que-${faqVO.FAQNUM}">
				<span id="que-${faqVO.FAQNUM}-toggle">+</span><span class="m_kind">
				<c:choose>
					<c:when test="${faqVO.KIND==1}">
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
	</div>

</div>
</article>
<script>

const items = document.querySelectorAll('.question');

 function openCloseAnswer() {
   const answerId = this.id.replace('que', 'ans');

   if(document.getElementById(answerId).style.display === 'block') {
     document.getElementById(answerId).style.display = 'none';
     document.getElementById(this.id + '-toggle').textContent = '+';
   } else {
     document.getElementById(answerId).style.display = 'block';
     document.getElementById(this.id + '-toggle').textContent = '-';
   }
 }

 items.forEach(item => item.addEventListener('click', openCloseAnswer));

</script>
<%@ include file="../include/footer.jsp" %>

