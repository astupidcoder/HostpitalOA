<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap3/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap3/css/bootstrap-theme.min.css">
<script src="${pageContext.request.contextPath}/static/bootstrap3/js/jquery-1.11.2.min.js"></script>
<script src="${pageContext.request.contextPath}/static/bootstrap3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css"  media="all">
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.datas{
float:right;
}
</style>

<script>
	/* var myDate = new Date();
	var date=myDate.toLocaleDateString();     //获取当前日期
	var tb=document.getElementById("tb");
	var td=tb.rows[0].cells[3];
	td.innerHTML="111"; */
</script>
<script type="text/javascript">
 function guahao(btn){
	/*  var value=btn.tagName;
	 alert("当前元素："+value);
	 alert("上一个元素："+btn.parentNode.parentNode.tagName); */
	 var doctNo=btn.parentNode.parentNode.cells[3].innerHTML;
	 alert(doctNo);
     $.ajax({type:"post",
			url:"${pageContext.request.contextPath}/appoint/update.do",
			async:true,
			data:{"doctNo":Number(doctNo),"p_userNo":'${currentUser.userNo}'},
			dataType:"json",
			success:function(result){
				if(result.success){
				alert("挂号成功");
				}else{
					alert(result.errorMsg);
				}
			}
			
	}
	)  

} 
</script>
</head>
<body>
<div class="datas">
<table class="layui-table" lay-even="" lay-skin="row" id="tb">
<colgroup>
    <col width="150">
    <col width="150">
    <col width="200">
    <col>
    <col>
  </colgroup>
<thead>
<tr>
<th>医师</th>
<th>科室</th>
<th>职务</th>
<th>门诊信息</th>
<th>挂号</th>
</tr>
</thead>
  <tbody>
	<c:forEach var="doct" items="${doctList }" varStatus="status">
	<tr>
	<td align="center">
	<a href="${pageContext.request.contextPath}/doctor/info/${doct.userNo }.html">
	<img width="10%" src="${pageContext.request.contextPath}/static/userImages/${doct.imageName }"/>
	</a>
	<a href="${pageContext.request.contextPath}/doctor/info/${doct.userNo }.html">${doct.userName }</a>
	</td>
	<td>
	${doct.office.officeName }
	</td>
	<td align="center">
	  <span>${doct.degree }</span>
	 </td>
	<td>
	<%-- ${status.index } --%>
	<c:out value="${doct.userNo }"/>
	</td>
	<td>
<button onclick="guahao(this)">挂号</button> 
<%-- 	<a href="${pageContext.request.contextPath}/appoint/add.do?p_userNo=${currentUser.userNo}&doctNo=${doct.userNo}">挂号</a>
 --%>	</td>
	</tr>
	</c:forEach>
	</tbody>
</table>
</div>
<nav aria-label="Page navigation">
  <ul class="pagination">
 ${pageCode }
  </ul>
</nav>
</body>
</html>