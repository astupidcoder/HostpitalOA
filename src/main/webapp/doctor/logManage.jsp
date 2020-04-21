<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css"  media="all">
<script src="${pageContext.request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<!--转换时间格式-->
<script type="text/javascript">
 function dateToStr(date) {
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
 console.log(str);
 return str;
 }
</script>
</head>
<body>
<a href="${pageContext.request.contextPath}/static/log/wallhaven-582006.jpg" download>下载</a>
<br>
<button type="button" class="layui-btn" id="fileBtn"><i class="layui-icon"></i>上传文件</button>
<br><br>
<script>
layui.use('upload', function(){
  var $ = layui.jquery
  ,upload = layui.upload;
  //指定允许上传的文件类型
  upload.render({ //允许上传的文件后缀
    elem: '#fileBtn'
    ,url: '${pageContext.request.contextPath}/log/upload.do'
    ,data:{
    	userNo:"${currentUser.userNo}"
    }
    ,accept: 'file' //普通文件
    /* ,exts: 'zip|rar|7z' //只允许上传压缩文件 */
    ,done: function(res){
      console.log(res.msg);
      if(res.data=="true"){
    	  layer.msg('上传成功！', {
    	        time: 20000, //20s后自动关闭
    	        btn: ['知道了']
    	      });
    	layui.use('table', function(){
    		  var table = layui.table;   	  
    	  table.reload('idTest', {
    		  where: { //设定异步数据接口的额外参数，任意设
    		  }
    		  ,page: {
    		    curr: 1 //重新从第 1 页开始
    		  }
    		});
    	});
      }else{
    	  layer.msg('上传失败！', {
  	        time: 20000, //20s后自动关闭
  	        btn: ['知道了']
  	      });
      }
    }
  });

  });
</script>

 
<div class="layui-btn-group demoTable">
  <button class="layui-btn" data-type="getCheckData">获取选中行数据</button>
  <button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
  <button class="layui-btn" data-type="isAll">验证是否全选</button>
</div>
 
<table class="layui-table" lay-data="{width: 892, height:332, url:'${pageContext.request.contextPath}/log/list.do?userNo=${currentUser.userNo }', page:true, id:'idTest'}" lay-filter="demo">
  <thead>
    <tr>
      <th lay-data="{type:'checkbox', fixed: 'left',align:'center'}"></th>
      <th lay-data="{field:'id', width:100, sort: true, fixed: true,align:'center'}">ID</th>
      <th lay-data="{field:'userNo', width:150,align:'center'}">用户编号</th>
      <th lay-data="{field:'logName', width:200, sort: true,align:'center'}">日志</th>
      <th lay-data="{field:'date', width:200, sort: true,align:'center',templet:'<div>{{dateToStr(d.date)}}</div>'}">时间</th>
      <th lay-data="{fixed: 'right', width:170, align:'center', toolbar: '#barDemo'}"></th>
    </tr>
  </thead>
</table>
 
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail" id="download">查看</a>
  <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
               
<script>
layui.use('table', function(){
  var table = layui.table;
  //监听表格复选框选择
  table.on('checkbox(demo)', function(obj){
    console.log(obj)
  });
  //监听工具条
  table.on('tool(demo)', function(obj){
    var data = obj.data;
    if(obj.event === 'detail'){
     // layer.msg('ID：'+ data.logName + ' 的查看操作');
    // $("#download").attr("href",""+data.logName+"'")
   //  alert($("#download").attr("href"));
	window.open("${pageContext.request.contextPath}/log/download.do?id="+data.id);
     //$("#download").attr("href","${pageContext.request.contextPath}/log/download.do?id='"+data.id+"'");
    } else if(obj.event === 'del'){
      layer.confirm('真的删除行么', function(index){
        obj.del();
        layer.close(index);
      });
    } else if(obj.event === 'edit'){
      layer.alert('编辑行：<br>'+ JSON.stringify(data))
    }
  });
  
  var $ = layui.$, active = {
    getCheckData: function(){ //获取选中数据
      var checkStatus = table.checkStatus('idTest')
      ,data = checkStatus.data;
      layer.alert(JSON.stringify(data));
    }
    ,getCheckLength: function(){ //获取选中数目
      var checkStatus = table.checkStatus('idTest')
      ,data = checkStatus.data;
      layer.msg('选中了：'+ data.length + ' 个');
    }
    ,isAll: function(){ //验证是否全选
      var checkStatus = table.checkStatus('idTest');
      layer.msg(checkStatus.isAll ? '全选': '未全选')
    }
  };
  
  $('.demoTable .layui-btn').on('click', function(){
    var type = $(this).data('type');
    active[type] ? active[type].call(this) : '';
  });
});
</script>
</body>
</html>