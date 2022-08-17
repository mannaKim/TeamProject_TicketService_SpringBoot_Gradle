function go_write(){
	if(document.writeFrm.name.value == "") {
		alert("제목을 입력해주세요"); 	    
	    document.writeFrm.name.focus();
	}else if(document.writeFrm.content.value == "") {
	    alert("내용를 입력해 주세요.");	    
	    document.writeFrm.content.focus();
	}else if(document.writeFrm.kind.value == "") {
	    alert("분류를 선택해 주세요.");	    
	    document.writeFrm.kind.focus();
	}else{
			document.writeFrm.action="ticket.do?command=qnaWrite";
			document.writeFrm.submit();
	}
}

