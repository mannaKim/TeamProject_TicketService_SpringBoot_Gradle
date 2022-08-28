<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../include/header.jsp"%>
<%@ include file="../include/sub/sub_image_menu.jsp"%>
<article>
<br><br>
        <div class="wdBox">
            <div class="wdBox1">
                <h3>회원님의 정보 내역을 확인해 주세요.</h3>
                <p>회원탈퇴 후 모두 소멸됩니다.</p>
                <ul>
                    <li>이름 : <span>${member.name}</span></li>
                    <li>진행중인 주문 : <span style="color: red;">${orderNum}</span>건
                        &nbsp; <a href="allGoodsOrderList">> 내역확인</a>
                    </li>
                </ul>
            </div>
            <br>
            <div class="wdBox2">
                <h3>어떤 점이 불편하셨나요?</h3>
                <p>고객님의 의견을 반영하여 더 좋은 모습으로 찾아 뵙기 위해 노력하겠습니다.</p>
                <div>
                    <ul>
                        <li>
                            <label>상품정보 부족</label><input type='radio' value='11'>
                        </li>
                        <li>
                            <label>상품가격 불만</label><input type='radio' value='11'>
                        </li>
                        <li>
                            <label>교환/환불/반품 불만</label><input type='radio' value='11'>
                        </li>
                        <li>
                            <label>상품 및 콘텐츠 검색 불편</label><input type='radio' value='11'>
                        </li>
                        <li>
                            <label>시스템 오류</label><input type='radio' value='11'>
                        </li>
                        <li>
                            <label>사이트 불편</label><input type='radio' value='11'>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="clear"></div>
            <br>
            <input type="button" value="회원탈퇴" class="goodsButton2" onClick="withdrawalConfirm('${loginUser.id}')">
        </div>
        <br><br>
    </article>
<%@ include file="../include/footer.jsp"%>