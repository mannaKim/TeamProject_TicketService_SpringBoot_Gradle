<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp" %>
		<main>
            <div id="page01" class="page">
                <div id="ticketbox">
                    <div id="ticketimage">
                    	<div id="imgbox">
                    		<c:forEach items="${ticketList}" var="ticketListVO">	
									<a href="ticketingList">
										<img src="ticket_image/${ticketListVO.IMAGE}"/>
									</a>
                        	</c:forEach>
                        </div>
                        <div id="remot">▶</div>
                        <div id="lbutton">←</div>
                        <div id="rbutton">→</div>
                        <div id="currentNum">1/5</div>
                    </div>
                </div>
            </div>
	
			<div id="page02" class="page">
				<div id="tickettitle">
                        <div id="ticketname">
                           <a href="ticketingList">예매하러가기</a>
                        </div>
                  </div>
			</div>
            <div id="page03" class="page">
                <div id="goodsbox">
                	<div id="slide_banner">
						<div id="banner_imgs">
							<c:forEach items="${goodsBannerList}" var="banner"><a href='${banner.LINK}'><img class='b_img' src='/goods_images/sub_images/${banner.IMAGE}'></a></c:forEach>
						</div>
						<div id="goods_remot">
							<ul>
								<li onClick="moveNum(0)"></li>
								<li onClick="moveNum(1)"></li>
								<li onClick="moveNum(2)"></li>
								<li onClick="moveNum(3)"></li>
							</ul>
						</div>
						<div id="goods_lbutton" onClick="moveLeft();"
							style="background-image: url(/goods_images/sub_images/left.png);"></div>
						<div id="goods_rbutton" onClick="moveRight();"
							style="background-image: url(/goods_images/sub_images/right.png);"></div>
					</div>
                </div>
            </div>

            <div id="page04" class="page">
                <div id="qnabox">
                    <div id="topqna">
                        <div id="qnaname">문의하기</div>
                    </div>
                    <div id="botqna">
                        <div id="qnatext">
                        	<a href="qna">이동하기</a>
                        </div>
                    </div>
                </div>
            </div>
        </main>

<%@ include file="include/footer.jsp" %>