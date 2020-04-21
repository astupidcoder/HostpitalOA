<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row">
	  <div class="col-md-8">
	  <img class="icon" alt="白衣天使" src="${pageContext.request.contextPath}/static/images/hushi.jpg">
		待病人如亲人 提高病人满意度 
	  </div>
	  <div id="times">
    </div>
   <script type="text/javascript">
     function  getD1(){
         var date=new Date();
         var d1=date.toLocaleString();
         var div1=document.getElementById("times");
         div1.innerHTML =d1;
 
     }
 
     setInterval("getD1();",1000);
 
    </script>

	  <span>欢迎你，<font color=red><a href="${pageContext.request.contextPath}/patient/info.do">${currentUser.userName }</a></font></span>&nbsp;&nbsp;
	  <a href="${pageContext.request.contextPath}/patient/logout.do" style="color:green">退出</a>
	  <div class="col-md-4"><iframe width="420" scrolling="no" height="60" frameborder="0" allowtransparency="true" src="//i.tianqi.com/index.php?c=code&id=12&icon=1&num=5&site=12"></iframe></div>
</div>
	
