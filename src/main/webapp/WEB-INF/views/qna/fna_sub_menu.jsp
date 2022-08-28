<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<link href="/css/qna.css" rel="stylesheet">

<style>
.qna_sub_main{
	height: 200px; width: 1100px;
	margin: 0 auto;
}

.fnqkind{
	width: 800px; height: 70px;
	margin: 0 auto;
	margin-top: 50px;
}

.allkind{
	margin: 0 auto;
	list-style: none;
}

li:first-child{
	margin-left: 7px;
}

.kind {
	text-align: center;
	border: 1px solid #2F4F4F;
	width: 19.2%;
	float: left;
	cursor: pointer;
	height: 60px;
}

.kind a {
	height: 60px;
	text-decoration : none;
	text-align: center;
	vertical-align: middle;
	line-height: 60px;
	padding: 19px 26px;
}
.kind:hover, #qna_link:hover, #qna_link:active{
	 background-color: #2F4F4F;
	 color: white;
}

#qna_link:hover, #qna_link:active{
	 background-color: #2F4F4F;
	 color: white;
}

/*1:1문의 헤드*/
.qna_head {
	margin-top: 220px;
	margin-left: 200px;
	width: 100%;
	margin-bottom: 50px;
	font-size: 30px;
	color: #2F4F4F;
	/*다크 슬레이트 색상*/
}
</style>

<article>
	<div class="qna_sub_main">
	<div class="qna_head">
		<h2>FAQ</h2>
	</div>
		<div class="fnqkind">
		    <ul class="allkind">
		    <li class="kind" ><a id="qna_link" href="qnafaq">전체보기</a></li>
		    <li class="kind"><a id="qna_link" href="qnafaqK?kind=1"> &nbsp;  전시  &nbsp; </a></li>
		    <li class="kind"><a id="qna_link" href="qnafaqK?kind=2">회원안내</a></li>
		    <li class="kind"><a id="qna_link" href="qnafaqK?kind=3">관람/예약</a></li>
		    <li class="kind"><a id="qna_link" href="qnafaqK?kind=4">&nbsp;  굿즈  &nbsp; </a></li>
		    </ul>
		</div>
	</div>
</article>