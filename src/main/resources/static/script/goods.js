function count(num, numOfInven){
	let q = document.goodsFrm.quantity.value;
	if(numOfInven == 0){
		alert("품절된 상품입니다.");
		return;
	}
	if(num==-1 && q>1) q--;
	else if (num==1) {
		if(q >= numOfInven){
			alert("구매 가능 수량을 초과했습니다.");
			return;
		}
		q++;
	}
	document.goodsFrm.quantity.value = q;
}

function go_Gcart(numOfInven){
	if(numOfInven == 0){
		alert("품절된 상품입니다.");
		return;
	}
	document.goodsFrm.action="goodsCartInsert";
	document.goodsFrm.submit();
}

function changeQuantity(num, gseq, quantity, numOfInven){
	if(numOfInven == 0){
		alert("품절된 상품입니다.");
		return;
	}
	if(num==-1 && quantity<=1) return;
	if(num==1 && quantity>=numOfInven){
		alert("구매 가능 수량을 초과했습니다.");
		return;
	}
	let update_quantity = quantity + num;
	let url = "goodsCartInsert?gseq="+gseq+"&quantity="+update_quantity;
	location.href = url;
}

function go_Gcart_delete(){
	var count = 0;
	if(document.goodsCartFrm.gcseq.length == undefined){
		if(document.goodsCartFrm.gcseq.checked==true) count++;
	}else{
		for(var i=0; i<document.goodsCartFrm.gcseq.length; i++){
			if(document.goodsCartFrm.gcseq[i].checked==true) count++;
		}
	}
	if(count==0)
		alert("삭제할 상품을 선택하세요.");
	else{
		document.goodsCartFrm.action="goodsCartDelete";
		document.goodsCartFrm.submit();
	}
}

function go_Gorder_insert(){
	var count = 0;
	if(document.goodsCartFrm.gcseq.length == undefined){
		if(document.goodsCartFrm.gcseq.checked==true) count++;
	}else{
		for(var i=0; i<document.goodsCartFrm.gcseq.length; i++){
			if(document.goodsCartFrm.gcseq[i].checked==true) count++;
		}
	}
	if(count==0)
		alert("구입할 상품을 선택하세요.");
	else if(document.goodsCartFrm.soldout.value=="1")
		alert("품절된 상품이 있습니다. 품절 상품을 제외하고 구입할 상품을 선택하세요.");
	else{
		document.goodsCartFrm.action="goodsOrderCheck";
		document.goodsCartFrm.submit();
	}
}

function go_Gorder(numOfInven){
	if(numOfInven == 0){
		alert("품절된 상품입니다.");
		return;
	}
	document.goodsFrm.action="goodsOrderCheckOne";
	document.goodsFrm.submit();
}

function cal() {
	if(document.goodsCartFrm.dpoint.value=="" || document.goodsCartFrm.totalPrice1.value==""){
		return;
	}
	document.goodsCartFrm.totalPrice2.value = document.goodsCartFrm.totalPrice1.value - document.goodsCartFrm.dpoint.value;
}

function pointCheck(mpoint){
	if(document.goodsCartFrm.dpoint.value > mpoint) {
		alert("회원님의 보유 포인트는 " + mpoint + "입니다.");
		return document.goodsCartFrm.dpoint.value = "";
	} else if(document.goodsCartFrm.dpoint.value < 500){
		alert("500포인트 이하는 사용하실수 없습니다.");
		return document.goodsCartFrm.dpoint.value = "";
	}else {
		alert("포인트가 사용되었습니다.");
		return true;
	}
}

function cal2() {
	if(document.goodsFrm.dpoint.value=="" || document.goodsFrm.totalPrice1.value==""){
		return;
	}
	document.goodsFrm.totalPrice2.value = document.goodsFrm.totalPrice1.value - document.goodsFrm.dpoint.value;
}

function pointCheck2(mpoint){
	if(document.goodsFrm.dpoint.value > mpoint) {
		alert("회원님의 보유 포인트는 " + mpoint + "입니다.");
		return document.goodsFrm.dpoint.value = "";
	} else if(document.goodsFrm.dpoint.value < 500){
		alert("500포인트 이하는 사용하실수 없습니다.");
		return document.goodsFrm.dpoint.value = "";
	} else {
		alert("포인트가 사용되었습니다.");
		return true;
	}
}

//포인트 변경 적용값.
function chkPoint(amt,pnt,min,unit) {
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
		if(pnt > amt ){ //결제금액보다 포인트가 더 클 때
			v_point = amt; //사용할 포인트는 결제금액과 동일하게 설정
		}
	}
	document.getElementById("use_pnt").value = v_point; //input 값 설정
	changePoint(amt,pnt,min,unit);
}
	
function changePoint(amt,pnt,min,unit){
	// input값을 불러옴 > left_pnt 변경 > 최종결제 변경
	// amt : 최초 결제 금액 
	// pnt : 사용가능,남은 포인트
	// min : 사용 가능 최소 포인트 
	// unit : 사용단위
	var return_point = parseInt(document.getElementById("use_pnt").value);  //사용할 포인트 (input 입력값)
	
	if( return_point == null ){
		document.getElementById("use_pnt").value = 0;
	}
	
	if (return_point > pnt){ //입력값이 사용가능 포인트보다 클때
		return_point = pnt;
		document.getElementById("use_pnt").value = return_point;  //input 값 재설정
	}
	
	if(return_point > amt ){ //결제금액보다 포인트가 더 클 때
		return_point = amt; //사용할 포인트는 결제금액과 동일하게 설정
		document.getElementById("use_pnt").value = return_point;  //input 값 재설정
	}
	
	if ( return_point%unit > 0 ){ // 최소 사용포인트 설정. 
		return_point = 0; 
		document.getElementById("use_pnt").value = return_point; //input 값 재설정
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
	
	console.log(amt); // 상품 가격
	console.log(amt * 0.05); // 포인트 
	console.log(return_point * 0.05); // 최종결제금액에대한 포인트.

	document.getElementById("result_pnt").innerHTML = amt - return_point; // 최종 결제금액 = 결제금액 - 사용할 포인트
	document.getElementById("result_point").innerHTML = (amt * 0.05) - ( return_point *0.05 ); // 최종 포인트 = 적립 총 포인트 - 사용할 포인트
}