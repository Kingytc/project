<%@ page import="com.sai.laps.helper.*,java.net.*,java.util.Enumeration;"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<%
	response.addHeader("P3P","CP=\"IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT\"");
	response.addHeader("X-UA-Compatible","IE=EmulateIE8");
	response.setHeader("X-Frame-Options", "SAMEORIGIN");
	response.setHeader("X-XSS-Protection", "1;mode=block"); 
	response.setHeader("X-Content-Type-Options", "nosniff"); 
	response.setHeader("X-Permitted-Cross-Domain-Policies", "none"); 
%>
<%
	Enumeration enumSession = session.getAttributeNames();
	while (enumSession.hasMoreElements()) {
		String strName = (String) enumSession.nextElement();
		session.removeAttribute(strName);
	}

	request.setAttribute("_cache_refresh", "true");
	InetAddress thisip = InetAddress.getLocalHost();
	String strHostAddress=thisip.getHostAddress();
	
	String strImageEnable=ApplicationParams.getImageEnabled();
	
	String loginPanel="";
	String logintop="";
	String user="";
	String pass="";
	String usertxt="";
	if(strImageEnable.equalsIgnoreCase("Y"))
	{
		 loginPanel="loginPanel";
		 logintop="logintop";
		 user="user";
		 pass="pass";
		 usertxt="usertxt";
	}
	else
	{
		 loginPanel="";
		 logintop="";
		 user="";
		 pass="";
		 usertxt="usertxtNOIMG";
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<link rel="icon"
	href="<%=com.sai.laps.helper.ApplicationParams.getAppUrl()%>img/favicon.ico"
	type="image/x-icon" />
<link rel="shortcut icon"
	href="<%=com.sai.laps.helper.ApplicationParams.getAppUrl()%>img/favicon.ico" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Karnataka Bank Ltd. Lending Automation Processing System
&nbsp;&nbsp;&nbsp; ""&nbsp;&nbsp;&nbsp;<%=InetAddress.getLocalHost().getHostName()%>&nbsp;&nbsp;&nbsp;""</title>

<style>
/* body{background:url(../img/loginContainerBg.gif) 0 0 repeat-x #efefef;} */
body{
	background: url(../img/loginBg-min.jpg) 0 0 no-repeat #efefef;
    background-size: cover;
    font-family: 'Trebuchet MS' !important;
    height: 100vh;
}
*{margin:0;padding:0;} a:focus{outline:none;}
.loginWrapper{width:100%;}
.logintop{background:url(../img/topDesign.png) 420px 0 no-repeat;width:1000px;height:76px;margin:0 auto;}
.loginCont{
	width: 340px;
    background: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 0px 0 40px 0;
    margin: 0 auto;
    border-radius: 5px;
    box-shadow: 0 0 6px #717171;
}
.loginFooter{background:#fff;width:100%;height:115px;}
.loginPanel{width:1000px;height:400px;margin:0 auto;background:url(../img/loginBg.gif) 420px 0px no-repeat;}
/* .karnatakaLogo{padding:100px 0 0 50px;float:left;} */
.karnatakaLogo{
	margin-bottom: 0px;
    text-align: center;
    background: #942188;
    padding: 5px;
}
.panel{
	float: left;
    margin: 0 40px;
    background: #fff;
}
.loginHeader {
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 35px 0;
}
.loginHeader h4 {
    font-size: 23px;
    font-weight: bold;
    padding-left: 10px;
}
.userSec {
    position: relative;
}
.passSec {
    position: relative;
}
.mbtm20 {
    margin-bottom: 20px;
}
.user,.pass{background:url(../img/userBg.gif) 0 0 no-repeat;width:213px;height:33px;margin-bottom:17px;}
.pass{background-image:url(../img/passwordBg.gif);}
.usertxt{width:170px;margin:2px 20px 0 8px;height:26px;color:#43433d;font:normal 12px Verdana, Arial, Helvetica, sans-serif;line-height:26px !important;border:none;background:transparent;}
.loginBtn{
	background: #9d3d97;
    background: -moz-linear-gradient(left, #9d3d97 0%, #bf616f 62%, #f79c29 100%);
    background: -webkit-linear-gradient(left, #9d3d97 0%,#bf616f 62%,#f79c29 100%);
    background: linear-gradient(to right, #9d3d97 0%,#bf616f 62%,#f79c29 100%);
    filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#9d3d97', endColorstr='#f79c29',GradientType=1 );
    padding: 10px 25px;
    border: unset;
    color: #fff;
    cursor: pointer;
    font-weight: bold;
    min-width: 270px;
    font-size: 15px;
}
.loginBtn:hover {
    background: #fd6a15;
    color: #fff;
    transition: all 0.5s;
    border: unset;
}
.loginBtn:focus {
    outline: 1px solid #942188 !important;
}
.lapslogo{text-align: center;
    position: absolute;
    right: 50px;
    bottom: 30px;
	margin-top: 27px;}
.forgot{
	font-size: 14px;
    font-weight: normal;
    color: #fff;
    display: inline-block;
    text-decoration: none;
    padding-top: 15px;
    cursor: pointer;
    color: #000;
    display: block;
    text-align: center;
}
.forgot:hover{text-decoration:underline;}
.loginSec {
    height: 80vh;
    display: flex;
    align-items: center;
    justify-content: center;
}
.userSec img {
    position: absolute;
    left: 0;
    bottom: 6px;
    width: 20px;
}
.passSec img {
    position: absolute;
    left: 0;
    bottom: 6px;
    width: 20px;
}
.usertxtNOIMG{
	width: 270px;
    margin-top: 2px;
    height: 26px;
    color: #000;
    font-size: 12px;
    font-weight: bold;
    line-height: 26px !important;
    border: none;
    background: transparent;
    padding: 2px 5px;
    margin-left: 30px;
    border-bottom: 1px solid #ffbffc;
}
.usertxtNOIMG:focus {
    outline: none !important;
}
input::placeholder{
	color: #666666;
	font-weight: normal;
	font-size: 15px;
	letter-spacing:0.5px;
}
</style>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/LosTokenChanges.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/jsencrypt.min.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>

<%
	String strClientIP=Helper.correctNull((String)request.getRemoteAddr());



	if(strClientIP.equalsIgnoreCase("127.0.0.1"))
	{
		strClientIP=strHostAddress;
	}
%>
<script>

function loadFocus()
{
	document.forms[0].txtusr_id.focus();
}
function clearFields()
{

document.forms[0].txtusr_id.value="";
document.forms[0].txtusr_password.value="";
}

function entsub(myform) 
{
  if (window.event && window.event.keyCode == 13)
    Validate();
  else
    return true;
}

function Validate()
{
		var bstate = true;
		var password = checktrim(document.forms[0].txtusr_password.value);
		var userid = checktrim(document.forms[0].txtusr_id.value);
		var publicKey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCHcNzM5CWCKHK72PwWl1iVlFe+qMQIokxttpZAtJ+5whA0FMd4aLNbn2zFvPNfLsTi2bopDmPHcP8YFeopozKXbqUQBj5x53WMjyCsUiZRejBRnW65oXqwpF3MI60rTujWvq7L95er+i36J4C4s/QVpohGLUJl1AMRG3skMgDCMwIDAQAB";
	    var obj = new JSEncrypt();
	    obj.setPublicKey(publicKey);
	    if(password=="")
		{
	        var encrypted = obj.encrypt("empty");
	    }
	    else
		{
	       var encrypted = obj.encrypt(password);
	    }
		if(userid == "")
		{
			bstate = false;
			alert("Enter User Name");
			document.forms[0].txtusr_id.focus();
		}
		else if(password == "")
		{
			bstate = false;
			alert("Enter Password");
			document.forms[0].txtusr_password.focus();
		}
		if(bstate)
		{
//var varQryString ="<%=ApplicationParams.getAppUrl()%>action/hidlogin.jsp";
//var params = {'hidPage' : 'LoginPage','hidBeanGetMethod':'getData','txtusr_password':'','txtusr_id':userid,'hidBeanId':'authenticate',
//		'saltHash':'','hidpass':'','hidLDAPpasswrd':encrypted,'LOS_APPINTPGEID':document.forms[0].LOS_APPINTPGEID.value,'PREV_LOS_APPINTPGEID':document.forms[0].LOS_APPINTPGEID.value};
var title = "LOGIN";
//var prop = "scrollbars=yes,status=1,menubar=no,resizable,location=0,toolbar=0,width="+(screen.width-10)+",height="+(screen.height-100)+",left=0,top=0";
//removePasswordField();
//openWindowUsingFormForLogin(params,varQryString,prop,title);
		document.forms[0].hidBeanMethod.value="getData";
		document.forms[0].hidLDAPpasswrd.value=encrypted;
		document.forms[0].PREV_LOS_APPINTPGEID.value=document.forms[0].LOS_APPINTPGEID.value;
		document.forms[0].hidPage.value="LoginPage";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/hidlogin.jsp";
		document.forms[0].submit();
		}
}

function PurgeUser()
{	

	var bstate = true;
		var password = checktrim(document.forms[0].txtusr_password.value);
		var userid = checktrim(document.forms[0].txtusr_id.value);
		if(userid == "")
		{
			bstate = false;
			alert("Enter User Name");
			document.forms[0].txtusr_id.focus();
		}
		else if(password == "")
		{
			bstate = false;
			alert("Enter Password");
			document.forms[0].txtusr_password.focus();
		}
		if(bstate)
		{
		document.forms[0].hidBeanMethod.value="getData";
		document.forms[0].hidPage.value="PurgeUser";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/hidlogin.jsp";
		document.forms[0].submit();
		}
	

	/*var varQryString = "<%//=ApplicationParams.getAppUrl()%>action/purgeuser.jsp";
	var title = "Purge";
	var prop = "scrollbars=no,width=260,height=140,resizable=no,alwaysRaised";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(varQryString,title,prop);*/
	
}
function ChangePassword()
{
	var varQryString = "<%=ApplicationParams.getAppUrl()%>action/changepassword.jsp";
	var title = "changepassword";
	var prop = "scrollbars=no,width=450,height=200";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(varQryString,title,prop);
}

function showAccess(val)
{
	if(val=="y")
	document.all.accesslyr.style.visibility="visible";
	else
	document.all.accesslyr.style.visibility="hidden";
}
function onLoading()
{
	document.forms[0].txtusr_id.focus();
}

function callonline(varpagetype)
{

	var VARPAGEPROPERTIES= "scrollbars=yes,resizable=yes,status=YES,menubar=no,location=0,toolbar=no";
	var VARPAGEURL = "https://172.31.14.147:9010/laps?PAGE_TYPE="+varpagetype;
	window.open(VARPAGEURL,"",VARPAGEPROPERTIES);
}
</script>
</head>

<body onLoad="onLoading()">
<div class="loginWrapper">
	<div class="<%=logintop%>"></div>
	<div class="karnatakaLogo"><img src="<%=ApplicationParams.getAppUrl()%>img/karnatakaLogo.gif" alt="Karnataka Logo" /></div>
	<div class="loginSec">
	<div class="loginCont">
		<div class="<%=loginPanel%>">
			
<!--			<div class="karnatakaLogo"><img src="<%=ApplicationParams.getAppUrl()%>img/ubiLogo.png" alt="Karnataka Logo" /></div>-->
			<form action="" method="post">
			<div class="panel">
				<div class="loginHeader">
					<img src="/laps/img/lock.png" alt="">
					<h4>LOGIN</h4>
				</div>
				<div class="<%=user%> mbtm20 userSec"><input type="text" name="txtusr_id" value="" class="<%=usertxt%>"  
				onKeyPress="notAllowSingleQuote()" autocomplete="off"
					oncopy="return false" ondrag="return false" ondrop="return false"
					onpaste="return false" placeholder="Username"/>
					<img src="/laps/img/user1.png" alt="">
				</div>
				<div class="<%=pass%> mbtm20 passSec"><input name="txtusr_password" type="password" class="<%=usertxt%>"  value=""
				onkeypress="notAllowSingleQuote();return entsub(this.form)"
				autocomplete="off" oncopy="return false" ondrag="return false"
				ondrop="return false" onpaste="return false" placeholder="Password"/>
				<img src="/laps/img/key.png" alt="">
			</div>
			<div style="text-align: center;margin-top: 30px;">
				<button type="button" class="loginBtn" onClick="Validate()">Login</button>
			</div>
				<a class="forgot" onClick="ChangePassword()" style="cursor: pointer; display:block; text-align: center;">Change Password ?</a>
			</div>
						
		</div>		
	</div>
</div>
	
		<div class="lapslogo"><img src="<%=ApplicationParams.getAppUrl()%>img/lapsLogo.gif" alt="Laps Logo" style="float:right;margin-top:27px;" /></div>
	
<!--	<a href="http://192.168.0.224:9024/laps/action/singlelogin.jsp">Single Signon</a>-->
<input type="hidden" name="hidPage" /> 
<input type="hidden" name="hidBeanId" value="authenticate" /> 
<input type="hidden" name="hidBeanMethod" value="getData" /> 
<input type="hidden" name="hidlogincount" value="<%=Helper.correctNull(request.getParameter("hidlogincount"))%>" />
<input type="hidden" name="saltHash" value=""> 
<input type="hidden" name="hidpass" value="">
<input type="hidden" name="hidnewpass" value="">
<input type="hidden" name="hidLDAPpasswrd" value="">
<input type="hidden" name="hidEncUserId" value="">
<input type="hidden" name="LOS_APPINTPGEID" value="">
<input type="hidden" name="hidEncUserId" value="">
<input type="hidden" name="PREV_LOS_APPINTPGEID" value="">
</form>
</div>
</body>
</html>