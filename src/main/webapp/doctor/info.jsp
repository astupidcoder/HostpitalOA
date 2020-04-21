<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css"  media="all">

</head>
<body>
<img width="10%" src="${pageContext.request.contextPath}/static/userImages/${doct.imageName }"/><br>
${doct.userName }&nbsp;&nbsp;&nbsp;${doct.degree }<br><br>${doct.sign }<br>${doct.profile }
</body>
</html>