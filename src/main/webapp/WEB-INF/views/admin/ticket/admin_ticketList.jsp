<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/admin_header.jsp"%>

<article>
<br>
<h2 align="center">전시 리스트</h2>
<form name="formm">
<table id="t_admin_listbox">
	<tr>
		<th height="20">No.</th>
		<th height="20">행사명</th>
		<th height="20">행사기간</th>
		<th height="20">등록일</th>
		<th height="20">&nbsp;</th>
	</tr>
	<tr><td id="t_admin_listbox_line" colspan="5"></td><tr>
	<c:forEach items="${ticketList}" var="tpVO">
		<tr>
			<td>${tpVO.TPSEQ}</td>
			<td>${tpVO.NAME}</td>
			<td>
				<fmt:formatDate pattern="yyyy.MM.dd" value="${tpVO.SDATE}" type="date" />
			 ~ <fmt:formatDate pattern="yyyy.MM.dd" value="${tpVO.EDATE}" type="date" />
			 </td>
			 <td><fmt:formatDate pattern="yyyy.MM.dd" value="${tpVO.INDATE}" type="date" /></td>
			<td id="btn">
				<input type="hidden" name="tpseq" value="${tpVO.TPSEQ}">
				<input type="button" class="adminbtn" value="수정" onClick="updatePass();">
				<input type="button" class="adminbtn" value="삭제"  
					onClick="open_win2('admin_deleteForm?tpseq=${tpVO.TPSEQ}', 'delete');">
			</td>
		</tr>
	</c:forEach>
	<tr><td id="t_admin_listbox_line" colspan="5"></td><tr>
</table>
<div id="t_admin_listboxbottom">
<table>
	<tr>
		<td>행사명 <input type="text" name="key" value="${key}">
			<input class="adminbtn" type="button" name="btn_search" value="검색" 
				onClick="go_ticketSearch('admin_ticketList');">
			<input class="adminbtn" type="button" name="btn_total" value="전체보기 " 
				onClick="go_ticketTotal('admin_ticketList');">
			<input class="adminbtn" type="button" name="btn_write" value="행사등록"  onClick="go_wrt();">
		</td>
	</tr>
</table>
</div>
</form>
 	<jsp:include page="../../include/paging/paging.jsp">
		<jsp:param name="command" value="admin_ticketList" />
	</jsp:include>
</article>

<%@ include file="../../include/admin_footer.jsp"%>