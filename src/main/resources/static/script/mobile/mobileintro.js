function Mreply_check() {
	if(document.frm_event.id.value==""){
		alert("로그인을 먼저 해주세요.");
		document.frm_event.action = "MloginForm";
		document.frm_event.submit();
		return false;
	} 
	
	if(document.frm_event.reply.value=="") {
		return false;
	}
	return true;
}

function MupdateReply(comm, replynum){
	if(comm=='Mupdate'){
		var url="MupdRepForm?replynum=" + replynum;
		var opt = "toolbar=no, menubar=no, resizable=no, scrollbars=no,";
		opt = opt +"  width=700, height=500, top=300, left=300";
		window.open(url,"Update Reply",opt);
	}
}



function go_MeventDetail(evnum){
	opener.location.href="MeventDetailWithoutCount?num=" + evnum;
	self.close();
}