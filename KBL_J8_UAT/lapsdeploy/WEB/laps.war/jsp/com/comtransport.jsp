<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
   if(objValues instanceof java.util.HashMap)
  {
	  hshValues=(java.util.HashMap)objValues;
  }
%>
<html>
<head>
<title>Process of Manufacture</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
function placeValues()
{
	disableFields(true);
}
function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			else if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
		}
	}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{

	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;

}
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true)

}
function doDelete()
{
	if(varRecordFlag=="Y")
		{
	if(ConfirmMsg(101))
	 {
	
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanMethod.value="updateTrans";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comtransport.jsp";
		document.forms[0].submit();
	 }
	   }
	  else{
	 ShowAlert(158);
	 }
		
}
function doSave()
{
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanMethod.value="updateTrans";
		document.forms[0].hidBeanGetMethod.value="getTransData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comtransport.jsp";
		document.forms[0].submit();
		
}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanGetMethod.value="getTransData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comtransport.jsp";
		document.forms[0].submit();
	 }
		
}

function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appURL+"action/"+"comsearch.jsp";
		document.forms[0].submit();
	}
	
}

function callLink(page,bean,method)
{
	if (document.forms[0].cmdsave.disabled)
	{
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
	 }
	else
	{
		ConfirmMsg(103);
	}
}

 function callApplicantTab(page)
  { 
   	
	if (document.forms[0].cmdsave.disabled)
	{
	  if(page=="company")
	  { 
		  document.forms[0].hidBeanGetMethod.value="getData";
		  document.forms[0].action=appURL+"action/comcompany.jsp";
	  }
	  if(page=="proposal")
	  {
		  document.forms[0].hidBeanGetMethod.value="getProposal";
		  document.forms[0].action=appURL+"action/comproposal.jsp";
	  }
	    	  if(page=="facilities")
	  {
		  document.forms[0].hidBeanMethod.value="getFacilityData";
		  document.forms[0].hidBeanId.value="facilities";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/facilities.jsp";
	  }
	
		  document.forms[0].submit();
	 }
	else
	{
		ConfirmMsg(103);
	}
	
	
  }

var strvalue="corp_prodtranspo.htm";
function doHelp()     
{
  var hlpvar = appURL+"phlp/corp_prodtranspo.htm";
  var title = "Transportation";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onload="placeValues()">
<form method="post" name="fltintrate" class="normal"> <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable"> <tr> <td valign="top" colSpan="5"><jsp:include page="../share/applurllinkscom.jsp" flush="true"> 
<jsp:param name="pageid" value="4" /> <jsp:param name="cattype" value="<%=strCategoryType%>" /> 
<jsp:param name="ssitype" value="<%=strSSIType%>" /> </jsp:include></td></tr> 
</table><table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable"> <tr> <td class="page_flow">Home -&gt; Corporate -&gt; 
Existing Application -&gt; Products -&gt; Transportation</td></tr> </table><span style="display:none"><lapschoice:borrowertype /></span> 
<lapschoice:application/> <table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable"> <tr> <td valign="bottom"> <table border="0" cellspacing="2" cellpadding="3"
			class="outertable" WIDTH="70%"> <tr align="center"> <td width="10%" class="sub_tab_inactive"><b><a
					href="#" onClick="javascript:callLink('comactivities.jsp','compro','getActivity')">Activities</a></b></td><td width="10%" class="sub_tab_inactive"><b><a
					href="#" onClick="javascript:callLink('comproduction.jsp','combanking','getProductData')">About 
Prod.</a></b></td><td width="10%" class="sub_tab_inactive"><b><a
					href="#" onClick="javascript:callLink('comrawmaterials.jsp','combanking','getRawData')">Raw 
Materials</a></b></td><td width="10%" class="sub_tab_inactive"><b><a href="#" onClick="javascript:callLink('comprocessdesc.jsp','combanking','getDescData')">Manf.Process</a></b></td><td width="10%" class="sub_tab_inactive"><b><a href="#" onClick="javascript:callLink('comgovtpolicies.jsp','combanking','getGovtData')">Govt.Policy</a></b></td><td width="10%" class="sub_tab_active"><b>Transportation</b></td><td width="10%" class="sub_tab_inactive"><b><a
					href="#" onClick="javascript:callLink('commarketing.jsp','combanking','getSegmentData')">Marketing</a></b></td></tr> 
</table></td></tr> </table><table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1"> 
<tr> <td valign="top"> <table width="100%" border="0" cellspacing="0" cellpadding="1" align="center" class="outertable"> 
<tr> <td valign="top"> <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"> 
<tr align="center" class="dataheader"> <td width="36%">Transportation modes for 
transporting raw materials and finished goods</td><td width="36%">Ancillary facilities, 
such as jetties, warehouses etc.,</td></tr> <tr align="center"> <td width="36%"> 
<textarea name="mode" cols="70" rows="9" onKeyPress="textlimit(this,199)" onKeyUp="textlimit(this,199)"><%=Helper.correctNull((String)hshValues.get("Transportation modes"))%></textarea> 
</td><td width="36%"> <textarea name="ancillary" cols="70" rows="9" onKeyPress="textlimit(this,199)" onKeyUp="textlimit(this,199)"><%=Helper.correctNull((String)hshValues.get("Ancillary facilities"))%></textarea> 
</td></tr> <tr> <td colspan="2">&nbsp;</td></tr> <tr> <td colspan="2"> <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable"> 
<tr class="dataheader"> <td width="21%" align="center">Cost per unit of transportation</td><td width="42%" align="center">Fleet 
strength of company's own transport system</td><td width="37%" align="center">Long 
term transport contracts, if any</td></tr> <tr> <td width="21%" align="center" class="dataheader">Raw 
Materials</td><td width="42%" align="center"> <textarea name="rawfleet" cols="50"  rows="2" onKeyPress="textlimit(this,199)" onKeyUp="textlimit(this,199)"><%=Helper.correctNull((String)hshValues.get("Fleet strength"))%></textarea> 
</td><td width="37%" align="center"> <textarea name="rawlong" cols="50" rows="2" onKeyPress="textlimit(this,199)" onKeyUp="textlimit(this,199)"><%=Helper.correctNull((String)hshValues.get("Longterm transport"))%></textarea> 
</td></tr> <tr> <td width="21%" align="center" class="dataheader">Finished Goods</td><td width="42%" align="center"> 
<textarea name="finishedfleet" cols="50" rows="2" onKeyPress="textlimit(this,199)" onKeyUp="textlimit(this,199)"><%=Helper.correctNull((String)hshValues.get("Finished Goods Fleet Strength"))%></textarea> 
</td><td width="37%" align="center"> <textarea name="finishedlong" cols="50" rows="2" onKeyPress="textlimit(this,199)" onKeyUp="textlimit(this,199)"><%=Helper.correctNull((String)hshValues.get("Finished Goods Longterm transport"))%></textarea> 
</td></tr> </table></td></tr> </table></td></tr> </table></td></tr> </table><br> 
<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/> <!-- <input type="hidden" name="hidAction" >
  <input type="hidden" name="hidBeanId">
  <input type="hidden" name="hidBeanMethod" value="">
  <input type="hidden" name="hidBeanGetMethod" value="">
  <input type="hidden" name="hidSourceUrl"> --> </form>
</body>
</html>