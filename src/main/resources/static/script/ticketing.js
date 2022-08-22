
function choiceDayCheck( ){
	if(document.formmm.selectedDate.value==""){
		alert("날짜를 선택해주세요");
		document.formmm.selectedDate.focus();
		return;
	}
	
	document.formmm.action="ticketingCart";
	document.formmm.submit();
		
}


function go_CartList( ){
	var cartlist = document.cartlist;
	if( cartlist.quantity1.value == "0" && cartlist.quantity2.value == "0" ){
		alert("예매권 수량을 먼저 선택 해주세요.");
		cartlist.quantity1.focus();
		return false;
	}	
	cartlist.action="ticketingCartList";
	cartlist.submit();

}

function go_ticketing( ){
	document.cartlist.action="ticketing";
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

function quantity(totalPrice3,price3) {
    var x = document.getElementById("select").value
    document.getElementById("view").innerHTML = "- "+x ;	
    var y = totalPrice3;	
    //console.log( x + " = x값");
    //console.log( y + " = totalPrice3값");
    //console.log( z + " = price3값");
    //console.log( y - x + " = y - x 값 ");
    //console.log(typeof x);
	//console.log(typeof y);
	const num = parseInt(x)
	//console.log(typeof num);
	//console.log( y - num + " = y - num 값 ");
	//document.getElementById("view").innerHTML = x ;	
	document.getElementById("view2").innerHTML = y - num ;	
}

function go_mypage( ){
	document.cartlist.action="ticketCartList";
	document.cartlist.submit();
}

