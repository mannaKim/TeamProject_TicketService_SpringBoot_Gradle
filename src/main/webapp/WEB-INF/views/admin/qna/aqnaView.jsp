<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../../include/admin_header.jsp"%>
	
	<style>

/*input 관련 속성 */
input {
	background: transparent;
}
input:focus, textarea:focus {
	outline:none;
}

select {
	position: relative;
	width: 150px;
	height: 35px;
	border-radius: 5px;
	border: 1px solid #2F4F4F;
	text-align: center;
	background: #2F4F4F;
	color: white;
}
/*내용*/
.qna_tt {
	padding: 10px;
	width: 100%;
	height: 340px;
	resize: none;
	min-height: 100px;
}

.qna_ttt {
	height: 250px;
	padding: 10px;
	width: 90%;
}
/*제목*/
.qna_h {
	height: 50px;
	padding: 0 10px;
	width: 100%;
	border-width: 1px;
}

.qna_ht {
	padding: 0 10px;
	height: 50px;
	width: 90%;
}

/*댓글 관련*/
.qna_rp {
	margin-top: 20px;
	margin-bottom: 10px;
}

.qna_rp th, .qna_rp td {
	height: 50px;
}

.qna_h_re {
	height: 35px;
	width: 98%;
	padding-left: 10px;
	border: 1px solid #2F4F4F;
}
.qna_w {
	width: 10%;
}
.qna_wr{
	padding-left: 10px;
}

/*버튼*/
.qna_bt_box {
	width: 100%;
	height: 100px;
	margin-bottom: 100px;
}
.qna_bts {
	width: 306px;
	height: 45px;
	margin-top: 10px;
	margin-left: 70%;
	margin-bottom: 100px;
}

.qna_bts_1 {
	margin-top: 10px;
	margin-left: 80%;
	margin-bottom: 70px;
}
.qna_bu {
	position: relative;
	width: 150px;
	height: 45px;
	border-radius: 5px;
	border: 1px solid #2F4F4F;
}
.qna_bu:hover {
	background-color: #2F4F4F;
	color: white;
}

/*페이지*/
.qna_pag {
	margin-top: 30px; margin-left : 20%;
	margin-right: 20%; 	margin-left: 20%;
	width: 60%;
	text-align: center;
}


/*리스트 테이블*/
#qna_list th, #qna_list td {
	padding: 10px;
}
#qna_list .qna_empty {
	padding-top: 150px;
	padding-bottom: 150px;
	
}

</style>

<article  id="admin_notice">
	<div class="qna_px">
	<div class="qna_head">
		<h2 align="center">1:1 문의 확인</h2>
	</div>
	<form>
		<table  id="notice_table" style="border-collapse: collaps;">
			<tr>
				<th style="border-top: 0;">제목</th>
				<td class="qna_ht" align="left" style="border-top: 0;">${qnaVO.SUBJECT}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td class="qna_ht" align="left">${qnaVO.ID}</td>
			</tr>
			<tr>
				<th>등록일</th>
				<td class="qna_ht" align="left"><fmt:formatDate
						value="${qnaVO.INDATE}" type="date" /></td>
			</tr>
			<tr>
				<th style="border-bottom: 0;">문의내용</th>
				<td class="qna_ttt" align="left" style="border-bottom: 0;">${qnaVO.CONTENT}</td>
			</tr>
		</table>
		<div class="clear"></div>
		<div class="qna_bts_1">
			<input type="button" value="목록" class="qna_bu"
				onclick="location.href='aqnaList'">
		</div>
	</form>

	<form method="post" name="frm_reply" class="qna_rp" action="qnaReply" >
		<!--   <input type="hidden" name="command" value="qnaReply" />  -->
		<input type="hidden" name="qnanum" value="${qnaVO.QSEQ}" />
		<table style="width: 100%;">
			<tr>
				<th class="qna_w">작성자</th>
				<th align="left" class="qna_wr">답변 내용</th>
				<th>날짜</th>
				<th>답변 작성</th>
			</tr>
			<tr>
				<td align="center">${id}<input type="hidden" name="id"
					value="${id}"></td>
				<td align="left"><input type="text" name="content" size="80"
					class="qna_h_re"></td>
				<td></td>
				<td><input type="submit" value="작성" class="qna_bu"
					onClick="return reply_check();"></td>
			</tr>
			<c:forEach items="${replyList}" var="reply">
			<input type="hidden" name="renum" value="${reply.RENUM}" />
				<tr>
					<td align="center">${reply.ID}</td>
					<td align="left">&nbsp;${reply.CONTENT}</td>
					<td><fmt:formatDate value="${reply.INDATE}" type="date" /></td>
					<td>
				<!-- <input type="button" value="삭제" class="qna_bu"
						id="qna_re_d" onClick="reply_delete('${reply.RENUM}','${qnaVO.QSEQ}');"></td>  -->
						<input type="button" value="삭제"  class="qna_bu"
						id="qna_re_d" onclick="location.href='aqnaReD?renum=${reply.RENUM}&qnanum=${reply.QNANUM}'">
						
				</tr>
			</c:forEach>
		</table>
	</form>
	</div>
</article>

<script type="text/javascript">

function reply_check(){
	 if(document.frm_reply.content.value == "") {
	    alert("내용를 입력해 주세요.");	    
	    document.frm_reply.content.focus();
	    return false;
	}else{
		return true;
	}
}
</script>

<%@ include file="../../include/admin_footer.jsp"%>