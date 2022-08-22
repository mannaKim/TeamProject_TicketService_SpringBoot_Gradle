<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sub/mypage_sub_menu.jsp"%>
<link href="/css/member.css" rel="stylesheet">
<article style="margin:0 auto;">
	<br>
  	<form method="post" name="joinFrm" id="joinFrm">
		<fieldset id="join_fild" style="margin-left:55px">
			<div id="join_login">
				<div id="join_id" class="join">
					<h3>아이디</h3>
					<input type="text" name="id" value="${loginUser.id}" size="12"readonly style="width:370px; height:35px; font-size:18px;">
				</div>
				<div id="join_pass" class="join">
					<h3>비밀번호</h3>
					<input type="password" name="pwd" style="width:370px; height:35px; font-size:18px; margin-bottom:20px;">
					<h3>비밀번호 확인</h3>
					<input type="password" name="pwdCheck" style="width:370px; height:35px; font-size:18px;">
				</div>
			</div>
			<div id="join_person">
				<div id="join_name" class="join">
					<h3>이름</h3>
					<input type="text" name="name" value="${loginUser.name}" style="width:370px; height:35px; font-size:18px;">
				</div>
				<div id="join_phone" class="join">
					<h3>전화번호</h3>
					<input type="text" name="phone" value="${loginUser.phone}" style="width:370px; height:35px; font-size:18px;">
				</div>
				<div id="join_email" class="join">
					<h3>E-Mail</h3>
					<input type="text" name="email" value="${loginUser.email}" style="width:370px; height:35px; font-size:18px; margin-bottom:20px;">
				</div>
			</div>
			<div id="join_address">
	      		<h3>주소</h3>
	      		<input type="text" name="zip_num" value="${loginUser.zip_num}" size="10" style="width:370px; height:35px; font-size:18px; margin-bottom:20px;">
	      		<input type="button" value="주소 찾기" class="join_checkbox" onclick="find_address();">
	      		<h3>상세주소</h3>
	      		<input type="text" name="address1" value="${loginUser.address1}" size="50" style="width:370px; height:35px; font-size:18px;">
	      		<input type="text" name="address2" value="${loginUser.address2}" size="25" style="width:370px; height:35px; font-size:18px; margin-top:7px;">
      		</div>
      		<div id="join_buttons">
      			<input type="reset" class="goodsButton2" value="다시작성" style="width:175px;">
    			<input type="button" class="goodsButton1" value="수정" onClick="go_modify();" style="width:175px;">
    		</div>
    	</fieldset>
  	</form>
</article>
<%@ include file="../include/footer.jsp"%>