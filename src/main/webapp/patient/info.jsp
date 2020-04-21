<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css"  media="all">
<script src="${pageContext.request.contextPath}/static/layui/layui.js" charset="utf-8"></script>

</head>
<body>
<form class="layui-form" action="">
 <div class="layui-form-item">
    <label class="layui-form-label">姓名：</label>
    <div class="layui-input-inline">
      <input type="text" name="username" lay-verify="required" value="${currentUser.userName }" autocomplete="off" class="layui-input">
    </div>
    
     <label class="layui-form-label">当前状态：</label>
    <div class="layui-input-inline">
      <input type="text" name="status" lay-verify="required" value="${currentUser.status }" autocomplete="off" class="layui-input">
    </div>
    
  </div>
  
  
  <div class="layui-form-item">
    <div class="layui-inline">
      <label class="layui-form-label">手机：</label>
      <div class="layui-input-inline">
        <input type="tel" name="phone" lay-verify="required|phone" autocomplete="off" value="${currentUser.tel }" class="layui-input">
      </div>
    </div>
    <div class="layui-inline">
      <label class="layui-form-label">邮箱：</label>
      <div class="layui-input-inline">
        <input type="text" name="email" lay-verify="email" value="${currentUser.email }" autocomplete="off" class="layui-input">
      </div>
    </div>
    
    <div class="layui-form-item">
    <label class="layui-form-label">性别：</label>
    <div class="layui-input-block">
      <input type="radio" name="sex" value="男" title="男" checked="">
      <input type="radio" name="sex" value="女" title="女">
      <input type="radio" name="sex" value="禁" title="禁用" disabled="">
    </div>
    
    <div class="layui-form-item">
    <label class="layui-form-label">身高：</label>
    <div class="layui-input-inline">
      <input type="text" name="height" value="${currentUser.height }" lay-verify="required" autocomplete="off" class="layui-input">
    </div>
  </div>
  
    
      <div class="layui-form-item">
    <label class="layui-form-label">血型:</label>
    <div class="layui-input-block">
      <select name="bloodType" lay-filter="aihao">
        <option value=""></option>
        <option value="0">A</option>
        <option value="1" selected="">B</option>
        <option value="2">O</option>
        <option value="3">AB</option>
      </select>
    </div>
  </div>
   
   <div class="layui-inline">
      <label class="layui-form-label">出生日期</label>
      <div class="layui-input-inline">
     <%--  
      <fmt:parseDate value="${currentUser.birthday }" var="birthday" 
                              pattern="yyyy-MM-dd hh:mm:ss" /> --%>
        <input type="text" name="date" id="date"  value="${currentUser.birthday }" lay-verify="date" autocomplete="off" class="layui-input">
      </div>
    </div>
    
    <div class="layui-form-item">
    <label class="layui-form-label">联系地址：</label>
    <div class="layui-input-block">
      <input type="text" name="address" lay-verify="title" autocomplete="off" value="${currentUser.address }" class="layui-input">
    </div>
  </div>
  </div>
  </div>
  </form>
  
<script>
layui.use(['form', 'layedit', 'laydate'], function(){
  var form = layui.form
  ,layer = layui.layer
  ,layedit = layui.layedit
  ,laydate = layui.laydate;
  
  //日期
  laydate.render({
    elem: '#date'
  });
  laydate.render({
    elem: '#date1'
  });
  
  //创建一个编辑器
  var editIndex = layedit.build('LAY_demo_editor');
 
  //自定义验证规则
  form.verify({
    title: function(value){
      if(value.length < 5){
        return '标题至少得5个字符啊';
      }
    }
    ,pass: [
      /^[\S]{6,12}$/
      ,'密码必须6到12位，且不能出现空格'
    ]
    ,content: function(value){
      layedit.sync(editIndex);
    }
  });
  
  //监听指定开关
  form.on('switch(switchTest)', function(data){
    layer.msg('开关checked：'+ (this.checked ? 'true' : 'false'), {
      offset: '6px'
    });
    layer.tips('温馨提示：请注意开关状态的文字可以随意定义，而不仅仅是ON|OFF', data.othis)
  });
  
  //监听提交
  form.on('submit(demo1)', function(data){
    layer.alert(JSON.stringify(data.field), {
      title: '最终的提交信息'
    })
    return false;
  });
 
  //表单初始赋值
  form.val('example', {
    "username": "贤心" // "name": "value"
    ,"height": ${currentUser.height}
    ,"bloodType": 1
    ,"like[write]": true //复选框选中状态
    ,"close": true //开关状态
    ,"sex":${currentUser.sex}
    ,"address": ${currentUser.address}
  })
  
  
});
</script>
</body>
</html>