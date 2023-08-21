<%@include file="../share/directives.jsp"%>
<%
//out.println(hshValues);
ArrayList arrAssessmentData = new ArrayList();
ArrayList arrAssessmentDisp = new ArrayList();
if (hshValues.get("arrAssessment") != null) 
{
	arrAssessmentData = (ArrayList) hshValues.get("arrAssessment");
}
ArrayList arrIncAssessmentData = new ArrayList();
ArrayList arrIncAssessmentDisp = new ArrayList();
HashMap hshIncAssessmentValues = new HashMap();
if (hshValues.get("hshInc") != null) 
{
	hshIncAssessmentValues = (HashMap) hshValues.get("hshInc");
}
if (hshIncAssessmentValues.get("arrIncAssessment") != null) 
{
	arrIncAssessmentData = (ArrayList) hshIncAssessmentValues.get("arrIncAssessment");
}
String strprd_bankscheme=Helper.correctDouble((String)hshValues.get("prd_bankscheme"));
String strStaffPrd=Helper.correctNull((String)hshValues.get("strStaffPrd"));
String strPrdType=Helper.correctNull((String) session.getAttribute("strProductType"));
String strProductPurpose=Helper.correctNull((String)session.getAttribute("strPrdPurpose"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();

%>
<html>
<head>
<title>Appraisal - Common Assessment</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
var varSecuirtyFlag="<%=Helper.correctNull((String)hshValues.get("strSecuirtyFlag"))%>";
var varProductPurpose="<%=strProductPurpose%>";
var varProductType="<%=Helper.correctNull((String) session.getAttribute("strProductType"))%>";
var varCOP="<%=Helper.correctDouble((String) hshValues.get("strCOP"))%>";
var varMLSS="<%=Helper.correctDouble((String) hshValues.get("strMLSS"))%>";
var varVehiType="<%=Helper.correctDouble((String) hshValues.get("strVehicleType"))%>";
var varHouseFlag="<%=Helper.correctNull((String) hshValues.get("strHouseFlag"))%>";
var varVehicleFlag="<%=Helper.correctNull((String) hshValues.get("strVehicleFlag"))%>";
var varValuationFlag1="<%=Helper.correctNull((String) hshValues.get("strValuationFlag"))%>";
function callOnLoad()
{
	if(document.forms[0].appstatus.value=="Open/Pending")
	{
		if(varProductType=="pH" && !(varProductPurpose=="F"||varProductPurpose=="T"||varProductPurpose=="HC"))
		{
			if(varHouseFlag!="" && varHouseFlag=="N")
			{
					alert("Please Fill all fields in Proposed Assets-->House Tab ");
					document.forms[0].hidBeanGetMethod.value="getHousingLoanData";
					document.forms[0].hidBeanId.value="perpropertydetails";
					document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/per_house_proposed_asset.jsp";	
					document.forms[0].submit();
			}
			else if(varValuationFlag1!="" && varValuationFlag1=="N")
			{
					alert("Please Fill all fields in Proposed Assets-->ValuationEntry Tab ");
					document.forms[0].hidBeanGetMethod.value="getValuerEntryData";
					document.forms[0].hidBeanId.value="perpropertydetails";
					document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/valuation_entry.jsp";	
					document.forms[0].submit();
			}
			else if(varProductPurpose=="G")
			{
				var varAmt="<%=Helper.correctDouble((String) hshValues.get("strPurchseplotprice"))%>";
				var varTotal=eval(varAmt)+eval(varMLSS);
				if(!((eval(varCOP)==eval(varAmt))||(eval(varTotal)==eval(varCOP))))
				{
					alert("Total Purchase value should tally with Cost of the Project");
					document.forms[0].hidBeanGetMethod.value="getHousingLoanData";
					document.forms[0].hidBeanId.value="perpropertydetails";
					document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/per_house_proposed_asset.jsp";	
					document.forms[0].submit();
				}
			}
			else if(varProductPurpose=="C"||varProductPurpose=="R")
			{
				var varAmt="<%=Helper.correctDouble((String) hshValues.get("strConstructioncost"))%>";
				var varTotal=eval(varAmt)+eval(varMLSS);
				if(!((eval(varCOP)==eval(varAmt))||(eval(varTotal)==eval(varCOP))))
				{
					alert("Total Cost of Construction should tally with Cost of the Project");
					document.forms[0].hidBeanGetMethod.value="getHousingLoanData";
					document.forms[0].hidBeanId.value="perpropertydetails";
					document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/per_house_proposed_asset.jsp";	
					document.forms[0].submit();
				}
			}
			else if(varProductPurpose=="S")
			{
				var varAmt="<%=Helper.correctDouble((String) hshValues.get("strPurchseplotprice"))%>";
				var varAmt1="<%=Helper.correctDouble((String) hshValues.get("strEstimatedcost"))%>";
				varAmt=eval(varAmt)+eval(varAmt1);
				var varTotal=eval(varAmt)+eval(varMLSS);
				if(!((eval(varCOP)==eval(varAmt))||(eval(varTotal)==eval(varCOP))))
				{
					alert("Total Purchase and estimated construction value should tally with Cost of the Project");
					document.forms[0].hidBeanGetMethod.value="getHousingLoanData";
					document.forms[0].hidBeanId.value="perpropertydetails";
					document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/per_house_proposed_asset.jsp";	
					document.forms[0].submit();
				}
			}
			else if(varProductPurpose=="H")
			{
				var varAmt="<%=Helper.correctDouble((String) hshValues.get("strPurchasebuiltprice"))%>";
				var varTotal=eval(varAmt)+eval(varMLSS);
				if(!((eval(varCOP)==eval(varAmt))||(eval(varTotal)==eval(varCOP))))
				{
					alert("Total Purchase Price of building should tally with Cost of the Project");
					document.forms[0].hidBeanGetMethod.value="getHousingLoanData";
					document.forms[0].hidBeanId.value="perpropertydetails";
					document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/per_house_proposed_asset.jsp";	
					document.forms[0].submit();
				}
			}
		}
		if(varProductType=="pA")
		{
			if(varVehicleFlag!="" && varVehicleFlag=="N")
			{
				alert("Please Fill all fields in Proposed Assets-->Vehicle Tab ");
				document.forms[0].hidBeanGetMethod.value="getBoatAuto";
				document.forms[0].hidBeanId.value="percollateral";
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perappvehicle.jsp";	
				document.forms[0].submit();
			}
			else if(varValuationFlag1!="" && varValuationFlag1=="N")
			{
					alert("Please Fill all fields in Proposed Assets-->ValuationEntry Tab ");
					document.forms[0].hidBeanGetMethod.value="getValuerEntryData";
					document.forms[0].hidBeanId.value="perpropertydetails";
					document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/valuation_entry.jsp";	
					document.forms[0].submit();
			}
			else if(varVehiType=="1")
			{
				var varAmt="<%=Helper.correctDouble((String) hshValues.get("strVehicleAmt"))%>";
				var varTotal=eval(varAmt)+eval(varMLSS);
				if(!((eval(varCOP)==eval(varAmt))||(eval(varTotal)==eval(varCOP))))
				{
					alert("Total Vehicle Cost should tally with Cost of the Project");
					document.forms[0].hidBeanGetMethod.value="getBoatAuto";
					document.forms[0].hidBeanId.value="percollateral";
					document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perappvehicle.jsp";	
					document.forms[0].submit();
				}
			}
			else
			{
				var varAmt="<%=Helper.correctDouble((String) hshValues.get("strLeastval"))%>";
				var varTotal=eval(varAmt)+eval(varMLSS);
				if(!((eval(varCOP)==eval(varAmt))||(eval(varTotal)==eval(varCOP))))
				{
					alert("Total Vehicle Cost should tally with Cost of the Project");
					document.forms[0].hidBeanGetMethod.value="getBoatAuto";
					document.forms[0].hidBeanId.value="percollateral";
					document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perappvehicle.jsp";	
					document.forms[0].submit();
				}
			}
		}
		if(varProductType=="pB")
		{
			var varAmt="<%=Helper.correctDouble((String) hshValues.get("strGSTReturnAmt"))%>";
			var varTotal=eval(varAmt)+eval(varMLSS);
			if(!((eval(varCOP)==eval(varAmt))||(eval(varTotal)==eval(varCOP))))
			{
				alert("Total of GST Returns entered in loan products tab should tally with Total Amount in GST Returns Details tab");
				document.forms[0].hidBeanGetMethod.value="getGSTDetails";
				document.forms[0].hidBeanId.value="appraisal";
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/pergstdetails.jsp";	
				document.forms[0].submit();
			}
		}
	}
	
	if(varProductType=="pH" && (varProductPurpose=="F" || varProductPurpose=="T") && varSecuirtyFlag!="N")
	{
		alert("Freeze Securities in Securities tab");
		document.forms[0].hidBeanGetMethod.value="getAttachedRetailSecurityDetails";
		document.forms[0].hidBeanId.value="bankappfi";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/attachedsecurities_retail.jsp";	
		document.forms[0].submit();
	}
}

</script>
</head>
<body onload="callOnLoad();">
<form name="appform" method="post" class="normal">
<%if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>

<% if(strSessionModuleType.equalsIgnoreCase("DIGI")) { %>
<jsp:include page="../share/applurllinkerdigi.jsp" flush="true">
<jsp:param name="pageid" value="10" /></jsp:include>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Digi Retail -&gt; Appraisal -&gt; Assessment</td>
	</tr>
</table>
<% } else { %>
<jsp:include page="../share/Applurllinkper.jsp" flush="true">
<jsp:param name="pageid" value="10" /></jsp:include>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Appraisal -&gt;Assessment</td>
	</tr>
</table>
<%} %>
<lapschoice:application />
<jsp:include page="../share/apprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="15" />
</jsp:include>
<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
			<jsp:param name="subpageid" value="109" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<jsp:include page="../share/postsanctionapprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="15" />
		</jsp:include>
<%} %>

<br>
<table width="60%" border="0" cellpadding="0" cellspacing="0" class="outertable" align="center">
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="3" cellspacing="1" class="outertable">
			<% if (hshValues.get("arrAssessment") != null) {%>
			<tr class="dataheader">
				<td align="center" colspan="3"><b>ASSESSMENT BASED ON COST</b></td>
			</tr>
			<%	if (arrAssessmentData != null && arrAssessmentData.size() > 0)
				{
					for (int i = 0; i < arrAssessmentData.size(); i++)
					{	
					arrAssessmentDisp=(ArrayList)arrAssessmentData.get(i);
					if(strProductPurpose.equalsIgnoreCase("F")){
					if(i==5){%>
				<tr class="dataheader">
					<td align="center" colspan="3"><b>Assessment based on Cost of House</b></td>
				</tr>
					<%}}
					%>
					<tr  class="datagrid">
					<td align="left"><%=arrAssessmentDisp.get(0)%></td>
					<td align="right"><%=arrAssessmentDisp.get(1)%></td>
					</tr>
					<%}
				}}
			if(!strprd_bankscheme.equalsIgnoreCase("035"))
			{
			if (hshIncAssessmentValues.get("arrIncAssessment") != null) {
				if(!(strProductPurpose.equalsIgnoreCase("G")||(strStaffPrd.equalsIgnoreCase("Y") && strPrdType.equalsIgnoreCase("pH"))) && !strSessionModuleType.equals("DIGI")){%>
				<tr class="dataheader">
					<td align="center" colspan="3"><b>ASSESSMENT BASED ON INCOME</b></td>
				</tr>
				<%}
				if (arrIncAssessmentData != null && arrIncAssessmentData.size() > 0)
				{
					for (int i = 0; i < arrIncAssessmentData.size(); i++)
					{	
						arrIncAssessmentDisp=(ArrayList)arrIncAssessmentData.get(i);
						if(arrIncAssessmentDisp.get(0).toString().startsWith("Applicant -") ||
								arrIncAssessmentDisp.get(0).toString().startsWith("Joint-Applicant -") ||
								arrIncAssessmentDisp.get(0).toString().startsWith("Co-Obligant -") ||
								arrIncAssessmentDisp.get(0).toString().startsWith("Guarantor -")){
					%>
					<tr class="dataheader">
					<td colspan="3"><b><%=arrIncAssessmentDisp.get(0)%></b></td>
					</tr>
					<%} else if(arrIncAssessmentDisp.get(0).toString().startsWith("MAXIMUM AMOUNT BASED ON SCHEME")||
							arrIncAssessmentDisp.get(0).toString().startsWith("OVERALL")){%>
					<tr class="dataheader">
					<td colspan="3" align="center"><b><%=arrIncAssessmentDisp.get(0)%></b></td>
					</tr>
					<%} else {
						if(!(arrIncAssessmentDisp.get(0).toString().startsWith("Limit Eligible as per salary")) )
						{
						if((arrIncAssessmentDisp.get(0).toString().startsWith("Total Limit Eligible as per Income")))
						{%>
				<tr class="dataheader">
				<td align="center" colspan="3"><b>ELIGIBLE LIMIT AS PER INCOME</b></td>
				</tr>
					
				<tr  class="datagrid">
				<td align="left"><%=arrIncAssessmentDisp.get(0)%></td>
				<td align="right"><%=arrIncAssessmentDisp.get(1)%></td>
				</tr>
								
				<%}else{ %>
						
					<tr  class="datagrid">
					<td align="left"><%=arrIncAssessmentDisp.get(0)%></td>
					<td align="right"><%=arrIncAssessmentDisp.get(1)%></td>
					</tr>
				<%}
				}
				}
					}
				}}} if(hshValues.get("arrAssessment") == null && hshIncAssessmentValues.get("arrIncAssessment") == null){%>
				<tr class="dataheader">
					<td align="center" colspan="3"><b>No Assessment to Display</b></td>
				</tr>
				<%} %>
			</table>
		</td>
	</tr>
</table>
<br>
<input type="button" name="cmdsave" disabled style="display:none">
<lapschoice:combuttonnew btnnames='' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>