<%@ page import="com.sai.fw.management.utils.*"%>
<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%@include file="../share/directives.jsp"%>
<% 
ArrayList arryCol=new ArrayList();
ArrayList arryRow = new ArrayList();
if(hshValues!=null)
{
 	arryRow=(ArrayList)hshValues.get("arrData"); 	
}
String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
if(schemetype. trim().equalsIgnoreCase(""))
{
	schemetype="0";
}
%>
<html>
<head>
<title>Sericulture</title>
<STYLE>
DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
</STYLE>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var txt_mulberry = "<%=Helper.correctNull((String)hshValues.get("agr_area_mulberry"))%>" 

var varunit=new Array();
var varrate=new Array();
var varamount=new Array();
<%
for(int i=1;i<19;i++)
{
	if(arryRow!=null && arryRow.size()>=i)
		{

		arryCol=(ArrayList)arryRow.get(i-1);
		if(arryCol!=null)
		{	
																			
%>  
		
		varunit["<%=i-1%>"]="<%=Helper.correctNull((String)arryCol.get(0))%>";
		varrate["<%=i-1%>"]="<%=Helper.correctNull((String)arryCol.get(1))%>";
		varamount["<%=i-1%>"]="<%=Helper.correctNull((String)arryCol.get(2))%>";
		
<%
			}
		}
}

%>

</script>

<script>
function callCalender(name)
{
	if(document.forms[0].hideditflag.value=="Y")
	{
		showCal(appUrl,name);
	}
}
function callLink(page,bean,method)
{	
	 document.forms[0].hidAction.value="";
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}



function onloading()
{	
	disableFields(true);	
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value="<%=schemetype%>";
	var strUserMode="";
	strUserMode=document.forms[0].hidUsrMode.value;
	if(strUserMode=='MAKER_MODE')
	{
		disabledFields(true);
		disableEditButtons(false, true, true, true, false, false);
	}
	else if(strUserMode=='CHECKER_MODE')
	{
		disabledFields(true);
		disableEditButtons(true, true, true, true, false, false);
	}
	else if(strUserMode=='VIEW_MODE%')
	{
		disabledFields(true);
		disableEditButtons(true, true, true, true, false, false);
	}		
	callfilldata();
}

function callfilldata()
{

	for(var i=0;i<varunit.length;i++)
	{
		document.forms[0].txt_units[i].value = varunit[i];
		document.forms[0].txt_rate[i].value = varrate[i];
		document.forms[0].txt_amount[i].value = varamount[i];	
	}
}
function calAmount(i)
{
	
	var txtunits = document.forms[0].txt_units[i].value;
	var txtrate = document.forms[0].txt_rate[i].value;
	var txtTotal=0;
	if(txtunits=='')
	{
		txtunits = 0;
		document.forms[0].txt_units[i].value = 0;
	}
	if(txtrate=='')
	{
		txtrate = 0.00;
		document.forms[0].txt_rate[i].value = 0.00;
	}
	
	var txtresult = eval(txtunits)*eval(txtrate);
	document.forms[0].txt_amount[i].value = txtresult;
	document.forms[0].txt_amount[i].value = roundtxt(document.forms[0].txt_amount[i]);

	for(var i=0;i<17;i++)
	{
		txtTotal=NanNumber(txtTotal+parseFloat(roundVal(document.forms[0].txt_amount[i].value)));
	}

	document.forms[0].txt_totamount.value=txtTotal;
	
}

function enableButtons(bool1, bool2, bool3, bool4, bool5, bool6)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}
function doSave()
{   

	if(trim(document.forms[0].txt_mulberry.value)=="")
	{
		ShowAlert('121','Details of the area under mulberry to be cultivated');
		return;
	}
	if(trim(document.forms[0].txt_cocoon.value)=="")
	{
		ShowAlert('121','Marketing Arrangement for cocoon');
		return;
	}
	if(txt_mulberry!="")
	{
		document.forms[0].hidAction.value = "update";
	}
	enableButtons(true, true, true, true, true, false);
	document.forms[0].hidBeanId.value="agreconomic";		
	document.forms[0].hidSourceUrl.value="/action/agr_sericultureprojcost.jsp";
	document.forms[0].hidBeanMethod.value="updateSericultreProjectDetails";
	document.forms[0].hidBeanGetMethod.value="getSericultreProjectDetails";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
	
}
function doEdit()
{
 	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	enableButtons(true, true, false, false, false, true);	
	
	for(var i=0;i<varunit.length;i++)
	{
		document.forms[0].txt_amount[i].readOnly = true;	
	}
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidBeanGetMethod.value="getSericultreProjectDetails";
		document.forms[0].action=appUrl+"action/agr_sericultureprojcost.jsp";
		document.forms[0].submit(); 		
	}	
}



function doClose()
{
	if( ConfirmMsg(100))
	{
		parent.menuFrame.doWindowClose();
	}
}
function disableFields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	
		
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=one;
	 	}
	 	if(document.forms[0].elements[i].type=='checkbox')
	 	{
			document.forms[0].elements[i].disabled=one;
	 	}
	 	if(document.forms[0].elements[i].type=='textarea')
	 	{
	 		document.forms[0].elements[i].readOnly=one;
	 	}
		  
	}
}


function doDelete()
{
	if(txt_mulberry=="")
	{
		ShowAlert(167);
	}
	else
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value ="delete";
			document.forms[0].action=appUrl+"action/ControllerServlet";	
			document.forms[0].hidBeanMethod.value="updateSericultreProjectDetails";
			document.forms[0].hidBeanGetMethod.value="getSericultreProjectDetails";
			document.forms[0].hidBeanId.value="agreconomic";
			document.forms[0].hidSourceUrl.value="action/agr_sericultureprojcost.jsp";	
			document.forms[0].method="post";			
			document.forms[0].submit();	
		}
	}	
}
</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading();">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5();"><script
	language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="999" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
      <td class="page_flow">Home -> Agriculture -> Project Cost</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="76" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table><br>
  <table width="80%"  border="0" align="center" cellpadding="3" cellspacing="0"  class="outertable border1">
  
  <tr>
  	<td width="40%">Details of the area under mulberry to be cultivated<b> * </b></td>	
  	<td><textarea rows="4" cols="40" name="txt_mulberry" onKeyPress="checkEnter();textlimit(txt_mulberry,399);notAllowSingleAndDoubleQuote()"  onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String)hshValues.get("agr_area_mulberry"))%></textarea>
  	</td>	
 </tr>
 <tr>
  	<td>Marketing Arrangement for cocoon<b> * </b></td>	
  	<td><textarea rows="4" cols="40" name="txt_cocoon" onKeyPress="checkEnter();textlimit(txt_cocoon,399);notAllowSingleAndDoubleQuote()"  onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String)hshValues.get("agr_marketingarrangements"))%></textarea>
  	</td>	
 </tr>
 </table>
 <br>

 <br>
	<%String strappno =Helper.correctNull((String)hshValues.get("appno"));%> 
	<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete'	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
    <input type="hidden" name="hidBeanMethod" value="">
	<input type="hidden" name="hidBeanGetMethod" value="">
	<input type="hidden" name="hidBeanId" value="">
	<input type="hidden" name="hidSourceUrl" value="">
	<input type="hidden" name="hidAction" value="">
	<input type="hidden" name="hidUsrMode" value='<%=session.getAttribute("strUserMode")%>'>	
	
</form>
</body>
</html>
