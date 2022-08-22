<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/admin_header.jsp"%>
<article id="adminEvent_Update">
	<h2 align="center">이벤트 수정</h2>
	<form name="frm" method="post" action="updateAdminEvent">
		<input type="hidden" name="evnum" value="${event.evnum}">
		<input type="hidden" name="id" value="${event.id}">
		<table>
			<tr>
				<th style="width:150px; height:40px;">이벤트제목</th>
				<td><input type="text" name="title" value="${event.title}" size="60" style="width:400px; height:25px; font-size:16px;"></td>
			</tr>
			<tr>
				<th style="width:150px; height:40px;">이벤트 기간</th>
				<td><input type="text" name="evdate" value="${event.evdate}" size="60" style="width:400px; height:25px; font-size:16px;">(형식 : yy/mm/dd로 입력하세요.)</td>
			</tr>
			<tr>
				<th style="width:150px; height:40px;">당첨자 발표일</th>
				<td><input type="text" name="evperson" value="${event.evperson}" size="60" style="width:400px; height:25px; font-size:16px;">(형식 : yy/mm/dd로 입력하세요.)</td>
			</tr>
			<tr>
				<th style="width:150px; height:40px;">배너사진</th>
				<td>
					<input type="button" value="배너이미지 선택" onClick="eventimg1();">
					<div id="evimage1" style="float:left;"></div>
					<div><input type="hidden" name="eimage"></div>
					<img src="" id="previewimg1" width="150" style="display:none"/>
					<input type="hidden" name="oldPicture1" value="${event.eimage}">
				</td>
			</tr>
			<tr>
				<th style="width:150px; height:40px;">메인사진</th>
				<td>
					<input type="button" value="메인이미지 선택" onClick="eventimg2();">
					<div id="evimage2" style="float:left;"></div>
					<div><input type="hidden" name="eimage2"></div>
					<img src="" id="previewimg2" width="150" style="display:none"/>
					<input type="hidden" name="oldPicture2" value="${event.eimage2}">
				</td>
			</tr>
		</table><br>
		<div id="adminEventUp_btn">
			<input type="submit" class="adminbtn" value="수정" style="width:70px; height:30px;">
			<input type="reset" class="adminbtn" value="다시작성" style="width:100px; height:30px;">
			<input type="button" class="adminbtn" value="목록" onClick="location.href='adminEvent'" style="width:70px; height:30px;">
		</div>
	</form>
</article>
<%@ include file="../../include/admin_footer.jsp"%>