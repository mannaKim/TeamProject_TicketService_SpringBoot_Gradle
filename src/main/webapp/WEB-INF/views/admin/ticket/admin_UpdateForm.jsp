<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/admin_header.jsp"%>

<article>
<div id="warp" align="center">
<form method="post" action="admin_ticketUpdate">
<!-- 이미지 업로드 -->
	<input type="hidden" name="tpseq" value="${tpvo.TPSEQ}">
	<input type="hidden" name="oldImage" value="${tpvo.IMAGE}">
	
	<table id="t_writebox" >
			<tr><th colspan="2">행사등록</th></tr>
			<tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
			<tr><td id="t_writebox_title">행사명</td>
				<td width="343">
		       		<input type="text" name="name" value="${tpvo.NAME}" size="80">
		    	</td>
		    </tr>
		    <tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
			<tr>
				<td id="t_writebox_title">행사 기간</td>
				<td>
					<input type="text" name="sdate" value="<fmt:formatDate pattern="yyyy.MM.dd" value="${tpvo.SDATE}" type="date" />" size="11">
				 ~ <input type="text" name="edate" value="<fmt:formatDate pattern="yyyy.MM.dd" value="${tpvo.EDATE}" type="date" />" size="11">
			</td>
			</tr> 
			<tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
			<tr>
				<td id="t_writebox_title">가격(일반)</td>
				<td width="70">
					<input type="text" name="price1" value="${tpvo.PRICE1}" size="20">
				</td>
			</tr>
			<tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
			<tr>
		  		<td id="t_writebox_title">가격(어린이)</td>
		  		<td width="70">
		  			<input type="text" name="price2" value="${tpvo.PRICE2}" size="20">
		  		</td>
			</tr>
			<tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
			<tr>
				<td id="t_writebox_title">할인가격</td><td width="72">
				<input type="text" name="price3" value="${tpvo.PRICE3}" size="20">
			</td>
			</tr>
			<tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
			<tr>
		  		<td id="t_writebox_title">나이</td>
		  		<td width="70">
		  			<input type="text" name="age" value="${tpvo.AGE}" size="20">
		  		</td>
			</tr>
			<tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
			<tr>
				<td id="t_writebox_title">장소</td><td width="72">
				<input type="text" name="place" value="${tpvo.PLACE}" size="80"></td>
			</tr>
			<tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
			<tr>
				<td id="t_writebox_title">상세주소</td><td width="72">
				<input type="text" name="address" value="${tpvo.ADDRESS}" size="80"></td>
			</tr>
			<tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
			<tr>
				<td id="t_writebox_title">공연입장 시간</td><td width="72">
				<input type="text" name="daytime" value="${tpvo.DAYTIME}" size="20">
			</td>
			<tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
			<tr>
				<td id="t_writebox_title">관람 시간</td><td width="72">
				<input type="text" name="showtime" value="${tpvo.SHOWTIME}" size="20">
			</td>
			</tr>
			<tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
			<tr>
				<td id="t_writebox_title">행사 소개</td>
				<td>
					<textarea cols="70" rows="15" name="content">${tpvo.CONTENT}</textarea>
				</td>
			</tr>
			<tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
			<tr>
				<td id="t_writebox_title">
					<img src="ticket_image/${tpvo.IMAGE}" width="80"><br>행사 이미지
				</td>
				<td width="343" height="343">
					<input type="hidden" name="image" id="image"> <!-- 이미지 미리보기를 위해 히든테그삽입 -->
	    			<div id="filename"></div>
				</td>
			</tr>
			<tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
		</table>
		<div align="center" style="margin-top: 10px;">
			<input type="submit" value="수정" class="adminbtn">
			<input type="reset" value="다시작성" class="adminbtn">
			<input type="button" value="목록" class="adminbtn" onClick="location.href='admin_ticketList'">
		</div>
		
</form>
<div align="center" style="position:relative; top:-70px;">
<form name="fromm" id="fileupForm" method="post" enctype="multipart/form-data">
	<input type="file" name="fileimage">
	<input type="button" id="myButton" value="추가">
</form>
</div>
</div>
</article>

<%@ include file="../../include/admin_footer.jsp"%>