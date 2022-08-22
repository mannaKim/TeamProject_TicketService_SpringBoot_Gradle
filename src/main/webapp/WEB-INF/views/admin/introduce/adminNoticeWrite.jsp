<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/admin_header.jsp"%>
<article id="adminNotice_write">
	<h2 align="center">공지사항 작성</h2>
	<form name="frm" method="post" action="noticeWrite">
		<table>
			<tr>
				<th width="100" height="40">작성자</th>
				<td>${loginUser.id}<input type="hidden" name="id" value="${loginUser.id}"></td>
			</tr>
			<tr>
				<th width="100" height="40">* 제목</th>
				<td><input type="text" name="title" style="width:180px; height:25px; font-size:16px;"></td>
			</tr>
			<tr>
				<th width="100">* 내용</th>
				<td>
					<textarea cols="70" rows="13" name="content" style="font-size:16px;"></textarea>
				</td>
			</tr>
		</table>
		${message}
		<br>
		<div id="adminNoticewt_btn">
			<input type="submit" class="adminbtn" value="등록" style="width:70px; height:30px;">
			<input type="reset" class="adminbtn" value="다시작성" style="width:100px; height:30px;">
			<input type="button" class="adminbtn" value="목록으로" onClick="location.href='adminNotice'" style="width:100px; height:30px;">
		</div>
	</form>
</article>

<%@ include file="../../include/admin_footer.jsp"%>