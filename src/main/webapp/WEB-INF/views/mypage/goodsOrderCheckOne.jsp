<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<article class="mp_art">
	<div class="mp_sub_head">주문서</div>
</article>
<article>
	<form action="goodsOrderInsertOne" method="post" name="goodsFrm">
		<input type="hidden" name="gseq" value="${goodsVO.GSEQ}">
		<input type="hidden" name="quantity" value="${quantity}">
		<div class="goodsBox">
			<div class="goodsCart">
				<br>
				<br>
				<table id="orderCheck">
					<tr>
						<th>주문자</th>
						<th>수령인</th>
						<th>휴대폰</th>
					</tr>
					<tr>
						<td>${loginUser.name}(${loginUser.id})</td>
						<td><input type="text" name="name" value="${loginUser.name}">
						</td>
						<td><input type="text" name="phone"
							value="${loginUser.phone}"></td>
					</tr>
					<tr>
						<th colspan="3">주소지</th>
					</tr>
					<tr>
						<td align="center" colspan="3">
							<input type="text" id="sample6_postcode" placeholder="우편번호"
							name="zip_num" value="${loginUser.zip_num}" size="50" readonly> <input
							type="button" onclick="sample6_execDaumPostcode()"
							class="goodsButton3" id="find_zip_num" value="우편번호 찾기"> <br> <input
							type="text" id="sample6_address" placeholder="주소" name="address1"
							value="${loginUser.address1}" size="50" readonly> <br> <input
							type="text" id="sample6_detailAddress" placeholder="상세주소"
							name="address2" value="${loginUser.address2}" size="50"> <br> <input
							type="text" id="sample6_extraAddress" placeholder="참고항목"
							name="address3" value="${loginUser.address3}" size="50" readonly>
							<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
							<script>
									function sample6_execDaumPostcode() {
										new daum.Postcode(
												{
													oncomplete : function(data) {
														// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
														// 각 주소의 노출 규칙에 따라 주소를 조합한다.
														// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
														var addr = ''; // 주소 변수
														var extraAddr = ''; // 참고항목 변수
	
														//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
														if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
															addr = data.roadAddress;
														} else { // 사용자가 지번 주소를 선택했을 경우(J)
															addr = data.jibunAddress;
														}
	
														// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
														if (data.userSelectedType === 'R') {
															// 법정동명이 있을 경우 추가한다. (법정리는 제외)
															// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
															if (data.bname !== ''
																	&& /[동|로|가]$/g
																			.test(data.bname)) {
																extraAddr += data.bname;
															}
															// 건물명이 있고, 공동주택일 경우 추가한다.
															if (data.buildingName !== ''
																	&& data.apartment === 'Y') {
																extraAddr += (extraAddr !== '' ? ', '
																		+ data.buildingName
																		: data.buildingName);
															}
															// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
															if (extraAddr !== '') {
																extraAddr = ' ('
																		+ extraAddr
																		+ ')';
															}
															// 조합된 참고항목을 해당 필드에 넣는다.
															document
																	.getElementById("sample6_extraAddress").value = extraAddr;
	
														} else {
															document
																	.getElementById("sample6_extraAddress").value = '';
														}
	
														// 우편번호와 주소 정보를 해당 필드에 넣는다.
														document
																.getElementById('sample6_postcode').value = data.zonecode;
														document
																.getElementById("sample6_address").value = addr;
														// 커서를 상세주소 필드로 이동한다.
														document
																.getElementById(
																		"sample6_detailAddress")
																.focus();
													}
												}).open();
									}
								</script></td>
					</tr>
				</table>
				<br>
				<table id="orderCheck">
					<tr>
						<th colspan="2">상품명</th>
						<th>수량</th>
						<th>가격</th>
					</tr>
					<tr>
						<td width="300px"><a href="goodsDetail?gseq=${goodsVO.GSEQ}">
								<img src="/goods_images/${goodsVO.IMAGE}">
						</a></td>
						<td><a href="goodsDetail?gseq=${goodsVO.GSEQ}">
								${goodsVO.NAME} </a></td>
						<td>${quantity}</td>
						<td><fmt:formatNumber value="${totalPrice}" type="currency" /></td>
					</tr>
				</table>
				<br>
				<table id="orderCheck">
					<tr>
						<th>결제 방법</th>
					</tr>
					<tr>
						<td>
							<br>
							<div class="toggle">
							    <input type="radio" id="toggle3-1" name="payment" value="0">
							    <label for="toggle3-1">&nbsp;&nbsp;&nbsp;신용카드&nbsp;&nbsp;&nbsp; </label>
							    <input type="radio" id="toggle3-2" name="payment" value="1">
							    <label for="toggle3-2">&nbsp;&nbsp;&nbsp;휴대폰결제&nbsp;&nbsp;&nbsp;</label>
							    <input type="radio" id="toggle3-3" name="payment" value="2">
							    <label for="toggle3-3">&nbsp;&nbsp;&nbsp;계좌이체&nbsp;&nbsp;&nbsp;</label>
							    <input type="radio" id="toggle3-4" name="payment" value="3">
							    <label for="toggle3-4">&nbsp;&nbsp;&nbsp;가상계좌&nbsp;&nbsp;&nbsp;</label>
							</div> 
							<br>   
						</td>
					</tr>
				</table>
				<br>
				<table id="orderCheck">
					<tr>
						<th>최종 결제 금액</th>
					</tr>
					<tr>
						<td><fmt:formatNumber value="${totalPrice}" type="currency" /></td>
					</tr>
				</table>
				<br>
				<table id="orderCheck">
					<tr>
						<th>품절 시 환불 방법</th>
					</tr>
					<tr>
						<td>선택하신 결제 방법으로 환불해 드립니다.<br>낮은 확률로 상품이 품절일 가능성이 있습니다. 이에 품절 시
							빠르게 환불 처리해드립니다.<br>현금 환불의 경우, 예금정보가 일치해야 환불 처리가 가능합니다. 은행명, 계좌번호,
							예금주명을 정확히 기재 부탁드립니다.<br>환불받으신 날짜 기준으로 3~5일(주말 제외) 후 결제대행사에서 직접 고객님의
							계좌로 환불 처리됩니다.</td>
					</tr>
				</table>
				<br>
				<div style="text-align:center;">
					<span style="color:#3CB371">회원 본인은 구매 조건, 주문 내용 확인 및 결제에 동의합니다.</span>
					<span style="color:red">${message}</span>
				</div>
				<div class="goodsCartButton" id="orderCheckButton">
					<input type="button" value="취소" class="goodsButton2"
						onClick="location.href='goodsDetail?gseq=${goodsVO.GSEQ}'">
					<input type="submit" value="주문하기" class="goodsButton1">
				</div>
			</div>
		</div>
	</form>
	<br>
	<br>
</article>
<%@ include file="../include/footer.jsp"%>