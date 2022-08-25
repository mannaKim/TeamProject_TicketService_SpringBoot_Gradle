<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/admin_header.jsp"%>
	<script src="adminqna.js"></script>
<link href="adminqna.css" rel="stylesheet">
<article style="margin-top: 150px;">
	<div class="qna_px">
	<div class="qna_head_m">
		<h2> FAQ 추가 </h2>
	</div>
	<form name="writeFrm" method="post" action="faqWrite">
		<!--<input type="hidden" name="command" value="qnaWrite">   -->
		<div class="plag">
			<table id="write">
				<tr>
					<th>카테고리</th>
					<td colspan="5" align="left">
						<select name="kind">
							<option value="">선택</option>
							<c:forEach items="${kindList}" var="kindName" varStatus="status">
								<option value="${status.count}">${kindName}</option>	
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr><th>질문</th>
					<td>
						<input class="qna_h" type="text" name="subject" size="47" maxlength="100">${faqVO.con_q}
					</td>
				</tr>
				<tr>
					<th>답변</th>
					<td>
						<textarea name="content" rows="10" cols="30" class="qna_tt" style="background-color:transparent">${faqVO.con_a}</textarea>
					</td>
				</tr>
			</table>
			<div class="qna_bt_box">
			<div class="qna_bts">
				<input  type="button" value="작성" class="qna_bu" onclick="go_write_faq();">
				<input type="button" value="취소" class="qna_bu"
					onClick="location.href='faqList'">
			</div>
			</div>
			</div>
	</form>
	</div>
</article>

<script>
	function go_write_faq(){
		 if(document.writeFrm.subject.value == "") {
		    alert("질문을 입력해 주세요.");	    
		    document.writeFrm.subject.focus();
		}else if(document.writeFrm.content.value == "") {
		    alert("답변을 입력해 주세요.");	    
		    document.writeFrm.content.focus();
		}else if(document.writeFrm.kind.value == "") {
			    alert("카테고리를 입력해 주세요.");	    
			    document.writeFrm.kind.focus();
		}else{
			document.writeFrm.action="faqWrite";
			document.writeFrm.submit();
		}
	}
	
	</script>
<%@ include file="../../include/admin_footer.jsp"%>

   
