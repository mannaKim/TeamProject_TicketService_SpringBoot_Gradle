<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/admin_header.jsp"%>
 <article id="adminEvent_Write">
<h2 align="center">이벤트 등록</h2>
	<form name="frm" method="post" action="eventWrite">
		<table>
			<tr>
				<th style="width:150px; height:40px;">작성자</th>
				<td>${loginUser.id}<input type="hidden" name="id" value="${loginUser.id}"></td>
			</tr>
			<tr>
				<th style="width:150px; height:40px;">이벤트명</th>
				<td><input type="text" name="title" size="60" style="width:400px; height:25px; font-size:16px;"></td>
			</tr>
			<tr>
				<th style="width:150px; height:40px;">이벤트기간</th>
				<td><input type="text" name="evdate" size="60" style="width:400px; height:25px; font-size:16px;"></td>
			</tr>
			<tr>
				<th style="width:150px; height:40px;">당첨자발표일</th>
				<td><input type="text" name="evperson" size="60" style="width:400px; height:25px; font-size:16px;"></td>
			</tr>
			<tr>
				<th style="width:150px; height:40px;">배너이미지</th>
				<td>
					<input type="button" value="배너이미지 선택" onClick="eventimg1();">
					<div id="evimage1" style="float:left;"></div>
					<div><input type="hidden" name="eimage"></div>
					<img src="" id="previewimg1" width="150" style="display:none"/>
				</td>
			</tr>
			<tr>
				<th style="width:150px; height:40px;">메인이미지</th>
				<td>
					<input type="button" value="메인이미지 선택" onClick="eventimg2();">
					<div id="evimage2" style="float:left;"></div>
					<div><input type="hidden" name="eimage2"></div>
					<img src="" id="previewimg2" width="150" style="display:none"/>
				</td>
			</tr>
		</table><br>
		${message}
		<div id="adminEventWt_btn">
			<input type="submit" class="adminbtn" value="등록" style="width:70px; height:30px;">
			<input type="button" class="adminbtn" value="돌아가기" onClick="location.href='adminEvent'" style="width:100px; height:30px;">
		</div>	
	</form>
</article>   
    
<%@ include file="../../include/admin_footer.jsp"%>