<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/admin_header.jsp"%>


<article>

	<form name="formm" method="post">
	<div>
		<table id="t_writebox" >
			<tr><th colspan="2">행사등록</th></tr>
			<tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
			<tr><td id="t_writebox_title">행사명</td>
				<td width="343">
		       		<input type="text" name="name" size="47" maxlength="100">
		    	</td>
		    </tr>
		    <tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
			<tr>
				<td id="t_writebox_title">행사 기간</td>
				<td>
					<input type="text" name="sdate" size="7" placeholder="yyyy-MM-dd" >
					~ <input type="text" name="edate" size="7" placeholder="yyyy-MM-dd">
				</td>
			</tr> 
			<tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
			<tr>
				<td id="t_writebox_title">가격(일반)</td>
				<td width="70">
					<input type="text" name="price1" size="7">
				</td>
			</tr>
			<tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
			<tr>
		  		<td id="t_writebox_title">가격(어린이)</td>
		  		<td width="70">
		  			<input type="text" name="price2" size="7">
		  		</td>
			</tr>
			<tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
			<tr>
				<td id="t_writebox_title">할인가격</td><td width="72">
				<input type="text" name="price3" size="7" >
			</td>
			</tr>
			<tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
			<tr>
		  		<td id="t_writebox_title">나이</td>
		  		<td width="70">
		  			<input type="text" name="age" size="7">
		  		</td>
			</tr>
			<tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
			<tr>
				<td id="t_writebox_title">장소</td><td width="72">
				<input type="text" name="place" size="11" >
			</td>
			<tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
			<tr>
				<td id="t_writebox_title">상세주소</td><td width="72">
				<input type="text" name="address" size="47" >
			</td>
			</tr>
			<tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
			<tr>
				<td id="t_writebox_title">공연입장 시간</td><td width="72">
				<input type="text" name="daytime" size="11" >
			</td>
			<tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
			<tr>
				<td id="t_writebox_title">관람 시간</td><td width="72">
				<input type="text" name="showtime" size="11" >
			</td>
			</tr>
			<tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
			<tr>
				<td id="t_writebox_title">행사 소개</td>
				<td><textarea name="content" rows="8" cols="70"></textarea></td>
			</tr>
			<tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
			<tr>
				<td id="t_writebox_title">행사 이미지</td>
				<td width="343" height="343" >
					<input type="hidden" name="image" id="image">
	    			<div id="filename"></div>
				</td>
			</tr>
			<tr><td id="t_admin_listbox_line" colspan="2"></td><tr>
		</table>
		<div align="center" style="margin-top: 10px;">
		
		<input class="adminbtn" type="submit" value="등록" onClick="go_save()">
		<input class="adminbtn" type="button" value="목록" onClick="go_mov()">
		</div>
		</div>
	</form>
	
	<div align="center" style="position:relative; top:-70px;">
	<form name="fromm" id="fileupForm" method="post" enctype="multipart/form-data">
	<input type="file" name="fileimage"><input type="button" id="myButton" value="추가">
	</form>
	</div>
	
</article>

<%@ include file="../../include/admin_footer.jsp"%>