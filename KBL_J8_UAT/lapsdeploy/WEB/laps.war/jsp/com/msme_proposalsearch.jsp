<%@include file="../share/directives.jsp"%>
<%
	ArrayList g1 = new ArrayList();
	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMinimumFractionDigits(2);
	nf.setMaximumFractionDigits(2);
	nf.setGroupingUsed(false);
	ArrayList arr11 = (ArrayList) hshValues.get("arrRow");
	String srtdataflag = "";
	if (arr11 != null && arr11.size() > 0) {
		srtdataflag = "Y";
	} else {
		srtdataflag = "N";
	}
	String appno = Helper.correctNull((String) hshValues.get("appno"));
String strCBSID = Helper.correctNull((String) hshValues.get("strCBSID"));
session.setAttribute("appno", appno);
session.setAttribute("strCBSID", strCBSID);

%>

<html>
<head>
<title>Commercial-Existing Application form</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var MSME_CRITERIA_SALES="<%=Helper.correctNull((String) hshValues.get("PERAPP_CRITERIA_SALES_TURNOVER"))%>";
var varinitializeflag="<%=Helper.correctNull((String) hshValues.get("MSME_INITIATE_FLAG"))%>";
var varcriteriainvest="<%=Helper.correctNull((String) hshValues.get("MSME_CRITERIA_INVESTMENT"))%>";
var varminority="<%=Helper.correctNull((String) hshValues.get("indinfo_minority"))%>";
var varindreligion="<%=Helper.correctNull((String) hshValues.get("indinfo_religion"))%>";
var varcommunityminority="<%=Helper.correctNull((String) hshValues.get("cominfo_minority_community"))%>";
var nonindreligion="<%=Helper.correctNull((String) hshValues.get("perapp_religion"))%>";
var varmaj_member="<%=Helper.correctNull((String) hshValues.get("majority_member"))%>";
var varstake_held="<%=Helper.correctNull((String) hshValues.get("stake_held"))%>";
var varconstitut="<%=Helper.correctNull((String) hshValues.get("constitutionnew"))%>";
var varcaste="<%=Helper.correctNull((String) hshValues.get("indinfo_caste"))%>";
var vargender="<%=Helper.correctNull((String) hshValues.get("perapp_sex"))%>";								
var vardataflag="<%=srtdataflag%>";
var varStatus="<%=Helper.correctNull((String) hshValues
	.get("strstatus"))%>";
var varmsmestatus="<%=Helper.correctNull((String) hshValues
	.get("strmsmestatus"))%>";
		
var	varPropNo= "<%=Helper.correctNull((String) hshValues
	.get("MSME_APPNO"))%>";

var varMSMEsales="<%=Helper.correctNull((String) hshValues.get("MSME_SALES_TURNOVER"))%>";	
var varMSMEdate="<%=Helper.correctNull((String) hshValues.get("MSME_SALES_DATE"))%>";	
var VarMSMECriteria="<%=Helper.correctNull((String) hshValues.get("MSME_CRITERIA_SALES"))%>";	
var varPersales="<%=Helper.correctNull((String) hshValues.get("PERAPP_SALES_TURNOVER"))%>";	
var varPerdate="<%=Helper.correctNull((String) hshValues.get("PERAPP_SALES_TURNOVER_DATE"))%>";	
var varPerCriteria="<%=Helper.correctNull((String) hshValues.get("PERAPP_CRITERIA_SALES_TURNOVER"))%>";	

function disableFields(val) {
	for ( var i = 0; i < document.forms[0].length; i++) {
		if (document.forms[0].elements[i].type == 'text') {
			document.forms[0].elements[i].readOnly = val;
		}
		if (document.forms[0].elements[i].type == 'select-one') {
			document.forms[0].elements[i].disabled = val;
		}
	}
}

function disableCommandButtons(cmdEdit, cmdSave, cmdCancel, cmddelete,cmdinitiate,cmdClose) {
	document.forms[0].cmdedit.disabled = cmdEdit;
	document.forms[0].cmdsave.disabled = cmdSave;
	document.forms[0].cmdcancel.disabled = cmdCancel;
	document.forms[0].cmddelete.disabled = cmddelete;
	document.forms[0].cmdsendforverification.disabled = cmdinitiate;
	document.forms[0].cmdclose.disabled = cmdClose;
	
}

function doEdit() {
	disableFields(false);
	if(varPropNo!=""){
	disableCommandButtons(true, false, false, false, false,false);
	}else{
	disableCommandButtons(true, false, false, false, true,false);
	}
	document.forms[0].hidAction.value = "update";

	document.forms[0].sel_majoritymem.disabled=true;
	document.forms[0].sel_heldwomen.disabled=true;
	document.forms[0].sel_applt_sex.disabled=true;
	document.forms[0].sel_caste.disabled=true;
	
	document.forms[0].sel_religion.disabled=true;
	document.forms[0].sel_minority.disabled=true;
	document.forms[0].sel_firm_minority.disabled=true;
	document.forms[0].sel_corp_religion.disabled=true
	 document.forms[0].txt_sales_turnoverdate.disabled=true;
	 document.forms[0].txt_sales_turnover.disabled=true;
	 document.forms[0].sel_sales_turnover.disabled=true;
}

function doCancel() {
	var varconfirm = ConfirmMsg('102');
	if (varconfirm) {
		document.forms[0].hidBeanGetMethod.value = "getmsmeproposalresult";
		document.forms[0].hidBeanId.value = "inwardRegister";
		document.forms[0].action = appURL + "action/msme_proposalsearch.jsp";
		document.forms[0].submit();
	}
}

function doSave() {
	
	if(document.forms[0].txt_sales_turnover.value=="0.00"||document.forms[0].txt_sales_turnover.value=="")
	{
		  ShowAlert(121,'Sales Turnover of the Applicant');
		    
		  document.forms[0].txt_sales_turnover.focus();
		  return;
	}
	if (eval(document.forms[0].txt_sales_turnover.value)<1) {
		alert("Sales Turnover of the applicant value should not be less than 1");
		document.forms[0].txt_sales_turnover.focus();
		return;

	}
	if(document.forms[0].txt_sales_turnoverdate.value=="")
	{
		  ShowAlert(121,'Sales Turnover As on Date');
		  document.forms[0].txt_sales_turnoverdate.focus();
		  return;
	}
	if(document.forms[0].sel_sales_turnover.value==""||document.forms[0].sel_sales_turnover.value=="0")
	{
		  ShowAlert(111,'Criteria for Sales Turnover');
		  document.forms[0].sel_sales_turnover.focus();
		  return;
	}
	if(document.forms[0].txt_equipval.value=="0.00"||document.forms[0].txt_equipval.value=="")
	{
		  ShowAlert(121,'Investment in Plant & Machineries/Equipments');
		    
		  document.forms[0].txt_equipval.focus();
		  return;
	}
	if (eval(document.forms[0].txt_equipval.value)<1) {
		alert("Investment in Plant & Machineries/Equipments value should not be less than 1");
		document.forms[0].txt_equipval.focus();
		return;

	}
	if(document.forms[0].txt_effdate.value=="")
	{
		  ShowAlert(121,' New Classification Effective date');
		  document.forms[0].txt_effdate.focus();
		  return;
	}
	if(document.forms[0].txt_investDate.value=="")
	{
		  ShowAlert(121,' Investment value as on Date');
		  document.forms[0].txt_investDate.focus();
		  return;
	}
	if(document.forms[0].sel_criteria_invest.value==""||document.forms[0].sel_criteria_invest.value=="0")
	{
		  ShowAlert(111,'Criteria for Investment value');
		  document.forms[0].sel_criteria_invest.focus();
		  return;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value = "insert";
	document.forms[0].hidBeanGetMethod.value = "updatemsmeproposal";
	document.forms[0].hidBeanId.value = "inwardRegister";
	document.forms[0].action = appURL + "action/msme_proposalsearch.jsp";
	document.forms[0].submit();
}

function doDelete() {
	var varconfirm = ConfirmMsg('101');
	if (varconfirm) {
		document.forms[0].hidAction.value = "delete";
		document.forms[0].hidBeanMethod.value = "updatemsmeproposal";
		document.forms[0].hidBeanGetMethod.value = "getmsmeproposalresult";
		document.forms[0].hidBeanId.value = "inwardRegister";
		document.forms[0].hidSourceUrl.value = "/action/msme_proposalsearch.jsp";
		document.forms[0].action = appURL + "controllerservlet";
		document.forms[0].method = "post";
		document.forms[0].submit();
	}
}
function doClose() {
	if (ConfirmMsg(100)) {
		document.forms[0].action = appURL + "action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function callCalender(name) {

	if (document.forms[0].cmdsave.disabled == false) {
		showCal(appURL, name);

	}
}
function callonLoad(){
	 disableFields(true);
	 
	 if(varMSMEsales!="" && varPersales!=""){
		 if(varMSMEsales != varPersales ){
			 alert("Sales Turnover does not match with  Sales Turnover in Customer profile page.");
			 disableCommandButtons(true, false, true, true, true,false);
		 }
	 }
	 if(varMSMEdate!="" && varPerdate!=""){
		 if(varMSMEdate != varPerdate ){
			 alert("Sales Turnover Date does not match with  Sales Turnover Date in Customer profile page.");
			 disableCommandButtons(true, false, true, true, true,false);
		 }
	 }
	 if(VarMSMECriteria!="" && varPerCriteria!=""){
		 if(VarMSMECriteria != varPerCriteria ){
			 alert("Sales Turnover criteria does not match with  Sales Turnover criteria in Customer profile page.");
			 disableCommandButtons(true, false, true, true, true,false);
		 }
	 }
		
	 if(document.forms[0].hidpropchk.value=="N")
	 {  
			disableCommandButtons(true, true, true, true, true,false);
	 }else {
		
			disableCommandButtons(false, true, true, true, true,false);
		
	 }
	 if(MSME_CRITERIA_SALES!=""){
		 document.forms[0].sel_sales_turnover.value=MSME_CRITERIA_SALES;
	 }
	 
	 if(document.forms[0].hidappno.value!="")
	 {
		 if(document.forms[0].hidpropchk.value=="N")
		 { 
		 document.forms[0].cmdsendforverification.disabled=true;
		 document.forms[0].cmddocumentupload.disabled=true;
		 }else{
			 document.forms[0].cmdsendforverification.disabled=false;
		 }
	 }
	 
	 if(varinitializeflag=="Y")
	 {
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmdsendforverification.disabled=true;
		 document.all.idBranch.style.display="none";
	 }
	 if(varStatus=="Revert Back")
	 {
		 document.forms[0].cmdedit.disabled=false;
		 document.forms[0].cmdsendforverification.disabled=false;
		 document.forms[0].cmddocumentupload.disabled=false;
		 document.all.idBranch.style.display="none";
	 }
	 if(varcriteriainvest!=""){
		 document.forms[0].sel_criteria_invest.value=varcriteriainvest;
	 }
	 
	// document.forms[0].cmdreport.disabled=true;
	/* if(document.forms[0].hidappstatus.value=="pa")
	 {
		document.forms[0].cmdreport.disabled=false; 
	 }*/
	 if(vardataflag=="N"){
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddocumentupload.disabled=true;
		 document.forms[0].cmdclose.disabled=false;
		 
	 }
	 document.all.idBranch.style.display="none";
	 if(varconstitut!="01")
	 {
		 
		 document.all.maj3.style.display = "none";
			//document.all.maj4.style.display = "none";
			document.all.id_ind.style.display = "none";
			if(varstake_held!="")
			{
				document.forms[0].sel_heldwomen.value=varstake_held;
			}else{
				document.forms[0].sel_heldwomen.value="S";
			}
			
			if(varmaj_member!="")
			{
				document.forms[0].sel_majoritymem.value=varmaj_member;
			}else{
				document.forms[0].sel_majoritymem.value="0";
			}
			if(varcommunityminority!="")
			{
				document.forms[0].sel_firm_minority.value=varcommunityminority;
			}else{
				document.forms[0].sel_firm_minority.value="0";
			}
			
			if(nonindreligion!="")
			{
				document.forms[0].sel_corp_religion.value=nonindreligion;
			}else{
				document.forms[0].sel_corp_religion.value="0";
			}
			
			document.forms[0].sel_majoritymem.disabled=true;
			document.forms[0].sel_heldwomen.disabled=true;
			document.forms[0].sel_firm_minority.disabled=true;
			document.forms[0].sel_corp_religion.disabled=true; 
	 }
	 else if(varconstitut=="01")
	 {
		 if(varcaste!="")
			{
				document.forms[0].sel_caste.value=varcaste;
			}else{
				document.forms[0].sel_caste.value="0";
			}
			
			if(vargender!="")
			{
				document.forms[0].sel_applt_sex.value=vargender;
			}else{
				document.forms[0].sel_applt_sex.value="0";
			}
			if(varminority!="")
			{
				document.forms[0].sel_minority.value=varminority;
			}else{
				document.forms[0].sel_minority.value="";
			}
			
			if(varindreligion!="")
			{
				document.forms[0].sel_religion.value=varindreligion;
			}else{
				document.forms[0].sel_religion.value="0";
			}
			
			document.forms[0].sel_applt_sex.disabled=true;
			document.forms[0].sel_caste.disabled=true;
			document.forms[0].sel_religion.disabled=true;
			document.forms[0].sel_minority.disabled=true;
	        document.all.maj1.style.display = "none";
		    document.all.id_nonind.style.display = "none";
	 }
	 
	 if(varStatus=="Deleted"){
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmdsendforverification.disabled=true;
		 document.forms[0].cmddocumentupload.disabled=false;
		 document.forms[0].cmdclose.disabled=false;
	 }
	 if(varmsmestatus=="pa" || varmsmestatus=="pr"){
		 document.forms[0].cmddocumentupload.disabled=false;
	 }
	 
}
function doSendForVerification() {
	 document.all.idBranch.style.display="table-row";
	
	if(document.forms[0].hid_Branch.value=="")
	{
		alert("Select Organisation");
		return;
	}
	if(document.forms[0].hiddocchk.value=="N"){
	alert("Please Upload at least one  Document");
	return;
    }
	document.forms[0].hidAction.value = "Initiate";
	document.forms[0].hidBeanId.value = "inwardRegister";
	document.forms[0].hidBeanMethod.value = "updatemsmeproposal";
	document.forms[0].hidBeanGetMethod.value = "getmsmeproposalresult";
	document.forms[0].hidSourceUrl.value = "/action/msme_proposalsearch.jsp";
	document.forms[0].action = appURL + "controllerservlet";			
	alert("Proposal sent successfully");
	document.forms[0].submit();
}
function doReport()
{
	var prop = "scrollbars=yes,width=1100,height=700,top=25,left=180";
	var url=appURL+"action/msmerunrepot.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getMsmeReport&appno="+document.forms[0].hidappno.value;
	window.open(url,"MSME",prop);	
}
function showOrganizationSearch(path, forgscode, forgname)
{
	if(document.forms[0].cmdsendforverification.disabled==false)
	{
		var appno1=document.forms[0].hidappno.value;
		{
			var prop = "scrollbars=no,width=300,height=300,top=100,left=250";
			var url=appURL+"action/orgnamelist.jsp?pagename=MSME&appno="+appno1;
			window.open(url,"",prop);
		}
	}
}
function doDocumentUpload()
{
	var varmsmeappno=document.forms[0].hidmsmeappno.value;
	var varstatus=document.forms[0].hidappstatus.value;
	var varQryString = <%=ApplicationParams.getAppUrl()%>+"action/perm_docAttachment.jsp?hidBeanId=perDeviation&hidBeanGetMethod=getpermDocumentDetails&hidpagefrom=MSME&appno="+document.forms[0].hidappno.value+"&strmsmeappno="+varmsmeappno+"&appstatus="+varstatus+"&varPageName=MsmeDoc";
	var title = "Organization";
	var prop = "scrollbars=yes,width=1200,height=900,menubar=yes";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString,title,prop);
}

function doDocument()
{
	var varQryString = <%=ApplicationParams.getAppUrl()%>+"action/perm_docAttachment.jsp?hidBeanId=perDeviation&hidBeanGetMethod=getpermDocumentDetails&hidpagefrom=MSME&appno="+document.forms[0].hidappno.value;
	var title = "Organization";
	var prop = "scrollbars=yes,width=1200,height=900,menubar=yes";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString,title,prop);
}
</script>
</head>
<body onload="callonLoad();">
<form name="exist" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>

				<td valign="top" class="page_flow">Home -&gt; MSME</td>

			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5"
	class="outertable " align="center">
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
							<tr class="dataheader">
								<td>MSME Proposal No : <%=Helper.correctNull((String) hshValues.get("MSME_APPNO"))%>&nbsp;</td>
								<td>Customer ID : <%=Helper.correctNull((String) hshValues.get("strCBSID"))%></td>
								<td>Customer Name : <%=Helper.correctNull((String) hshValues
							.get("strborrowername"))%></td>
								<td>Branch Name : <%=Helper.correctNull((String) hshValues
									.get("msmeorgsocde"))
							+ "-"
							+ Helper.correctNull((String) hshValues
									.get("msmeorgname"))%></td>
																	<td>Status: <%=Helper.correctNull((String) hshValues
							.get("strstatus"))%></td>
							</tr>
							<tr valign="top">
								<td colspan="8">
								<table width="100%" border="0" cellspacing="1" cellpadding="1"
									class="outertable">
									<tr class="dataheader">
										<td rowspan="2">Sl.No</td>
										<td  rowspan="2">Proposal No</td>
										<td  rowspan="2">Facility Sl.No</td>
										<td  rowspan="2">Facility Name</td>
										<td  rowspan="2">Amount</td>
										<td  rowspan="2">Activity Code</td>
										<td  colspan="4" align="center">MISClassification</td>
										<td  rowspan="2"> Plant & Machineries Value</td>
										<td  rowspan="2">Equipments Value</td>
										<td rowspan="2">Sanction Date</td>
										<td rowspan="2">Status of Facility</td>

									</tr>
									<tr class="dataheader">

										<td>Agriculture/Industry/Service Category type</td>
										<td>Sector</td>
										<td>Govt. Announced scheme</td>
										<td>Stand Up India</td>
									</tr>
									<tr>
										<td colspan="8">
										<%
											ArrayList v = (ArrayList) hshValues.get("arrRow");
											if (v != null) {
												int vecsize = v.size();

												if (vecsize != 0) {

													for (int l = 0; l < vecsize; l++) {

														g1 = (ArrayList) v.get(l);
										%>
										
									<tr class="datagrid">
										<td><%=l+1%></td>
										<td><%=Helper.correctNull((String) g1.get(0))%></td>
										<td><%=Helper.correctNull((String) g1.get(1))%></td>
										<td><%=Helper.correctNull((String) g1.get(2))%></td>
										<td align="right"><%=nf.format(Double.parseDouble(Helper
										.correctDouble((String) g1.get(3))))%></td>
										<td><%=Helper.correctNull((String) g1.get(4))%></td>
										<td><%=Helper.correctNull((String) g1.get(5))%></td>
										<td><%=Helper.correctNull((String) g1.get(12))%></td>
										<td ><%=Helper.correctNull((String) g1.get(14))%></td>
										<td><%=Helper.correctNull((String) g1.get(13))%></td>
										<td  align="right"><%=nf.format(Double.parseDouble(Helper
										.correctDouble((String) g1.get(7))))%></td>
										<td align="right"><%=nf.format(Double.parseDouble(Helper
										.correctDouble((String) g1.get(6))))%></td>
										<td><%=Helper.correctNull((String) g1.get(15))%></td>
										<td><%=Helper.correctNull((String) g1.get(8))%></td>

									</tr>
									<%
										}
											} else {
									%>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td align="center" colspan="10">No Data Found</td>
									</tr>
									<%
										}

										}
									%>
									<tr>
									<%
											ArrayList v1 = (ArrayList) hshValues.get("arrRow");
											if (v1 != null) {
												int vecsize = v1.size();
												if (vecsize != 0) {

										%>
										<br>
										<td nowrap="nowrap" align="center" colspan="10"><span class="mantatory">Details
										Fetched as on date -&nbsp;&nbsp;<%=Helper.getCurrentDateTime()%></td>
										<%}} %>
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
		</td>
	</tr>
</table>

<tr>
	<td>
	<table width="100%" border="0" cellspacing="0" cellpadding="3"
		class="outertable border1" align="center">
		<tr>
			<td>
			<table width="100%" border="0" cellspacing="1" cellpadding="3"
				class="outertable" align="center">
				<tr id="maj1">
					<td>Whether majority of shareholding & controlling stake held
					by women</td>
					<td><select name="sel_heldwomen"
						style="background: #FFFFCC; font-weight: bold; text-align: right;">
						<option value="S" selected="selected">--Select--</option>
						<option value="Y">Yes</option>
						<option value="N">No</option>
					</select></td>
					<td>Whether majority of members belongs to SC/ST</td>
					<td><select name="sel_majoritymem"
						style="background: #FFFFCC; font-weight: bold; text-align: right;">
						<option value="0" selected="selected">--Select--</option>
						<option value="Y">Yes</option>
						<option value="N">No</option>
					</select></td>
				</tr>
				<tr id="maj3">
					<td>Gender</td>
					<td><select name="sel_applt_sex"
						style="background: #FFFFCC; font-weight: bold; text-align: right;">
						<option value="0">--Select--</option>
						<option value="M">Male</option>
						<option value="F">Female</option>
						<option value="O">Others</option>
					</select></td>
					<td>Caste/Tribe&nbsp;</td>
					<td><select name="sel_caste"
						style="background: #FFFFCC; font-weight: bold; text-align: right;">
						<option value="0">&lt;--Select--&gt;</option>
						<%
							String apptype = "7";
						%>
						<lapschoice:CBSStaticDataNewTag apptype='<%=apptype%>' />
					</select></td>
				<tr id="id_nonind">
					<td>Whether majority of members/owners belong to minority
					community</td>
					<td><select name="sel_firm_minority"
						style="background: #FFFFCC; font-weight: bold; text-align: right;">
						<option value="0" selected="selected">--Select--</option>
						<option value="Y">Yes</option>
						<option value="N">No</option>
					</select></td>
					<td>Religion</td>
					<td><select name="sel_corp_religion"
						style="background: #FFFFCC; font-weight: bold; text-align: right;">
						<option value="0">&lt;--Select--&gt;</option>
						<%
							apptype = "11";
						%>
						<lapschoice:CBSStaticDataNewTag apptype='<%=apptype%>' />
					</select></td>
				</tr>
				<tr id="id_ind">
					<td>Minority</td>
					<td><select name="sel_minority"
						style="background: #FFFFCC; font-weight: bold; text-align: right;">
						<option value="Y">Yes</option>
						<option value="N" selected>No</option>
					</select></td>

					<td width="18%">Religion</td>
					<td width="22%"><select name="sel_religion"
						style="background: #FFFFCC; font-weight: bold; text-align: right;">
						<option value="0">&lt;--Select--&gt;</option>
						<%
							apptype = "11";
						%>
						<lapschoice:CBSStaticDataNewTag apptype='<%=apptype%>' />
					</select></td>

				</tr>
				<tr>
					<td>Sales Turnover of the Applicant (Rs.)<b><span
						class="mantatory">&nbsp;*</span></b></td>
					<td><input type="text" name="txt_sales_turnover" size="12"
						value="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("PERAPP_SALES_TURNOVER"))))%>"
						onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"
						style="background: #FFFFDD; font-weight: bold; text-align: right;"></td>
					<td>Sales Turnover As on Date<b><span class="mantatory">&nbsp;*</span></b></td>
					<td><input type="text" name="txt_sales_turnoverdate" size="12"
						maxlength="10" style="background: #FFFFDD; font-weight: bold; text-align: right;"
						value="<%=Helper.correctNull((String) hshValues
							.get("PERAPP_SALES_TURNOVER_DATE"))%>"
						>
					</td>
				</tr>
				<tr>
					<td>Criteria for Sales Turnover<b><span class="mantatory">&nbsp;*</span></b></td>
					<td><select name="sel_sales_turnover" style="background: #FFFFDD; font-weight: bold; width: 200px">
						<option value="0">&lt;--Select--&gt;</option>
						<%
							String apptype1 = "243";
						%>
						<lapschoice:StaticDataNewTag apptype='<%=apptype1%>' />
					</select></td>
				</tr>
				<tr>
					<td>Investment in Plant & Machineries/Equipments (Rs.)<b><span
						class="mantatory">&nbsp;*</span></b></td>
					<td><input type="text" name="txt_equipval"
						onKeyPress="allowNumber(this)" style="text-align: right;"
						onBlur="roundtxt(this);"
						value="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("MSME_EQUIP_VAL"))))%>"></td>

					<td>New Classification Effective date<b><span
						class="mantatory">&nbsp;*</span></b></td>
					<td colspan="3"><input type="text" name="txt_effdate"
						size="12" maxlength="10"
						value="<%=Helper.correctNull((String) hshValues
							.get("MSME_CLASSI_DATE"))%>"
						onBlur="checkDate(this);">
					<a onClick="callCalender('txt_effdate')"
						title="Click to view calender" border=0><img
						src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
						border="0"></a></td>
				</tr>
				<tr>
					<td>Investment value as on Date <b><span class="mantatory">&nbsp;*</span></b></td>
					<td><input type="text" name="txt_investDate"
							onBlur="checkDate(this);checkmaxdate(this,currentDate);" size="15%"
						value="<%=Helper.correctNull((String) hshValues
							.get("MSME_INVESTMENT_DATE"))%>">
					<a alt="Select date from calender"
						href="javascript:callCalender('txt_investDate')" tabindex="10">
					<img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
						 border="0"> </a></td>
					<td>Criteria for Investment value<span class="mantatory">&nbsp;*</span></b></td>
					<td><select name="sel_criteria_invest" style="width: 200px">
						<option value="0">&lt;--Select--&gt;</option>
						<%
							String strapptype = "248";
						%>
						<lapschoice:StaticDataNewTag apptype='<%=strapptype%>' />
					</select></td>
				</tr>
				<tr id="idBranch">
					<td>Organisation</td>
					<td><input type="hidden" name="hid_Branch" value=""> <input
						type="text" name="txt_Branch" size="38" value=""> <b><a
						href="#"
						onClick="showOrganizationSearch('<%=ApplicationParams.getAppUrl()%>','hid_Branch','txt_Branch')"
						style="cursor: hand"> <img
						src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
						border="0"></a></b></td>
				</tr>

				<%if (!Helper.correctNull((String) hshValues.get("MSME_REVERT_REMARKS"))
							.equalsIgnoreCase("")) {
				%>
				<tr>
					<td>Remarks</td>
					<td><textarea name="txt_remarks" cols="90" rows="5"
						tabindex="21" disabled="disabled"><%=Helper.correctNull((String) hshValues
								.get("MSME_REVERT_REMARKS"))%></textarea></td>
				</tr>
				<%
					}
				%>

			</table>
			</td>
		<tr>
			<br>
		<!-- <tr>
			<td>
			
			</td>
		</tr> -->
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
				align="center">
				<lapschoice:combuttonnew
					btnnames='Edit_Save_Cancel_delete_Send for Verification_Document Upload'
					btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
			</table>
		<input type="hidden" name="hidPageType"
			value="<%=request.getParameter("hidPageType")%>">
		<input type="hidden" name="hidapplicantid">
		<input type="hidden" name="hidRatingProposalFlag">
		<input type="hidden" name="hidRatingProposalPendingFlag">
		<input type="hidden" name="hidRatingProposalUser">
		<input type="hidden" name="hidApprovedApplDemoID">
		<input type="hidden" name="hidOccuCode">
		<input type="hidden" name="hidappid"
			value="<%=Helper.correctNull((String) hshValues.get("strappid"))%>">
		<input type="hidden" name="hidname"
			value="<%=Helper.correctNull((String) hshValues
							.get("strborrowername"))%>">
		<input type="hidden" name="hidcbsid"
			value="<%=Helper.correctNull((String) hshValues.get("strCBSID"))%>">
		<input type="hidden" name="hidappno"
			value="<%=Helper.correctNull((String) hshValues.get("MSME_APPNO"))%>">
		<input type="hidden" name="hidinitiateFlag">
		<input type="hidden" name="hidappstatus"
			value="<%=Helper.correctNull((String) hshValues
							.get("MSME_APPSTATUS"))%>">
							<input type="hidden" name="hidappstatus1"
			value="<%=Helper.correctNull((String) hshValues
							.get("strmsmestatus"))%>">
		<input type="hidden" name="hiddocchk"
			value="<%=Helper.correctNull((String) hshValues
							.get("strmsmedoccheck"))%>">
		<input type="hidden" name="hidpropchk"
			value="<%=Helper.correctNull((String) hshValues
							.get("strpropmodificationchk"))%>">
							<input type="hidden" name="hidmsmeappno"
			value="<%=Helper.correctNull((String) hshValues
							.get("appno"))%>">
<input type="hidden" name="hid_sales_turnover"
			value="<%=Helper.correctNull((String) hshValues
							.get("PERAPP_SALES_TURNOVER"))%>">
							<input type="hidden" name="hid_sales_turnoverdate"
			value="<%=Helper.correctNull((String) hshValues
							.get("PERAPP_SALES_TURNOVER_DATE"))%>">
							<input type="hidden" name="hidsel_sales_turnover"
			value="<%=Helper.correctNull((String) hshValues
							.get("PERAPP_CRITERIA_SALES_TURNOVER"))%>">
		<lapschoice:hiddentag pageid='<%=PageId%>' />
		</form>
</body>
</html>
