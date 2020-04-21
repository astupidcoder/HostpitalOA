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
<table class="layui-table" lay-even>
<caption>${officeName }</caption>
<thead>
<tr>
<th>医生姓名</th>
<th>职位</th>
</tr>
</thead>

<tbody>
	<c:forEach var="doct" items="${doctorList }">
	<tr>
	<td align="center">
	<a href="${pageContext.request.contextPath}/doctor/info/${doct.userNo }.html">
	<img width="10%" src="${pageContext.request.contextPath}/static/userImages/${doct.imageName }"/>
	</a>
	<a href="${pageContext.request.contextPath}/doctor/info/${doct.userNo }.html">${doct.userName }</a>
	</td>
	<td align="center">
	 <span>${doct.degree }</span>
	 </td>
	</c:forEach>
</tbody>
</table>
</div>
</body>
</html>