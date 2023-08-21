<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
%>
<html>
<head>
<title>Process of Manufacture</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
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
			else if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
		}
	}
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true);
}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;

}
function doDelete()
{
	if(varRecordFlag=="Y")
		{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanMethod.value="updateDesc";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comprocessdesc.jsp";
		document.forms[0].submit();
	 }
	 }
	 else{
	 ShowAlert(158);
	 }
}
function doSave()
{
		var count=0;forCount=0;
		
		for(var i=0;i<document.forms[0].elements.length;i++)
		{	
			if(document.forms[0].elements[i].type=="textarea")
			{	
				if(document.forms[0].elements[i].value=="")
				{		
				  count=count+1;
				}  
				forCount=forCount+1;
			}

		}	
			
		if(count == forCount)
		{
		alert("Atleast enter one element");
		return false;
		}	
		document.forms[0].cmdsave.disabled = true;
				
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanMethod.value="updateDesc";
		document.forms[0].hidBeanGetMethod.value="getDescData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comprocessdesc.jsp";
		document.forms[0].submit();
		
}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanGetMethod.value="getDescData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comprocessdesc.jsp";
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

var strvalue="corp_prodmanupro_prodpro.htm";
function doHelp()     
{
  var hlpvar = appURL+"phlp/corp_prodmanupro_prodpro.htm";
  var title = "ProductionProcess";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onload="placeValues()">
<form method="post" name="fltintrate" class="normal"> <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable"> <tr> <td valign="top" colSpan="5"><jsp:include
			page="../share/applurllinkscom.jsp" flush="true"> <jsp:param name="pageid" value="4" /> 
<jsp:param name="cattype" value="<%=strCategoryType%>" /> <jsp:param name="ssitype" value="<%=strSSIType%>" /> 
</jsp:include></td></tr> </table><table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable"> <tr> <td class="page_flow">Home -&gt; Corporate &amp;SME -&gt; Application -&gt; Products -&gt; Manf. Process -&gt; Production Process</td></tr> 
</table><span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application /> 
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable"> <tr> <td valign="bottom"> <table border="0" cellspacing="2" cellpadding="3"
			class="outertable" WIDTH="70%"> <tr align="center"> <td width="10%" class="sub_tab_inactive"><b><a
					href="#" onClick="javascript:callLink('comactivities.jsp','compro','getActivity')">Activities</a></b></td><td width="10%" class="sub_tab_inactive"><b><a
					href="#" onClick="javascript:callLink('comproduction.jsp','combanking','getProductData')">About 
Prod.</a></b></td><td width="10%" class="sub_tab_inactive"><b><a
					href="#" onClick="javascript:callLink('comrawmaterials.jsp','combanking','getRawData')">Raw 
Materials</a></b></td><td width="10%" class="sub_tab_active"><b>Manf.Process</b></td><td width="10%" class="sub_tab_inactive"><b><a
					href="#" onClick="javascript:callLink('comgovtpolicies.jsp','combanking','getGovtData')">Govt.Policy</a></b></td><td width="10%" class="sub_tab_inactive"><b><a
					href="#" onClick="javascript:callLink('comtransport.jsp','combanking','getTransData')">Transportation</a></b></td><td width="10%" class="sub_tab_inactive"><b><a
					href="#" onClick="javascript:callLink('commarketing.jsp','combanking','getSegmentData')">Marketing</a></b></td></tr> 
</table></td></tr> </table><table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable"> <tr> <td valign="top"> <table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="center" class="outertable"> <tr> <td valign="top"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="outertable"> <tr> <td> <table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable"> <tr> 
<td colspan="2"> <table border="0" cellspacing="2" cellpadding="3" width="20%" 
									class="outertable"> 
<tr align="center"> <td width="10%" class="sub_tab_active" NOWRAP><b>Production 
Process</b></td><td width="10%" class="sub_tab_inactive" NOWRAP><a
											href="#" onClick="javascript:callLink('comstandard.jsp','combanking','getStdData')"><b>Other 
Details </b></a></td></tr> </table></td></tr> <tr> <td colspan="2"> <table width="100%" border="0" cellspacing="0" cellpadding="3"
									class="outertable border1"> 
<tr> <td valign="top"> <table width="100%" border="0" cellspacing="1" cellpadding="3"
											class="outertable"> 
<tr class="dataheader" align="center"> <td width="50%">Description of the production 
/ service delivery</td><td width="50%">Production Schedule and time taken per 
unit of production</td></tr> <tr> <td align="center" width="50%"><textarea
													name="Description" cols="70" rows="9" onKeyPress="textlimit(this,199)" onKeyUp="textlimit(this,199)" ><%=Helper.correctNull((String) hshValues
							.get("Description Production"))%></textarea> 
</td><td align="center" width="50%"><textarea
													name="Schedule" cols="70" rows="9" onKeyPress="textlimit(this,199)" onKeyUp="textlimit(this,199)"><%=Helper.correctNull((String) hshValues
							.get("Production Schedule"))%></textarea> 
</td></tr> <tr align="center"> <td width="50%" height="18">&nbsp;</td><td width="50%" height="18">&nbsp;</td></tr> 
<tr align="center" class="dataheader"> <td width="50%">Output to Input Ratio of 
major products, if not applicable asset turnover ratio</td><td width="50%">Technology 
used for the manufacture of the Product</td></tr> <tr> <td align="center" width="50%"><textarea name="Output"
													cols="70" rows="9" onKeyPress="textlimit(this,199)" onKeyUp="textlimit(this,199)"><%=Helper.correctNull((String) hshValues
							.get("Output to Input Ratio"))%></textarea> 
</td><td align="center" width="50%"><textarea
													name="Technology" cols="70" rows="9" onKeyPress="textlimit(this,199)" onKeyUp="textlimit(this,199)"><%=Helper.correctNull((String) hshValues
							.get("Technology used"))%></textarea> 
</td></tr> </table></td></tr> </table></td></tr> </table></td></tr> </table></td></tr> 
</table></td></tr> </table><br> <lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel"
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' /> 
<lapschoice:hiddentag pageid='<%=PageId%>'/> </form>
</body>
</html>