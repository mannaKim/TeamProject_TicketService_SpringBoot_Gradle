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
	location.href="aqnaReD?renum=" + renum + "&qseq=" + qseq;
}

function go_write_faq(){
	if(document.writeFrm.subject.value == "") {
		alert("질문을 입력해 주세요.");	    
		document.writeFrm.subject.focus();
		return false;
	} if(document.writeFrm.content.value == "") {
		alert("답변을 입력해 주세요.");	    
		document.writeFrm.content.focus();
		return false;
	}else{
		if(document.writeFrm.kind.value == "") {
			alert("카테고리를 입력해 주세요.");	    
			document.writeFrm.kind.focus();
			return false;
		}else{
			return true;
		}
	}
}

