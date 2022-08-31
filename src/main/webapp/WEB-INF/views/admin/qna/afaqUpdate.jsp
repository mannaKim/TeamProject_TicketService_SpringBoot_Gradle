<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/admin_header.jsp"%>
	<link href="adminqna.css" rel="stylesheet">
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
	margin: 0 auto;
	margin-top: 20px;
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
<article id="admin_notice" >
	<div class="qna_px">
	<div class="qna_head_m">
		<h2> FAQ 수정 </h2>
	</div>
	<form name="writeFrm" method="post" action="faqUpdate">
		<!--<input type="hidden" name="command" value="qnaWrite">   -->
		<div class="plag">
			<table id="notice_table">
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
						<input class="qna_h" type="text" name="subject" size="47" maxlength="100" value="${faqVO.con_q}"
						style="border:none;">
					</td>
				</tr>
				<tr>
					<th>답변</th>
					<td>
						<textarea name="content" rows="10" cols="30" class="qna_tt" style="background-color:transparent; border:none;">${faqVO.con_a}</textarea>				
					</td>
				</tr>
			</table>
			<div class="qna_bt_box">
			<div class="qna_bts">
				<input  type="submit" value="작성" class="qna_bu">
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

   
