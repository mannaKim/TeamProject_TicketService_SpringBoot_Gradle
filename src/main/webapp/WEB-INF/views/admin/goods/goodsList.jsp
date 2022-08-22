<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/admin_header.jsp"%>
<article id="admin_goods">
  	<h2 align="center">굿즈 리스트</h2>
  	<br>
    <form name="frm" method="post">
    	<table id="search_table">
	    	<tr>
	    		<td><a href="#" onClick="go_totalGoodsList();">전체보기</a></td>
	    		<td><a href="#" onClick="go_goodsCategory('1');">문구</a></td>
	    		<td><a href="#" onClick="go_goodsCategory('2');">디지털</a></td>
	    		<td><a href="#" onClick="go_goodsCategory('3');">가방 · 파우치</a></td>
	    		<td><a href="#" onClick="go_goodsCategory('4');">취미용품</a></td>
	    		<td><a href="#" onClick="go_goodsCategory('5');">패션 · 잡화</a></td>
	    	</tr>
      		<tr>
        		<td colspan="5">
          			<input type="text" name="key" value="${key}" size="25">
          			<input type="button" class="adminbtn" value="검색" onClick="go_searchGoodsList();">
        		</td>
        		<td>
        			<input type="button" class="adminbtn" value="상품등록" onClick="go_goodsInsertForm();">
        		</td>
      		</tr>
      	</table>
  	</form>
  	<c:choose>
  		<c:when test="${empty goodsList}">
  			<table id="goods_table">
  				<tr>
  					<td>'${key}'에 대한 검색 결과가 없습니다.</td>
  				</tr>
  			</table>
  		</c:when>
  		<c:otherwise>
  			<table id="goods_table">
		  		<tr>
		  			<th width="80">번호</th>
		  			<th width="100">분류</th>
		  			<th colspan="2">상품명</th>
		      		<th width="100">등록일</th>
		      		<th width="100">재고</th>
		      		<th width="100">판매유무</th>
		      	</tr>
		    	<c:forEach items="${goodsList}" var="gvo">
		      		<tr>
		        		<td align="center">${gvo.GSEQ}</td>
		        		<td>${goodsKindList[gvo.KIND]}</td>
		        		<td width="150">
		          			<a href="#" onClick="go_goodsDetail('${gvo.GSEQ}');">
		          				<img src="/goods_images/${gvo.IMAGE}" width="100px">
		          			</a>
		        		</td>
		        		<td>
		          			<a href="#" onClick="go_goodsDetail('${gvo.GSEQ}');">${gvo.NAME}</a>
		        		</td>
		        		<td><fmt:formatDate value="${gvo.INDATE}"/></td>
		        		<td>
		        			<c:choose>
		        				<c:when test='${gvo.NUM_INVENTORY==0}'>
		        					<span style="color: red;">${gvo.NUM_INVENTORY}</span>
		        				</c:when>
					            <c:otherwise>${gvo.NUM_INVENTORY}</c:otherwise>
					        </c:choose>
		        		</td>
		        		<td>
		        			<c:choose>
		        				<c:when test='${gvo.USEYN=="n"}'>판매중지</c:when>
					            <c:otherwise>판매중</c:otherwise>
					        </c:choose>
		        		</td>
		      		</tr>
		    	</c:forEach>
		  	</table>
  		</c:otherwise>
  	</c:choose>
  	<br><br>
   	<c:choose>
  		<c:when test="${empty kind}">
  			<jsp:include page="../../include/paging/paging.jsp">
				<jsp:param value="adminGoodsList" name="command" />
			</jsp:include>
  		</c:when>
  		<c:otherwise>
  			<jsp:include page="../../include/paging/goods_paging.jsp">
				<jsp:param value="adminGoodsList?kind=${kind}" name="command" />
			</jsp:include>
  		</c:otherwise>
  	</c:choose>
</article>
<%@ include file="../../include/admin_footer.jsp"%>