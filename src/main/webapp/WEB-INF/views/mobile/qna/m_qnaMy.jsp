<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/m_sub/m_mypage_sub_menu.jsp" %>
<link href="/css/mobile/m_qna.css" rel="stylesheet">

<article>
	<div class="qna_px_list">
		<div style="text-align:left;margin:40px auto 20px;">
			<h1>나의 문의</h1>
		</div>
		<form name="formm" method="post">
			<table id="qna_list">
				<tr>
					<th>번호</th>
					<th align="left" class="qna_wr">제목</th>
					<th>등록일</th>
					<th>답변여부</th>
				</tr>
				<c:choose>
					<c:when test="${empty qnaList}">
						<tr>
							<td colspan="4" class="qna_empty">작성한 글이 없습니다</td>
						</tr>
					</c:when>

					<c:otherwise>
						<c:forEach items="${qnaList}" var="qnaVO">
							<tr>
								<td>${qnaVO.QSEQ}</td>
								<td align="left" class="qna_wr"><a
									href="mqnaMyView?qseq=${qnaVO.QSEQ}"> 
										<c:choose>
										<c:when test="${qnaVO.KIND==1}">
											[전시]
										</c:when>
										<c:when test="${qnaVO.KIND==2}">
											[회원안내]
										</c:when>
										<c:when test="${qnaVO.KIND==3}">
											[관람/예약]
										</c:when>
										<c:when test="${qnaVO.KIND==4}">
											[굿즈]
										</c:when>
										<c:otherwise>
											[기타]
										</c:otherwise>
									</c:choose> &nbsp; ${qnaVO.SUBJECT}
							</a> <c:if test="${qnaVO.REPLYCNT>0}">
									<span style="color: #3CB371; font-weight: bold;">[${qnaVO.REPLYCNT}]</span>
								</c:if></td>
							<td><fmt:formatDate value="${qnaVO.INDATE}" type="date" /></td>
							<td><c:choose>
						<c:when test="${qnaVO.REPLYCNT>0 }"> 답변완료 </c:when>
						<c:otherwise> 답변대기 </c:otherwise>
					</c:choose></td>  
								<!-- <td><c:choose>
					<c:when test="${qnaVO.rep=='1' }"> N </c:when>
					<c:when test="${qnaVO.rep=='2' } "> Y </c:when>
				</c:choose></td>   답변여부는 해결을 하지 못해 나중에 해보는 것으로... -->
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
			<div class="clear"></div>
			<br>

			<div id="paging" align="center"
				style="font-size: 110%; font-weight: bold;">
				<c:url var="action" value="mqnaMy" />
				<c:if test="${paging.prev}">
					<a href="${action}?page=${paging.beginPage-1}">◀</a>&nbsp;
		    </c:if>
				<c:forEach begin="${paging.beginPage}" end="${paging.endPage}"
					var="index">
					<c:choose>
						<c:when test="${paging.page==index}">
							<span style="color: #3CB371">${index}&nbsp;</span>
						</c:when>
						<c:otherwise>
							<a href="${action}?page=${index}&key=${key}">${index}</a>&nbsp;
		        </c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${paging.next}">
					<a href="${action}?page=${paging.endPage+1}">▶</a>&nbsp;
		    </c:if>
			</div>
			<br>
			<!-- <br>
			<div class="clear"></div>
			<div class="qna_bts_1">
				<input type="button" value="1:1 문의하기"  class="qna_bu" onClick="location.href='mqnaWriteForm'"> 
				문의하기 버튼을 누르면 QnaWirteFormAction 으로 이동합니다. 
			</div>
			<div class="clear"></div>
			<br> -->
		</form>
	</div>
</article>
<%@ include file="../include/footer.jsp" %>
