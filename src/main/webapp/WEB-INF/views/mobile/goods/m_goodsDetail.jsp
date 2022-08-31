<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
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
	<!-- 굿즈 디테일 -->
	<div class="goodsBox">
		<form method="post" name="goodsFrm">
			<input type="hidden" name="gseq" value="${goodsVO.GSEQ}">
			<div class="goodsDetail_img1">
				<img src="/goods_images/${goodsVO.IMAGE}" width="100%">
			</div>
			<div class="goodsDetail">
				<c:if test="${goodsVO.NUM_INVENTORY>0}">
					<h2>${goodsVO.NAME}</h2>
				</c:if>
				<c:if test="${goodsVO.NUM_INVENTORY==0}">
					<h2><span style="color:gray">[품절] ${goodsVO.NAME}</span></h2>
				</c:if>
				<hr>
				<table>
					<tr>
						<td width="100px">판매가 :</td>
						<td><h3>${goodsVO.PRICE2}원</h3></td>
					</tr>
					<tr>
						<td>구매 수량 :</td>
						<td>
							<button type="button" class="goodsQuantity" 
								onClick="count(-1, ${goodsVO.NUM_INVENTORY});">-</button>
							<input type="text" name="quantity" size="2" value="1" readonly>
							<button type="button" class="goodsQuantity" 
								onClick="count(1, ${goodsVO.NUM_INVENTORY});">+</button>
						</td>
					</tr>
					<c:if test="${goodsVO.NUM_INVENTORY<=20 && goodsVO.NUM_INVENTORY>1}">
						<tr>
							<td><span style="color:#3CB371">남은 수량 :</span></td>
							<td>
								<span style="color:#3CB371">${goodsVO.NUM_INVENTORY} 개</span>
							</td>
						</tr>
					</c:if>
					<c:if test="${goodsVO.NUM_INVENTORY==1}">
						<tr>
							<td colspan="2">
								<span style="color: red; font-weight: bold;">마지막 1개</span>
							</td>
						</tr>
					</c:if>
				</table>
				<div class="goodsCartButton">
					<input type="button" value="장바구니" class="goodsButton2" 
						onClick="go_Gcart(${goodsVO.NUM_INVENTORY})">
				</div>
				<div class="goodsCartButton">
					<input type="button" value="즉시구매" class="goodsButton1" 
						onClick="go_Gorder(${goodsVO.NUM_INVENTORY});">
				</div>
			</div>
		</form>
		<div class="clear"></div>
		<hr>
		<div class="clear"></div>
		<div class="goodsDetail_img2">
			<img src="/goods_images/${goodsVO.DETAIL_IMG}" width="320">
		</div>
	</div>
</article>
<%@ include file="../include/footer.jsp"%>