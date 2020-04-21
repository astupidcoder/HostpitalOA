<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>预约挂号</legend>
</fieldset>
 
<div class="layui-tab layui-tab-card">
  <ul class="layui-tab-title">
    <li id="tel" class="layui-this">电话预约</li>
    <li id="online">网上预约</li> 
  </ul>
  <div class="layui-tab-content">
    <div class="layui-tab-item layui-show" id="telCon">电话预约挂号及取号流程<br>

<strong>预约挂号：</strong>

电话预约拨打114或116114（外地010-114），全天24小时可预约。<br>

放号时间：<br>

<p>通过电话预约挂号可挂7日内的号源，周一至周五上午8:30投放出第7日新号源，下午14:00停止预约次日号源（周末及节假日除外）。</p>

就诊当日：<br>

<p>初次来院就诊患者需持患者本人预约时的有效证件先办理注册建档，二代身份证患者可在院内自助机办理注册建档，北京医保患者办理注册建档后需在院内自助机进行医保卡关联。</p>

<strong>取号方式：</strong>

1）院内自助机取号：<br>

     <p>持患者本人身份证或北京医保卡在指定时间内到医院院内自助机缴费取号，可使用任意银联标识的银行卡、微信和支付宝支付挂号费；</p>

2）手机APP取号：<br>

    <p> 已在我院注册建档的患者，可下载我院官方手机APP，注册后绑定患者信息，通过【预约取号】功能进行取号，北京医保患者在手机APP缴费取号后需持医保卡到院内自助机换医保卡，否则本次就诊为自费。</p>

取号时间：<br>

<p>上午号必须在就诊日上午9:00前取号，下午号必须在就诊日下午14:00前取号。<br>

取号成功后需先在院内自助机上报到，再到诊区候诊。<br>

退号规则：<br>

本号过期（超过预约就诊日期的工作开始时间）作废，一律不退号。 </div>
    <div class="layui-tab-item" id="onlineCon" height="100%">
    <%-- <div class="list-group" style="width:150px;float:left;">
	  <a href="#" class="list-group-item active">
	    按科室挂号
	  </a>
	  <a href="http://www.baidu.com" target="content" class="list-group-item">按疾病挂号</a>
	  <a href="${pageContext.request.contextPath}/doctor/list.do" target="content" class="list-group-item">按医生挂号</a>
	</div> --%>
	<form class="layui-form layui-form-pane" action="${pageContext.request.contextPath}/search/list.do">
	<div><h2>出诊信息查询</h2></div><br>
	<div class="layui-form-item">
	    <label class="layui-form-label">疾病名称</label>
	    <div class="layui-input-inline">
	      <input type="text" name="sickName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
	    </div>
    </div>
    
    	<div class="layui-form-item">
		    <label class="layui-form-label">科室名称</label>
		    <div class="layui-input-inline">
		      <input type="text" name="officeName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
		    </div>
   		 </div>
    
    	<div class="layui-form-item">
		    <label class="layui-form-label">医师名称</label>
		    <div class="layui-input-inline">
		      <input type="text" name="doctName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
		    </div>
   	   </div>
   	   <div style="width: 216px; margin: 0;">
      <!-- layui 2.2.5 新增 -->
      <button type="submit" class="layui-btn layui-btn-fluid" formtarget="content">选好了，去查询</button>
    </div>
   </form>
	<iframe name="content" src="" style="width:83%;height:450px" frameborder="0" scrolling="auto">
 		 <p>您的浏览器不支持  iframe 标签。</p>
	</iframe>
     </div>
    
  </div>
</div>


<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
layui.use('element', function(){
  var $ = layui.jquery
  ,element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块
  
  //触发事件
  var active = {
    tabAdd: function(){
      //新增一个Tab项
      element.tabAdd('demo', {
        title: '新选项'+ (Math.random()*1000|0) //用于演示
        ,content: '内容'+ (Math.random()*1000|0)
        ,id: new Date().getTime() //实际使用一般是规定好的id，这里以时间戳模拟下
      })
    }
    ,tabDelete: function(othis){
      //删除指定Tab项
      element.tabDelete('demo', '44'); //删除：“商品管理”
      
      
      othis.addClass('layui-btn-disabled');
    }
    ,tabChange: function(){
      //切换到指定Tab项
      element.tabChange('demo', '22'); //切换到：用户管理
    }
  };
  
  $('.site-demo-active').on('click', function(){
    var othis = $(this), type = othis.data('type');
    active[type] ? active[type].call(this, othis) : '';
  });
  
  //Hash地址的定位
  var layid = location.hash.replace(/^#test=/, '');
  element.tabChange('test', layid);
  
  element.on('tab(test)', function(elem){
    location.hash = 'test='+ $(this).attr('lay-id');
  });
  
});
</script>
