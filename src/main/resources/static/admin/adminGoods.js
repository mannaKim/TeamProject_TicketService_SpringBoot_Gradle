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

function calculatePrice(){
	if(document.frm.price1.value=="" || document.frm.price2.value=="") return;
	else document.frm.price3.value = document.frm.price2.value - document.frm.price1.value;
}

function deleteGoodsConfirm(gseq){
	if(confirm('삭제하시겠습니까?')){
		location.href = "adminGoodsDelete?gseq="+gseq;
	}else {
		location.href = "adminGoodsDetail?gseq="+gseq;
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
