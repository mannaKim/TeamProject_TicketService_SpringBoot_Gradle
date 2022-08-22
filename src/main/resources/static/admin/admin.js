function adminCheck() {
	if(document.frm.id.value==""){
		alert("아이디를 입력하세요");
		document.frm.id.focus();
		return false;
	} else if(document.frm.pwd.value==""){
		alert("비밀번호를 입력하세요.");
		document.frm.pwd.focus();
		return false;
	}
	return true;
}

function go_wrt() {
	document.formm.action = "ticket.do?command=admin_ticketWriteForm";
	document.formm.submit();
}
function go_mov() {
	document.formm.action = "ticket.do?command=admin_ticketList";
	document.formm.submit();
}


function go_save(){
	var theForm = document.formm;
	if( theForm.name.value==""){ 
		alert('행사명을 입력하세요.');
		theForm.name.focus();
	}else if (theForm.sdate.value == "") {
		alert('기간(시작날짜)를 입력하세요.'); 	
		theForm.sdate.focus();	
	} else if (theForm.edate.value == "") {
		alert('기간(끝나는 날짜)를 입력하세요.'); 		
		theForm.edate.focus();
	} else if (theForm.price1.value == "") {
		alert('가격(일반)을 입력하세요.'); 		
		theForm.price1.focus();
	} else if (theForm.price2.value == "") {
		alert('가격(어린이)을 입력하세요.'); 		
		theForm.price2.focus();
	} else if (theForm.price3.value == "") {
		alert('할인가격을 입력하세요.'); 		
		theForm.price3.focus();
	} else if (theForm.age.value == "") {
		alert('나이를 입력하세요.'); 		
		theForm.age.focus();
	} else if (theForm.place.value == "" ) {
		alert('장소를 입력하세요.'); 		
		theForm.place.focus();
	} else if (theForm.address.value == "") {
		alert('상세주소를 입력하세요.'); 		
		theForm.address.focus();
	} else if (theForm.daytime.value == "") {
		alert('공연입장 시간을 입력하세요.'); 		
		theForm.daytime.focus();
	} else if (theForm.showtime.value == "") {
		alert('공연 시간을 입력하세요.'); 		
		theForm.showtime.focus();
	} else if (theForm.content.value == "") {
		alert('행사소개를 입력하세요.'); 		
		theForm.content.focus();
	} else if (theForm.image.value == "") {
		alert('상품이미지들 등록하세요.'); 	
		theForm.image.focus();	
	} else{
		theForm.action = "ticket.do?command=admin_ticketWrite";
		theForm.submit();
	}
}


function go_ticketSearch( comm ){
	if( document.formm.key.value == "" ){
		alert("검색버튼 사용시에는 검색어 입력이 필수입니다");
	 	return;
	 }
	var url = "ticket.do?command=" + comm + "&page=1";
	document.formm.action = url;
	document.formm.submit();
}


function go_ticketTotal( comm ){
	document.formm.key.value="";
	document.formm.action = "ticket.do?command=" + comm + "&page=1";
	document.formm.submit();
}



function updatePass( tpseq ){
	var url = "ticket.do?command=admin_UpdateForm&tpseq=" + tpseq;
	document.formm.action = url;
	document.formm.submit();
}

function deletePass( tpseq ){
	var url = "ticket.do?command=admin_deleteForm&tpseq=" + tpseq;
	document.formm.action = url;
	document.formm.submit();
}

function go_nowrt() {
	document.frm.action = "ticket.do?command=adminNoticeInsert";
	document.frm.submit();
}


function noticeCheck() {
	if(document.frm.pass.value==""){
		alert("비밀번호를 입력하세요.");
		document.frm.pass.focus();
		return false;
	} else if(document.frm.title.value==""){
		alert("제목입력은 필수입니다.");
		document.frm.title.focus();
		return false;
	} else if(document.frm.content.value==""){
		alert("내용입력은 필수입니다.");
		document.frm.content.focus();
		return false;
	} else {
		return true;
	}
}

function go_notice(ntnum) {
	var url ="ticket.do?command=adminNoticeView&ntnum=" + ntnum;
	document.frm.action = url;
	document.frm.submit();
}


function checkPass(noticeNum, popupName){
	var url = "ticket.do?command=adminNoticeCheck&ntnum=" + noticeNum;
	var opt = "toolbar=no, scrollbar=yes, menubar=no, resizable=no, width=500, height=300";
	window.open(url, popupName, opt);
}



function passCheck(){
	if(document.frm.pass.value==""){
		alert("관리자 비밀번호를 입력해주세요.");
		document.frm.pass.focus();
		return false;
	}
	return true;
}

function go_evwrt() {
	location.href="ticket.do?command=adminEventInsert";
}

function go_event(evnum) {
	location.href = "ticket.do?command=adminEventView&evnum=" + evnum;
}

function event_save() {
	if(document.frm.title.value==""){
		alert("제목명은 필수입니다.");
		document.frm.title.focus();
		return false;
	} else if(document.frm.evdate.value=="") {
		alert("이벤트기간은 필수입니다.");
		document.frm.evdate.focus();
		return false;
	} else if(document.frm.evperson.value==""){
		alert("당첨자 발표일을 입력해주세요.");
		document.frm.evperson.focus();
		return false;
	} else if(document.frm.eimage.value==""){
		alert("배너이미지를 등록해주세요.");
		return false;
	} else if(document.frm.eimage2.value==""){
		alert("메인이미지를 등록해주세요.");
		return false;
	} else {
		document.frm.action = "ticket.do?command=eventWrite";
		document.frm.submit();
	}	
}


function go_search(comm) {
	if(document.frm.key.value==""){
		alert("검색어 입력이 필수입니다.");
		return;
	}
	console.log(comm);
	var url = "ticket.do?command=" + comm + "&page=1";
	document.frm.action = url;
	document.frm.submit();
}

function go_total(comm) {
	document.frm.key.value="";
	document.frm.action = "ticket.do?command=" + comm + "&page=1";
	document.frm.submit();
}

function delete2Pass( cseq ){
	var url = "ticket.do?command=admin_delete2Form&cseq=" + cseq;
	document.formm.action = url;
	document.formm.submit();
}