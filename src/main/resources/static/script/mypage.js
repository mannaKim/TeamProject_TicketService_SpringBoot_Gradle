function checkPwd(purpose){
	location.href = "ticket.do?command=checkPwdForm&purpose="+purpose;
}

function pwdCheck(){
	if(document.frm.pwd.value==""){
		alert('비밀번호를 입력해주세요.');
		document.frm.pwd.focus();
		return false;
	}
	return true;
}

function withdrawalConfirm(){
	if(confirm('탈퇴하시겠습니까?')){
		location.href = "ticket.do?command=withdrawal";
	}else {
		location.href = "ticket.do?command=mypage";
	}
}

function go_modify(){
	if(document.joinFrm.pwd.value==""){
		alert("비밀번호를 입력하세요.")
		document.joinFrm.pwd.focus();
	}else if(document.joinFrm.pwd.value!=document.joinFrm.pwdCheck.value){
		alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.")
		document.joinFrm.pwd.focus();
	}else if(document.joinFrm.name.value==""){
		alert("이름을 입력하세요.")
		document.joinFrm.name.focus();
	}else if(document.joinFrm.email.value==""){
		alert("이메일을 입력하세요.")
		document.joinFrm.email.focus();
	}else {
		document.joinFrm.action="ticket.do?command=modifyMember";
		document.joinFrm.submit();
	}
}