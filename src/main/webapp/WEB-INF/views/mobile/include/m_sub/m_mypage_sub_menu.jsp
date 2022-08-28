<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<style>
.mp_art {
	margin: 160px 0 0px;
}

.mp_sub_box {
	height: 100px;
	width: 90%;
	margin: 0 auto;
}

.mp_sub_head {
	font-size: 27pt;
	font-weight: bold;
	color: #2F4F4F;
	width: 180px;
	height: 50px;
	margin: 0 auto;
}

.mp_ul {
	margin-top: 30px;
	font-size: 15px;
	font-weight: bold;
}

.mp_ul li {
	float: left;
	width: 32.5%;
	text-align: center;
}

.mp_ul li a:hover {
	color: #2F4F4F
}

.mp_hr {
	width: 80%;
	margin: 0 auto;
	margin-top: 10px;
	border: 0;
	height: 2px;
	background-color: #2F4F4F;
}
</style>
<article class="mp_art">
	<div class="mp_sub_box">
		<div class="mp_sub_head"> MY PAGE </div>
		<nav id="mp_sub_menu">
		  <ul class="mp_ul">
		    <li><a href="m_goodsCartList">장바구니</a></li>
		    <li><a href="ticketCartList?page=1">나의 관람 정보</a></li>
		    <li><a href="m_allGoodsOrderList?page=1">나의 주문 정보</a></li>
		  </ul>
		   <ul class="mp_ul">
  		    <li><a href="mqnaMy?page=1">나의 문의 내역</a></li>
		    <li><a href="MEditcheckPwd">회원정보 수정</a></li>
		    <li><a href="MWithdrawcheckPwd">회원탈퇴</a></li>
		  </ul>
		</nav>
	</div>
	<br>
	<hr class="mp_hr">
</article>