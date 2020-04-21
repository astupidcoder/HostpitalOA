<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 <meta charset="utf-8">
  <meta name="renderer" content="webkit">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css">
<title>Insert title here</title>
</head>
<body>
              
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
  <legend>待病人如亲人 提高病人满意度</legend>
</fieldset>
 
    
  <div class="layui-row">
    <div class="layui-col-md9">
      <div class="grid-demo grid-demo-bg1">
      
      <ul class="layui-nav" lay-filter="">
  <li class="layui-nav-item">
 	 <a href="">预约挂号</a>
 	 <dl class="layui-nav-child">
	      <dd><a href="">电话预约</a></dd>
	      <dd><a href="">网上预约</a></dd>
   	 </dl>
   </li>
  <li class="layui-nav-item">
 	 <a href="">就医指南</a>
 	 <dl class="layui-nav-child">
	      <dd><a href="">选项1</a></dd>
	      <dd><a href="">选项2</a></dd>
	      <dd><a href="">选项3</a></dd>
    </dl>
  </li>
  <li class="layui-nav-item"><a href="">医生介绍</a></li>
  <li class="layui-nav-item">
    <a href="javascript:;">医院公告</a>
    <dl class="layui-nav-child"> <!-- 二级菜单 -->
      <dd><a href="">移动模块</a></dd>
      <dd><a href="">后台模版</a></dd>
      <dd><a href="">电商平台</a></dd>
    </dl>
  </li>
  <li class="layui-nav-item"><a href="">社区</a></li>
</ul>
      
      </div>
    </div>
    
    <div class="layui-col-md3">
      	<div class="grid-demo grid-demo-bg1">
		    <form class="layui-form" action="">
			  <div class="layui-form-item">
			    <div class="layui-input-block">
			      <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入标题" class="layui-input">
			    </div>
			  </div>
			      <button class="layui-btn layui-btn-primary">默认按钮</button>
		  	</form>
  		</div>
  	</div>
  </div>
 

 <script src="${pageContext.request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
layui.use('element', function(){
  var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块
  
  //监听导航点击
  element.on('nav(demo)', function(elem){
    //console.log(elem)
    layer.msg(elem.text());
  });
});
</script>
 
</body>
</html>