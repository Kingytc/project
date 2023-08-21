<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<lapschoice:handleerror />
<%String stramtin = "";
String schemetype="";
schemetype = Helper.correctNull((String) request.getParameter("schemetype"));

String cattype = Helper.correctNull((String) request.getParameter("cattype"));
String applevel = Helper.correctNull((String) request.getParameter("applevel"));
//System.out.println("applevel==="+applevel);			
cattype = Helper.correctNull((String) request.getParameter("cattype1"));
if (cattype.equals(""))
{
	cattype = Helper.correctNull((String) session.getAttribute("cattype"));
}
String ssitype = (String) request.getParameter("ssitype");
if (ssitype.equalsIgnoreCase("")) {
	ssitype = Helper.correctNull((String) hshValues	.get("hidSSIType"));
}
String strType = Helper.correctNull((String) session.getAttribute("link"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	
	%>
<html>
<head>
<title>Activities</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentdate="<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varschemetype="<%=schemetype%>";


function Onloading()
{
	disablefields(true);
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=varschemetype;
}

function disablefields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}		
	}
	document.forms[0].txt_amnreq.readOnly=true;
	document.forms[0].txt_corpsvalue.readOnly=true;
	
}

function enablebuttons(editbool,savebool,canbool,delbool,closebool)
{
	document.forms[0].cmdedit.disabled=editbool;
	document.forms[0].cmdsave.disabled=savebool;
	document.forms[0].cmdcancel.disabled=canbool;
	document.forms[0].cmddelete.disabled=delbool;
	document.forms[0].cmdclose.disabled=closebool;
}

function doEdit()
{
	//document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value="insert";
	disablefields(false);
	enablebuttons(true,false,false,false,true);
}

function doSave()
{
	if(trim(document.forms[0].txt_recmamunt.value)=="")
	{
		ShowAlert('121', "Loan Amount"); 	
		document.forms[0].txt_recmamunt.focus();
		return;	
	}
	//document.forms[0].hid_categoryType.value = varCategoryType;
	//document.forms[0].hidRecordflag.value=varRecordFlag;
	enablebuttons(true,true,true,true,false);
	document.forms[0].hidBeanId.value="compro"
	document.forms[0].hidBeanMethod.value="updateSHGAssessment";
	document.forms[0].hidBeanGetMethod.value="getSHGAssessment";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_shgassessment.jsp";
	document.forms[0].submit();
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanGetMethod.value="getSHGAssessment";
		document.forms[0].action=appURL+"action/com_shgassessment.jsp";
		document.forms[0].submit();
	 }
}

function doDelete()
{
	if(ConfirmMsg(101))
 	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanMethod.value="updateSHGAssessment";
		document.forms[0].hidBeanGetMethod.value="getSHGAssessment";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_shgassessment.jsp";
		document.forms[0].submit();
	 }

}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
}

function callLink(page,bean,method)
{ 
	if (document.forms[0].hideditflag.value=="N")
	{
	 	document.forms[0].hidBeanGetMethod.value=method;
	 	document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].action=appURL+"action/"+page;
	 	document.forms[0].submit();
	}
	else 
	{
		ShowAlert(103);
	}
}

function callCalender(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		 showCal(appURL,val);
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onload="Onloading()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="frmcapitalstructure" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="999" />
			<jsp:param name="cattype" value="<%=cattype%>" />
			<jsp:param name="ssitype" value="<%=ssitype%>" />
		</jsp:include></td>
	</tr>
</table>
<table>
	
	<tr>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Group Finance - &gt; SHG Assessment</td>
	</tr>
	
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="210" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
	
			
		</jsp:include></td>
	</tr>
</table>

<br>
<table width="60%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
	<tr>

		<td>
		<table width="60%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
			<td>Amount Requested</td>
			<td><input type="text" name="txt_amnreq" onblur="roundtxt(this)" size="30" maxlength="15" style="text-align: right" onkeypress="allowNumber(this)" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("LOAN_AMTREQD"))))%>"></td>
			</tr>
			<tr>
			<td>Total value in corpus of the group</td>
			<td><input type="text" name="txt_corpsvalue" onblur="roundtxt(this)"  size="30" maxlength="15"  style="text-align: right" onkeypress="allowNumber(this)" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dbltotalA"))))%>"></td>
			</tr>
			<tr>
			<td>Loan Amount</td>
			<td><input type="text" name="txt_recmamunt" onblur="roundtxt(this)" size="30"  maxlength="15"  style="text-align: right" onkeypress="allowNumber(this)" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("ASA_LOANAMNT"))))%>"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<input type="hidden" name="hid_categoryType" value="">
<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
 <input
	type="hidden" name="hidAction" value=""> <input type="hidden"
	name="hidBeanId" value=""> <input type="hidden"
	name="hidBeanMethod" value=""> <input type="hidden"
	name="hidBeanGetMethod" value=""> <input type="hidden"
	name="hidSourceUrl" value=""> <input type="hidden"
	name="hidApp_type" value="A"> <input type="hidden" name="page"
	value=""> <INPUT TYPE="hidden" name="trapEdit"
	value="<%=Helper.correctNull((String) hshValues.get("trapEdit"))%>">
<INPUT TYPE="hidden" name="hidEditMode"
	value="<%=Helper.correctNull((String) hshValues.get("hidEditMode"))%>">
<input type="hidden" name="hidDemoId"
	value="<%=request.getParameter("hidDemoId")%>"> <input
	type="hidden" name="hidAppType"
	value="<%=Helper.correctNull((String) hshValues.get("hidAppType"))%>">
	</form>

</body>
</html>
