<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/admin_header.jsp"%>
<article id="admin_goods">
	<h2 align="center">굿즈 배너 리스트</h2>
	<div class="goods_buttonBox2">
    	<input type="button" class="adminbtn" value="배너 등록" 
    		onClick="location.href='goodsBannerWriteForm'">
  	</div>
  	<div class="clear"></div>
	<table id="goods_orderTable">
		<tr>
			<th>번호</th>
			<th colspan="2" width="250">배너 이름</th>
			<th>순서</th>
			<th>사용유무</th>
			<th>등록일</th>
			<th>배너위치</th>
			<th>링크</th>
			<th>수정 / 삭제</th>
		</tr>
		<c:choose>
			<c:when test="${empty goodsBannerList}">
				<tr>
					<td colspan="9">등록된 배너 이미지가 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${goodsBannerList}" var="goodsBanner">
					<tr>
						<td align="center">${goodsBanner.GBSEQ}</td>
						<td>
							${goodsBanner.NAME}
						</td>
						<td>
							<img src="/goods_images/sub_images/${goodsBanner.IMAGE}" width="220px">
						</td>
						<td>
							${goodsBanner.ORDER_SEQ}
						</td>
						<td>${goodsBanner.USEYN}</td>
						<td><fmt:formatDate value="${goodsBanner.INDATE}" /></td>
						<td>
							<c:choose>
								<c:when test="${goodsBanner.MOBILE == 'n'}">
									pc 배너
								</c:when>
								<c:otherwise>
									mobile 배너
								</c:otherwise>
							</c:choose>
						</td>
						<td><a href="${goodsBanner.LINK}">${goodsBanner.LINK}</a></td>
						<td>
							<input type="button" value="수정"
								onClick="location.href='goodsBannerEditForm?gbseq=${goodsBanner.GBSEQ}'">
								/
							<input type="button" value="삭제"
								onClick="deleteGoodsBannerConfirm(${goodsBanner.GBSEQ});">
						</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
</article>
<%@ include file="../../include/admin_footer.jsp"%>