<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<link href="/css/qna.css" rel="stylesheet">
<article style="margin-top: 150px;">
	<div class="qna_px">
	<div class="qna_head_m">
		<h2> 1:1 문의 </h2>
	</div>
	<form name="writeFrm" method="post" action="qnaWrite">
		<!--<input type="hidden" name="command" value="qnaWrite">   -->
		<div class="plag">
			<table id="write">
				<tr>
					<th>문의종류</th>
					<td colspan="5" align="left">
						<select name="kind">
							<option value="">선택</option>
							<c:forEach items="${kindList}" var="kindName" varStatus="status">
								<option value="${status.count}">${kindName}</option>
								<%-- <input type="hidden" name="kind" value="${status.count}">	 --%>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr><th>제목</th>
					<td>
						<input class="qna_h" type="text" name="subject" size="47" maxlength="100">${qnaVO.subject}
					</td>
				</tr>
				<tr>
					<th>문의내용</th>
					<td>
						<textarea name="content" rows="10" cols="30" class="qna_tt" style="background-color:transparent">${qnaVO.content}</textarea>
					</td>
				</tr>
			</table>
			<div class="qna_bt_box">
			<div class="qna_bts">
				<input  type="button" value="작성" class="qna_bu" onClick="go_write();">
				<!-- 작성 버튼을 누르면 작성 내용 확인 후 QnaWriteAction 으로 이동합니다.  -->
				<input type="button" value="취소" class="qna_bu"
					onClick="location.href='qnaList'">
				<!-- 목록 버튼을 누르면 작성 내용 확인 후 qnalist.jsp 로 이동합니다.  -->
			</div>
			</div>
			</div>
	</form>
	</div>
</article>
<%@ include file="../include/footer.jsp" %>

   
