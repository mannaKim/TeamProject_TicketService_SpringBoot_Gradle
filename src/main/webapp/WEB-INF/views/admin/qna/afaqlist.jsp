<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../../include/admin_header.jsp"%>
	<link href="adminqna.css" rel="stylesheet">
<style>
.qna_bt_faq{
	width: 100%;
}
.qna_bu_he{
	margin-left: 65%;
	width: 150px;
	height: 45px;
	border-radius: 5px;
	border: 1px solid #2F4F4F;
}
.qna_bu_f {
	position: relative;
	width: 75px;
	height: 45px;
	border-radius: 5px;
	border: 1px solid #2F4F4F;
}
.qna_bu_f:hover, .qna_bu_he:hover{
background-color: #2F4F4F;
	color: white;
}
</style>

<article id="admin_notice" >
	<form name="formm" method="post">
	<h2 align="center">FAQ 관리 </h2>
	<div class="qna_bt_faq">
		<input type="button" value="추가" class="qna_bu_he"
			onclick="location.href='faqWriteForm'">
	</div>
		<table id="notice_table">
			<tr>	<th width="50" height="50">번호</th>
    		<th width="300" height="50">질문</th>
    		<th width="300" height="50">답변</th>
    		<th width="150" height="50">수정/삭제</th>
    		</tr>
			<c:forEach items="${faqList}"  var="faqVO">
				<tr ><td height="50"> ${faqVO.FAQNUM}</td>    
		    		<td height="50">
<!--     		<a href="aqnaView?qseq=${faqVO.QSEQ}"> -->		
		    		<c:choose>
					<c:when test="${faqVO.KIND==1}">
						[전시]
					</c:when>
					<c:when test="${faqVO.KIND==2}">
						[회원안내]
					</c:when>
					<c:when test="${faqVO.KIND==3}">
						[관람/예약]
					</c:when>
					<c:otherwise>
						[굿즈]
					</c:otherwise>
				</c:choose>
		    		&nbsp; ${faqVO.CON_Q}</a>	</td>
		    		<td height="50"> ${faqVO.CON_A}</td>
		    		<td height="50"> <input type="button" value="수정" class="qna_bu_f"
			onclick="location.href='faqUpdateForm?faqnum=${faqVO.FAQNUM}'">
					 <input type="button" value="삭제" class="qna_bu_f"
			onclick="location.href='faqDelete?faqnum=${faqVO.FAQNUM}'"></td>
		   		</tr>
		  	</c:forEach>
		</table>
	<div class="clear"></div>
	<br>
	<div id="paging" align="center"
		style="font-size: 110%; font-weight: bold;">
		<c:url var="action" value="faqList" />
		<c:if test="${paging.prev}">
			<a href="${action}?page=${paging.beginPage-1}">◀</a>&nbsp;
    </c:if>
		<c:forEach begin="${paging.beginPage}" end="${paging.endPage}"
			var="index">
			<c:choose>
				<c:when test="${paging.page==index}">
					<span style="color: #3CB371">${index}&nbsp;</span>
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
	<br>
	</form>

</article>
<%@ include file="../../include/admin_footer.jsp"%>
