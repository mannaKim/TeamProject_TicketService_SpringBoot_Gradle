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

function go_nowrt() {
	document.frm.action = "adminNoticeInsert";
	document.frm.submit();
}


function go_notice(ntnum) {
	var url ="adminNoticeView?ntnum=" + ntnum;
	document.frm.action = url;
	document.frm.submit();
}

function NoticeCheck(ntnum, comm) {
	if(comm=='update') {
		alert("게시글을 수정하시겠습니까?");
		location.href="adminNoticeUpdateForm?num=" + ntnum;
	} else if(comm=='delete') {
		alert("게시글을 삭제하시겠습니까?");
		location.href="adminNoticeDelete?num=" +ntnum;
	}
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
	location.href="adminEventInsert";
}

function eventimg1() {
	var opt = "toolbar=no, menubar=no, resizable=no, width=500, height=300";
	window.open('eventselectimg1', 'bannerimg', opt);
}

function eventimg2() {
	var opt = "toolbar=no, menubar=no, resizable=no, width=500, height=300";
	window.open('eventselectimg2', 'bannerimg', opt);
}

function selectedimage1() {
	document.frm.submit();
}

function selectedimage2() {
	document.frm.submit();
}

function EventCheck(comm, evnum) {
	if(comm=='update') {
		alert("게시글을 수정하시겠습니까?");
		location.href="adminEventUpdateForm?num=" + evnum;
	} else if(comm=='delete') {
		alert("게시글을 삭제하시겠습니까?");
		location.href="adminEventDelete?num=" + evnum;
	}
}

function UserUpdate(id) {
	alert("유저목록을 수정하시겠습니까?");
	var url = "adminUserUpdateForm?id=" + id;
	var opt = "toolbar=no, menubar=no, resizable=no, scrollbars=no,";
	opt = opt + "width=700, height=500, top=300, left=300";
	window.open(url,"Point update",opt);
}

function go_adminUser(){
	opener.location.href="adminCheck";
	self.close();
}

function go_search(comm) {
	if(document.frm.key.value==""){
		alert("검색어 입력이 필수입니다.");
		return;
	}
	console.log(comm);
	var url = comm + "?page=1";
	document.frm.action = url;
	document.frm.submit();
}

function go_total(comm) {
	document.frm.key.value="";
	document.frm.action = comm + "?page=1";
	document.frm.submit();
}
