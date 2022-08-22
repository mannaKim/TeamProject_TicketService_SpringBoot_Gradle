function withdrawalConfirm(){
	if(confirm('탈퇴하시겠습니까?')){
		location.href = "withdrawal";
	}else {
		location.href = "mypage";
	}
}