<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>科室信息管理</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
var url;
/**
 * 搜索
 */
  function searchOffice(){
	  $('#dg').datagrid('load',{
		  s_officeName:$('#s_officeName').val(),
		  s_officeNo:$('#s_officeNo').val(),
		  s_dirName:$('#s_dirName').val()
	  });
  }

//回车事件绑定
  /*  $('#s_officeName').bind('keydown', function(event) {
  　　if (event.keyCode == "13") {
  　　　　//回车执行查询
      searchOffice();
  　　}
  }); 
  $('#s_officeNo').bind('keydown', function(event) {
	  　　if (event.keyCode == "13") {
	  　　　　//回车执行查询
	      searchOffice();
	  　　}
	  });
  $('#s_dirName').bind('keydown', function(event) {
	  　　if (event.keyCode == "13") {
	  　　　　//回车执行查询
	      searchOffice();
	  　　}
	  }); */
  /*
      重置搜索
  */
  function resetSearch(){
	  $('#s_officeName').val("");
	  $('#s_officeNo').val("");
	  $('#s_dirName').val("");
	  $("#dg").datagrid("load",{
		  
	  });
  }
  function deleteOffice(){
	  var selectedRows=$('#dg').datagrid('getSelections');
	 if(selectedRows.length==0){
		 $.messager.alert("系统提醒","请选择要删除的对象");
		 return;
	 }
	 var strIds=[];
	 for(var i=0;i<selectedRows.length;i++){
		 strIds.push(selectedRows[i].id);
	 }
	 var ids=strIds.join(",");
	 alert(strIds);
	 $.messager.confirm("系统提示","你确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
		 if(r){
			 $.post("${pageContext.request.contextPath}/office/delete.do",{delIds:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","您已成功删除<font color=red>"+result.delNums+"</font>条数据！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert('系统提示','<font color="red">'+selectedRows[result.errorIndex].gradeName+'</font>'+result.errorMsg);
					}
				},"json");
		 }
	 });
  }
  
  function openOfficeModifyDialog(){
	  var selectedRows=$('#dg').datagrid('getSelections');
	  if(selectedRows.length>1){
		 $.messager.alert("警告","只能选择一条对其进行修改");return;
	  }
	  if(selectedRows.length==0){
			 $.messager.alert("警告","请选择要修改的行");return;
		  }
	  var row=selectedRows[0];
	  $('#fm').form('load',{
		  officeNo:row.officeNo,
		  officeName:row.officeName,
		  wardNo:row.wardNo,
		  bedNum:row.bedNum
	  });
	  $('#dirName').val(row.doctor.userName);
	  $('#dirNo').val(row.doctor.userNo);
	  
	  $('#dlg').dialog('open').dialog("setTitle","修改科室信息");
	  url="${pageContext.request.contextPath}/office/save.do?id="+row.id;
  }
  function openOfficeAddDialog(){
	  $('#dlg').dialog('open').dialog("setTitle",'添加科室信息');
	  url="${pageContext.request.contextPath}/office/save.do";
  }
  
  function saveOffice(){
	  $("#fm").form("submit",{
		  url:url,
		  
		  onSubmit:function(){
			  alert(url);
			 return $(this).form("validate");},
		  success:function(result){
			  if(result.errorMsg){
				  $.messager.alert("系统提示",result.errorMsg);
				  return;
			  }else{
				  $.messager.alert("系统提示","保存成功");
				  resetValue();
				  $("#dlg").dialog("close");
				  $("#dg").datagrid("reload");
			       }
		  					}
		  }
	  );
  }
  
  function resetValue(){
	  $("#gradeName").val("");
	  $("#gradeDesc").val("");
  }
  function closeGradeDialog(){
	  $("#dlg").dialog("close");
	  resetValue();
  }
  
  /* 	取json二级对象的属性值 */
  function formatDoctor(val,row){
  	return row.doctor.userName;
  }
  function formatDoctor2(val,row){
	  	return row.doctor.userNo;
	  }
</script>
</head>
<body style="margin:5px">

<table id="dg" title="科室信息" class="easyui-datagrid" 
fitColumns="true" pagination="true" fit="true" rownumbers="true" url="${pageContext.request.contextPath}/office/list.do"
toolbar="#tb">
	<thead>
	<tr>
	    <th field="cb" checkbox="true"></th>
		<th field="id" width="50">Id</th>
		<th field="officeNo" width="100">科室编号</th>
		<th field="officeName" width="150">科室名称</th>
		<th field="wardNo" width="150">病房编号</th>
		<th field="bedNum" width="150">床位数量</th>
		<th field="dirName" width="150" formatter="formatDoctor">科室主任姓名</th>
		<th field="dirNo" width="150" formatter="formatDoctor2">科室主任编号</th>
	</tr>
	</thead>
</table>
	<div id="tb">
		<div>
		<a href="javascript:openOfficeAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
	    <a href="javascript:openOfficeModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
	    <a href="javascript:deleteOffice()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
	    </div>
	    <div>
	    &nbsp;科室名称：&nbsp;<input type="text" name="s_officeName" id="s_officeName"/>&nbsp;科室编号：<input type="text" name="s_officeNo" id="s_officeNo" />&nbsp;科室主任：<input type="text" name="s_dirName" id="s_dirName" />
	    <a href="javascript:searchOffice()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
	    <a href="javascript:resetSearch()" class="easyui-linkbutton" iconCls="icon-reload" plain="true">重置</a>
	    </div>
	</div>
	<div id="dlg" class="easyui-dialog" closed="true" buttons="#dlg-btns" style="width:600px;height:400px;padding:10px 20px">
	<form id="fm" method="post">
	<table>
		<tr> 
			<td>科室编号：</td>
			<td><input type="text" id="officeNo" name="officeNo" class="easyui-validatebox" required="true"></td>
			<td>科室名称：</td>
			<td><input type="text" id="officeName" name="officeName" class="easyui-validatebox" required="true"></td>
		</tr>
		<tr> 
			<td>病房编号：</td>
			<td><input type="text" id="wardNo" name="wardNo" class="easyui-validatebox" required="true"></td>
			<td>床位数量：</td>
			<td><input type="text" id="bedNum" name="bedNum" class="easyui-validatebox" required="true"></td>
		</tr>
		<tr>
			<td>科室主任姓名：</td>
			<td><input type="text" id="dirName" name="doctor.userName" class="easyui-validatebox"></td>
			<td>科室主任编号：</td>
			<td><input type="text" id="dirNo" name="doctor.userNo" class="easyui-validatebox" required="true"></td>
			<td valign="top">科室描述：</td>
			<td><textarea id="gradeDesc" name="gradeDesc" rows="7" cols="30"></textarea></td>
		</tr>
	</table>
	</form>
	</div>
	<div id="dlg-btns">
	<a href="javascript:saveOffice()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closeGradeDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>