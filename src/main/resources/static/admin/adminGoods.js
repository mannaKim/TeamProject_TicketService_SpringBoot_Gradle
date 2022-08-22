function go_totalGoodsList(){
	document.frm.key.value="";
	let url = "adminGoodsList?page=1";
	document.frm.action = url;
	document.frm.submit();
}

function go_goodsCategory(kind){
	document.frm.key.value="";
	let url = "adminGoodsList?page=1&kind="+kind;
	document.frm.action = url;
	document.frm.submit();
}

function go_searchGoodsList(){
	let url = "adminGoodsList?page=1";
	document.frm.action = url;
	document.frm.submit();
}

function go_goodsInsertForm(){
	location.href = "adminGoodsInsertForm";
}

function go_goodsInsert(){
	if(document.frm.kind.value=="" || document.frm.kind.value==0){
		alert("상품분류를 선택하세요.");
		document.frm.kind.focus();
	}else if(document.frm.name.value==""){
		alert("상품명을 입력하세요.");
		document.frm.name.focus();
	}else if(document.frm.price1.value==""){
		alert("원가를 입력하세요.");
		document.frm.price1.focus();
	}else if(document.frm.price2.value==""){
		alert("판매가를 입력하세요.");
		document.frm.price2.focus();
	}else if(document.frm.content.value==""){
		alert("상품상세를 입력하세요.");
		document.frm.content.focus();
	}else if(document.frm.image.value==""){
		alert("상품 대표이미지를 입력하세요.");
		document.frm.image.focus();
	}else if(document.frm.detail_img.value==""){
		alert("상품 상세이미지를 입력하세요.");
		document.frm.image.focus();
	}else{
		document.frm.action="ticket.do?command=adminGoodsInsert";
		document.frm.submit();
	}
}

function calculatePrice(){
	if(document.frm.price1.value=="" || document.frm.price2.value=="") return;
	else document.frm.price3.value = document.frm.price2.value - document.frm.price1.value;
}

function go_goodsDetail(gseq){
	document.frm.action = "ticket.do?command=adminGoodsDetail&gseq="+gseq;
	document.frm.submit();
}

function go_goodsModifyForm(gseq){
	location.href = "ticket.do?command=adminGoodsUpdateForm&gseq="+gseq;
}

function go_goodsModify(){
	if(document.frm.kind.value==""){
		alert("상품분류를 선택하세요.");
		document.frm.kind.focus();
	}else if(document.frm.name.value==""){
		alert("상품명을 입력하세요.");
		document.frm.name.focus();
	}else if(document.frm.price1.value==""){
		alert("원가를 입력하세요.");
		document.frm.price1.focus();
	}else if(document.frm.price2.value==""){
		alert("판매가를 입력하세요.");
		document.frm.price2.focus();
	}else if(document.frm.content.value==""){
		alert("상품상세를 입력하세요.");
		document.frm.content.focus();
	}else{
		if(confirm('수정하시겠습니까?')){
			document.frm.action = "ticket.do?command=adminGoodsUpdate";
			document.frm.submit();
		}
	}
}

function changeResult(oseq,odseq,result){
	let url = "ticket.do?command=changeOrderResult&oseq="+oseq;
	url+="&odseq="+odseq;
	if(result == '1') url+="&result=0";
	else url+="&result=1";
	location.href = url;
}

function changeResultAll(oseq){
	let url = "ticket.do?command=changeOrderResult&result=0&oseq="+oseq;
	location.href = url;
}
