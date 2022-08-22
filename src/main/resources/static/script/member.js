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
	let url = "showTerm?num="+num;
	let opt = "toolbar=no, menubar=no, resizable=no, width=560, height=300, scrollbars=yes, top=500, left=500";
	window.open(url,"Term",opt);
}

function go_joinForm(){
	if(document.termFrm.term_agreement[0].checked==false){
		alert("이용약관에 동의 후 가입을 진행해주세요.");
	}else if(document.termFrm.term_agreement[1].checked==false){
		alert("개인정보 수집 및 이용 동의 후 가입을 진행해주세요.");
	}else{
		location.href="joinForm";
	}
}

function idcheck(){
	if(document.joinFrm.id.value==""){
		alert("아이디를 입력하고 중복체크를 진행하세요.");
		document.joinFrm.id.focus();
		return;
	}
	var url = "idCheckForm?id="+document.joinFrm.id.value;
	var opt = "toolbar=no, menubar=no, resizable=no, width=300, height=250, scrollbars=no,";
	opt = opt +" top=300, left=300";
	window.open(url,"IdCheck",opt);
}

function useId(id){
	opener.joinFrm.id.value=id;
	opener.joinFrm.re_id.value=id;
	self.close();
}

function findAccount(comm){
	if(comm=='id'){
		var url="findIdForm";
		var opt = "toolbar=no, menubar=no, resizable=no, scrollbars=no,";
		opt = opt +"  width=700, height=500, top=300, left=300";
		window.open(url,"Find Id",opt);
	}else if(comm=='pwd'){
		var url="findPwdForm";
		var opt = "toolbar=no, menubar=no, resizable=no, scrollbars=no,";
		opt = opt +"  width=700, height=500, top=300, left=300";
		window.open(url,"Find Password",opt);
	}
}

function go_login_after_FindAccount(){
	opener.location.href="loginForm";
	self.close();
}