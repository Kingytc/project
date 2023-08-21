<%@include file="../share/directives.jsp"%>
<%String stramtin = "";
	if (strCategoryType.equalsIgnoreCase("OPS")) 
	{
		stramtin = "<b>in Lacs</b>";
	}
	  String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	  ArrayList arrSecRow = new ArrayList();
	  ArrayList arrSecCol = new ArrayList();
	  
	  int intLength = arrSecRow.size();
	  String strApplicant = Helper.correctNull((String)hshValues.get("strcmpId"));
	  String strAppId = Helper.correctNull((String)hshValues.get("strappId"));
	  String sectype = Helper.correctNull((String) request.getParameter("hidsectype"));
	  String strFreezeflag = Helper.correctNull((String)hshValues.get("strFreezeflag"));
	  String strPrioirycheck = Helper.correctNull((String)hshValues.get("strPrioirycheck"));
	  String strPrioityflag = Helper.correctNull((String)hshValues.get("strPrioityflag"));
	  
	   ArrayList arrRow = new ArrayList();
	  ArrayList arrCol = new ArrayList();
	  
	  ArrayList arrFacRow = new ArrayList();
	  ArrayList arrFacCol = new ArrayList();
	  
	  if(hshValues !=null){
		  arrFacRow=(ArrayList)hshValues.get("arrFacRow");
	  }
	  int count1=0,count2=0;
		if(hshValues!=null)
		  {
			count1=Integer.parseInt(Helper.correctInt((String) hshValues.get("count1")));
			count2=Integer.parseInt(Helper.correctInt((String) hshValues.get("count2")));
			  //arrRow = (ArrayList) hshValues.get("arrRow");
		  }
		String strPromotorFreeze=Helper.correctNull((String)hshValues.get("strPromotorFreezeflag"));
		String strcgtmseavail = Helper.correctNull((String)hshValues.get("strcgtmseavail"));
		String strcgtmsecoapp = Helper.correctNull((String)hshValues.get("strcgtmsecoapp"));

		
		%>
<html>
<head>
<title>Attached Securities</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentdate="<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varCategoryType = "<%=strCategoryType%>";
var varApplicant = "<%=strApplicant%>";
var varlength = "<%=intLength%>";
var varPromotorFreeze="<%=strPromotorFreeze%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("strappstatus"))%>";
var varPostSanc="<%=Helper.correctNull((String)session.getAttribute("strAppType"))%>";
var varLASCHK="<%=Helper.correctNull((String)hshValues.get("strLASCHK"))%>";
var varBorrID="<%=Helper.correctNull((String)hshValues.get("strBorrID"))%>";
var varReleasedSec="<%=Helper.correctNull((String)hshValues.get("strReleasedSec"))%>";
var varSecValuation="<%=Helper.correctNull((String)hshValues.get("strSecValuation"))%>";
var varSecVerification="<%=Helper.correctNull((String)hshValues.get("strSecVerification"))%>";
var varcollSec="<%=Helper.correctNull((String)hshValues.get("strcolSec"))%>";

var varstrcgtmseavail="<%=Helper.correctNull((String)hshValues.get("strcgtmseavail"))%>";
var varstrcgtmsecoapp="<%=Helper.correctNull((String)hshValues.get("strcgtmsecoapp"))%>";


function Onloading()
{
	var Freezeflag="N";
	disablefields(true);
	<%if(strFreezeflag.equalsIgnoreCase("N")){%>
		document.forms[0].cmdfreeze.disabled=false;
	<%}else{%>
		document.forms[0].cmdfreeze.disabled=true;
		 Freezeflag="Y";
	<%}%>
	<%if(strFreezeflag.equalsIgnoreCase("Y")){%>
		var varfrm=document.forms[0];
		varfrm.cmdfreeze.disabled=true;
		document.forms[0].cmdundo.disabled=false;
		 Freezeflag="Y";
	<%}else{%>
		if(Freezeflag=="N")
		{
			document.forms[0].cmdfreeze.disabled=false;
		}
		document.forms[0].cmdundo.disabled=true;
	<%}%>
	if(document.forms[0].hidNonPoolFlag.value=="Y")
	{
		document.forms[0].cmdfreeze.disabled=true;
		document.forms[0].cmdundo.disabled=true;
	}
	if((document.forms[0].btnenable.value=="N") || (appstatus=="pa"))
	{
		document.forms[0].cmdfreeze.disabled=true;
		document.forms[0].cmdundo.disabled=true;
	}
	if(document.forms[0].btnenable.value=="Y")
	{
		if(varPostSanc=="P")
		{
			var boolflag=false;
			var varPSterms = document.forms[0].hidPostSancParams.value.split("@");
			for(var i=0;i<varPSterms.length;i++)
			{
				boolflag=true;
			}
			if(boolflag)
			{
				<%if(strFreezeflag.equalsIgnoreCase("N")){%>
				document.forms[0].cmdfreeze.disabled=false;
			<%}else{%>
				document.forms[0].cmdfreeze.disabled=true;
			<%}%>
			<%if(strFreezeflag.equalsIgnoreCase("Y")){%>
				document.forms[0].cmdfreeze.disabled=true;
				document.forms[0].cmdundo.disabled=false;
			<%}else{%>
				if(Freezeflag=="N")
				{
					document.forms[0].cmdfreeze.disabled=false;
				}
				document.forms[0].cmdundo.disabled=true;
			<%}%>
			}
			else
			{
				document.forms[0].cmdfreeze.disabled=true;
				document.forms[0].cmdundo.disabled=true;
			}
		}
	}
	
}
function doUndo()
{
	document.forms[0].hidAction.value="undo";
	document.forms[0].hid_categoryType.value = varCategoryType;
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidBeanId.value="securitymaster"
	document.forms[0].hidBeanMethod.value="updateAttachedSecurityDetails";
	document.forms[0].hidBeanGetMethod.value="getAttachedSecurityDetails";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/attachedsecurities.jsp";
	document.forms[0].submit();
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
function doFreeze()
{
	if(varstrcgtmseavail=="Y")
	{
			alert("You cannot Freeze. Collateral security cannot be added if the facility is covered under CGTMSE. Kindly remove Securities ("+varcollSec+") and proceed.");
			return;
	  }
	if(varcollSec!="")
	{
		//alert("Collateral security cannot be added if the facility is covered under CGTMSE. ");
		 //return false;
	}
	if(varPromotorFreeze!="Y")
	  {
		 alert("Freeze still not done. Please Freeze Co-Applicant/ Guarantor in Co-Applicant / Guarantor tab");
		 return false;
	  }
	  if(varLASCHK!="")
	  {
		  alert("Equity share securities are not given for these facilities ("+varLASCHK+").\n At least one Equity share Security should be there for each Loan Against Share facility.");
		  return;
	  }
	  if(varSecValuation!="")
	  {
		  alert("Security Verification pending for the following securities ("+varSecValuation+"). Kindly Approve/Reject the modifications.");
		  return;
	  }
	  if(varSecVerification!="")
	  {
		  alert("Security Ownership change request yet to confirmed for the following securities ("+varSecVerification+"). Kindly Approve/Reject it.");
		  return; 
	  }
	  if(varBorrID!="")
	  {
		  alert("The following borrower ("+varBorrID+") securities are present in proposed securities. But Those Borrowers are not related to this proposal.");
	  }
	  if(varReleasedSec!="")
	  {
		  alert("The following Released securities  ("+varReleasedSec+")  are present in proposed securities.");
	  }
	  
	  if(varBorrID!="" ||varReleasedSec!="")
	  {
		  if(confirm("Do you want to detach third Party Securities/Released Securities from the Proposal?"))
		  {
			showProgress('imgloading');
			window.scrollTo(0, 0);
			document.forms[0].hidBeanId.value="securitymaster";
			document.forms[0].hidBeanMethod.value="DetachSecurities";
			document.forms[0].hidBeanGetMethod.value="getAttachedSecurityDetails";
			document.forms[0].hidSourceUrl.value="/action/attachedsecurities.jsp";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit(); 
		  }
	  }
	  else
	  {
		  showProgress('imgloading');
			window.scrollTo(0, 0);	
			document.forms[0].hidAction.value="freeze";
			document.forms[0].hidBeanId.value="securitymaster";
			//document.forms[0].hidBeanGetMethod.value="getAttachedSecurityDetails";
			document.forms[0].hidBeanGetMethod.value="getSecCollateralCoverage";
			document.forms[0].action=appURL+"action/attachedsecurities.jsp";
			document.forms[0].submit();
	  }
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onload="Onloading();">
<div id='imgloading' style="display:none;">
<img src="<%=ApplicationParams.getAppUrl()%>img/processing2.gif"></div>
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
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
 <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="33" />
			<jsp:param name="subpageid" value="106" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="33" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
			
			
		</jsp:include>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
	 <%if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home -&gt; Agriculture -&gt;Application -&gt; Promoters -&gt; Security Master -&gt; Attached Securities</td>
	<%} else if(strSessionModuleType.equals("RET")){%>
		<td class="page_flow">Home -&gt; Retail -&gt;Application -&gt; Security Master -&gt; Attached Securities</td>
	<%}else{%>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Promoters -&gt; Security Master -&gt; Attached Securities</td>
		<%} %>			
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../set/appurlsectabs.jsp" flush="true">
			<jsp:param name="pageid" value="21"/>
			<jsp:param name="Freezeflag" value="<%=strFreezeflag%>" />
		</jsp:include>
		</td>
	</tr>
</table>
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
	<tr>

		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
				<%
			int h=0;
			for(int g=0;g<count1;g++)
			{
				 arrCol=(ArrayList) hshValues.get("arrRow1"+(g+1));
				 if(g==0){ 
				 %>
				 <tr class="dataHeader">			                        
					<td align="center" colspan="10">Proposed Facilities</td>										
			</tr>
			<tr class="dataheader">	
					<td align="center" width="5%">S.No</td>
					<td align="left" width="15%">Facility Name</td>
					<td align="left" width="10%">Security Id</td>
					<td align="left" width="5%">Type</td>		                        
					<td align="left" width="10%">Security Type</td>
					<td align="left" width="10%">Classification</td>
					<td align="left" width="10%">Owner Name</td>
					<td align="left" width="10%">Attached Security Value</td>
					<td align="center" width="5%">Margin</td>
					<td align="left"width="10%">Present security value</td>	
			</tr>	
				 <%}
				 for(int c=0;c<arrCol.size();c++)
					{
					 ArrayList arrVal=(ArrayList) arrCol.get(c); 
					 if(arrCol.size()==0)
					 {%>
					
			
					<%}else {%>	 
				 
			<tr class="datagrid">
					<td align="center"><b><%=Helper.correctNull((String)arrVal.get(4))%></b>&nbsp;</td>
					<td align="left">
					<input type="hidden" name="hidFacname" value="<%=Helper.correctNull((String)arrVal.get(6))%>">
					<b><%=Helper.correctNull((String)arrVal.get(6))%></b></td>	
					<td align="left">
					<input type="hidden" name="hidSecID" value="<%=Helper.correctNull((String)arrVal.get(0))%>">
					<b><%=Helper.correctNull((String)arrVal.get(0))%></b></td>	
					<td align="left"><b><%=Helper.correctNull((String)arrVal.get(7))%></b></td>		                        
					<td align="left"><b><%=Helper.correctNull((String)arrVal.get(2))%></b></td>
					<td align="left">
					<input type="hidden" name="hidFacSno" value="<%=Helper.correctNull((String)arrVal.get(4))%>">
					<b><%=Helper.correctNull((String)arrVal.get(3))%></b></td>
					<td><b><%=Helper.correctNull((String)arrVal.get(9))%></td>
					<td align="right"><b><%=Helper.correctNull((String)arrVal.get(8))%></td>
					<td align="center"><b><%=Helper.correctNull((String)arrVal.get(1))%></b></td>
					<td align="right"><b><%=Helper.correctNull((String)arrVal.get(10))%></b></td>
			</tr>
			<%h++;}}}%>	
			
			
		
		<%
			for(int g=0;g<count2;g++)
			{
				 arrCol=(ArrayList) hshValues.get("arrRow2"+(g+1));
				if(g==0){ %>
				 <tr class="dataHeader">			                        
					<td align="center" colspan="10">Existing Facilities&nbsp;&nbsp;<b></td>										
			</tr>
			<tr class="dataheader">	
					<td align="left" colspan="2">Facility Name</td>
					<td align="left">Security Id</td>
					<td align="left">Type</td>		                        
					<td align="left">Security Type</td>
					<td align="left">Classification</td>
					<td align="left">Owner Name</td>
					<td align="left">Attached Security Value</td>
					<td align="center">Margin</td>
					<td align="left">Present security value</td>	
			</tr>	
				 <%}
				 for(int c=0;c<arrCol.size();c++)
					{
					 ArrayList arrVal=(ArrayList) arrCol.get(c); 
					 %>	 
				 
			<tr class="datagrid">
			<td align="left"  colspan="2">
					<input type="hidden" name="hidFacname" value="<%=Helper.correctNull((String)arrVal.get(6))%>">
					<b><%=Helper.correctNull((String)arrVal.get(6))%></b></td>	
					<td align="left">
					<input type="hidden" name="hidSecID" value="<%=Helper.correctNull((String)arrVal.get(0))%>">
					<b><%=Helper.correctNull((String)arrVal.get(0))%></b></td>	
					<td align="left"><b><%=Helper.correctNull((String)arrVal.get(7))%></b></td>		                        
					<td align="left"><b><%=Helper.correctNull((String)arrVal.get(2))%></b></td>
					<td align="left">
					<input type="hidden" name="hidFacSno" value="<%=Helper.correctNull((String)arrVal.get(4))%>">
					<b><%=Helper.correctNull((String)arrVal.get(3))%></b></td>
					<td><b><%=Helper.correctNull((String)arrVal.get(9))%></td>
					<td align="right"><b><%=Helper.correctNull((String)arrVal.get(8))%></td>
					<td align="center"><b><%=Helper.correctNull((String)arrVal.get(1))%></b></td>
					<td align="right"><b><%=Helper.correctNull((String)arrVal.get(10))%></b></td>
			</tr>
			<%h++;}}%>	
			
		</table>
		</td>
	</tr>
</table>

<br>
<input type="hidden" name="hid_categoryType" value="">
<input type="hidden" name="hidsectype" value="<%=sectype%>">
<lapschoice:combuttonnew btnnames="Freeze_Undo" btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="hidappno" value="<%=Helper.correctNull((String)request.getParameter("appno")) %>">
<input type="hidden" name="hidsize" value="<%=arrCol.size()%>">
<input type="hidden" name="hid_applicant" value="<%=strApplicant%>">
<input type="hidden" name="hidsize_priority"  value="<%=h%>">
<input type="hidden" name="hid_prioritycheck"  value="<%=strPrioirycheck%>">
<input type="hidden" name="cmdsave" disabled="disabled">
<input type="hidden" name="hidSecurityId" value="<%=Helper.correctNull((String) request.getParameter("hidsecid"))%>">
<input type="hidden" name="hidPostSancParams" value="<%=Helper.correctNull((String)hshValues.get("strPostSancParam"))%>">
</form>

</body>
</html>
