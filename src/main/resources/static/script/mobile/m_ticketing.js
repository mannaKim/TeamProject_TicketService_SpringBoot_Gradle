
function choiceDayCheck( ){
	if(document.formmm.selectedDate.value==""){
		alert("날짜를 선택해주세요");
		document.formmm.selectedDate.focus();
		return;
	}
	
	document.formmm.action="m_ticketingCart";
	document.formmm.submit();
		
}


function go_CartList( ){
	var cartlist = document.cartlist;
	if( cartlist.quantity1.value == "0" && cartlist.quantity2.value == "0" ){
		alert("예매권 수량을 먼저 선택 해주세요.");
		cartlist.quantity1.focus();
		return false;
	}	
	cartlist.action="m_ticketingCartList";
	cartlist.submit();

}

function go_ticketing( ){
	document.cartlist.action="m_ticketing";
	document.cartlist.submit();
}


function showCheck(ticketNum) {
	document.frm.action = "ticket.do?command=showUpdate&tpseq="+ticketNum;
	document.frm.submit();
}

function showDelete(ticketNum) {
	alert("게시글을 삭제하시겠습니까?");
	document.frm.action = "ticket.do?command=showDelete&tpseq="+ticketNum;
	document.frm.submit();
}

function go_ticketing( ){
	document.formm.action="ticket.do?command=ticketing";
	document.formm.submit();
}

function go_mypage( ){
	document.cartlist.action="ticketCartList";
	document.cartlist.submit();
}

$('input[type="text"]').keydown(function() {
  if (event.keyCode === 13) {
    event.preventDefault();
  };
});


function quantity(totalPrice3) {
    var x = document.getElementById("select").value
    document.getElementById("view").innerHTML = "- "+x ;	
    var y = totalPrice3;	
    
	const num = parseInt(x)	
	document.getElementById("result_pnt").innerHTML = y - num ;	
}


// 포인트 변경 적용값.

function ticket_chkPoint(amt,pnt,min,unit) {
	// input 값을 전체 마일리지로 설정  > minusPoint 
	// amt : 최초 결제 금액 
	// pnt : 사용가능, 남은 포인트 
	// min : 사용 가능 최소 포인트 
	// unit : 사용단위
	
	var v_point = 0; //사용할 포인트 (input 입력값)
	
	var x = document.getElementById("select").value // 셀렉문에서 선택된 값 . 최종 할인금액
	
	if (isNaN(x)) x = 0;
	v_result_amt = amt - x; // 결제금액 - 할인금액 // 최종 결제금액 
	
	if (document.getElementById("chk_point").checked){
		if (pnt < min) { //최소 사용 단위보다 작을 때
			v_point = 0; 
		} else {
			v_point = pnt - pnt%unit; //사용할 포인트 = 전체 마일리지 중 최소단위 이하 마일리지를 뺀 포인트
		}
		
		if(pnt > v_result_amt ){ // 결제금액보다 포인트가 더 클 때
			v_point = v_result_amt; // 사용할 포인트는 결제금액과 동일하게 설정
		}
		
	
	}
	
	document.getElementById("use_pnt").value = v_point; //input 값 설정
	ticket_changePoint(amt,pnt,min,unit);
}
	
function ticket_changePoint(amt,pnt,min,unit){
	// input값을 불러옴 > left_pnt 변경 > 최종결제 변경
	// amt : 최초 결제 금액 
	// pnt : 사용가능,남은 포인트
	// min : 사용 가능 최소 포인트 
	// unit : 사용단위

	var return_point = parseInt(document.getElementById("use_pnt").value);  // 사용할 포인트 (input 입력값)
	
	if (return_point > pnt){ //입력값이 사용가능 포인트보다 클때
		return_point = pnt;
		document.getElementById("use_pnt").value = return_point;  //input 값 재설정
	}
	
	if(return_point > amt ){ //결제금액보다 포인트가 더 클 때
		return_point = amt;  //사용할 포인트는 결제금액과 동일하게 설정
		document.getElementById("use_pnt").value = return_point;  //input 값 재설정
	}
	
	
	if (return_point < min){  // 최소 사용 단위보다 작을 때
		return_point = 0; 
		document.getElementById("use_pnt").value = return_point; //input 값 재설정
	} else {
		return_point = return_point - return_point%unit;  // 사용할 포인트 = 사용할 마일리지 중 최소단위 이하 마일리지를 뺀 포인트
	}
	
	
	var v_left = document.getElementsByName("left_pnt"); //사용가능 마일리지, 남은 포인트 값 설정
	for (var i = 0; i < v_left.length; i++) {
		v_left[i].innerHTML = pnt - return_point; //= 전체 포인트 중에 사용할 포인트빼고 남은 포인트
	}
	document.getElementById("view_point").innerHTML = return_point
	
	var v_select = document.getElementById("select").value // 셀렉문에서 선택된 값 . 최종 할인금액
	
	document.getElementById("result_pnt").innerHTML
		= amt - v_select - return_point; // 최종 결제금액 = 결제금액 - 사용할 포인트 - 할인금액 
	document.getElementById("result_point").innerHTML 
		= (( amt - v_select )* 0.03 ) - ( return_point*0.03 ); // 최종 포인트 = ( 결제금액 -할인금액 * 0.03) - 최종결제금액에대한 포인트
	
}
// _PRICE3_null 할인금액이 null 일경우 포인트 /

function ticket_chkPoint_PRICE3_null(amt,pnt,min,unit) {
	// input 값을 전체 마일리지로 설정  > minusPoint 
	// amt : 최초 결제 금액 
	// pnt : 사용가능, 남은 포인트 
	// min : 사용 가능 최소 포인트 
	// unit : 사용단위
	
	var v_point = 0; //사용할 포인트 (input 입력값)
	
	if (document.getElementById("chk_point").checked){
		if (pnt < min) { //최소 사용 단위보다 작을 때
			v_point = 0; 
		} else {
			v_point = pnt - pnt%unit; //사용할 포인트 = 전체 마일리지 중 최소단위 이하 마일리지를 뺀 포인트
		}
		if(pnt > amt ){ // 결제금액보다 포인트가 더 클 때
			v_point = amt; // 사용할 포인트는 결제금액과 동일하게 설정
		}
		
	
	}
	
	document.getElementById("use_pnt").value = v_point; //input 값 설정
	ticket_changePoint(amt,pnt,min,unit);
}
	
function ticket_changePoint_PRICE3_null(amt,pnt,min,unit){
	// input값을 불러옴 > left_pnt 변경 > 최종결제 변경
	// amt : 최초 결제 금액 
	// pnt : 사용가능,남은 포인트
	// min : 사용 가능 최소 포인트 
	// unit : 사용단위

	var return_point = parseInt(document.getElementById("use_pnt").value);  // 사용할 포인트 (input 입력값)
	
	if (return_point > pnt){ //입력값이 사용가능 포인트보다 클때
		return_point = pnt;
		document.getElementById("use_pnt").value = return_point;  //input 값 재설정
	}
	
	if(return_point > amt ){ //결제금액보다 포인트가 더 클 때
		return_point = amt;  //사용할 포인트는 결제금액과 동일하게 설정
		document.getElementById("use_pnt").value = return_point;  //input 값 재설정
	}
	
	if (return_point < min){  // 최소 사용 단위보다 작을 때
		return_point = 0; 
		document.getElementById("use_pnt").value = return_point; //input 값 재설정
	} else {
		return_point = return_point - return_point%unit;  // 사용할 포인트 = 사용할 마일리지 중 최소단위 이하 마일리지를 뺀 포인트
	}
	
	
	var v_left = document.getElementsByName("left_pnt"); //사용가능 마일리지, 남은 포인트 값 설정
	for (var i = 0; i < v_left.length; i++) {
		v_left[i].innerHTML = pnt - return_point; //= 전체 포인트 중에 사용할 포인트빼고 남은 포인트
	}
	document.getElementById("view_point").innerHTML = return_point
	
	document.getElementById("result_pnt").innerHTML
		= amt - return_point; // 최종 결제금액 = 결제금액 - 사용할 포인트 
	document.getElementById("result_point").innerHTML 
		= ( amt * 0.03 ) - ( return_point*0.03 ); // 최종 포인트 = ( 결제금액 -할인금액 * 0.03) - 최종결제금액에대한 포인트
	
}