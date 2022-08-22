<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/admin_header.jsp"%>
<article id="admin_notice">
<h2 align="center">공지사항 관리페이지</h2>
	<table id="notice_table">
		<tr>
			<th width="100" height="40">공지No.</th>
    		<th width="300" height="40">제목</th>
    		<th width="100" height="40">관리자</th>
    		<th width="200" height="40">업로드날짜</th>
		</tr>
		<c:forEach items="${adminnotice}" var="noticeVO">
    				<tr>
    					<td height="50">${noticeVO.NTNUM}</td>
    					<td height="50">
    					<a href="#" onClick="go_notice('${noticeVO.NTNUM}');">${noticeVO.TITLE}</a>
    					</td>
    					<td height="50">${noticeVO.ID}</td>
    					<td height="50"><fmt:formatDate value="${noticeVO.INDATE}" pattern="YYYY/MM/dd EEEE"></fmt:formatDate></td>
    				</tr>
    	</c:forEach>
		</table>
	<form name="frm" method="post" id="adminNotice_serbox">
		<table>
			<tr>
				<td><input type="text" name="key" value="${key}" style="width:170px; height:20px;">
				<input type="button" class="adminbtn" value="검색" onClick="go_search('adminNotice');" style="height:25px;">
				<input type="button" class="adminbtn" value="전체보기" onClick="go_total('adminNotice');" style="height:25px;">
				<input type="button" class="adminbtn" value="공지사항등록" onClick="go_nowrt();" style="height:25px;">
				</td>
			</tr>
		</table>
	</form>
	<br>
	<div id="paging" align="center"
		style="font-size: 110%; font-weight: bold;">
		<c:url var="action" value="adminNotice" />
		<c:if test="${paging.prev}">
			<a href="${action}?page=${paging.beginPage-1}">◀</a>&nbsp;
    </c:if>
		<c:forEach begin="${paging.beginPage}" end="${paging.endPage}"
			var="index">
			<c:choose>
				<c:when test="${paging.page==index}">
					<span style="color:#3CB371">${index}&nbsp;</span>
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
</article>
<%@ include file="../../include/admin_footer.jsp"%>