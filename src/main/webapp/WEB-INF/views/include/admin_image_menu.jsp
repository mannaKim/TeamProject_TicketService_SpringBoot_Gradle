<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">

<div id="sub_img">
  
</div>
<div class="clear"></div>

<nav id="sub_menu">
  <ul>
  	<!-- 서브메뉴를 클릭하면 무조건 page가 1이도록 파라미터 전달 -->
    <li><a href="ticket.do?command=adminGoodsList&page=1">굿즈관리</a></li>
    <li><a href="ticket.do?command=adminGoodsOrderList&page=1">굿즈주문관리</a></li>
    <li><a href="ticket.do?command=admin_ticketList">전시예약관리</a></li>
    <li><a href="ticket.do?command=adminNotice">공지사항</a></li>
    <li><a href="ticket.do?command=adminEvent">이벤트관리</a></li>
    <li><a href="ticket.do?command=aqna">Qna관리</a></li>
  </ul>
</nav>