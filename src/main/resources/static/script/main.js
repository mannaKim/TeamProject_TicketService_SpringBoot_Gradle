      var num = 0;
        $(function(){
            var time;
            var state = false;

            $("#rbutton").click(function(){
                if(state==false){
                    num++;
                    if(num==5){
                        num=0;
                    }
                    $("#imgbox").animate({left:-755 * num}, 500);
                    $("#currentNum").html((num+1) + "/5");
                }
            });

            $("#lbutton").click(function(){
                
                if(state==false){
                    if(num==0){
                        num=5;
                    }
                    num--;
                    $("#imgbox").animate({left:-755 * num}, 500);
                    $("#currentNum").html((num+1) + "/5");
                }
            });

            $("#remot").click(function(){
                if(state == false){
                    state = true;
                time = window.setInterval(function(){
                    num++;
                    if(num > 4){
                        num=0;
                    }
                    $("#imgbox").animate({left:-755 * num}, 500);
                    $("#currentNum").html((num+1) + "/5");
                }, 1500);
                    $(this).html("■");
                } else {
                    state = false;
                    window.clearInterval(time);
                    $(this).html("▶");
                }
            });
        });