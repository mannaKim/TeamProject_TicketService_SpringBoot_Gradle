<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<article class="mp_art">
	<div class="mp_sub_box">
		<div class="mp_sub_head"> MY PAGE </div>
		<nav id="mp_sub_menu">
		  <ul class="mp_ul">
		    <li><a href="goodsCartList">장바구니</a></li>
		    <li><a href="ticketCartList?page=1">나의 관람 정보</a></li>
		    <li><a href="allGoodsOrderList?page=1">나의 주문 정보</a></li>
		    <li><a href="qnaMy?page=1">나의 문의 내역</a></li>
		    <li><a href="#" onClick="checkPwd('modifyMemberForm');">회원정보 수정</a></li>
		    <li><a href="#" onClick="checkPwd('withdrawalForm');">회원탈퇴</a></li>
		  </ul>
		</nav>
	</div>
	<br>
	<hr class="mp_hr">
</article>