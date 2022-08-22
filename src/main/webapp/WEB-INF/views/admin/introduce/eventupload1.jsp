<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	opener.frm.eimage.value='${evimage1}'; // 전송될 히든태그에 이름 삽입
	opener.document.getElementById('evimage1').innerHTML = '${evimage1}'; // 파일이름 확인을 위한 표시
	opener.document.getElementById('previewimg1').setAttribute('src','/ticket_image/' + '${evimage1}');
	opener.document.getElementById('previewimg1').style.display='inline'; // 이미지 미리보기
	self.close();
</script>
</head>
<body>

</body>
</html>