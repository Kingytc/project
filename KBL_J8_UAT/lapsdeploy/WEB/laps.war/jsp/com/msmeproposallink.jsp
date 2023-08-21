<%@ include file="../share/directives.jsp"%>
<%
	String strUserID = Helper.correctNull((String) session
			.getAttribute("strUserId"));
	String strAppid = Helper.correctNull((String) hshValues
			.get("strAppid"));
	ArrayList arryRow = (ArrayList) hshValues.get("arrRow1");
	ArrayList arryCol = new ArrayList();
	ArrayList g1 = new ArrayList();
	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMinimumFractionDigits(2);
	nf.setMaximumFractionDigits(2);
	nf.setGroupingUsed(false);
	int arrSize=0;
	if(arryRow!=null){
		arrSize = arryRow.size();
	}
%>
<html>
<head>
<title>MSME</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var varPendingFlag="<%=Helper.correctNull((String)hshValues.get("strPendingFlag"))%>";
var vardeletingflag="<%=Helper.correctNull((String)hshValues.get("strdeletingFlag"))%>";
var varminority="<%=Helper.correctNull((String)hshValues.get("indinfo_minority"))%>";
var varindreligion="<%=Helper.correctNull((String)hshValues.get("indinfo_religion"))%>";
var varcommunityminority="<%=Helper.correctNull((String)hshValues.get("cominfo_minority_community"))%>";
var nonindreligion="<%=Helper.correctNull((String)hshValues.get("perapp_religion"))%>";
var varmaj_member="<%=Helper.correctNull((String)hshValues.get("majority_member"))%>";
var varstake_held="<%=Helper.correctNull((String)hshValues.get("stake_held"))%>";
var varconstitut="<%=Helper.correctNull((String)hshValues.get("constitutionnew"))%>";
var varcaste="<%=Helper.correctNull((String)hshValues.get("indinfo_caste"))%>";
var vargender="<%=Helper.correctNull((String)hshValues.get("perapp_sex"))%>";
var varOrgLevel="<%=strOrgLevel%>";
var vararrSize="<%=arrSize%>";
var varappstatus="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>";
var varSales="<%=Helper.correctNull((String)hshValues.get("PERAPP_SALES_TURNOVER"))%>";
var varSalesDate="<%=Helper.correctNull((String)hshValues.get("PERAPP_SALES_TURNOVER_DATE"))%>";
var varSalesCriteria="<%=Helper.correctNull((String)hshValues.get("PERAPP_CRITERIA_SALES_TURNOVER"))%>";	
var varProfilestatus="<%=Helper.correctNull((String)hshValues.get("strProfilestatus"))%>";
var strnoproposal="<%=Helper.correctNull((String)hshValues.get("strnoproposal"))%>";

function doClose() {
	if (ConfirmMsg(100)) {
		document.forms[0].action = appURL + "action/mainnav.jsp";
		document.forms[0].submit();
	}
}

function doNew()
{	
	
	if(varPendingFlag=="Y")
	{
		alert("MSME Proposal already Pending for this Customer. Either Approve/Reject before creating New One");
		return;
	}
	if(varappstatus=="true" || varProfilestatus !="Y")
	{
		alert("Kindly click on modify in Customer Profile and update latest details before proceeding and ensure customer profile status is completed");
		return;
	}
	if(varconstitut!="01")
	{
		if(varstake_held=="")
		{
			alert("Please Select the majority of shareholding & controlling stake held by women - Customer Demographics Tab");
			return;
		}
		
		if(varmaj_member=="")
		{
			alert("Please Select the majority of members belongs to SC/ST - Customer Demographics Tab");
			return;
		}
		if(varcommunityminority==""||varcommunityminority=="0"){
			alert("Please fill Whether majority of members/owners belong to minority community in Customer Profile -> Demographics tab");
			return;
		}
	}
	if(varconstitut=="01")
	{
		if(varminority==""||varminority=="0")
		{
			alert("Please fill Minority Details in Customer Profile -> Demographics tab");
			return;
		}
		if(varcaste==""||varcaste=="0")
		{
			alert("Please fill Caste in Customer Profile -> Demographics tab");
			return;
		}
		if(vargender==""||vargender=="0")
		{
			alert("Please fill Gender in Customer Profile -> Demographics tab");
			return;
		}
		
	}	
	
		if(strnoproposal=="N"){
			alert("Atleast one Application should already be created in branch , to create a new proposal");
			return;
		}
	
	if(varSales==""){
		alert("Please fill Sales Turnover in Customer Profile -> Demographics tab");
		return;
	}
	if(varSalesDate==""){
		alert("Please fill Sales Turnover As on Date in Customer Profile -> Demographics tab");
		return;
	}
	if(varSalesCriteria=="0"){
		alert("Please fill Criteria for Sales Turnover in Customer Profile -> Demographics tab");
		return;
	}
	
	
	document.forms[0].hidBeanId.value="inwardRegister";
	document.forms[0].hidBeanGetMethod.value="getmsmeproposalresult";
	document.forms[0].action=appURL + "action/msme_proposalsearch.jsp?";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
	
}

function callMSME(varmsmeappno,varorgscodeflag,varorgscode,varstatus,varorgname)
{
	
	if(varorgscodeflag=="N" && varstatus=="Open/Pending")
	{
		alert("proposal is created by  "+(varorgname)+"  hence user of other organisations cannot make modifications");
	}
	
	document.forms[0].hidBeanId.value = "inwardRegister";
	document.forms[0].hidBeanGetMethod.value = "getmsmeproposalresult";
	document.forms[0].action = appURL + "action/msme_proposalsearch.jsp?appno="+varmsmeappno;
	document.forms[0].submit();
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="">
<form method="post" class="normal">
<table width="98%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td class="page_flow">Home -&gt; MSME</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
		</table>

		<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="4"
					class="outertable">
					<tr>
						<td valign="top"><br>
						
						<table width="90%" border="0" cellspacing="0" cellpadding="3"
							align="center" class="outertable">
							<tr>
								<td valign="top" align="center">
								<table width="60%" border="0" cellspacing="0" cellpadding="0"
									align="center" class="outertable border1">
									<tr>
										<td align="center">
										<table width="100%" border="0" cellspacing="0" cellpadding="3"
											align="center" class="outertable">
											<tr class="datagrid" align="center">
												<td><B>Borrower Name: <%=Helper.correctNull((String) hshValues.get("strborrowername"))%></B>
												</td>
												<td>
											<%if(Integer.parseInt(Helper.correctInt((String)hshValues.get("strMSMEMinpower")))!=0&&(Integer.parseInt(Helper.correctInt((String)session.getAttribute("strUserClass")))>=Integer.parseInt(Helper.correctInt(Helper.correctInt((String)hshValues.get("strMSMEMinpower")))))){ %>
												
												<input type="button" name="cmdnew" value="New Proposal"
													onClick="doNew()" class="buttonStyle" />
													<%}else{ %> 
													<input type="button" name="cmdnew"  value="New Proposal" class="buttonStyle" disabled>
													
													<%} %>
													</td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						<br>
	</tr>
</table>
</td>
</tr>
<table width="100%" border="0" cellspacing="0" cellpadding="5"
	class="outertable border1" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="4"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							align="center" class="outertable">
							<tr valign="top">
								<td  colspan="8">
								<table width="100%" border="0" cellspacing="1" cellpadding="1"
									class="outertable">
									<tr class="dataheader" align="center">

												<td width="5%">Sl No</td>
												<td width="10%">Proposal No</td>
												<td width="10%">Sales Turnover of the Applicant</td>
												<td width="10%">Sales Turnover As on Date</td>
												<td width="10%">Criteria for Sales Turnover</td>
												<td width="10%">Invest in Plant & Machineries / Equipments </td>
												<td width="10%">New Classification Effective date</td>
												<td width="10%">Status of Facility</td>
											</tr>
											<tr>
										<td colspan="8">
											<%
												ArrayList v = (ArrayList) hshValues.get("arrRow1");
												if (v != null) {
													int vecsize = v.size();

													if (vecsize != 0) {

														for (int l = 0; l < vecsize; l++) {

															g1 = (ArrayList) v.get(l);
											%>

											<tr class="datagrid">
												<td width="5%"><%=l + 1%></td>
												<td width="10%"><a href="javascript:callMSME('<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(8))%>','<%=Helper.correctNull((String)g1.get(9))%>','<%=Helper.correctNull((String)g1.get(7))%>','<%=Helper.correctNull((String)g1.get(10))%>')">
												<%=Helper.correctNull((String) g1.get(0))%></a></td>
												<td width="10%" align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) g1.get(2))))%></td>
												<td width="10%" align="center"><%=Helper.correctNull((String) g1.get(3))%></td>
												<td width="10%"><%=Helper.correctNull((String) g1.get(4))%></td>
												<td width="10%" align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) g1.get(5))))%></td>
												<td width="10%" align="center"><%=Helper.correctNull((String) g1.get(6))%></td>
												<td width="10%"><%=Helper.correctNull((String) g1.get(7))%></td>
											</tr>
											<%
												}
													} else {
											%>
											
											<tr>
										    <td align="center" colspan="9" class="datagrid" height="10%">No Data Found</td>
								       	    </tr>
											<%
												}

												}
											%>
											
								</table>
								</td>
							</tr>
							
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<tr>
<td>
<table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td>
		<table width="0%" border="0" cellspacing="0" cellpadding="2">
			<tr valign="middle">
				<td align="center"><input type="button" name="cmdclose"
					value="Close" class="buttonClose" onClick="doClose()"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<input type="hidden" name="hidappno" value="">
<input type="hidden" name="hidBeanId" value=""> 
<input type="hidden" name="hidBeanMethod" value=""> 
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidAction" value=""> 
<input type="hidden" name="hidSourceUrl" value=""> 
<input type="hidden" name="hidappid" value="<%=Helper.correctNull((String)hshValues.get("strappid"))%>">
<input type="hidden" name="hidname" value="<%=Helper.correctNull((String)hshValues.get("strborrowername"))%>">
<input type="hidden" name="hidcbsid" value="<%=Helper.correctNull((String)hshValues.get("strCBSID"))%>">
</form>
</body>
</html>