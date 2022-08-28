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
	document.goodsFrm.action="m_goodsCartInsert";
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
	let url = "m_goodsCartInsert?gseq="+gseq+"&quantity="+update_quantity;
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
		document.goodsCartFrm.action="m_goodsCartDelete";
		document.goodsCartFrm.submit();
	}
}

function go_Gorder_insert(mpoint){
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
		document.goodsCartFrm.action="m_goodsOrderCheck?point=" + mpoint;
		document.goodsCartFrm.submit();
	}
}

function go_Gorder(numOfInven){
	if(numOfInven == 0){
		alert("품절된 상품입니다.");
		return;
	}
	document.goodsFrm.action="m_goodsOrderCheckOne";
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

function withdrawalConfirm(){
	if(confirm('탈퇴하시겠습니까?')){
		location.href = "Mwithdrawal";
	}else {
		location.href = "m_mypage";
	}
}