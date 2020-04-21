<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>联系人管理</title>
<script src="${pageContext.request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css"  media="all">
<script type="text/html" id="titleTpl">
{{# if(d.doctor==null){ }}
{{d.userName}}
{{# } else{ }}
<a href="${pageContext.request.contextPath}/doctor/info/{{d.doctor.userNo}}.html" class="layui-table-link">{{d.doctor.userName}}</a>
{{# } }}
</script>
<script type="text/html" id="telTpl">
{{# if(d.doctor==null){ }}
{{d.tel}}
{{# } else{ }}
{{d.doctor.tel}}
{{# } }}
</script>

<script type="text/html" id="qqTpl">
{{# if(d.doctor==null){ }}
<li><a href="http://wpa.qq.com/msgrd?v=3&uin={{d.qq}}&site=qq&menu=yes"><span></span><em>{{d.qq}}</em></a></li>
{{# } else{ }}
<li><a href="http://wpa.qq.com/msgrd?v=3&uin={{d.doctor.qq}}&site=qq&menu=yes"><span></span><em>{{d.doctor.qq}}</em></a></li>
{{# } }}
</script>

<script type="text/html" id="emailTpl">
{{# if(d.doctor==null){ }}
{{d.email}}
{{# } else{ }}
{{d.doctor.email}}
{{# } }}
</script>


</head>
<body><br>
<div class="layui-input-inline">
      <input type="text" name="searchName" id="searchName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
    </div>&nbsp;&nbsp;&nbsp; <button class="layui-btn layui-btn-warm" onclick="search()"><i class="layui-icon">&#xe615;</i>搜索</button>		
    <br><br>
 <div class="layui-btn-group demoTable">
  <button class="layui-btn" data-type="getCheckData"><i class="layui-icon">&#xe640;</i>删除选中行数据</button>
  <button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
  <button class="layui-btn" data-type="isAll">验证是否全选</button>
  <button class="layui-btn layui-btn-normal" onclick="add()"><i class="layui-icon">&#xe608;</i>添加联系人</button>
</div>

<table class="layui-hide" id="test" lay-filter="test"></table> 	

<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail" id="download"><i class="layui-icon">&#xe702;</i>查看</a>
  <a class="layui-btn layui-btn-xs" lay-event="edit"><i class="layui-icon">&#xe642;</i>编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon">&#xe640;</i>删除</a>
</script>

<script>
layui.use('table', function(){
  var table = layui.table;
  
  table.render({
    elem: '#test'
    ,url:'${pageContext.request.contextPath}/contact/list.do?userNo='+${currentUser.userNo}
     ,cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
    ,cols: [[
    	{width:50,type:'checkbox', fixed: 'left',align:'center'},
      {field:'id', width:80, align:'center',title: 'ID', sort: true}
      ,{field:'username', width:80,align:'center', title: '姓名',templet: '#titleTpl'
      },
     /*  {field:'officeName', width:180, align:'center',title: '科室',templet:function(d){
          return d.doctor.office.officeName;
        }},
        {field:'degree', width:180,align:'center', title: '学历',templet: '<div>{{d.doctor.degree}}</div>'
        }, */
        {field:'tel', width:180,align:'center', title: '电话',templet:'#telTpl' 
        },
        {field:'email', width:180,align:'center', title: '邮箱',templet: '#emailTpl'
        },
        {field:'qq', width:180,align:'center', title: 'QQ',templet: '#qqTpl'
        },
       {fixed: 'right', width:250, align:'center', toolbar: '#barDemo'
        }
     /*  ,{field:'sign', title: '签名', width: '30%', minWidth: 100} //minWidth：局部定义当前单元格的最小宽度，layui 2.2.1 新增
      ,{field:'wealth', width:137, title: '财富', sort: true} */
    ]]
    ,page: true
    ,response: {
      statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
    }
    ,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据
      return {
        "code": res.status, //解析接口状态
        "msg": res.message, //解析提示文本
        "count": res.total, //解析数据长度
        "data": res.rows//解析数据列表
      };
    }
  });
  
  
//监听表格复选框选择
  table.on('checkbox(test)', function(obj){
    console.log(obj)
  });
  //监听工具条
  table.on('tool(test)', function(obj){
    var data = obj.data;
    if(obj.event === 'detail'){
    	if(data.doctor==null){
    	      layer.msg(data.remark);
    	}else{
      layer.msg(data.doctor.userName+"<br>"+data.doctor.office.officeName+"<br>"+data.doctor.degree+"<br>"+data.remark);
    	}
    // $("#download").attr("href",""+data.logName+"'")
   //  alert($("#download").attr("href"));
	//window.open("${pageContext.request.contextPath}/log/download.do?id="+data.id);
     //$("#download").attr("href","${pageContext.request.contextPath}/log/download.do?id='"+data.id+"'");
    } else if(obj.event === 'del'){
      layer.confirm('真的删除本条数据么？', function(index){
        obj.del();
        layer.close(index);
        $.post("${pageContext.request.contextPath}/contact/delete.do?delIds="+data.id,{},
        function(r){
        	var result=eval('(' + r + ')'); 
        	if(result.success){
        	layer.msg("删除成功");
        	}else{
        		layer.msg("删除失败");
        	}
        }		
        );
      });
    } else if(obj.event === 'edit'){
      //layer.alert('编辑行：<br>'+ data.tel);
    	if(data.doctor==null){
  	      //layer.msg(data.remark);
  	//  layer.alert(data.qq);	
  	    //var result=eval('('+data+')');
  	   // var result=JSON.stringify(data);
    		modifyInfo(data);
  	}else{
    layer.msg(data.doctor.userName+"<br>"+data.doctor.office.officeName+"<br>"+data.doctor.degree+"<br>"+data.remark);
  	}
    }
  });
  
  var $ = layui.$, active = {
    getCheckData: function(){ //获取选中数据
      var checkStatus = table.checkStatus('test')
      ,data = checkStatus.data;
  	if(data.length==0){
		layer.msg('请先选择要删除的数据行！');
		return ;
	}
    var strIds=[];
    if(data.length>0){
    	for(var i=0;i<data.length;i++)
    	strIds+=data[i].id+",";
    }
      //layer.alert(strIds);
      layer.confirm("确定要删除<font color=red>"+data.length+"</font>条数据吗？", function(){
    	  //alert(index);
      $.post("${pageContext.request.contextPath}/contact/delete.do",{delIds:strIds},
    	        function(r){
    	        	var result=eval('(' + r + ')'); 
    	        	if(result.success){
    	        	layer.msg("删除成功!!!",{icon: 1,time:2000,shade:3});
			        location.reload(true);
    	        	}else{
    	        		layer.msg("删除失败!!!");
    	        	}
    	        }		
    	        );
      });
    }
    ,getCheckLength: function(){ //获取选中数目
      var checkStatus = table.checkStatus('test')
      ,data = checkStatus.data;
      layer.msg('选中了：'+ data.length + ' 个');
    }
    ,isAll: function(){ //验证是否全选
      var checkStatus = table.checkStatus('test');
      layer.msg(checkStatus.isAll ? '全选': '未全选')
    }
  };
  
  $('.demoTable .layui-btn').on('click', function(){
    var type = $(this).data('type');
    active[type] ? active[type].call(this) : '';
  });
});


</script>


<form  class="layui-form" style="display:none" id="infoForm" name="infoForm" lay-filter="infoForm" action="${pageContext.request.contextPath}/contact/save.do" method="post">

   <input type="hidden" name="userNo1" value=${currentUser.userNo } lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
   <input type="hidden" name="flag" id="flag" value="1">
      <input type="hidden" name="id">
 <div class="layui-form-item">
    <label class="layui-form-label">姓名：</label>
    <div class="layui-input-inline">
      <input type="text" name="userName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
    </div>
  </div>

    
  <div class="layui-form-item">
    <div class="layui-inline">
      <label class="layui-form-label">手机:</label>
      <div class="layui-input-inline">
        <input type="tel" name="tel" lay-verify="required|phone" autocomplete="off" class="layui-input">
      </div>
    </div>
  
   <div class="layui-inline">
      <label class="layui-form-label">邮箱:</label>
      <div class="layui-input-inline">
        <input type="text" name="email" lay-verify="email" autocomplete="off" class="layui-input">
      </div>
    </div>
  
    <div class="layui-form-item">
    <label class="layui-form-label">QQ：</label>
    <div class="layui-input-inline">
      <input type="text" name="qq" lay-verify="required|number" placeholder="请输入" autocomplete="off" class="layui-input">
    </div>
  </div>
  
  
  
  <div class="layui-form-item layui-form-text">
    <label class="layui-form-label">备注：</label>
    <div class="layui-input-block">
      <textarea placeholder="请输入内容" class="layui-textarea" name="remark"></textarea>
    </div>
  </div>
  
   <div class="layui-form-item">
    <div class="layui-input-block">
      <button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
    </div>
  </div>
</form>



<script>
layui.use(['form', 'layedit', 'laydate'], function(){
  var form = layui.form
  ,layer = layui.layer
  ,layedit = layui.layedit
  ,laydate = layui.laydate;
  

  
  //自定义验证规则
  form.verify({
    title: function(value){
      if(value.length < 5){
        return '标题至少得5个字符啊';
      }
    }
    ,qq:[
      /^[\S]{6,12}$/
      ,'qq必须6到12位，且不能出现空格'
    ]
 
  });

  
  //监听提交
  form.on('submit(demo1)', function(data){
	  layer.alert(JSON.stringify(data.field), {
	      title: '最终的提交信息'
	    });
	 /* $.post("${pageContext.request.contextPath}/contact/save.do",data,
			 function(result){
		 if(result.success){
			 layer.alert("提交成功！"); 
		 }else{
			 layer.alert("提交失败！");
		 }
	 }); */
   /*  layer.alert(JSON.stringify(data.field), {
      title: '最终的提交信息'
    }); */
  });
 
  
  
  
});

</script>
<script>
function modifyInfo(data){
	 // alert(JSON.stringify(data));
	  $("#flag").val("1"); //flag标志为修改状态
	layui.use('form', function(){
		  var form = layui.form;
		  
		  //各种基于事件的操作，下面会有进一步介绍
	//表单初始赋值
	  form.val('infoForm', {
		 "id":data.id
		 ,"userName": data.userName// "name": "value"
	    ,"tel":data.tel
	    ,"email":data.email
	    ,"qq":data.qq
	    ,"remark":data.remark
	    
	  }) 
	  //form.render(null, 'infoForm');
		});
layer.open({
	  type: 1,
	  content: $('#infoForm') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
	});
}

//新增联系人
function add(){
	$("#flag").val("0");  //flag标志改为添加状态，在后台判断
	layer.open({
		  type: 1,
		  content: $('#infoForm') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
		});
}
</script>
<script>
function search(){
	layui.use('table', function(){
		  var table = layui.table;
table.reload('test', {
	  where: { //设定异步数据接口的额外参数，任意设
	    searchName: $("#searchName").val()
	
	  }
	  ,page: {
	    curr: 1 //重新从第 1 页开始
	  }
	});
});
};
</script>
</body>
</html>