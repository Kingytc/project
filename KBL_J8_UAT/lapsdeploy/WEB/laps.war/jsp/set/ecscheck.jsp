<%@ include file="../share/directives.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<%
String app_enchflag = Helper.correctNull((String) hshValues.get("app_enchflag"));
String app_enachdate = Helper.correctNull((String) hshValues.get("app_enachdate"));
String msg = Helper.correctNull((String) hshValues.get("resultStatusmsg"));
String EnachnotAvai = Helper.correctNull((String) hshValues.get("EnachnotAvai"));
String EnachUpdate = Helper.correctNull((String) hshValues.get("EnachUpdate"));

%>
<title>E-NACH</title>
<script  LANGUAGE="JavaScript">
var varEnachnotAvai = "<%= EnachnotAvai %>";
var varEnachUpdate = "<%= EnachUpdate %>";
var varmsg = "<%=msg%>";

function doGetenachlink()
{
	if(document.forms[0].txtapplicationno.value=="")
	{
		alert("Enter Proposal Number");
		return;
	}
	document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].hidBeanGetMethod.value="enachcheckService";
	document.forms[0].hidSourceUrl.value="/action/ecscheck.jsp"; 
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidAction.value="CALLINGAPI";
	document.forms[0].submit();
	document.getElementById("progress").style.visibility="visible";
}

function doGetUpdenachlink()
{
	if(document.forms[0].txtapplicationno.value=="")
	{
		alert("Enter Proposal Number");
		return;
	}
	document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].hidBeanGetMethod.value="enachcheckService";
	document.forms[0].hidSourceUrl.value="/action/ecscheck.jsp"; 
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidAction.value="updateENACH";
	document.forms[0].submit();
	document.getElementById("progress").style.visibility="visible";
}
function doClose()
{
	if (ConfirmMsg("100"))
	{
		document.forms[0].action = appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}	
}

function doReset()
{
	document.forms[0].action=appURL+"action/ecscheck.jsp";
	document.forms[0].submit();
}
function loadPage()
{
	if(varmsg != ""){
		alert("E-NACH Details Sent successfully");
		doReset();
	}

	if(varEnachnotAvai == "Y"){
		alert("E-NACH Details not available / Loan Account not yet opened");
		doReset();
	}

	if(varEnachUpdate == "Y"){
		alert("E-NACH Cancelled successfully");
		doReset();
	}
	
	if(document.forms[0].app_enchflag.value == "Y" && document.forms[0].app_enachdate.value == "Y")
	{
		//document.forms[0].cmdenachlink.disabled=true;
		document.forms[0].cmdupdenachlink.disabled=false;
	}else{
		document.forms[0].cmdupdenachlink.disabled=true;
		document.forms[0].cmdenachlink.disabled=false;
	}
}
function ButtonEnable()
{
	var txtapplicationno=document.forms[0].txtapplicationno.value;
	document.all.ifrmenach.src=appURL+"action/iframeenach.jsp?hidBeanId=perapplicant&hidBeanGetMethod=enachcheckService&hidAction=CALLINGIFRAME&appno="+txtapplicationno;
	loadPage();
}

</script>
</head>
<body onLoad ="loadPage()">
<div id="progress" style="position:absolute; width:106px; visibility:hidden; height:19px; z-index:9999999; left: 800px; top: 700px" >
<img src="<%=ApplicationParams.getAppUrl()%>img/processing2.gif"></div>
<form method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr>
            <td class="page_flow">Home -&gt; E-NACH</td>
          </tr>
        </table>
         <br><br>
          <table width="80%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
         <tr>
        <td>
         <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
          <tr >
          <td class="datagrid" width="20%" align="center">Enter Proposal Number <span class="mantatory">*&nbsp;</span> &nbsp;&nbsp;&nbsp;&nbsp; 
          	<input type="text" name="txtapplicationno" onkeypress="allowInteger()" onChange="ButtonEnable()">
          </td>
          </tr>
          <tr>
          <td width="20%" align="center" class="outertable">
          <input type="button" name="cmdenachlink" value="Send ENACH Link" class="buttonOthers" onclick="doGetenachlink()">
           <input type="button" name="cmdupdenachlink" value="CANCEL ENACH" class="buttonOthers" onclick="doGetUpdenachlink()">
           </td>
          </tr>
        </table>
        </td></tr>
        </table>
        <br><br>
        <table>
<lapschoice:combuttonnew btnnames='Reset'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' /></table>
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidSourceUrl">
<input type="hidden" name="hidAction">
<input type="hidden" name="hidBeanGetMethod">
<input type="hidden" name="app_enchflag" value="<%=app_enchflag%>">
<input type="hidden" name="app_enachdate">
<iframe	height="0" width="0" id="ifrmenach" frameborder="0" style="border: 0"></iframe>
</form>
</body>
</html>