<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sub/mypage_sub_menu.jsp"%>
<article>
	<br><br>
	<div class="chkPwdBox">
		<br>
		<form name="frm" method="post" action="Withdrawcheck">
		<input type="hidden" name="id" value="${loginUser.id}">
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
			<input type="submit" value="확인"class="goodsButton1">
		</form>
		<br>
	</div>
	<br><br>
</article>
<%@ include file="../include/footer.jsp"%>