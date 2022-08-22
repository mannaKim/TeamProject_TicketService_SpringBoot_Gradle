<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sub/mypage_sub_menu.jsp"%>
<article>
	<br><br><br><br><br><br><br><br>
	<div class="chkPwdBox">
		<br><br>
		<form name="frm" method="post" action="checkPwd">
			<input type="hidden" name="purpose" value="${purpose}">
			<div class="chkPwd">
				<table>
					<tr>
						<th colspan="2"><h1>비밀번호 확인</h1><br></th>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="pwd" size="15"></td>
					</tr>
				</table>
			</div>
			${message} <br>
			<input type="submit" value="확인"
				class="goodsButton1" onClick="return pwdCheck()">
		</form>
		<br><br>
	</div>
	<br><br><br><br><br><br><br><br>
</article>
<%@ include file="../include/footer.jsp"%>