<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<script src="/script/mobile/mobilebanner.js"></script>
<article class="underHeader">
	<!-- 굿즈 검색창 -->
	<br><br>
	<div class="goods_subMenu">
		<form class="goods_searchBox" method="post" name="frm" action="m_goodsSearch?page=1">
			<div class="goods_search">
				<input type="text" name="key" value="${key}" size="45">
			</div>
			<div class="goods_searchBtn">
				<input type="submit" value="">
			</div>
		</form>
	</div>
	<br><br>
	<!-- 슬라이드 배너 -->
	<div class="background_white">
		<div id="slide_banner">
			<div id="banner_imgs">
				<c:forEach items="${goodsBannerList}" var="banner"><a href='${banner.LINK}'><img class='b_img' src='/goods_images/sub_images/${banner.IMAGE}'></a></c:forEach>
			</div>
			<div id="goods_remot">
				<ul>
					<li onClick="moveNum(0)"></li>
					<li onClick="moveNum(1)"></li>
					<li onClick="moveNum(2)"></li>
					<li onClick="moveNum(3)"></li>
				</ul>
			</div>
			<div id="goods_lbutton" onClick="moveLeft();"></div>
			<div id="goods_rbutton" onClick="moveRight();"></div>
		</div>
	</div>
	<!-- 베스트 상품 -->
	<div class="background_white">
		<div class="goodsBox">
			<div class="goodsBox_main">
				<h2>Best-Seller</h2>
				<c:forEach items="${bestGoodsList}" var="gvo">
					<div class="goods">
						<a href="m_goodsDetail?gseq=${gvo.GSEQ}">
							<img src="/goods_images/${gvo.IMAGE}">
							<c:choose>
								<c:when test="${gvo.NUM_INVENTORY==0}">
									<del>
										<p>[품절] ${gvo.NAME}</p>
									</del>
								</c:when>
								<c:otherwise>
									<p>${gvo.NAME}</p> 
								</c:otherwise>
							</c:choose>
						</a>
						<h3>
							<fmt:formatNumber value="${gvo.PRICE2}" type="currency" />
						</h3>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<div class="clear"></div>
	<!-- 카테고리 메뉴 -->
	<div class="goods_categoryBox">
		<table>
			<tr>
				<td><img src="/goods_images/sub_images/gs_icon_01.png"
					width="55px"
					onClick="location.href='m_goodsCategory?kind=1&page=1'"></td>
				<td><img src="/goods_images/sub_images/gs_icon_02.png"
					width="55px"
					onClick="location.href='m_goodsCategory?kind=2&page=1'"></td>
				<td><img src="/goods_images/sub_images/gs_icon_03.png"
					width="55px"
					onClick="location.href='m_goodsCategory?kind=3&page=1'"></td>
				<td><img src="/goods_images/sub_images/gs_icon_04.png"
					width="55px"
					onClick="location.href='m_goodsCategory?kind=4&page=1'"></td>
				<td><img src="/goods_images/sub_images/gs_icon_05.png"
					width="55px"
					onClick="location.href='m_goodsCategory?kind=5&page=1'"></td>
			</tr>
			<tr>
				<td><a href="m_goodsCategory?kind=1&page=1">문구</a></td>
				<td><a href="m_goodsCategory?kind=2&page=1">디지털</a></td>
				<td><a href="m_goodsCategory?kind=3&page=1">가방 ·
						파우치</a></td>
				<td><a href="m_goodsCategory?kind=4&page=1">취미용품</a></td>
				<td><a href="m_goodsCategory?kind=5&page=1">패션 ·
						잡화</a></td>
			</tr>
		</table>
	</div>
	<!-- 신상품 -->
	<div class="background_white">
		<div class="goodsBox">
			<div class="goodsBox_main">
				<h2>MD's Pick</h2>
				<c:forEach items="${newGoodsList}" var="gvo">
					<div class="goods">
						<a href="m_goodsDetail?gseq=${gvo.GSEQ}"> <img
							src="/goods_images/${gvo.IMAGE}">
							<c:choose>
								<c:when test="${gvo.NUM_INVENTORY==0}">
									<del>
										<p>[품절] ${gvo.NAME}</p>
									</del>
								</c:when>
								<c:otherwise>
									<p>${gvo.NAME}</p> 
								</c:otherwise>
							</c:choose>
						</a>
						<h3>
							<fmt:formatNumber value="${gvo.PRICE2}" type="currency" />
						</h3>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</article>
<%@ include file="../include/footer.jsp"%>