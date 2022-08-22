<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<link href="/css/qna.css" rel="stylesheet">
<article style="margin-top: 150px;">
	<div class="qna_px">
	<div class="qna_head_m">
		<h2>1:1 문의</h2>
	</div>
	<form name="formm" method="post">
		<table class="qnatable">
			<tr>
				<th>제목</th>
				<td class="qna_ht" align="left">${qnaVO.SUBJECT}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td class="qna_ht" align="left">${qnaVO.ID}</td>
			</tr>
			<tr>
			<tr>
				<th>등록일</th>
				<td class="qna_ht" align="left"><fmt:formatDate value="${qnaVO.INDATE}" type="date" /></td>
			</tr>
			<tr>
				<th>문의내용</th>
				<td class="qna_ttt" align="left">${qnaVO.CONTENT}</td>
			</tr>
		</table>
		<div class="clear"></div>
		<div class="qna_bts_1">
			<input type="button" value="목록으로" class="qna_bu" 
				onclick="location.href='qnaList'">
			<!-- 목록 버튼을 누르면 qnalist.jsp 로 이동합니다.  -->
		</div>
	</form>

	<form method="post" name="frm_reply" class="qna_rp">
		<input type="hidden" name="command" value="qnaReply" /> <input
			type="hidden" name="qnanum" value="${qnaVO.QSEQ}" />
		<table>
			<c:forEach items="${replyList}" var="reply">
				<c:choose>
					<c:when test="${reply.CONTENT==null}">
					</c:when>
					<c:otherwise>
						<tr>
							<th width="100">작성자</th>
							<th align="left" class="qna_wr">답변 내용</th>
							<th>날짜</th>
						</tr>
					</c:otherwise>
				</c:choose>
				<tr align="center">
					<td>${reply.ID}</td>
					<td align="left">&nbsp; ${reply.CONTENT}</td>
					<td><fmt:formatDate value="${reply.INDATE}" type="date" /></td>
				</tr>
			</c:forEach>
		</table>
	</form>
</div>
</article>

<%@ include file="../include/footer.jsp" %>