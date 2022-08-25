<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>TicketService_Admin</title>
	<link href="/admin/admin.css" rel="stylesheet">
	<link href="/admin/adminGoods.css" rel="stylesheet">
	<link href="/admin/adminqna.css" rel="stylesheet">
	<script src="/script/member.js"></script>
	<script src="/admin/admin.js"></script>
	<script src="/admin/adminGoods.js"></script>
	<script src="/admin/adminqna.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script type="text/javascript">
	$(function(){
		$('#myButton').click(function(){
			var formselect = $('#fileupForm')[0];
			var formdata = new FormData(formselect);
			$.ajax({
			url:"<%=request.getContextPath()%>/fileup",
	        type : "POST",
	        enctype : "multipart/form-data",
	        async : false,
	        data : formdata,
	        timeout:10000,
	        contentType : false,
	        processData : false,
	        success : function(data){
				if(data.STATUS == 1){
					$("#filename").append("<div>"+data.FILENAME+"<div>");
					$("#image").val(data.FILENAME);
					$("#filename").append("<img src='upload/"+data.FILENAME+"' height='150'/>")
					}
				},
				error:function(){ alert("실패");
				}
			});
		});
	});
	$(function(){
		$('#goodsUploadButton').click(function(){
			var formselect = $('#goodsUpForm')[0];
			var formdata = new FormData(formselect);
			$.ajax({
			url:"<%=request.getContextPath()%>/goodsfileup",
	        type : "POST",
	        enctype : "multipart/form-data",
	        async : false,
	        data : formdata,
	        timeout:10000,
	        contentType : false,
	        processData : false,
	        success : function(data){
				if(data.STATUS == 1){
					$("#image").val(data.FILENAME);
					$("#filename").append("<img src='goods_images/"+data.FILENAME+"' width='200'/>");
					$("#filename").append("<div>"+data.FILENAME+"<div>");
					}
				},
				error:function(){ alert("실패");
				}
			});
		});
	});
	$(function(){
		$('#goodsUploadButton2').click(function(){
			var formselect = $('#goodsUpForm2')[0];
			var formdata = new FormData(formselect);
			$.ajax({
			url:"<%=request.getContextPath()%>/goodsfileup2",
	        type : "POST",
	        enctype : "multipart/form-data",
	        async : false,
	        data : formdata,
	        timeout:10000,
	        contentType : false,
	        processData : false,
	        success : function(data){
				if(data.STATUS == 1){
					$("#detail_img").val(data.FILENAME);
					$("#filename2").append("<img src='goods_images/"+data.FILENAME+"' width='200'/>");
					$("#filename2").append("<div>"+data.FILENAME+"<div>");	
					}
				},
				error:function(){ alert("실패");
				}
			});
		});
	});
	$(function(){
		$('#goodsBannerUpload').click(function(){
			var formselect = $('#bannerUpForm')[0];
			var formdata = new FormData(formselect);
			$.ajax({
			url:"<%=request.getContextPath()%>/goodsbannerup",
	        type : "POST",
	        enctype : "multipart/form-data",
	        async : false,
	        data : formdata,
	        timeout:10000,
	        contentType : false,
	        processData : false,
	        success : function(data){
				if(data.STATUS == 1){
					$("#image").val(data.FILENAME);
					$("#filename").append("<img src='goods_images/sub_images/"+data.FILENAME+"' width='400'/>");
					$("#filename").append("<div>"+data.FILENAME+"<div>");	
					}
				},
				error:function(){ alert("실패");
				}
			});
		});
	});
	</script>
</head>
<body>
	<div id="admin_wrap">
		<header id="admin_header">
		<div id="admin_topMenu">
			<div id="admin_logo">
				<a href="/">
					<img src="ticket_image/logo.png">
				</a>
			</div>
			
			<div id="admin_topicon"> <!-- LOGIN CART MYPAGE등등이 들어가는 코드 -->
			<ul>	
				<c:choose>
				  <c:when test="${empty loginUser}">
					<li><a href="loginForm">LOGIN</a></li>
				  </c:when>
				  <c:otherwise>
					<li>${loginUser.name}(${loginUser.id})관리자</li>
					<li class="admin_li"><a href="logout">LOGOUT</a></li>
					<li class="admin_li"><a href="/">사용자 페이지</a></li>
					<li class="admin_li"><a href="adminNotice">관리자 페이지</a></li>
					<li class="admin_li"><a href="adminCheck">유저목록 페이지</a></li>
				  </c:otherwise>
				</c:choose>
			</ul>
			</div>
		</div>
		<div class="clear"></div>
		<div id="admin_subMenu">
			<div id="admin_subicon">
			  <ul>
			  	<li><a href="adminNotice?page=1&key=">공지사항</a></li>
			    <li><a href="adminGoodsList?page=1&key=">굿즈관리</a></li>
			    <li><a href="adminGoodsOrderList?page=1">굿즈주문관리</a></li>
			    <li><a href="adminGoodsBannerList">굿즈배너관리</a></li>
			    <li><a href="admin_ticketList?page=1&key=">전시관리</a></li>
			    <li><a href="adminticketOrderList?page=1&key=">전시예약관리</a></li>
			   	<li><a href="adminEvent?page=1">이벤트관리</a></li>
			    <li><a href="aqnaList">Q&amp;A관리</a></li>
			    <li><a href="faqList">FAQ관리</a></li>
			  </ul>
			 </div>
		</div>
	</header>