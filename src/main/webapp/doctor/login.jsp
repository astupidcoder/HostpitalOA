<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登陆页面</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap3/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap3/css/bootstrap-theme.min.css">
<script src="${pageContext.request.contextPath}/static/bootstrap3/js/jquery-1.11.2.min.js"></script>
<script src="${pageContext.request.contextPath}/static/bootstrap3/js/bootstrap.min.js"></script>
</head>
 <style type="text/css">
	  body {
        padding-top: 200px;
        padding-bottom: 40px;
        background-image: url('${pageContext.request.contextPath}/static/images/star.gif');
      }
      
      .form-signin-heading{
      	text-align: center;
      }

      .form-signin {
        max-width: 300px;
        padding: 19px 29px 0px;
        margin: 0 auto 20px;
        background-color: #fff;
        border: 1px solid #e5e5e5;
        -webkit-border-radius: 5px;
           -moz-border-radius: 5px;
                border-radius: 5px;
        -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
           -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
                box-shadow: 0 1px 2px rgba(0,0,0,.05);
      }
      .form-signin .form-signin-heading,
      .form-signin .checkbox {
        margin-bottom: 10px;
      }
      .form-signin input[type="text"],
      .form-signin input[type="password"] {
        font-size: 16px;
        height: auto;
        margin-bottom: 15px;
        padding: 7px 9px;
      }

</style>     
<script type="text/javascript">
function reset(){
	document.getElementById("userName").value="";
	document.getElementById("password").value="";
	return;
}
</script>
<body>
<div style="text-align:center" class="container">
	<form method="post" action="${pageContext.request.contextPath}/doctor/login.do" name="myForm" class="form-signin">
			<h2 class="form-signin-heading">医生登录</h2>
			
		用户名：<input type="text" class="form-control" name="userNo" id="userName" value="${doctor.userNo }" placeholder="你若盛开，清风自来"><br>
		密码：&nbsp;&nbsp;&nbsp;<input type="password" class="form-control" name="password" id="password" value="${doctor.password }" placeholder="请输入密码"><br>
		<input type="checkbox" id="remember" name="remember" value="remember-me">记住我&nbsp;&nbsp;&nbsp;<font color="red">${errorInfo }</font><br>
		<button type="submit" class="btn btn-large btn-primary">登陆</button>&nbsp;&nbsp;&nbsp;
		<button type="button" class="btn btn-large btn-primary" onclick="reset()">重置</button>
   </form>
</div>
</body>
</html>