<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/admin_header.jsp"%>
<%-- <%@ include file="../admin_image_menu.jsp" %> --%>

<article>
<br>
<h2 align="center">전시 예약 리스트</h2>
<form name="formm">
<table id="t_admin_listbox">
	<tr>
		<th>예매번호</th>
		<th>행사명</th>
		<th>구매자</th>
		<th>ID</th>
		<th>공연날짜</th>
		<th>구매티켓</th>
		<th>&nbsp;</th>
	</tr>
	<tr><td id="t_admin_listbox_line" colspan="7"></td><tr>
	<c:forEach items="${ticketCartList}" var="tcvo">
		<tr>
			<td>${tcvo.CSEQ}</td>
			<td>${tcvo.PNAME}</td>
			<td>${tcvo.MNAME}</td>
			<td>${tcvo.ID}</td>
			<td>
				<fmt:parseDate var="sdate" value="${tcvo.CHOISDATE}" pattern="yyyy-MM-dd HH:mm:ss"/>
				<fmt:formatDate pattern="yyyy.MM.dd" value="${tcvo.CHOISDATE}" type="date" />
			</td>
			<td>${tcvo.QUANTITY1 + tcvo.QUANTITY2}매 (일반:${tcvo.QUANTITY1}매 어린이:${tcvo.QUANTITY2}매)</td>
			<td id="btn">
				<input type="button" class="adminbtn" value="삭제" 
					onClick="open_win2('admin_delete2Form?cseq=${tcvo.CSEQ}', 'delete_cart')">
			</td>
		</tr>
	</c:forEach>
	<tr><td id="t_admin_listbox_line" colspan="7"></td><tr>
</table>
<div id="t_admin_listboxbottom">
<table>
	<tr>
		<td>행사명 <input type="text" name="key" value="${key}">
			<input class="adminbtn" type="button" name="btn_search" value="검색" 
				onClick="go_ticketSearch('adminticketOrderList');">
			<input class="adminbtn" type="button" name="btn_total" value="전체보기" 
				onClick="go_ticketTotal('adminticketOrderList');">
		</td>
	</tr>
</table>
</div>
</form>
	<jsp:include page="../../include/paging/paging.jsp">
		<jsp:param name="command" value="adminticketOrderlistForm" />
	</jsp:include>
</article>

<%@ include file="../../include/admin_footer.jsp"%>