<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../admin_header.jsp" %>
<article id="admin_goods">
  	<h2>굿즈 등록</h2>
    <form name="frm" method="post" enctype="multipart/form-data">
    	<table id="goods_table2">
			<tr>
				<th width="150px;">상품분류</th>
				<td colspan="5">
					<select name="kind">
						<option value="0">선택</option>
						<c:forEach items="${goodsKindList}" var="goodsKind" varStatus="status">
							<option value="${status.count}">
								${goodsKind}
							</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>상품명</th>
				<td colspan="5">
					<input type="text" name="name" maxlength="100" size="70">
				</td>
			</tr>
			<tr>
				<th>원가[A]</th>
				<td><input type="text" name="price1" onkeyup="calculatePrice();" size="10"></td>
				<th style="border-left:1px dotted gray;" width="150px">판매가[B]</th>
				<td><input type="text" name="price2" onkeyup="calculatePrice();" size="10"></td>
				<th style="border-left:1px dotted gray;" width="150px">[B-A]</th>
				<td><input type="text" name="price3" size="10"></td>
			</tr>
			<tr>
				<th>제품 설명</th>
				<td colspan="5">
          			<textarea name="content" rows="8" cols="70"></textarea>
        		</td>
			</tr> 
			<tr>
				<th>상품 대표이미지</th>
				<td colspan="5">
					<input type="file" name="image">
				</td>
			</tr>
			<tr>
				<th>상품 상세이미지</th>
				<td colspan="5">
					<input type="file" name="detail_img">
				</td>
			</tr>	
    	</table>
    	<div class="goods_buttonBox">
  	  		<input type="button" class="adminbtn" value="상품등록" onClick="go_goodsInsert();">
    		<input type="button" class="adminbtn" value="목록으로" onClick="location.href='ticket.do?command=adminGoodsList&page=1'">
  		</div>
  	</form>
</article>
<%@ include file="../admin_footer.jsp" %>