<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>医生信息管理</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
var url;
	function searchDoctor(){
		$('#dg').datagrid('load',{
			s_userNo:$('#s_userNo').val(),
			s_doctName:$('#s_doctName').val(),
			s_officeNo:$('#s_officeNo').combobox("getValue")
		});
	}
	 /*
    重置搜索
*/
function resetSearch(){
	s_userNo:$('#s_userNo').val("");
	s_doctName:$('#s_doctName').val("");
	s_officeNo:$('#s_officeNo').combobox('setValue','');
	  $("#dg").datagrid("load",{
		  
	  });
}	
	function deleteDoctor(){
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
				 $.post("${pageContext.request.contextPath}/doctor/delete.do",{delIds:ids},function(result){
						if(result.success){
							$.messager.alert("系统提示","您已成功删除<font color=red>"+result.delNums+"</font>条数据！");
							$("#dg").datagrid("reload");
						}else{
							$.messager.alert('系统提示',result.errorMsg);
						}
					},"json");
			 }
		 });
	  }
	
	function openDoctorAddDialog(){
		  $('#dlg').dialog('open').dialog("setTitle",'添加医生信息');
		  url="${pageContext.request.contextPath}/doctor/manage/save.do";
		 
	  }
	
	function saveDoctor(){
		$("#fm").form("submit",{
			  url:url,
			  onSubmit:function(){
				  if($('#sex').combobox("getValue")==""){
					  $.messager.alert("系统提示","性别不能为空");
					  return false;
				  }
				  alert(url);
				 return $(this).form("validate");},
			  success:function(result){
				 
				  if(result.errorMsg){
					  $.messager.alert("系统提示",result.errorMsg);
					  return;
				  }else{
					  $.messager.alert("系统提示","保持成功lll");
					  resetValue();
					  $("#dlg").dialog("close");
					  $("#dg").datagrid("reload");
				       }
			  					}
			  }
		  );
	}
	
	function resetValue(){
		$("#stuNo").val("");
		$("#stuName").val("");
		$("#sex").combobox("setValue","");
		$("#birthday").datebox("setValue","");
		$("#gradeId").val("");
		$("#stuDesc").val("");
	}
	
	function closeDoctorDialog(){
		  $("#dlg").dialog("close");
		  resetValue();
	  }
	
	function openDoctorModifyDialog(){
		 var selectedRows=$('#dg').datagrid('getSelections');
		  if(selectedRows.length!=1){
			 $.messager.alert("警告","只能选择一条对其进行修改");return;
		  }
		  var row=selectedRows[0];
		  $('#fm').form('load',row);
		  $('#officeName').val(row.office.officeName);
		  $('#officeNo').val(row.office.officeNo);
		  $('#dlg').dialog('open').dialog("setTitle","修改医生信息");
		  url="${pageContext.request.contextPath}/doctor/manage/save.do?id="+row.id;
	}

/* 	取二级对象的属性值 */
function formatOffice(val,row){
	return row.office.officeName;
}
function formatOffice2(val,row){
	return row.office.officeNo;
}
</script>
</head>
<body style="margin:5px">
	<table id="dg" title="医生信息管理" class="easyui-datagrid" fitColumns="true" pagination="true" fit="true"
	rownumbers="true" url="${pageContext.request.contextPath}/doctor/manage/list.do" toolbar="#tb">
	<thead>
			<tr>
			<th field="db" checkbox="true"></th>
			<th field="id" width="50" align="center">Id</th>
			<th field="userNo" width="50" align="center">职工号</th>
			<th field="userName" width="100" align="center">姓名</th>
			<th field="sex" align="center" width="50">性别</th>
			<th field="age" width="50" align="center">年龄</th>
			<th field="office.officeName" formatter="formatOffice" width="100" align="center" >科室名称</th>
			<th field="office.officeNo" width="150" align="center" hidden="true" formatter="formatOffice2">科室编号</th>
			<th field="degree" width="150" align="center">学历</th>
			</tr>
	</thead>
</table>
	<div id="tb">
	   <div>
	   <a href="javascript:openDoctorAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
	   <a href="javascript:openDoctorModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
	   <a href="javascript:deleteDoctor()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
	   </div>
	  <div>
	   &nbsp;职工号:&nbsp;<input type="text" name="s_userNo" id="s_userNo" size="10"/>
	 姓名:&nbsp;<input type="text" name="s_doctName" id="s_doctName" size="10"/>
	科室名称:&nbsp;<input class="easyui-combobox" editable="true", limitToList="true" name="s_officeNo" id="s_officeNo" size="10" data-options="panelHeight:'auto',editable:false,valueField:'officeNo',textField:'officeName',url:'${pageContext.request.contextPath}/office/comboList.do'"/>
	<a href="javascript:searchDoctor()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
	<a href="javascript:resetSearch()" class="easyui-linkbutton" iconCls="icon-reload" plain="true">重置</a>
	   </div>
	</div>
	
	<div id="dlg" class="easyui-dialog" closed="true" buttons="#dlg-btns" style="width:570px;height:400px;padding:10px 20px">
	<form id="fm" method="post">
	<table cellspacing="5px;">
		<tr> 
			<td>医生工号:</td>
			<td><input type="text" id="userNo" name="userNo" class="easyui-validatebox" required="true"></td>
			<td>医生姓名:</td>
			<td><input type="text" id="userName" name="userName" class="easyui-validatebox" required="true"></td>
		</tr>
		<tr>
		<td>性别:</td>
			<td>&nbsp;<select class="easyui-combobox" id="sex" name="sex" editable="false" panelHeight="auto" style="width:155px">
	 <option value="">请选择</option>
	 <option value="男">男</option>
	 <option value="女">女</option>
	 </select></td>
			<td>年龄:</td>
			<td><input type="text" id="age" name="age" class="easyui-validatebox" required="true"></td>
		</tr>
		<tr>
		   <td>学历:</td>
			<td><input type="text" id="degree" name="degree" class="easyui-validatebox" required="true"></td>
		</tr>
		<tr>
			<td>所属科室：</td>
			<td><input type="text" id="officeName" name="office.officeName" class="easyui-validatebox"></td>
			<td>所属科室编号：</td>
			<td><input type="text" id="officeNo" name="office.officeNo" class="easyui-validatebox" required="true"></td>
		</tr>
		<tr>
			<td valign="top">简介:</td>
			<td colspan="3"><textarea id="sign" name="sign" rows="7" cols="50"></textarea></td>
		</tr>
	</table>
	</form>
	</div>
	
	<div id="dlg-btns">
	<a href="javascript:saveDoctor()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closeDoctorDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>