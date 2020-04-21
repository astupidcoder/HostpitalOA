<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<%
   //权限验证
     if(session.getAttribute("currentUser")==null){
    	 response.sendRedirect("index.jsp");
    	 return;
     }
%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
$(function(){
	//定义树
	var treeData=[{
	id:1,
	text:"系统管理",
	children:[{
		text:"科室信息管理",
		attributes:{
			url:"officeInfoManage.jsp"
		}
	},{
		text:"医生信息管理",
		attributes:{
			url:"doctorInfoManage.jsp"
		}
		
	},
	{
		id:11,
		text:"药品基本信息管理",
		children:[
			{
				id:112,
				text:"查询药品",
				attributes:{
					url:"medica.jsp"
				}
			},{
			id:111,
			text:"添加药品",
			attributes:{
				url:"addMedica.jsp"
			}
		},
		]
}
	]
}];
	//实例化树菜单
	$("#tree").tree({
		data:treeData,
		lines:true,
		onClick:function(node){
			if(node.attributes){
				openTabs(node.text,node.attributes.url);
			}
		}
	});
	//新增tab
	function openTabs(text,url){
	if($("#tabs").tabs('exists',text)){
		$("#tabs").tabs('select',text);
	}		
	else{
		var content="<iframe framborder='0' scrolling='auto' style='width:100%;height:100%;' src="+url+"></iframe>";
		$("#tabs").tabs('add',{
			title:text,
			closable:true,
			content:content
		});
		
	 }
	}
});
</script>
</head>
<body class="easyui-layout">
<div region="north" style="height:90px;"><strong>系统管理</strong>
		<div style="width:80;float:left"><img src="${pageContext.request.contextPath}/static/images/hushi.jpg" style="width:15%"/></div>
	<div style="padding-top:50px;padding-right:20px">当前用户：<font color=red>${currentUser.userName } </font></div>
</div>
<div region="center">
	<div class="easyui-tabs" fit="true" border="false" id="tabs">
      <div title="首页">
          <div style="padding-top:100px;" align="center"><font color="red" size=50>欢迎使用</font></div>
      </div>     
	</div>
</div>
<div region="west" style="width:150px;" title="导航菜单" split="true">
	西<ul id="tree"></ul>
</div>
<div region="south" style="height:50px;" align="center">南</div>

主界面
</body>
</html>