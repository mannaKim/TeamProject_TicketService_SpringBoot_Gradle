var imgNum=0;
var timer;
window.onload = play;

function play(){
	timer = window.setInterval(function(){
		imgNum++;
		if(imgNum>3) imgNum=0;
		var dist = -1200*imgNum;
		document.getElementById("banner_imgs").style.left=dist+"px";
		},4000);
}

function moveLeft(){
	if(imgNum==0) return; 
	imgNum--;
	var dist = -1200*imgNum;
	document.getElementById("banner_imgs").style.left=dist+"px";
}

function moveRight(){
	if(imgNum==3) imgNum=-1; 
	imgNum++;
	var dist = -1200*imgNum;
	document.getElementById("banner_imgs").style.left=dist+"px";
}

function moveNum(n){
	imgNum=n;
	document.getElementById("banner_imgs").style.left=(n*1200*-1)+"px";
}