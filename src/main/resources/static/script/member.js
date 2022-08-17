function go_login() {
	alert("로그인을 먼저 해주세요.");
	location.href="loginForm";
}

function loginCheck() {
	if(document.loginFrm.id.value==""){
		alert("아이디는 필수 입력사항입니다.");
		document.loginFrm.id.focus();
		return false;
	} else if(document.loginFrm.pwd.value=="") {
		alert("비밀번호는 필수 입력사항입니다.");
		document.loginFrm.pwd.focus();
		return false;
	} else {
		return true;
	}
}

function checkAll(){
	if(document.getElementById("termAll").checked==true){ 
		//id가 termAll인 checkbox의 값이 true라면
		for(let i=0;i<3;i++) document.getElementsByName("term_agreement")[i].checked=true;
		//name이 term_agreement인 checkbox들의 값을 모두 true로 바꾼다.
	}
	if(document.getElementById("termAll").checked==false){
		//id가 all인 checkbox의 값이 false라면
		for(let i=0;i<3;i++) document.getElementsByName("term_agreement")[i].checked=false;  
		//name이 term_agreement인 checkbox들의 값을 모두 false로 바꾼다.
	}
}

function checkAllList(){
	checkCount = 0;
	for(let i=0;i<3;i++) {
		if(document.getElementsByName("term_agreement")[i].checked==false){
			checkCount++;
		}		
	}
	if(checkCount>0) document.getElementById("termAll").checked = false;
	if(checkCount == 0) document.getElementById("termAll").checked = true;
}

function showTerm(num){
	let url = "ticket.do?command=showTerm&num="+num;
	let opt = "toolbar=no, menubar=no, resizable=no, width=560, height=300, scrollbars=yes, top=500, left=500";
	window.open(url,"Term",opt);
}

function go_joinForm(){
	if(document.termFrm.term_agreement[0].checked==false){
		alert("이용약관에 동의 후 가입을 진행해주세요.");
	}else if(document.termFrm.term_agreement[1].checked==false){
		alert("개인정보 수집 및 이용 동의 후 가입을 진행해주세요.");
	}else{
		location.href="ticket.do?command=joinForm";
	}
}

function idcheck(){
	if(document.joinFrm.id.value==""){
		alert("아이디를 입력하고 중복체크를 진행하세요.");
		document.joinFrm.id.focus();
		return;
	}
	let url = "ticket.do?command=idCheckForm&id="+document.joinFrm.id.value;
	let opt = "toolbar=no, menubar=no, resizable=no, width=300, height=250, scrollbars=no,";
	opt = opt +" top=300, left=300";
	window.open(url,"IdCheck",opt);
}

function useId(id){
	opener.joinFrm.id.value=id;
	opener.joinFrm.idCheck.value=id;
	self.close();
}

function find_address(){
	let url = "ticket.do?command=findAddress";
	let opt = "toolbar=no, menubar=no, resizable=no, scrollbars=no,";
	opt = opt +" width=450, height=300, top=300, left=300";
	window.open(url,"주소 찾기",opt);
}

function save_address(zip_num,sido,gugun,dong){
	//함수 호출 형태 : result('123-123','서울시','서대문구','대현동')
	opener.document.joinFrm.zip_num.value=zip_num;
	opener.document.joinFrm.address1.value=sido+" "+gugun+" "+dong;
	self.close();
}

function go_join(){
	if(document.joinFrm.id.value==""){
		alert("아이디를 입력하세요.")
		document.joinFrm.id.focus();
	}else if(document.joinFrm.idCheck.value!=document.joinFrm.id.value){
		alert("아이디 중복확인을 하지 않았습니다.")
		document.joinFrm.id.focus();
	}else if(document.joinFrm.pwd.value==""){
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
		document.joinFrm.action="ticket.do?command=join";
		document.joinFrm.submit();
	}
}

function findAccount(comm){
	if(comm=='id'){
		var url="ticket.do?command=findIdForm";
		var opt = "toolbar=no, menubar=no, resizable=no, scrollbars=no,";
		opt = opt +"  width=700, height=500, top=300, left=300";
		window.open(url,"Find Id",opt);
	}else if(comm=='pwd'){
		var url="ticket.do?command=findPwdForm";
		var opt = "toolbar=no, menubar=no, resizable=no, scrollbars=no,";
		opt = opt +"  width=700, height=500, top=300, left=300";
		window.open(url,"Find Password",opt);
	}
}

function go_login_after_FindAccount(){
	opener.location.href="ticket.do?command=loginForm";
	self.close();
}

function resetPwd(){
	if(document.frm.pwd.value==""){
		alert("비밀번호를 입력하세요.")
		document.frm.pwd.focus();
		return false;
	}else if(document.frm.pwd.value!=document.frm.pwd_chk.value){
		alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.")
		document.frm.pwd_chk.focus();
		return false;
	}
	return true;
}