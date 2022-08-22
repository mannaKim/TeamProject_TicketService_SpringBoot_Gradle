<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/admin_header.jsp"%>
<article id="admin_noticeView">
<h2 align="center">공지사항 관리페이지</h2>
    <table id="notice_table">
    	<tr>
    		<th width="250" height="30">작성자</th>
    		<th width="250" height="30">제목</th>
    		<th width="250" height="30">작성일</th>
    	</tr>
    	<tr>
    		<td height="50">${notice.ID}</td>
    		<td height="50">${notice.TITLE}</td>
    		<td height="50"><fmt:formatDate value="${notice.INDATE}" pattern="YYYY/MM/dd EEEE"></fmt:formatDate></td>
    	</tr>
    	<tr>
    		<td colspan="4" height="100">${notice.CONTENT}</td>
    	</tr>
    	</table>
    	<br>
    	<div id="noticeView_btn">
	    	<input type="button" class="adminbtn" value="목록으로" onClick="location.href='adminNotice'" style="width:100px; height:30px;">
	    	<input type="button" class="adminbtn" value="수정하기" onClick="NoticeCheck('${notice.NTNUM}', 'update');" style="width:100px; height:30px;">
	    	<input type="button" class="adminbtn" value="삭제하기" onClick="NoticeCheck('${notice.NTNUM}', 'delete');" style="width:100px; height:30px;">
	    </div>
    </article>


<%@ include file="../../include/admin_footer.jsp"%>