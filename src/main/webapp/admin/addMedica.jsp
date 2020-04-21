<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*"
    import="com.ysu.dao.MedicaClassDao" import="com.ysu.util.DbUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>增加药品</title>
<link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.5.2/themes/icon.css">
<link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.5.2/themes/default/easyui.css">
<script type="text/javascript" src="jquery-easyui-1.5.5.2/jquery.min.js"></script>
<script type="text/javascript" src="jquery-easyui-1.5.5.2/jquery.easyui.min.js"></script>
<script type="text/javascript" src="jquery-easyui-1.5.5.2/locale/easyui-lang-zh_CN.js"></script>
<script>
$(function(){
	
})
function submitForm(){
	$("#fm").form("submit",{
		//url:"addMedica",
		onSubmit:function(){
			return $(this).form("validate");
	},
	  success:function(result){
		  var data=eval('('+result+')');
		  if(data.success){
			  $.messager.alert({
				  title:"系统提示",
				  msg:"药品添加成功！",
				  fn:function(){
					  window.location.href="medica.jsp";
				  }
			  })
		  }else{
			  $.messager.alert({
				  title:"系统提示",
				  msg:"药品添加失败！！！",
				  fn:function(){
					  
				  }
			  })
		  
	  }
	}
	})
}
function resetValue(){
	$("#fm").form('clear');
}
</script>
</head>
<body>
<div align="center">
   <form id="fm" action="addMedica" method="post" class="easyui-form">
<br>&nbsp;&nbsp;&nbsp;名称:&nbsp;&nbsp;<input class="easyui-textbox" name="name" required=true style="width:15%"/><br><br>
    所属类别 :&nbsp;<select class="easyui-combobox" name="className" style="width:15%">
    <%
 
    DbUtil dbUtil=new DbUtil();
   Connection con=null;
   try{
   	con=dbUtil.getCon();
   }catch(Exception e){
   	e.printStackTrace();
   }
  MedicaClassDao medicaClassDao=new MedicaClassDao();
  ResultSet rs=medicaClassDao.medicaClassList(con);
   while(rs.next()){
    
    out.println("<option value="+rs.getInt(1)+">"+rs.getString(2)+"</option>");
   }
   	rs.close();
     dbUtil.closeCon(con);
   %>
    </select><br><br>
  &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;价格:&nbsp;&nbsp;<input class="easyui-numberbox" name="price" required=true style="width:15%"/>&nbsp;元/两<br><br>
  &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;库存:&nbsp;&nbsp;<input class="easyui-numberbox" name="volume" required=true style="width:15%"/>&nbsp;斤<br><br>
   生产日期:&nbsp;&nbsp;<input class="easyui-datebox" name="pdate" required=true style="width:15%"/><br><br>
   生产商:&nbsp;&nbsp;<input class="easyui-textbox" name="producer" required=true style="width:15%"/><br><br>
   <a class="easyui-linkbutton" onClick="submitForm()">提交</a>&nbsp;&nbsp;&nbsp;&nbsp;<a class="easyui-linkbutton" onclick="resetValue()">重置</a>
   </form>
   </div>
</body>
</html>