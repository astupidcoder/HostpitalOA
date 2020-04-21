<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="datas">
	<c:forEach var="office" items="${officeList }">
	<li>
	<a href="${pageContext.request.contextPath}/office/info/${office.officeNo }.html">
	${office.officeName }
	</a>
	</li>
	</c:forEach>
</div>
</body>
</html>