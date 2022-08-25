<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../../include/admin_header.jsp"%>
	<link href="adminqna.css" rel="stylesheet">
<style>
.qna_bts_a {
	width: 350px;
	height: 47px;
	margin-top: 10px;
	margin-left: 60%;
	margin-bottom: 2px;
}
.qna_bu_a {
	position: relative;
	width: 150px;
	height: 45px;
	border-radius: 5px;
	border: 1px solid #2F4F4F;
}
.qna_bu_a:hover {
	background-color: #2F4F4F;
	color: white;
}

</style>

<article id="admin_notice">
	<h2 align="center">1:1 문의 관리 </h2>
	<div class="qna_bts_a">
		<input type="button" value="답변대기" class="qna_bu_a"
			onclick="location.href='aqnaListN'">
		<input type="button" value="전체" class="qna_bu_a"
			onclick="location.href='aqnaList'">
	</div>
	<form name="formm" method="post">
		<table id="notice_table">
			<tr>	<th width="100" height="40">번호</th>
    		<th width="400" height="40">제목</th>
    		<th width="100" height="40">등록일</th>
    		<th width="100" height="40">작성자</th>
    		<th width="100" height="40">답변여부</th>
    		</tr>
			<c:forEach items="${qnaList}"  var="qnaVO">
				<tr ><td height="50"> ${qnaVO.QSEQ}</td>    
		    		<td height="50">
		    		<a href="aqnaView?qseq=${qnaVO.QSEQ}">
		    		<c:choose>
					<c:when test="${qnaVO.KIND==1}">
						[전시]
					</c:when>
					<c:when test="${qnaVO.KIND==2}">
						[회원안내]
					</c:when>
					<c:when test="${qnaVO.KIND==3}">
						[관람/예약]
					</c:when>
					<c:when test="${qnaVO.KIND==4}">
						[굿즈]
					</c:when>
					<c:otherwise>
						[기타]
					</c:otherwise>
				</c:choose>
		    		&nbsp; ${qnaVO.SUBJECT}</a>	
		    		<c:if test="${qnaVO.REPLYCNT>0}">
								<span style="color:#3CB371;font-weight:bold;">[${qnaVO.REPLYCNT}]</span>
							</c:if>
							</td>           
		       		<td height="50"><fmt:formatDate value="${qnaVO.INDATE}" type="date"/></td>
		       		<td height="50"> ${qnaVO.ID} </td>
		       		<td height="50"><c:choose>
						<c:when test="${qnaVO.REPLYCNT>0 }"> 답변완료 </c:when>
						<c:otherwise> 답변대기 </c:otherwise>
					</c:choose></td>   
		   		</tr>
		  	</c:forEach>
		</table>
	<div class="clear"></div>
	<br>
	<div id="paging" align="center"
		style="font-size: 110%; font-weight: bold;">
		<c:url var="action" value="aqnaListN" />
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