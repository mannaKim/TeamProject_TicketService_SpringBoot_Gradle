<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>TicketService</title>
	<script src="ticketing/ticketing.js"></script>
	<link href="css/ticket.css" rel="stylesheet">
	<link href="css/ticketingbtn.css" rel="stylesheet">
	<script src="member/member.js"></script>
</head>
<body>
	<div id="wrap">	<!-- wrap : 페이지 전체를 감싸는 div의 css 아이디 --> 
		<header>
			<!-- 로고 -->
			<div id="logo">
				<a href="ticket.do?command=index">
					로고<!-- 로고 이미지가 들어갈 자리 -->
				</a>
			</div>
		
			<!-- 로그인, 마이페이지 -->
			<nav id="user_menu">
				<ul>
					<c:choose>
						<c:when test="${empty loginUser}">
							<li><a href="#" onClick="go_login();">MyPage</a></li>
							<!-- MyPage는 추후 이미지로 변경 -->
						</c:when>
						<c:otherwise>
							<li>${loginUser.name}(${loginUser.id})</li>
							<li><a href="ticket.do?command=logout">LOGOUT</a></li>
							<li><a href="ticket.do?command=myPage">MyPage</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</nav>
			
			
			<!-- 상단 메뉴 -->
			<nav id="top_menu">
				<ul>
					<li><a href="ticket.do?command=introduce">전시소개</a></li>
					<li><a href="ticket.do?command=ticketingList">전시예약</a></li>
					<!-- <li><a href="ticket.do?command=">전시후기</a></li> -->
					<li><a href="ticket.do?command=goodsMain">굿즈</a></li>
					<li><a href="ticket.do?command=">Q &amp; A</a></li>
				</ul>
			</nav>	
		</header>
	
