function reply_check() {
	if(document.frm_event.id.value==""){
		alert("로그인을 먼저 해주세요.");
		document.frm_event.action = "loginForm";
		document.frm_event.submit();
		return false;
	} 
	
	if(document.frm_event.reply.value=="") {
		return false;
	}
	return true;
}

function updateReply(comm, replynum){
	if(comm=='update'){
		var url="updRepForm?replynum=" + replynum;
		var opt = "toolbar=no, menubar=no, resizable=no, scrollbars=no,";
		opt = opt +"  width=700, height=500, top=300, left=300";
		window.open(url,"Update Reply",opt);
	}
}



function go_eventDetail(evnum){
	opener.location.href="eventDetailWithoutCount?num=" + evnum;
	self.close();
}