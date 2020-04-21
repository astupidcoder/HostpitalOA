<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
   %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>药品信息</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
  $(function(){
	
  })
  
  function delMedica(){
	  var selectedRows=$('#dg').datagrid('getSelections');
		 if(selectedRows.length==0){
			 $.messager.alert("系统提醒","请选择要删除的对象");
			 return;
		 }
		 var strIds=[];
		 for(var i=0;i<selectedRows.length;i++){
			 strIds.push(selectedRows[i].medicaId);
		 }
		 var ids=strIds.join(",");
		 alert(strIds);
		 $.messager.confirm("系统提示","你确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			 if(r){
				 $.post("${pageContext.request.contextPath}/medica/delete.do",{delIds:ids},function(result){
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
  
  
  function modifyMedica(){
	  var selectedRows=$('#dg').datagrid('getSelections');
	  if(selectedRows.length!=1){
		 $.messager.alert("警告","请选择一条对其进行修改");return;
	  }
	  var row=selectedRows[0];
	  alert(row.medicaClass.className);
	 // $('#fm').form('load',row);
	  $("#className").val(row.medicaClass.className);
	/*   $('#officeName').val(row.office.officeName);
	  $('#officeNo').val(row.office.officeNo); */
	  $('#dlg').dialog('open').dialog("setTitle","修改药品信息");
	  url="${pageContext.request.contextPath}/doctor/manage/save.do?id="+row.id;
		  window.location.href="modifyMedica.jsp?modifyId="+strIds;
}
	 
  function searchMedica(){
		$('#dg').datagrid('load',{
			searchName:$('#s_MedicaName').val()
		});
  }
  
  /* 	取二级对象的属性值 */
  function formatClass(val,row){
  	return row.medicaClass.className;
  }
 
  <!--转换时间格式-->
   function dateToStr(val,row) {
	var date=row.pdate;
   var time = new Date(date.time);
   var y = time.getFullYear();
   var M = time.getMonth() + 1;
   M = M < 10 ? ("0" + M) : M;
   var d = time.getDate();
   d = d < 10 ? ("0" + d) : d;
   var h = time.getHours();
   h = h < 10 ? ("0" + h) : h;
   var m = time.getMinutes();
   m = m < 10 ? ("0" + m) : m;
   var s = time.getSeconds();
   s = s < 10 ? ("0" + s) : s;
   var str = y + "-" + M + "-" + d + " " + h + ":" + m + ":" + s;
   return str;
   }
</script>
</head>
<body>
<table id="dg" title="药品信息管理" class="easyui-datagrid" fitColumns="true" pagination="true" fit="true"
	rownumbers="true" url="${pageContext.request.contextPath}/medica/list.do" toolbar="#tb">
	<thead>
			<tr>
			<th field="db" checkbox="true"></th>
			<th field="medicaId" width="50" align="center">药品编号</th>
			<th field="name" width="100" align="center">名称</th>
			<th field="price" width="50" align="center">价格</th>
			<th field="volume" width="50" align="center">库存</th>
			<th field="pdate" width="50" align="center" formatter="dateToStr">生产日期</th>
			<th field="producer" width="50" align="center">生产商</th>
			<th field="medicaClass.className" formatter="formatClass" width="100" align="center" >所属类别</th>
			</tr>
	</thead>
</table>

<div id="tb">
	  <input type="text" name="s_MedicaName" id="s_MedicaName" data-options="iconCls:'icon-search'"  prompt='请输入药品名称...'/>
	 <a class="easyui-linkbutton" name="searchBtn" id="searchBtn" href="javascript:searchMedica()">查询</a>&nbsp;&nbsp;
	 <a class="easyui-linkbutton" name="delBtn" id="delBtn" href="javascript:delMedica()">删除选中药品</a>&nbsp;&nbsp;
	 <a class="easyui-linkbutton" name="modifyBtn" id="modifyBtn" href="javascript:modifyMedica()">修改</a>
	 <br>
</div>

<div id="dlg" class="easyui-dialog" closed="true" style="width:570px;height:400px;padding:10px 20px">
	 <form id="fm" method="post" class="easyui-form">
	     药品编号 :&nbsp;&nbsp;<input class="easyui-textbox" name="medicaId" readonly><br>
	   名称 :&nbsp;&nbsp;<input class="easyui-textbox" name="name" required=true><br>
	     所属类别 :&nbsp;&nbsp;<select class="easyui-combobox" name="className" id="className">
	    </select><br>
	   价格:&nbsp;&nbsp;<input class="easyui-numberbox" name="price"required=true>&nbsp;元/两<br>
	   库存:&nbsp;&nbsp;<input class="easyui-numberbox" name="volume" required=true>&nbsp;斤<br>
	   生产日期:&nbsp;&nbsp;<input class="easyui-datebox" name="pdate"  required=true><br>
	   生产商:&nbsp;&nbsp;<input class="easyui-textbox" name="producer"  required=true><br>
	   <a href="javascript:void(0)" class="easyui-linkbutton" onClick="submitForm()">提交</a>&nbsp;&nbsp;&nbsp;&nbsp;<a class="easyui-linkbutton" onClick="backWard()">返回</a>
	 </form>
 </div>
</body>
</html>