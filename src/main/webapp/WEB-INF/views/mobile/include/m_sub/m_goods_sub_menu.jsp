<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<!-- 굿즈 검색창 -->
<br>
<br>
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
<br>
<br>
<!-- 카테고리 메뉴 -->
<div class="background_white">
	<div class="goods_categoryBox">
		<table>
			<tr>
				<td><img src="/goods_images/sub_images/gs_icon_01.png"
					width="55px" onClick="location.href='m_goodsCategory?kind=1&page=1'"></td>
				<td><img src="/goods_images/sub_images/gs_icon_02.png"
					width="55px" onClick="location.href='m_goodsCategory?kind=2&page=1'"></td>
				<td><img src="/goods_images/sub_images/gs_icon_03.png"
					width="55px" onClick="location.href='m_goodsCategory?kind=3&page=1'"></td>
				<td><img src="/goods_images/sub_images/gs_icon_04.png"
					width="55px" onClick="location.href='m_goodsCategory?kind=4&page=1'"></td>
				<td><img src="/goods_images/sub_images/gs_icon_05.png"
					width="55px" onClick="location.href='m_goodsCategory?kind=5&page=1'"></td>
			</tr>
			<tr>
				<td><a href="m_goodsCategory?kind=1&page=1">문구</a></td>
				<td><a href="m_goodsCategory?kind=2&page=1">디지털</a></td>
				<td><a href="m_goodsCategory?kind=3&page=1">가방 · 파우치</a></td>
				<td><a href="m_goodsCategory?kind=4&page=1">취미용품</a></td>
				<td><a href="m_goodsCategory?kind=5&page=1">패션 · 잡화</a></td>
			</tr>
		</table>
	</div>
</div>