<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/admin_header.jsp"%>
<article id="admin_goods">
  	<h2>굿즈 상세</h2>
  	<div class="goods_buttonBox">
  	  	<input type="button" class="adminbtn" value="상품수정" 
  	  		onClick="location.href='adminGoodsUpdateForm?gseq=${goodsVO.GSEQ}'">
    	<input type="button" class="adminbtn" value="상품삭제" 
    		onClick="deleteGoodsConfirm('${goodsVO.GSEQ}');">
    	<input type="button" class="adminbtn" value="목록으로" 
    		onClick="location.href='adminGoodsList?page=1'">
  	</div>
    <table id="goods_table2">
		<tr>
			<th width="150px;">상품분류</th>
			<td colspan="5">
				${goodsKind}
			</td>
		</tr>
		<tr>
			<th>상품명</th>
			<td colspan="2">
				${goodsVO.NAME}
			</td>
			<th style="border-left:1px dotted gray;">재 고</th>
			<td colspan="2">
					${goodsVO.NUM_INVENTORY}
			</td>
		</tr>
		<tr>
			<th>원가[A]</th>
			<td>${goodsVO.PRICE1}</td>
			<th style="border-left:1px dotted gray;" width="150px">판매가[B]</th>
			<td>${goodsVO.PRICE2}</td>
			<th style="border-left:1px dotted gray;" width="150px">[B-A]</th>
			<td>${goodsVO.PRICE3}</td>
		</tr>
		<tr>
			<th>제품 설명</th>
			<td colspan="5">
          		<p>${goodsVO.CONTENT}</p>
        	</td>
		</tr> 
		<tr>
			<th>상품 대표이미지</th>
			<td colspan="5">
				<img src="/goods_images/${goodsVO.IMAGE}" width="400">
			</td>
		</tr>	
		<tr>
			<th>상품 상세이미지</th>
			<td colspan="5">
				<img src="/goods_images/${goodsVO.DETAIL_IMG}" width="400">
			</td>
		</tr>
    </table>
</article>
<%@ include file="../../include/admin_footer.jsp"%>