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