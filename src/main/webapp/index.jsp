<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap3/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap3/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/blog.css">
<script src="${pageContext.request.contextPath}/static/bootstrap3/js/jquery-1.11.2.min.js"></script>
<script src="${pageContext.request.contextPath}/static/bootstrap3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">

</head>
<body>
<div class="container">
	<jsp:include page="/foreground/common/head.jsp"></jsp:include>
	
	<div class="row-fluid">
	<div class="span9">
	
	<jsp:include page="/foreground/content/lunzhuan.jsp"></jsp:include>
	
	</div>
	<div class="span3">
	
	</div>
	</div>
	<jsp:include page="/foreground/common/foot.jsp"></jsp:include>
</div>

<SCRIPT>
var auto;
var index=0;
$('.tuhuo ul li').hover(function(){
	clearTimeout(auto);
	index=$(this).index()
	
	move(index);
	},function(){
		auto=setTimeout('autogo('+index+')',3000)
		});
		
	function autogo(){
		
		
		if(index<5)
		{
				move(index);
				
				index++;
				
			}
			else{
				
				index=0;	
				move(index);
				
				index++;
				
				}
			
		}
		function move(l)
		{
			
		
			var src=$('.tu_img').eq(index).attr('src');
			
			$("#fou_img").css({  "opacity": "0"  });
			
			$('#fou_img').attr('src',src);
			
			$('#fou_img').stop(true).animate({ opacity: '1'},1000);
			$('.tuhuo ul li').removeClass('fouce');
			$('.tuhuo ul li').eq(index).addClass('fouce');
			$('.tuhuo p').hide();
			$('.tuhuo p').eq(index).show();
			var ao=$('.tuhuo p').eq(index).children('a').attr('href');
			$('#fou_img').parent('a').attr("href",ao);
			}
			autogo();
			setInterval('autogo()',3000);
</SCRIPT>
</body>
</html>