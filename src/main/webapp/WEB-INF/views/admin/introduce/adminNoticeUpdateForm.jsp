<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/admin_header.jsp"%>
<article id="adminNotice_update">
<h2 align="center">게시글 수정</h2>
	<form method="post" name="frm" action="updateNotice">
	<input type="hidden" name="ntnum" value="${notice.ntnum}">
	<table>
		<tr>
			<th width="100" height="40">작성자</th>
			<td>${notice.id}<input type="hidden" name="id" value="${notice.id}"></td>
		</tr>
		<tr>
			<th width="100" height="40" class="adminNoticeup_opt">* 제목</th>
			<td><input type="text" name="title" value="${notice.title}" style="width:180px; height:25px; font-size:16px;"></td>
		</tr>
		<tr>
			<th width="100">* 내용</th>
			<td><textarea cols="70" rows="13" name="content" style="font-size:16px;">${notice.content}</textarea>
			</td>
		</tr>
	</table>
	<br>
	<div id="adminNoticeup_btn">
		<input type="submit" class="adminbtn" value="수정" onClick="return noticeCheck()" style="width:70px; height:30px;">
		<input type="reset" class="adminbtn" value="다시작성" style="width:100px; height:30px;">
		<input type="button" class="adminbtn" value="돌아가기" onClick="location.href='adminNoticeView?ntnum=${notice.ntnum}'" style="width:100px; height:30px;">
	</div>
	</form>
</article>


<%@ include file="../../include/admin_footer.jsp"%>