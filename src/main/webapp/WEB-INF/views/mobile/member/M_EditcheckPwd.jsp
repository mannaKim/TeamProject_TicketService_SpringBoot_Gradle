<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ include file="../include/header.jsp"%>
<%@ include file="../include/m_sub/m_mypage_sub_menu.jsp"%>
<article id="chkPwdBox">
	<br><br>
	<div class="chkPwdBox">
		<br>
		<form name="frm" method="post" action="MEditcheck">
		<input type="hidden" name="id" value="${loginUser.id}">
			<div class="chkPwd">
				<table>
					<tr>
						<th colspan="2"><h1>비밀번호 확인</h1><br></th>
					</tr>
					<tr>
						<td><h3>비밀번호</h3></td>
						<td><input type="password" name="pwd" size="15" class="m_chkPwdBox"></td>
					</tr>
				</table>
			</div>
			${message} <br>
			<input type="submit" value="확인" class="goodsButton1">
		</form>
		<br>
	</div>
</article>
<%@ include file="../include/footer.jsp"%>