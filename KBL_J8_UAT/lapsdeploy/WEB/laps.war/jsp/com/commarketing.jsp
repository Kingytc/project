<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}

	ArrayList vec = null;
	int vecsize = 0;

	if (hshValues != null) {

		vec = (ArrayList) hshValues.get("vecVal");

	}

	if (vec != null) {
		vecsize = vec.size();

	}
%>
<html>
<head>
<title>Marketing &amp; Distribution</title>
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
				if (document.forms[0].elements[i].name=="products")
				{
					document.forms[0].elements[i].readOnly=true;		
				}
				else
				{
					document.forms[0].elements[i].readOnly=val;		  
				}
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
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanMethod.value="updateSegment";
		document.forms[0].hidBeanGetMethod.value="getSegmentData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/commarketing.jsp";
		document.forms[0].submit();
	 }
		
}
function doSave()
{
	if(document.forms[0].products.value == "")
	{
		alert("Enter products")
		document.forms[0].products.focus();
		return;
	}	
	if(document.forms[0].customer.value == "")
	{
		alert("Enter customer in numbers")
		document.forms[0].customer.focus();
		return;
	}
	if(document.forms[0].locations.value == "")
	{
		alert("Enter locations")
		document.forms[0].locations.focus();
		return;
	}			
	if(document.forms[0].endwise.value == "")
	{
		alert("Enter endwise")
		document.forms[0].endwise.focus();
		return;
	}			
	if(document.forms[0].use.value == "")
	{
		alert("Enter use")
		document.forms[0].use.focus();
		return;
	}			
 	

		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanMethod.value="updateSegment";
		document.forms[0].hidBeanGetMethod.value="getSegmentData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/commarketing.jsp";
		document.forms[0].submit();
}

function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanGetMethod.value="getSegmentData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/commarketing.jsp";
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

function  validate()
{ 
	/*var flag;
	for (m=0;m<8;m++)
	{
			if(document.forms[0].products[m].value != "" ) 
				return true;
		else
				flag=false;
	
	}
return flag;*/

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
		ShowAlert(103);
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
				document.forms[0].hidSourceUrl.value = "/action/facilities.jsp";
			}
			document.forms[0].submit();
		} else {
			ShowAlert(103);
		}

	}

	var strvalue = "corp_prodmark.htm";
	function doHelp() {
		var hlpvar = appURL + "phlp/corp_prodmark.htm";
		var title = "Promotors\Directors";
		var prop = "scrollbars=yes,width=600,height=450";
		prop = prop + ",left=50,top=150";
		window.open(hlpvar, title,
prop);
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onload="placeValues()">
<form method="post" name="fltintrate" class="normal"> <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable border1"> <tr> <td valign="top" colSpan="5"><jsp:include
			page="../share/applurllinkscom.jsp" flush="true"> <jsp:param name="pageid" value="4" /> 
<jsp:param name="cattype" value="<%=strCategoryType%>" /> <jsp:param name="ssitype" value="<%=strSSIType%>" /> 
</jsp:include></td></tr> </table><table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable border1"> <tr> <td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Products -&gt; Marketing -&gt; Marketing</td></tr> </table><span style="display: none"><lapschoice:borrowertype /></span><lapschoice:application /> 
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable"> <tr> <td valign="bottom"> <table border="0" cellspacing="2" cellpadding="3"
			class="outertable" WIDTH="70%"> <tr align="center"> <td width="10%" class="sub_tab_inactive"><b><a
					href="#" onClick="javascript:callLink('comactivities.jsp','compro','getActivity')">Activities</a></b></td><td width="10%" class="sub_tab_inactive"><b><a
					href="#" onClick="javascript:callLink('comproduction.jsp','combanking','getProductData')">About 
Prod.</a></b></td><td width="10%" class="sub_tab_inactive"><b><a
					href="#" onClick="javascript:callLink('comrawmaterials.jsp','combanking','getRawData')">Raw 
Materials</a></b></td><td width="10%" class="sub_tab_inactive"><b><a
					href="#" onClick="javascript:callLink('comprocessdesc.jsp','combanking','getDescData')">Manf.Process</a></b></td><td width="10%" class="sub_tab_inactive"><b><a
					href="#" onClick="javascript:callLink('comgovtpolicies.jsp','combanking','getGovtData')">Govt.Policy</a></b></td><td width="10%" class="sub_tab_inactive"><b><a
					href="#" onClick="javascript:callLink('comtransport.jsp','combanking','getTransData')">Transportation</a></b></td><td width="10%" class="sub_tab_active"><b>Marketing</b></td></tr> 
</table></td></tr> </table><table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable"> <tr> <td valign="top"> <table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="center" class="outertable"> <tr> <td valign="top"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="outertable"> <tr> <td> <table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable"> <tr> 
<td colspan="2"> <table border="0" cellspacing="2" cellpadding="3"
									class="outertable" WIDTH="60%"> 
<tr align="center"> <td width="10%" class="sub_tab_active"><b>Marketing</b></td><td width="10%" class="sub_tab_inactive"><b><a
											href="#" onClick="javascript:callLink('commarketingsegment.jsp','combanking','getMarketData')">Distribution</a></b></td><td width="15%" class="sub_tab_inactive" NOWRAP><b><a
											href="#" onClick="javascript:callLink('comdistribute.jsp','combanking','getDistData')">Major 
Customers Export</a></b></td><td width="15%" class="sub_tab_inactive" NOWRAP><b><a
											href="#" onClick="javascript:callLink('comdistributelocal.jsp','compro','getDistLocalData')">Major 
Customers Local</a></b></td><td width="10%" class="sub_tab_inactive"><b><a
											href="#" onClick="javascript:callLink('comcompetitor.jsp','combanking','getCompData')">Competition</a></b></td></tr> 
</table></td></tr> <tr> <td colspan="2"> <table width="100%" border="0" cellspacing="0" cellpadding="3"
									class="outertable border1"> 
<tr> <td valign="top"> <table width="100%" border="0" cellspacing="1" cellpadding="3"
											class="outertable"> 
<tr class="dataheader"> <td colspan="6">Number of customers segment-wise (geographic 
/ demographic / end use)</td></tr> <tr class="dataheader"> <td width="7%" align="center">S.No</td><td width="45%" align="center">Products</td><td width="45%" align="center">Customers 
in <br> Numbers or %</td><td width="35%" align="center">Location</td><td width="13%" align="center">End 
wise Customers in Numbers or %</td><td width="13%" align="center">End wise Usage</td></tr> 
<%
												ArrayList g1 = null;

												for (int l = 0; l < vecsize; l++) {

													int colSize = 0;

													if (l < vecsize) {
														g1 = (ArrayList) vec.get(l);

														if (g1 != null) {
															colSize = g1.size();

														}
													}

													if (colSize > 0) {
											%> 
<tr> <td width="7%" align="center"><%=l + 1%></td><td width="51%" align="center"><input type="text"
													name="products"
													value="<%=Helper.correctNull((String) g1
											.get(0))%>"
													size="25" maxlength="199"
													onKeyPre
	notAllowSplChar1(thi
s)"></td><td width="51%" align="center"><textarea
													name="customer" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"><%=Helper.correctNull((String) g1
											.get(4))%></textarea> 
</td><td width="35%" align="center"><textarea
													name="locations" cols="25" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"><%=Helper.correctNull((String) g1
											.get(2))%></textarea> 
</td><td width="7%" align="center"><textarea name="endwise" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"><%=Helper.correctNull((String) g1
											.get(3))%></textarea> 
</td><td width="7%" align="center"><textarea name="use" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"><%=Helper.correctNull((String) g1
											.get(5))%></textarea> 
</td></tr> <%
												} else {
											%> 
<tr> <td width="7%" align="center"><%=l + 1%></td><td width="51%" align="center"><input type="text"
													name="produ
	
="199"
													onKeyPress="notAllowSplChar1(this)"></td><td width="51%" align="center"><textarea
													name="customer" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"></textarea></td><td width="35%" align="center"><textarea
									
	
s="25"
													onKeyPress="notAllowSplChar1(this);textlimit(this,999)" onKeyUp="textlimit(this,999)"></textarea></td><td width="7%" align="center"><textarea name="endwise" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"></textarea> 
</td><td width="7%" align="center" ><textarea name="use" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"></textarea> </td></tr> 
<%
												}
												}
											%> 
</table></td></tr> </table></td></tr> </table></td></tr> </table></td></tr> </table></td></tr> 
</table><br> <lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel"
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' /> 
<lapschoice:hiddentag pageid='<%=PageId%>' /> </form>
</body>
</html>