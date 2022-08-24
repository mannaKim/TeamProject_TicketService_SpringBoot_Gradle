<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/admin_header.jsp"%>
<article id="admin_goods">
	<h2 align="center">굿즈 배너 수정</h2>
	<form name="frm" action="editGoodsBanner">
		<input type="hidden" name="gbseq" value="${goodsBanner.gbseq}">
		<table id="goods_table2">
			<tr>
				<th>배너 이름</th>
				<td><input type="text" name="name" value="${goodsBanner.name}" size="50"></td>
			</tr>
			<tr>
				<th>배너 순서</th>
				<td>
					<select name="order_seq">
						<option value="">디스플레이 될 순서를 선택하세요</option>
						<c:forEach items="${orderList}" var="order" varStatus="status">
							<c:choose>
								<c:when test="${goodsBanner.order_seq==status.index}">
									<option value="${status.index}" selected>
										${order}
									</option>
								</c:when>
								<c:otherwise>
									<option value="${status.index}">
										${order}
									</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>배너 링크</th>
				<td><input type="text" name="link" value="${goodsBanner.link}" size="50"></td>
			</tr>
			<tr>
				<th>배너 이미지</th>
				<td>
					<input type="hidden" name="oldImage" value="${goodsBanner.image}">
					<img src='goods_images/sub_images/${goodsBanner.image}'  width='400'>
					<div>현재 이미지(수정전) : ${goodsBanner.image}</div>
					<input type="hidden" name="image" id="image" value="${goodsBanner.image}">
					<div id="filename"></div>
				</td>
			</tr>
		</table>
		<div style="margin: 0 auto; text-align: center; color: red">${message}</div>
    	<div class="goods_buttonBox">
  	  		<input type="submit" class="adminbtn" value="배너수정">
    		<input type="button" class="adminbtn" value="목록으로" onClick="location.href='adminGoodsBannerList'">
  		</div>
	</form>
	<form name="formm" id="bannerUpForm" method="post" enctype="multipart/form-data">
  		<table id="goods_table2">
  			<tr>
				<td>
					<input type="file" name="fileimage">
					<input type="button" id="goodsBannerUpload" value="배너 이미지 추가">
				</td>
			</tr>
		</table>
	</form>
</article>
<%@ include file="../../include/admin_footer.jsp"%>