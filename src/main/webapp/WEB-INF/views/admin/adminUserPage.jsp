<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/admin_header.jsp"%>

<article id="admin_user">
<h2 align="center">관리자 유저관리 페이지</h2>
	<c:if test="${loginUser.admin == 1}">
			<table>
				<tr>
					<th width="60" height="40">아이디</th>
					<th width="60" height="40">이름</th>
					<th width="180" height="40">전화번호</th>
					<th width="160" height="40">이메일</th>
					<th width="130" height="40">가입일</th>
					<th width="60" height="40">포인트</th>
					<th width="80" height="40">등급</th>
					<th width="200" height="40">등급변경</th>
				<c:forEach items="${UserPage}" var="member">
					<tr align="center">
						<td height="50">${member.ID}</td>
						<td height="50">${member.NAME}</td>
						<td height="50">${member.PHONE}</td>
						<td height="50">${member.EMAIL}</td>
						<td height="50"><fmt:formatDate value="${member.INDATE}" pattern="yy/MM/dd (E)"></fmt:formatDate></td>
						<td height="50"><fmt:formatNumber value="${member.MPOINT}" type="number"></fmt:formatNumber></td>
						<td height="50">
							<c:choose>
								<c:when test ="${member.ADMIN==1}">
									관리자
								</c:when>
								<c:otherwise>
									유저
								</c:otherwise>
							</c:choose>
						</td>
						<td height="40">
							<input type="button" value="수정" style="width:50px; height:30px;" onClick="UserUpdate('${member.ID}');">
							<c:choose>
								<c:when test="${member.ADMIN==1}">
									<input type="button" value="일반 변경" style="width:100px; height:30px;" 
									onClick="location.href='editadmin?id=${member.ID}&admin=${member.ADMIN}'"/>
								</c:when>
								<c:otherwise>
									<input type="button" value="관리자 변경" style="width:100px; height:30px;"
									onClick="location.href='editadmin?id=${member.ID}&admin=${member.ADMIN}'"/>
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
		<div id="paging" align="center"
		style="font-size: 110%; font-weight: bold;">
		<c:url var="action" value="adminCheck" />
		<c:if test="${paging.prev}">
			<a href="${action}?page=${paging.beginPage-1}">◀</a>&nbsp;
    </c:if>
		<c:forEach begin="${paging.beginPage}" end="${paging.endPage}"
			var="index">
			<c:choose>
				<c:when test="${paging.page==index}">
					<span style="color:#3CB371">${index}&nbsp;</span>
				</c:when>
				<c:otherwise>
					<a href="${action}?page=${index}&key=${key}">${index}</a>&nbsp;
        </c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.next}">
			<a href="${action}?page=${paging.endPage+1}">▶</a>&nbsp;
    </c:if>
	</div>
	</div>
</article>

<%@ include file="../include/admin_footer.jsp" %> 