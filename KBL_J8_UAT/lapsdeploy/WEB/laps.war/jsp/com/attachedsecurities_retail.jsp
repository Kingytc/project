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
  int count1=0,count2=0,totcount=0;
	if(hshValues!=null)
	  {
		count1=Integer.parseInt(Helper.correctInt((String) hshValues.get("count1")));
		count2=Integer.parseInt(Helper.correctInt((String) hshValues.get("count2")));
		totcount=Integer.parseInt(Helper.correctInt((String) hshValues.get("strTotcount")));
		  //arrRow = (ArrayList) hshValues.get("arrRow");
	  }
	session.setAttribute("strFrzfalgnew",strFreezeflag);
	
	String strFreezecoappguar=Helper.correctNull((String)hshValues.get("strCoAppFreezeflag"));
	String strProductType=Helper.correctNull((String)session.getAttribute("strProductType"));
	
	String prd_type = Helper.correctNull((String) session.getAttribute("strProductType"));
	String strPrdPurpose=Helper.correctNull((String) session.getAttribute("strPrdPurpose"));
	String strProAvailableFor =Helper.correctNull((String) hshValues.get("prd_applicablefor"));
	int linkid = Integer.parseInt(Helper.correctInt(request.getParameter("linkid")));
	String strValuationFlag=Helper.correctNull((String)hshValues.get("valuationFlag"));
	session.setAttribute("valuationFlag",strValuationFlag);
	String strHouseFlag=Helper.correctNull((String)hshValues.get("HouseEdit_Flag"));
	session.setAttribute("HouseEdit_Flag",strHouseFlag);
	String strVehicleFlag=Helper.correctNull((String)hshValues.get("VehicleEdit_Flag"));
	session.setAttribute("VehicleEdit_Flag",strVehicleFlag);
	String strcgtmseavail = Helper.correctNull((String)hshValues.get("strcgtmseavail"));
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
var varFreezecoappguar="<%=strFreezecoappguar%>";
var varProductType="<%=strProductType%>";
var varSecChkFlag="<%=Helper.correctNull((String)hshValues.get("strSecChkforpI"))%>";
var varSecFlag="<%=Helper.correctNull((String)hshValues.get("strSecFlag"))%>";
var varPrdpurpose="<%=Helper.correctNull((String)hshValues.get("strPrdpurpose"))%>";
var varBorrID="<%=Helper.correctNull((String)hshValues.get("strBorrID"))%>";
var varReleasedSec="<%=Helper.correctNull((String)hshValues.get("strReleasedSec"))%>";
var varSecValuation="<%=Helper.correctNull((String)hshValues.get("strSecValuation"))%>";
var varSecVerification="<%=Helper.correctNull((String)hshValues.get("strSecVerification"))%>";
var varValuationFlag="<%=Helper.correctNull((String)hshValues.get("valuationFlag"))%>";
var varHouseFlag="<%=Helper.correctNull((String)hshValues.get("HouseEdit_Flag"))%>";
var varVehicleFlag="<%=Helper.correctNull((String)hshValues.get("VehicleEdit_Flag"))%>";
var varColSec="<%=Helper.correctNull((String)hshValues.get("strcolSec"))%>";
var varCGTMSE_flag="<%=Helper.correctNull((String)hshValues.get("str_CGTMSEFlag"))%>";
function Onloading()
{
	var Freezeflag="N";
	disablefields(true);
	if(document.forms[0].btnenable.value=="Y")
	{
	<%if(strFreezeflag.equalsIgnoreCase("N")){%>
		document.forms[0].cmdfreeze.disabled=false;
		document.forms[0].cmdundo.disabled=true;
	<%}else{%>
		document.forms[0].cmdfreeze.disabled=true;
		document.forms[0].cmdundo.disabled=false;
		 Freezeflag="Y";
	<%}%>
	<%if(strFreezeflag.equalsIgnoreCase("Y")){%>
		document.forms[0].cmdfreeze.disabled=true;
		document.forms[0].cmdundo.disabled=false;
		 Freezeflag="Y";
	<%}else{%>
		if(Freezeflag=="N")
		{
			document.forms[0].cmdfreeze.disabled=false;
		}
		document.forms[0].cmdundo.disabled=true;
	<%}if(prd_type.equals("pC") && strSessionModuleType=="DIGI"){%>
		document.forms[0].cmdundo.disabled=true;
	<%}%>
	}else
	{
		document.forms[0].cmdfreeze.disabled=true;
		document.forms[0].cmdundo.disabled=true;
	}
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
	/*if(varProductType=="pH")
	{
		if(varHouseFlag=="N"){
			alert("Please Fill all fields in ProposedAssets-->House Tab ");
			return false;
			}
		if(varValuationFlag=="N"){
			alert("Please Fill all fields in ProposedAssets-->ValuationEntry Tab ");
			return false;
			}
		
		}
	if(varProductType=="pA")
	{
		if(varVehicleFlag=="N"){
			alert("Please Fill all fields in ProposedAssets-->Vehicle Tab ");
			return false;
			}
		if(varValuationFlag=="N"){
			alert("Please Fill all fields in ProposedAssets-->ValuationEntry Tab ");
			return false;
			}
		
		}*/
	    <%if(strcgtmseavail.equalsIgnoreCase("Y")){%>
			alert("You cannot Freeze. Collateral security cannot be added if the facility is covered under CGTMSE. Kindly remove Securities ("+varColSec+") and proceed.");
			return;
        <%}%>
		if(varColSec!="" && varCGTMSE_flag=="Y")
		{
			//alert("Collateral security cannot be added if the facility is covered under CGTMSE.Kindly remove ("+varColSec+") and proceed.");
			//return;
		}
	<%if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
		if(varProductType=="pI" && varSecChkFlag=="Y")
		{
			alert("Value of Securities not equal to attached Securities");
			return false;
		}
		if(varProductType=="pH" && (varPrdpurpose=="F" || varPrdpurpose=="T") && varSecFlag=="Y")
		{
			alert("Market value of the property is not equal to Collateral Securities");
			return false;
		}
	<%}%>
		if((varFreezecoappguar=="N" || varFreezecoappguar==""))
		  {
			 alert("Please Freeze Co-Applicant / Guarantor in Loan Particulars tab");
			 return false;
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
				document.forms[0].hidBeanId.value="bankappfi";
				document.forms[0].hidBeanMethod.value="DetachSecurities";
				document.forms[0].hidBeanGetMethod.value="getAttachedRetailSecurityDetails";
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
				document.forms[0].hidBeanId.value="bankappfi";
				document.forms[0].hidBeanMethod.value="getSecCollateralCoverageRetail";
				document.forms[0].hidBeanGetMethod.value="getAttachedRetailSecurityDetails";
				document.forms[0].action=appURL+"controllerservlet";
				document.forms[0].hidSourceUrl.value="/action/attachedsecurities_retail.jsp";
				document.forms[0].submit();
		  }
}

function callLink(page,bean,method)
{ 
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidAction.value="";
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

function Prioritycheck(facno,priorityval,rowid)
{
	var Prioirtyvalue=priorityval.value;
	var Priority=document.forms[0].hid_prioritycheck.value;
	var defaultVal="",defval="";

	var facility="",priVal="";
	var length="",flag="Y";

	facility=Priority.split("-");
	length=facility.length;

	for(var i=0;i<length;i++)
	{
		priVal=facility[i].split("@");
		defval=defaultVal.split("@");
		if(defval[0]==priVal[0])
		{
			if(defval[1]==priVal[1])
			{
				facility[i]="";
			}
		}
	}
	for(var i=0;i<length;i++)
	{
		priVal=facility[i].split("@");
		if(facno==priVal[0])
		{
			if(Prioirtyvalue==priVal[1])
			{
				flag="N";
				alert("Same Prioity cannot be given");
				priorityval.value="0";
				return;
			}
		}
	}
	if(flag=="Y")
	{
		if(!(Prioirtyvalue==0))
		{
			if(Priority=="")
			{				
				Priority=facno+"@"+Prioirtyvalue;
				document.forms[0].hid_prioritycheck.value=Priority;
			}
			else
			{
				Priority=Priority+"-"+facno+"@"+Prioirtyvalue;
				document.forms[0].hid_prioritycheck.value=Priority;
			}
		}
	}
}
function callalert()
{
	alert("Click Freeze to view Security Coverage");
	return;
}
function callLinkComments(page,bean,method,title)
{
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidAction.value="";
	 	document.forms[0].hidBeanGetMethod.value=method;
	 	document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].hpage.value=title;	 
	 	document.forms[0].action=appURL+"action/"+page;
	 	document.forms[0].submit();
	}
	else 
	{
		ShowAlert(103);
	}
}
function callMDTD()
{
	document.forms[0].action=appURL+"action/app_sec_MDTDdetails.jsp";
	document.forms[0].submit();	
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onload="Onloading();">
<div id='imgloading' style="display:none;">
<img src="<%=ApplicationParams.getAppUrl()%>img/processing2.gif"></div>
<form name="frmcapitalstructure" method="post" class="normal">
<%if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>

<% if(strSessionModuleType.equalsIgnoreCase("DIGI")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkerdigi.jsp" flush="true"> 
        <jsp:param name="pageid" value="22" />
        </jsp:include>
		</td>
	</tr>
</table>
<% } else { %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="22" />
        </jsp:include>
		</td>
	</tr>
</table>
<% } %>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
	 <%if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home -&gt; Agriculture -&gt;Application -&gt;  Security Master -&gt; Attached Securities</td>
	<%}else if(strSessionModuleType.equals("CORP")){%>
		<td class="page_flow">Home -&gt; Corporate -&gt;Application -&gt;  Security Master -&gt; Attached Securities</td>
	<%}else if(strSessionModuleType.equals("DIGI")) {%>
		<td class="page_flow">Home -&gt; Digi Retail -&gt; Application -&gt; Security Master -&gt; Attached Securities</td>
	<%}else{%>
	<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Application -&gt; Security Master -&gt; Attached Securities</td>
	<%} %>		
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
      <td>
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr align="center"> 
            <td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callLink('securitymaster_retail.jsp','bankappfi','getSecurityRetailDetails')">Borrower Securities</a></b></b>
            </td>
            <td align="center" width="15%" class="sub_tab_active"><b><b>Attached Securities</b></b></td>
           
           <%if(strSessionModuleType.equals("RET") || strSessionModuleType.equals("DIGI") ){ %>
           
          	<%
				  if (prd_type.substring(0, 1).equalsIgnoreCase("p")
								&& !prd_type.equalsIgnoreCase("pE")
								&& !prd_type.equalsIgnoreCase("pG")
								&& !prd_type.equalsIgnoreCase("pM")
								&& !prd_type.equalsIgnoreCase("pL")
								&& !prd_type.equalsIgnoreCase("pI")) {
							if (linkid == 5) {
				%>
				<td class="sub_tab_active" WIDTH="15%" nowrap="nowrap"><b>Proposed/Offered
				Asset</b></td>
				<%
					} else if ((prd_type.equalsIgnoreCase("pH")&& !(strPrdPurpose.equalsIgnoreCase("F")||strPrdPurpose.equalsIgnoreCase("T")||strPrdPurpose.equalsIgnoreCase("HC")))
									|| prd_type.equalsIgnoreCase("pM")
									|| prd_type.equalsIgnoreCase("pI")
									|| prd_type.equalsIgnoreCase("pT")) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('perpropertydetails','getHousingLoanData','per_house_proposed_asset.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					} else if (prd_type.equalsIgnoreCase("pA")||(prd_type.equalsIgnoreCase("pU") && strProAvailableFor.equalsIgnoreCase("V"))) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('percollateral','getBoatAuto','perappvehicle.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					} else if (prd_type.equalsIgnoreCase("pD")) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('perpropertydetails','getOtherAssetData','otherassets.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					} else if (prd_type.equalsIgnoreCase("pK")) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('agreconomic','getSolarlightData','per_solarlight.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					}
						}	
         		 %>
          <% } %>
            
            <%
			if(strFreezeflag.equalsIgnoreCase("Y")){%>
		 	<td align="center" width="15%" class="sub_tab_inactive_new"><b>
		 	 	<a href="JavaScript:callLink('com_attchsecuritydisplay_reatail.jsp','securitymaster','getCollateralSecurityDisplayretail')">
			 	Security Coverage</a></b></td>				
			<% }else{%>
			<td align="center" width="15%" class="sub_tab_inactive_new" align="center"><b><a href="JavaScript:callalert()">Security Coverage</a></b></td>
			
				<%} %>
          <td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callLinkComments('per_commentsonseccovergae.jsp','facilities','getComments','secoverageretail')">Comments on Security Coverage</a></b></b></td>
          <td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callMDTD()">MDTD</a></b></b></td>	
          <td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callLink('securitynewtab.jsp','bankappfi','getlegalopinionverification')">Legal opinion verification</a></b></b></td>	
          </tr>
        </table>
      </td>
    </tr>
  </table>
 <%} else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="4" />
			<jsp:param name="subpageid" value="106" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
      <td>pervehi
        <table width="80%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr> 
          <td align="center" width="15%" class="sub_tab_inactive"><b><b><a
					href="#" onclick="javascript:callLink('securitymaster_retail.jsp','bankappfi','getSecurityRetailDetails')">Security</a></b></b></td>
            <td align="center" width="15%" class="sub_tab_active"><b>Attached Securities</b>
            </td>
            <%
			if (prd_type.equalsIgnoreCase("pH")&& !(strPrdPurpose.equalsIgnoreCase("F")||strPrdPurpose.equalsIgnoreCase("T")||strPrdPurpose.equalsIgnoreCase("HC"))) {
		%>
		<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap" align="center"><a
			href="JavaScript:gototab('perpropertydetails','getHousingLoanData','per_house_proposed_asset.jsp')"><b>Proposed/Offered
		Asset</b></a></td>
		<%
			}
					%>
            
          <%
			if(strFreezeflag.equalsIgnoreCase("Y")){%>
		 	<td align="center" width="15%" class="sub_tab_inactive_new"><b>
		 	 	<a href="JavaScript:callLink('com_attchsecuritydisplay_reatail.jsp','securitymaster','getCollateralSecurityDisplayretail')">
			 	Security Coverage</a></b></td>				
			<% }else{%>
			<td align="center" width="15%" class="sub_tab_inactive_new" align="center"><b><a href="JavaScript:callalert()">Security Coverage</a></b></td>
			
				<%} %>
				
          
          </tr>
        </table>
      </td>
    </tr>
  </table>
<%} %>
 

<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
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
			<tr class="dataHeader"><td align="center" colspan="8">Proposed Facilities</td></tr>
			<tr class="dataheader">	<td align="left">Facility Name</td>
				<td align="left">Security Id</td>		                        
				<td align="left">Security</td>
				<td align="left">Security Type</td>
				<td align="left">Classification</td>
				<td align="left">Attached Security Value</td>
				<td align="center">Margin</td>
				<td align="left">Present security value</td>	
			</tr>	
				 <%}
				 for(int c=0;c<arrCol.size();c++)
					{
					 ArrayList arrVal=(ArrayList) arrCol.get(c); 
					 if(c==0)
					 {%>
					<%}else {%>	 
				 
			<tr class="datagrid">
				<td align="left" width="12%"><input type="hidden" name="hidFacname" value="<%=Helper.correctNull((String)arrVal.get(6))%>"><b><%=Helper.correctNull((String)arrVal.get(6))%></b></td>	
				<td align="left" width="12%"><input type="hidden" name="hidSecID" value="<%=Helper.correctNull((String)arrVal.get(0))%>"><b><%=Helper.correctNull((String)arrVal.get(0))%></b></td>			                        
				<td align="left" width="20%"><b><%=Helper.correctNull((String)arrVal.get(2))%></b></td>
				<td align="left" width="10%"><input type="hidden" name="hidSectype" value="<%=Helper.correctNull((String)arrVal.get(7))%>"><b>
				<%if(Helper.correctNull((String)arrVal.get(7)).equalsIgnoreCase("1")){out.println("Primary");}
				else{out.println("Collateral");}%></b></td>
				<td align="left" width="13%"><input type="hidden" name="hidFacSno" value="<%=Helper.correctNull((String)arrVal.get(4))%>"><b><%=Helper.correctNull((String)arrVal.get(3))%></b></td>
			
				<td align="right" width="10%"><input type="hidden" name="hidAttachsecValue" value="<%=Helper.correctNull((String)arrVal.get(8))%>"><b><%=Helper.correctNull((String)arrVal.get(8))%></b></td>
				<td align="center" width="5%"><b><%=Helper.correctNull((String)arrVal.get(1))%></b></td>
	 			<td align="right" width="10%"><input type="hidden" name="hidpresentsecvalue" value="<%=Helper.correctNull((String)arrVal.get(9))%>"><b><%=Helper.correctNull((String)arrVal.get(9))%></b></td>
			</tr>
			<%h++;}}}%>	
		<%
			for(int g=0;g<count2;g++)
			{
				 arrCol=(ArrayList) hshValues.get("arrRow2"+(g+1));
				if(g==0){ %>
				 <tr class="dataHeader">			                        
					<td align="center" colspan="8">Existing Facilities&nbsp;&nbsp;<b></td>										
			</tr>
			<tr class="dataheader">	
				<td align="left">Facility Name</td>
				<td align="left">Security Id</td>	
				<td align="left">Security</td>	                        
				<td align="left">Security Type</td>
				<td align="left">Classification</td>
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
				<td align="left" width="12%"><input type="hidden" name="hidFacname" value="<%=Helper.correctNull((String)arrVal.get(6))%>"><b><%=Helper.correctNull((String)arrVal.get(6))%></b></td>	
				<td align="left" width="12%"><input type="hidden" name="hidSecID" value="<%=Helper.correctNull((String)arrVal.get(0))%>"><b><%=Helper.correctNull((String)arrVal.get(0))%></b></td>			                        
				<td align="left" width="20%"><b><%=Helper.correctNull((String)arrVal.get(2))%></b></td>
				<td align="left" width="10%"><input type="hidden" name="hidSectype" value="<%=Helper.correctNull((String)arrVal.get(7))%>">	<b><%=Helper.correctNull((String)arrVal.get(7))%></b></td>
				<td align="left" width="13%"><input type="hidden" name="hidFacSno" value="<%=Helper.correctNull((String)arrVal.get(4))%>"><b><%=Helper.correctNull((String)arrVal.get(3))%></b></td>
				<td align="right" width="10%"><input type="hidden" name="hidAttachsecValue" value="<%=Helper.correctNull((String)arrVal.get(8))%>"><b><%=Helper.correctNull((String)arrVal.get(8))%></b></td>
				<td align="center" width="5%"><b><%=Helper.correctNull((String)arrVal.get(1))%></b></td>
	 			<td align="right" width="10%"><input type="hidden" name="hidpresentsecvalue" value="<%=Helper.correctNull((String)arrVal.get(9))%>"><b><%=Helper.correctNull((String)arrVal.get(9))%></b></td>
	
			</tr>
			<%h++;}}%>	
		</table>
		</td>
	</tr>
</table>
<script>

function doUndo()
{
	document.forms[0].hidAction.value="undo";
	document.forms[0].hid_categoryType.value = varCategoryType;
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidBeanId.value="bankappfi"
	document.forms[0].hidBeanMethod.value="updateAttachedRetailSecurityDetails";
	document.forms[0].hidBeanGetMethod.value="getAttachedRetailSecurityDetails";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/attachedsecurities_retail.jsp";
	document.forms[0].submit();
}
</script>
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
<input type="hidden" name="hpage">
<input type="hidden" name="cmdsave" disabled="disabled">
<input type="hidden" name="hidSecurityId" value="<%=Helper.correctNull((String) request.getParameter("hidsecid"))%>">
<input type="hidden" name="hidValuationFlag" value="<%=Helper.correctNull((String)hshValues.get("valuationFlag"))%>">
<input type="hidden" name="hidHouseEdit_Flag" value="<%=Helper.correctNull((String)hshValues.get("HouseEdit_Flag"))%>">
<input type="hidden" name="hidVehicleEdit_Flag" value="<%=Helper.correctNull((String)hshValues.get("VehicleEdit_Flag"))%>">
</form>

</body>
</html>
