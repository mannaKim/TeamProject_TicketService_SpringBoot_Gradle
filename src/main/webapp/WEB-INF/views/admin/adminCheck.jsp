<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="admin_header.jsp" %>

<article id="admin_user">
<h2 align="center">관리자 유저관리 페이지</h2>
	<c:if test="${loginUser.admin == 1}">
			<table>
				<tr>
					<th width="100" height="40">아이디</th>
					<th width="60" height="40">이름</th>
					<th width="200" height="40">전화번호</th>
					<th width="170" height="40">이메일</th>
					<th width="170" height="40">가입일</th>
					<th width="100" height="40">등급</th>
					<th width="200" height="40">등급변경</th>
				<c:forEach items="${mList}" var="member">
					<tr align="center">
						<td height="50">${member.id}</td>
						<td height="50">${member.name}</td>
						<td height="50">${member.phone}</td>
						<td height="50">${member.email}</td>
						<td height="50"><fmt:formatDate value="${member.indate}" pattern="YYYY/MM/dd EEEE"></fmt:formatDate></td>
						<td height="50">
							<c:choose>
								<c:when test ="${member.admin==1}">
									관리자
								</c:when>
								<c:otherwise>
									일반사용자
								</c:otherwise>
							</c:choose>
						</td>
						<td height="40">
							<c:choose>
								<c:when test="${member.admin==1}">
									<input type="button" value="일반으로 변경" style="width:150px; height:30px;" 
									onClick="location.href='ticket.do?command=editadmin&id=${member.id}&admin=${member.admin}'"/>
								</c:when>
								<c:otherwise>
									<input type="button" value="관리자로 변경" style="width:150px; height:30px;"
									onClick="location.href='ticket.do?command=editadmin&id=${member.id}&admin=${member.admin}'"/>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
				</tr>
			</table>
	</c:if>
	<div id="adminCheck_paging">
	<!-- 여기서 value값으로 보내는 command를 paging.jsp로 보내서 action태그에 value로 전달함. -->
		<jsp:include page="/paging.jsp">
			<jsp:param name="command" value="ticket.do?command=adminCheck" />
		</jsp:include>
	</div>
</article>

<%@ include file="admin_footer.jsp" %>   