function reply_check(){
	 if(document.frm_reply.content.value == "") {
	    alert("내용를 입력해 주세요.");	    
	    document.frm_reply.content.focus();
	    return false;
	}else{
		return true;
	}
}

function reply_delete(renum, qseq){
location.href="ticket.do?command=aqnaReD&renum=" + renum + "&qseq=" + qseq;
}
