<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/m_sub/m_mypage_sub_menu.jsp"%>
<article id="join_box">
  	<form method="post" name="joinFrm" id="joinFrm" action="MEditMember">
		<fieldset id="join_fild" style="border:none;">
			<div id="join_login">
				<div id="join_id" class="join">
					<h3>아이디</h3>
					<input type="text" name="id" value="${member.id}" size="12" readonly class="join_input">
				</div>
				<div id="join_pass" class="join">
					<h3>비밀번호</h3>
					<input type="password" name="pwd" class="join_input" style="margin-bottom:20px;">
					<h3>비밀번호 확인</h3>
					<input type="password" name="pwd_check" class="join_input">
				</div>
			</div>
			<div id="join_person">
				<div id="join_name" class="join">
					<h3>이름</h3>
					<input type="text" name="name" value="${member.name}" class="join_input">
				</div>
				<div id="join_phone" class="join">
					<h3>전화번호</h3>
					<input type="text" name="phone" value="${member.phone}" class="join_input">
				</div>
				<div id="join_email" class="join">
					<h3>E-Mail</h3>
					<input type="text" name="email" value="${member.email}" class="join_input" style="margin-bottom:20px;">
				</div>
			</div>
			<div id="join_address">
	      		<h3>주소</h3>
	      		<input type="text" name="zip_num" size="10" id="sample6_postcode" value="${member.zip_num}" readonly class="join_input" style="margin-bottom:20px;">
	      		<input type="button" value="주소 찾기" class="join_checkbox" onclick="sample6_execDaumPostcode()">
	      		<h3>상세주소</h3>
	      		<input type="text" name="address1" size="50" id="sample6_address" value="${member.address1}" readonly class="join_input">
	      		<input type="text" name="address2" size="30" id="sample6_detailAddress" value="${member.address2}" class="join_input" style="margin-top:7px;">
	      		<input type="text" name="address3" size="30" id="sample6_extraAddress" value="${member.address3}" readonly class="join_input" style="margin-top:7px;">
	      		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script>
		    function sample6_execDaumPostcode() {
		        new daum.Postcode({
		            oncomplete: function(data) {
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
		                if(data.userSelectedType === 'R'){
		                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                        extraAddr += data.bname;
		                    }
		                    // 건물명이 있고, 공동주택일 경우 추가한다.
		                    if(data.buildingName !== '' && data.apartment === 'Y'){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                    if(extraAddr !== ''){
		                        extraAddr = ' (' + extraAddr + ')';
		                    }
		                    // 조합된 참고항목을 해당 필드에 넣는다.
		                    document.getElementById("sample6_extraAddress").value = extraAddr;
		                
		                } else {
		                    document.getElementById("sample6_extraAddress").value = '';
		                }
		
		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                document.getElementById('sample6_postcode').value = data.zonecode;
		                document.getElementById("sample6_address").value = addr;
		                // 커서를 상세주소 필드로 이동한다.
		                document.getElementById("sample6_detailAddress").focus();
		            }
		        }).open();
		    }
		</script><br>
		</div>
		<div id="msgbox" class="join"><h4>${message}</h4></div>
		<div class="goodsCartButton">
			<input type="reset" class="goodsButton2" value="다시작성">
		</div>
		<div class="goodsCartButton">
			<input type="submit" class="goodsButton1" value="수정">
		</div>
		</fieldset>
  	</form>
</article>

<%@ include file="../include/footer.jsp"%>