<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<article class="introatc">
	<form id="noticeForm">
		<h1 class="introtitle">공지사항</h1>
		<table>
			<c:forEach items="${notice}" var="noticeVO">
				<tr>
				 <td class="m_title1" id="m_readcount">조회 : ${noticeVO.readcount}</td>
				 </tr>
				 <tr>
					<td class="m_title1" height="50"><a
						href="MnoticeView?ntnum=${noticeVO.ntnum}">${noticeVO.title}</a>
						<c:if test="${noticeVO.readcount>=15}">✨</c:if></td>
				</tr>
				<tr>
					<td class="m_title2"><fmt:formatDate value="${noticeVO.indate}"
							pattern="YYYY/MM/dd EEEE"></fmt:formatDate></td>
				</tr>
			</c:forEach>
		</table><br>
		<!-- 여기서 부터 페이지 -->
	<div id="notice_paging" align="center"
		style="font-size: 110%; font-weight: bold;">
		<c:url var="action" value="Mnotice" />
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
		<br><br>
		<div id="intro_buttons">
			<input type="button" value="돌아가기" class="submit" onClick="location.href='/'">
		</div>
	</form>
</article>


<%@ include file="../include/footer.jsp"%>