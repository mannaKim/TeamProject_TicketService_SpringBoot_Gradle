<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../admin_header.jsp" %>
<article id="admin_goods">
  	<h2>굿즈 상세</h2>
  	<div class="goods_buttonBox">
  	  	<input type="button" class="adminbtn" value="상품수정" onClick="go_goodsModifyForm('${gvo.gseq}');">
    	<input type="button" class="adminbtn" value="목록으로" onClick="location.href='ticket.do?command=adminGoodsList&page=1'">
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
			<td colspan="5">
				${gvo.name}
			</td>
		</tr>
		<tr>
			<th>원가[A]</th>
			<td>${gvo.price1}</td>
			<th style="border-left:1px dotted gray;" width="150px">판매가[B]</th>
			<td>${gvo.price2}</td>
			<th style="border-left:1px dotted gray;" width="150px">[B-A]</th>
			<td>${gvo.price3}</td>
		</tr>
		<tr>
			<th>제품 설명</th>
			<td colspan="5">
          		<p>${gvo.content}</p>
        	</td>
		</tr> 
		<tr>
			<th>상품 대표이미지</th>
			<td colspan="5">
				<img src="goods/goods_images/${gvo.image}" width="400">
			</td>
		</tr>	
		<tr>
		<th>상품 상세이미지</th>
			<td colspan="5">
				<img src="goods/goods_images/${gvo.detail_img}" width="400">
			</td>
			</tr>
    </table>
</article>
<%@ include file="../admin_footer.jsp" %>