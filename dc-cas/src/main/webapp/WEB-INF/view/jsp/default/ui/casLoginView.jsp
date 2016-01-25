<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
<% 
request.setAttribute("ctx", request.getContextPath());
String path=request.getParameter("service")+"";
System.out.println(path);
if(null!=path && !"".equals(path) && !"null".equals(path)){
	
	request.setAttribute("tujunlbs",path.contains("tujunlbs"));
	request.setAttribute("qdgadzws",path.contains("qdgadzws"));
	
	String pathsqhttp=path.substring(path.indexOf("://")+3,path.length());
	String pathj=pathsqhttp.substring(0, pathsqhttp.indexOf("/j"));
	String imgName=pathsqhttp.substring(0, pathsqhttp.indexOf("/"));
	request.setAttribute("path",pathj);
	request.setAttribute("imgName",imgName);
}
%>

<meta charset="utf-8">
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" >
<title>SSO Login</title>
<link rel="stylesheet" href="${ctx}/css/normalize.css">
<link rel="stylesheet" href="${ctx}/css/base.css">
<link rel="stylesheet" href="${ctx}/css/bootstrap.min.css">
<link rel="stylesheet" href="${ctx}/css/font-awesome.min.css">
<link rel="stylesheet" href="${ctx}/css/site.css">
<link rel="stylesheet" href="${ctx}/css/login.css">

<script src="${ctx}/js/modernizr-2.8.3.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery-1.10.2.min.js"></script>
<%-- <script type="text/javascript" src="${ctx}/js/jquery-ui.js"></script> --%>
<!-- validate -->
<script src="${ctx}/plugins/nicevalidator0.7.0/jquery.validate.js" type="text/javascript"></script> 
<script type="text/javascript" src="${ctx}/js/ba-debug.min.js"></script>
<!-- MD5 -->
<%-- <script src="${ctx}/js/jquery.base64.js"></script>
<script src="${ctx}/js/jquery.md5.js"></script> --%>
<!-- cookie -->
<script src="${ctx}/js/jquery.cookie.js"></script>
<!--[if lte IE 9]>
<script src="${ctx}/js/jquery.placeholder.min.js"></script>
<script>$(function() {$('input[type="text"],input[type="password"], textarea').placeholder();});</script>
<![endif]--> 
<spring:theme code="cas.javascript.file" var="casJavascriptFile" text="" />
<script type="text/javascript" src="<c:url value="${casJavascriptFile}" />"></script> 
    
 <%-- <spring:theme code="standard.custom.css.file" var="customCssFile" /> --%>
<link rel="stylesheet" href="<c:url value="${customCssFile}" />" />
<link rel="icon" href="<c:url value="/favicon.ico" />" type="image/x-icon" />
    
</head>

<body class="login-bg">
<%--  <c:if test="${not pageContext.request.secure}">
  <div id="msg" class="errors">
    <h2>Non-secure Connection</h2>
    <p>You are currently accessing CAS over a non-secure connection.  Single Sign On WILL NOT WORK.  In order to have single sign on work, you MUST log in over HTTPS.</p>
  </div>
</c:if> --%>

<div class="login">
 	<h1 class="logo-login"><img src="http://${path}/resource/images/logo/${imgName}_login.png"  onerror="javascript:this.src='${ctx}/images/logo-login.png'" width="279"  alt="Tracker"/></h1>  
  <form:form method="post" id="fm1" commandName="${commandName}" htmlEscape="true">
  
    <span class="form-tip pa js-form-tip"><form:errors path="*" id="msg" cssClass="errors" htmlEscape="false" /></span>
    <div class="form-group form-username">
      <input type="text" class="form-control username" id="username" name="username" value="${sessionScope.openIdLocalId}" tabindex="1" placeholder="Name">
    </div>
    <div class="form-group form-password">
      <form:password cssClass="form-control password" cssErrorClass="error" id="password" size="25" tabindex="2" path="password"  accesskey="${passwordAccessKey}" htmlEscape="true" autocomplete="off" placeholder="Password"/>
    </div>
    <div class="form-checkbox"><%--<span class="fr"><a href="javascript:;" tabindex="5">注册</a><span>&nbsp;&nbsp;/&nbsp;&nbsp;</span><a href="javascript:;" tabindex="6">忘记密码？</a></span>--%> 
      <span class="checkbox pointer">
      <input type="checkbox" id="rememberMe" name="rememberMe" tabindex="3">
      </span>&nbsp;&nbsp;7天免登录</div>
    <div class="form-group">
      <input type="hidden" name="lt" value="${loginTicket}" />
      <input type="hidden" name="execution" value="${flowExecutionKey}" />
      <input type="hidden" name="_eventId" value="submit" />
      <button type="submit" class="btn btn-primary btn-block" id="loginBtn" name="submit" accesskey="l" tabindex="4" >登 录</button>
      <!--<button type="submit" class="btn btn-default btn-block "><i class="fa fa-spinner fa-pulse"></i>&nbsp;正在登录</button>-->
    </div>
  </form:form>
  
  <span><i class="mappin"></i><i class="mappin"></i> <i class="mappin"></i> <i class="mappin"></i> <i class="mappin"></i><i class="mappin"></i> <!-- --></span>
</div>
<c:if test="${qdgadzws==true}">
	<div class="right-center">
		<h1><img src="${ctx}/images/qrcode/qdgadzws-qrcode.png" width="115" height="115"></h1>
		<p><a href="http://download.jimicloud.com/webDown/tracker/iphone"><img src="${ctx}/images/Apple-down.jpg" width="115" height="43"></a></p>
		<p><a href="http://download.jimicloud.com/webDown/tracker/android"><img src="${ctx}/images/Android-down.jpg" width="115" height="43"></p>
		
	</div>
</c:if>
 <script type="text/javascript">
 jQuery(document).ready(function() { 
	//初始化判断是否记住密码
	if ($.cookie("rmbUser") == "true") { 
		$("#rememberMe").attr("checked", true); 
		$("#rememberMe").parent().addClass("checked");
		$("#username").val($.cookie("username")); 
		
	}else{
		$("#rememberMe").parent().removeClass("checked");
	}
	 
	 $("#fm1").validate({
	 	 onkeyup:false,
		 rules: {
			 	   username: {
	                   required: true
	               },
	               password: {
	                   required: true
	               }
	            },
	      messages:{
	    	  		username:{
	      			   required:"请输入用户名&nbsp;&nbsp;",
	      			},
	      			password: {
	                   required: "请输入密码"
	                }
	      },
	      errorPlacement: function(error, element) {  
	  	    error.appendTo($(".js-form-tip"));  
	  	  }
	});
	 
	 //勾选记住密码
	 $("#rememberMe").click(function(){
		var $this = $(this);
		if($this.prop("checked")) {
			 $this.parent().addClass("checked");
		}else{
			$(this).parent().removeClass("checked");
		}
	 });
	 
	 //记住密码和表单验证
	 $("#loginBtn").click(function(){
		$("#username").val($.trim($("#username").val()));
		$("#msg").remove();
		if ($("#rememberMe").prop("checked")) {
			var username = $("#username").val();
			$.cookie("rmbUser", "true", { expires: 7 });//存储一个带7天期限的cookie
			$.cookie("username", username, { expires: 7 });
			$this.parent().addClass("checked");
		}else{
			$.cookie("username", "", { expires: -1 });
		} 
	 });
 });
 </script>
 
</body>
</html>
