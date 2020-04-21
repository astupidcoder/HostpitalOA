<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"
     import="com.ysu.dao.MedicaDao" import="com.ysu.util.DbUtil"
     import="com.ysu.dao.MedicaClassDao"
     %>
<%
String name="";
float volume=0;
String classId="";
String producer="";
Double price=0.0;
Date pdate=null;
String modifyId=request.getParameter("modifyId");
 DbUtil dbUtil=new DbUtil();
Connection con=null;
try{
	con=dbUtil.getCon();
}catch(Exception e){
	e.printStackTrace();
}
MedicaDao medicaDao=new MedicaDao();
ResultSet rs=medicaDao.medicaList(con,null,Integer.parseInt(modifyId));
if(rs.next()){
	name=rs.getString("name");
	price=rs.getDouble("price");
	volume=rs.getFloat("volume");
	 pdate=rs.getDate("pdate");
	producer=rs.getString("producer");
	classId=rs.getString("classId");
}
	rs.close();
  dbUtil.closeCon(con);
	


%>
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
function submitForm(){
	$("#fm").form("submit",{
		url:"modifyMedica",
		onSubmit:function(){
			return $(this).form("validate");
		},
		success:function(data){
			var data=eval('('+data+')');
			if(data.success){
				$.messager.alert({
					title:"系统提示",
					msg:"修改成功！！！",
					fn:function(){
						window.location.href='medica.jsp';
					}
					});
				}
			else{
				$.messager.alert({
					title:"系统提示",
					msg:"修改失败！！",
					fn:function(){
						window.location.href='modifyMedica.jsp';
					}
					});
				//setTimeout("window.location.href='modifyMedica.jsp';",1000);
			}
		}
	})
}

function backWard(){
	window.location.assign("medica.jsp");
}

</script>
</head>
<body>
<div align="center">
   <form id="fm" method="post" class="easyui-form">
     药品编号 :&nbsp;&nbsp;<input class="easyui-textbox" name="medicaId" value=<%=modifyId %> readonly><br>
   名称 :&nbsp;&nbsp;<input class="easyui-textbox" name="name" value=<%=name %> required=true><br>
     所属类别 :&nbsp;&nbsp;<select class="easyui-combobox" name="className">
    <%

   try{
   	con=dbUtil.getCon();
   }catch(Exception e){
   	e.printStackTrace();
   }
  MedicaClassDao medicaClassDao=new MedicaClassDao();
  ResultSet rs1=medicaClassDao.medicaClassList(con);
   while(rs1.next()){
    if(Integer.parseInt(classId)==rs1.getInt(1)){
    	out.println("<option value="+rs1.getInt(1)+" selected>"+rs1.getString(2)+"</option>");
    }else{
    out.println("<option value="+rs1.getInt(1)+">"+rs1.getString(2)+"</option>");
    }
   }
   	rs1.close();
     dbUtil.closeCon(con);
   %>
    </select><br>
   价格:&nbsp;&nbsp;<input class="easyui-numberbox" name="price" value=<%=price %> required=true>&nbsp;元/两<br>
   库存:&nbsp;&nbsp;<input class="easyui-numberbox" name="volume" value=<%=volume %> required=true>&nbsp;斤<br>
   生产日期:&nbsp;&nbsp;<input class="easyui-datebox" name="pdate" value=<%=pdate %> required=true><br>
   生产商:&nbsp;&nbsp;<input class="easyui-textbox" name="producer" value=<%=producer %> required=true><br>
   <a href="javascript:void(0)" class="easyui-linkbutton" onClick="submitForm()">提交</a>&nbsp;&nbsp;&nbsp;&nbsp;<a class="easyui-linkbutton" onClick="backWard()">返回</a>
   </form>
   </div>
</body>
</html>