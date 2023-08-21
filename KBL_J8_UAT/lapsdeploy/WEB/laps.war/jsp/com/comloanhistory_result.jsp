<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	String strAppno = "", strFacCategory = "";
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
	jtn.setMaximumFractionDigits(2);
	jtn.setMinimumFractionDigits(2);
	jtn.setGroupingUsed(false);

	String applicantid = "";
	String appstatus = "";
	String appname = "";
	String inwardno = "";
	String applevel = "";
	String valuesin = "";
	String strcatory = "";
	String strApporgname = "";
	String strAppholder = "";
	String btnenable = "";
	String strAppstatus = "";
	String loanType = "";
	String strModule = "";
	String strSessionModuleType = Helper.correctNull(
			(String) session.getAttribute("sessionModuleType")).trim();
	String strFacilityAgr = Helper.correctNull((String) hshValues
			.get("strFacilityAgr"));
	session.setAttribute("strFacilityAgr", strFacilityAgr);
	String ProposalType = Helper.correctNull((String) hshValues
			.get("app_proptype"));
	String sanctionrefno = "";
	String strBorrowerType = Helper.correctNull((String) hshValues
			.get("hidBorrowerType"));
	if (hshValues.get("hshAppData") != null) {
		HashMap hshRecord = (HashMap) hshValues.get("hshAppData");
		strAppno = Helper.correctNull((String) hshRecord.get("appno"));
		applicantid = Helper.correctNull((String) hshRecord
				.get("applicantid"));
		appstatus = Helper.correctNull((String) hshRecord
				.get("app_status"));
		appname = Helper
				.correctNull((String) hshRecord.get("app_name"));
		inwardno = Helper.correctNull((String) hshRecord
				.get("inwardno"));
		applevel = Helper.correctNull((String) hshRecord
				.get("applevel"));
		valuesin = Helper.correctNull((String) hshRecord
				.get("valuesin"));
		ProposalType = Helper.correctNull((String) hshRecord
				.get("app_proptype"));
		strAppholder = Helper.correctNull((String) hshRecord
				.get("applnholder"));
		strApporgname = Helper.correctNull((String) hshRecord
				.get("apporgname"));
		loanType = Helper.correctNull((String) hshRecord
				.get("apploantype"));
		strAppstatus = Helper.correctNull((String) hshRecord
				.get("app_status"));
		sanctionrefno = Helper.correctNull((String) hshRecord
				.get("sanctionrefno"));

		btnenable = ("" + Helper.correctNull(
				(String) session.getAttribute("strGroupRights"))
				.charAt(18)).equals("r") ? "N" : (appstatus
				.equalsIgnoreCase("OP") && strAppholder
				.equals(Helper.correctNull((String) session
						.getAttribute("strUserId")))) ? "Y" : "N";
	}
	if (strAppno.equalsIgnoreCase("")) {
		strAppno = Helper.correctNull((String) request
				.getParameter("appno"));
	}
	if (appstatus.equalsIgnoreCase("")) {
		appstatus = Helper.correctNull((String) request
				.getParameter("appstatus"));
	}
	if (strAppstatus.equalsIgnoreCase("op")
			|| strAppno.equalsIgnoreCase("new")) {
		appstatus = "Open/Pending";
	} else if (strAppstatus.equalsIgnoreCase("pa")) {
		appstatus = "Processed/Approved";
	} else if (strAppstatus.equalsIgnoreCase("pr")) {
		appstatus = "Processed/Rejected";
	} else if (strAppstatus.equalsIgnoreCase("ca")) {
		appstatus = "Closed/Approved";
	} else if (strAppstatus.equalsIgnoreCase("cr")) {
		appstatus = "Closed/Rejected";
	}
	if (appname.equalsIgnoreCase("")) {
		appname = Helper.correctNull((String) request
				.getParameter("compname"));
	}
	strcatory = Helper.correctNull((String) request
			.getParameter("hidcatory"));

	ArrayList vecData = new ArrayList();
	ArrayList vecRow = new ArrayList();
	ArrayList vecHead = new ArrayList();
	ArrayList vecFac = new ArrayList();
	ArrayList vecGroup = new ArrayList();
	String strHeaddesc = "";
	String strHeadId = "";
	String strFacId = "";
	String strFacdesc = "";
	String strExist = "";
	String strProposed = "";
	String strDiff = "";
	String strMargin = "", strAction = "", strFacType = "facility";
	String strInterest = "";
	String strInt = "";
	String strbplr = "";
	String strDP = "";
	String strSecurity = "";
	String strCbsaccountno = "";
	String strintremarks = "", strTUF = "";
	String strOutstanding = "";
	String strIntadjust = "";
	String strOsAsOn = "";
	String strexistbanktype = "";
	String strpropbanktype = "";
	int vecsize = 0;

	String strLC = Helper.correctNull((String) hshValues.get("lc"));
	String strTotExist = Helper.correctNull((String) hshValues
			.get("totexist"));
	String strTotDiff = Helper.correctNull((String) hshValues
			.get("totdiff"));
	strAppno = Helper.correctNull((String) hshValues.get("appno"));
	String strselsno = Helper.correctNull((String) hshValues
			.get("selsno"));
	String strsubselsno = Helper.correctNull((String) hshValues
			.get("selsubsno"));
	strAction = Helper.correctNull((String) hshValues.get("hidAction"));
	strFacType = Helper.correctNull((String) hshValues.get("factype"));
	strFacCategory = Helper.correctNull((String) hshValues
			.get("faccategory"));
	strInterest = Helper.correctNull((String) hshValues
			.get("facility_interest"));

	if (strFacCategory.trim().equals("")) {
		strFacCategory = "R";
	}
	if (strFacType.trim().equals("")) {
		strFacType = "facility";
	}
	if (hshValues != null) {
		vecData = (ArrayList) hshValues.get("vecData");
	}

	if (strBorrowerId.trim().equals("")) {
		strBorrowerId = Helper.correctNull((String) request
				.getParameter("comapp_id"));
	}
	String appval = Helper.correctNull((String) request
			.getParameter("val"));
	String appflag = Helper.correctNull((String) request
			.getParameter("valf"));
	String appMangflag = Helper.correctNull((String) request
			.getParameter("valm"));
	String appGroupflag = Helper.correctNull((String) request
			.getParameter("valg"));
	ArrayList arrSubGrpList = new ArrayList();

	if (!strCategoryType.equalsIgnoreCase("")) {
		session.removeAttribute("cattype");
		session.setAttribute("cattype", strCategoryType);
	}
	String strCheckFlag = Helper.correctNull((String) hshValues
			.get("strFlag"));
	String strFreeze = Helper.correctNull((String) hshValues
			.get("cre_freeze"));
	String strCBSid = Helper.correctNull((String) hshValues
			.get("inward_cbsid"));
	String strFlag = Helper.correctNull((String) hshValues
			.get("strRestuctureFlag"));
%>

<html>
<script>
var varstrSessionModuleType="<%=strSessionModuleType%>";
var varappid="<%=applicantid%>";
var checkbox_len="";
var checkbox_length="";
var varFlag=true;
function callFacsnoChk(obj)
{
	var Applicationno="";
	var facgroup="";
	checkbox_len=document.forms[0].chkFac;
	checkbox_length=checkbox_len.length;
	<%if (vecData != null && vecData.size() > 0) {
				if (vecData.size() > 1) {
					for (int l = 0; l < vecData.size(); l++) {%>
				if(document.forms[0].chkFac["<%=l%>"].checked==true)
				{
					<%vecRow = (ArrayList) vecData.get(l);
						if (vecRow != null) {
							if (Helper.correctNull(
									(String) vecRow.get(17))
									.equalsIgnoreCase("Y")) {%>
									alert("CBS account number/Limit Node mapping not done for the Sub limit/Adhoc/Additional limit of this proposal. Kindly modify the limit in Finacle as per the sanction or if released send mail for mapping of limit node or if not required send mail for closure of facility");
									obj.checked=false;
									return;
					
					<%} else {%>
					var boolFlag="false";
						facgroup="<%=Helper.correctNull((String) vecRow
												.get(10))%>"+"@"+"<%=Helper.correctNull((String) vecRow
												.get(11))%>";
						<%if (Helper.correctNull(
										(String) vecRow.get(12))
										.equalsIgnoreCase("0")) {%>
						for(var i=0;i<checkbox_length;i++)
						{
							var hidgroup=document.forms[0].txtgroup[i].value;
							if(hidgroup==facgroup)
							{
								document.forms[0].chkFac[i].checked=true;
							}
							var facgroup1="<%=Helper.correctNull((String)vecRow.get(20))%>"+"@"+"<%=Helper.correctNull((String)vecRow.get(19))%>";
							var adhocgroup=document.forms[0].hidAdhocSno[i].value;
							
							if(adhocgroup==facgroup1 && document.forms[0].chkFac[i].checked==true)
							{
								for(var j=0;j<checkbox_length;j++)
								{
									if(adhocgroup==document.forms[0].hidfacilitysno[j].value && document.forms[0].chkFac[j].checked==true)
									{
										boolFlag="true";
									}
								}

								if(boolFlag=="false")
								{
									alert("Select Regular Limit First");
									document.forms[0].chkFac[i].checked=false;
								}
							}
						}
						<%}%>
					<%if (vecRow != null) {%>
					Applicationno="<%=Helper
															.correctNull((String) vecRow
																	.get(11))%>";
					<%}
							}
						}%>
				}else if(document.forms[0].chkFac["<%=l%>"].checked==false){
					<%vecRow = (ArrayList) vecData.get(l);
						if (vecRow != null) {%>
					facgroup="<%=Helper.correctNull((String) vecRow
											.get(10))%>"+"@"+"<%=Helper.correctNull((String) vecRow
											.get(11))%>";
					<%if (Helper.correctNull(
									(String) vecRow.get(12))
									.equalsIgnoreCase("0")) {%>
					for(var i=0;i<checkbox_length;i++)
					{
						var hidgroup=document.forms[0].txtgroup[i].value;
						if(hidgroup==facgroup)
						{
						document.forms[0].chkFac[i].checked=false;
						}
					}
					<%}%>
					<%}%>
				}
			<%}
				} else if (vecData.size() == 1) {%>
			if(document.forms[0].chkFac.checked==true)
			{
				<%vecRow = (ArrayList) vecData.get(0);
					if (vecRow != null) {
					if (Helper.correctNull(
									(String) vecRow.get(17))
									.equalsIgnoreCase("Y")) {%>
									alert("CBS account number/Limit Node mapping not done for the Sub limit/Adhoc/Additional limit of this proposal. Kindly modify the limit in Finacle as per the sanction or if released send mail for mapping of limit node or if not required send mail for closure of facility");
									document.forms[0].chkFac.checked=false;
									return;
					
					<%}else{ %>
				Applicationno="<%=Helper.correctNull((String) vecRow.get(11))%>";
				<%}}%>
			}
		<%}
			}%>
	document.forms[0].hidApplicationno.value=Applicationno;
	parent.document.forms[0].hidApplicationno.value=Applicationno;
}

function callCheckedFacility()
{
	var facsno="";
	var varcashmarginchk="";
	<%if (vecData != null && vecData.size() > 0) {
				if (vecData.size() > 1) {
					for (int l = 0; l < vecData.size(); l++) {%>
				if(document.forms[0].chkFac["<%=l%>"].checked==true)
				{
					<%vecRow = (ArrayList) vecData.get(l);
						if (vecRow != null) {%>
					if(varcashmarginchk=="")
					{
						varcashmarginchk="<%=Helper.correctNull((String) vecRow
											.get(16))%>";
					}
					else
					{
						if(varcashmarginchk!="<%=Helper.correctNull((String) vecRow
											.get(16))%>")
						{
							alert("100% Cash Margin can't be renew with other facilities");
							return false;
						}
					}

					<%
					if (Helper.correctNull(
							(String) vecRow.get(17))
							.equalsIgnoreCase("Y")) {%>
							alert("CBS account number/Limit Node mapping not done for the Sub limit/Adhoc/Additional limit of this proposal. Kindly modify the limit in Finacle as per the sanction or if released send mail for mapping of limit node or if not required send mail for closure of facility");
							return false;
			
			<%}
					%>

					
						facsno=facsno+"<%=Helper.correctNull((String) vecRow
											.get(10))%>"+"@"+"<%=Helper.correctNull((String) vecRow
											.get(11))%>"+"@"+"<%=Helper.correctNull((String) vecRow
											.get(15))%>"+"@"+"<%=Helper.correctNull((String) vecRow.get(13))%>"+"@"+"<%=Helper.correctNull((String) vecRow.get(19))%>"+"@"+"<%=Helper.correctNull((String) vecRow.get(20))%>"+"~";
					<%}%>
				}
			<%}
				} else if (vecData.size() == 1) {%>
			if(document.forms[0].chkFac.checked==true)
			{
				<%vecRow = (ArrayList) vecData.get(0);
					if (vecRow != null) {%>
					facsno=facsno+"<%=Helper.correctNull((String) vecRow.get(10))%>"+"@"+"<%=Helper.correctNull((String) vecRow.get(11))%>"+"@"+"<%=Helper.correctNull((String) vecRow.get(15))%>"+"@"+"<%=Helper.correctNull((String) vecRow
					.get(13))%>"+"@"+"<%=Helper.correctNull((String) vecRow.get(19))%>"+"@"+"<%=Helper.correctNull((String) vecRow.get(20))%>"+"~";
				<%}%>
			}
		<%}
			}%>
		document.forms[0].hidFacSnoCheck.value=facsno;
		parent.document.forms[0].hidFacsno.value=facsno;
		return true;
					
}
function callRenew()
{
	checkbox_len=document.forms[0].chkFac;
	checkbox_length=checkbox_len.length;
	var varFacility_Flag=false;
	if(document.forms[0].chkFac.checked==true)
	{
		varFacility_Flag=true;
	}
	for(var k=0;k<checkbox_length;k++)
	{
		if(document.forms[0].chkFac[k].checked==true)
		{
			varFacility_Flag=true;
		}
	}
	if(varFacility_Flag==true)
	{
		if(parent.document.forms[0].radLoan[3].checked==false && parent.document.forms[0].txt_appinwardno.value=="")
		{
		  	ShowAlert(111,'Inward No');
		  	parent.document.forms[0].txt_appinwardno.focus();
		  	return;
		}
		varFlag=callCheckedFacility();
		if(varFlag==false)
		{
			return;
		}
		parent.document.forms[0].hidComappid.value=varappid;
		if(parent.document.forms[0].radLoan[2].checked)
		{
			parent.document.forms[0].hidType.value="S";
		}
		else if(parent.document.forms[0].radLoan[3].checked)
		{
			parent.document.forms[0].hidType.value="P";
		}
		else
		{
			parent.document.forms[0].hidType.value="R";
		}
		document.forms[0].cmdOK.disabled = true;
		parent.document.forms[0].hidBeanId.value="facilities";
		parent.document.forms[0].action=appURL+"action/comloanhistroy.jsp";
		parent.document.forms[0].hidBeanGetMethod.value="getApplicationRenew";		
		parent.document.forms[0].submit();
	}else{
		alert("Please Choose Any Facility");
		return;
	}
}
function callCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].action=appURL+"action/blank.jsp";
		document.forms[0].submit();
   }
	   
}
function callOnLoad()
{
	<%if (vecData.size() == 0) {%>
	document.forms[0].cmdOK.disabled=true;
	<%}%>
}
</script>
<head>
<script>
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onload="callOnLoad();">
<form name="srchform" method ="post" class="normal">

<table  width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
	<tr>
		<td align="center">
			<table width="100%" border="0" cellspacing="1" cellpadding="3" align="center">
			<tr class="dataheader">
				<td width="3%">&nbsp;</td>
				<td width="10%" align="center">Proposal Number</td>
				<td width="10%" align="center">Facility Head</td>
				<td width="15%" align="center">Facility</td>
				<%
					if (strFlag.equalsIgnoreCase("Y")) {
				%>
				<td width="10%" align="center">Existing<br> </td>
				<td width="10%" align="center">Proposed</td>
				<%
					} else {
				%>
				<td width="10%" align="center">Limit</td>
				<%
					}
				%>
				<td width="8%" align="center">CBS A/C No</td>
				<td width="8%" align="center">Process Date</td>
				<td width="10%" align="center">LimitType</td>
				<td width="10%" align="center">Nature of Limit</td>
				
				
			</tr>
	<%
		if (vecData != null) {
			vecsize = vecData.size();
		}
		String strSno = "", strSubLimit = "";
		int j = 0, intsno = 0, intGroup = 0;
		int subGrpSize = 0;
		String strPreCategory = "", strCategory = "", strMonths = "", strbranch = "";
		for (int i = 1; i <= vecsize; i++) {
			strHeaddesc = "";
			strCategory = "";
			strMonths = "";
			strFacdesc = "";
			strExist = "";
			strProposed = "";
			strDiff = "";
			strMargin = "";
			strInterest = "";
			strbranch = "";
			strbplr = "";
			strDP = "";
			strSecurity = "";
			strOutstanding = "";
			arrSubGrpList = new ArrayList();
			String strGrpList = "";
			strIntadjust = "";
			String strPurpose = "";
			String strGroup = "", strDesc = "", strCurCat = "";
			String strIntType = "", strRepaytype = "", strGovtsponsschem = "", strSchemeType = "", strSponsAgency = "";
			String strSubsidyType = "", strsubsidyAmunt = "", strFacCode = "", strSubFacCode = "", strAgrSchemeType = "", strAgrSubSchemeType = "";
			String strHolidayPeriod = "", strInterestrec = "", strInterestCharged = "", strModerepay = "", strOperationAcno = "";
			String strRemarks = "", strPerInstal = "", strfacdesctype = "";
			String strFacSubIntType = "", strFacIntId = "", strFacBaseRate = "";
			String strfacDescNew = "";
			String strfacnature = "";
			String strAgency = "";
			String strFreshLimit = "";
			String Applicationno = "";
			String strgroupid = "";
			String Strfacilitysno = "",strAdhocDet="";
			String CBS_Accno = "";
			String Process_date = "";
			vecRow = (ArrayList) vecData.get(i - 1);
			if (vecRow != null) {
				strHeadId = Helper
						.correctNull((String) vecRow.get(0));
				vecHead.add(strHeadId);
				strFacId = Helper.correctNull((String) vecRow.get(2));
				vecFac.add(strHeadId);
				strHeaddesc = Helper.correctNull((String) vecRow
						.get(1));
				strFacdesc = Helper.correctNull((String) vecRow
						.get(6));
				strProposed = Helper.correctNull((String) vecRow
						.get(8));
				strSno = Helper.correctNull((String) vecRow.get(10));
				strExist = jtn.format(Double.parseDouble(Helper
						.correctDouble((String) vecRow.get(7))));
				strfacnature = Helper.correctNull((String) vecRow
						.get(9));
				Applicationno = Helper.correctNull((String) vecRow
						.get(11));
				strGroup = Helper
						.correctNull((String) vecRow.get(12));
				strCategory = Helper.correctNull((String) vecRow
						.get(13));
				strCurCat = strCategory;
				intsno = Integer.parseInt(strSno);
				if (!strGroup.trim().equals("")) {
					intGroup = Integer.parseInt(strGroup);
				}
				strgroupid = strGroup + "@" + Applicationno;
				strAdhocDet=strGroup+"@"+Applicationno;
				if(strCategory.equalsIgnoreCase("D"))
				strgroupid = Helper.correctNull((String) vecRow.get(20)) + "@" + Helper.correctNull((String) vecRow.get(19));
				if(strCategory.equalsIgnoreCase("A"))
					strAdhocDet = Helper.correctNull((String) vecRow.get(20)) + "@" + Helper.correctNull((String) vecRow.get(19));
				Strfacilitysno = strSno + "@" + Applicationno;
				CBS_Accno = Helper.correctNull((String) vecRow
						.get(15));
				;
				Process_date = Helper.correctNull((String) vecRow
						.get(14));

			}
	%>
	<%
		if (strGroup.trim().equals("0") && ((strCategory.equalsIgnoreCase("R")||strCategory.equalsIgnoreCase("O"))||strFlag.equalsIgnoreCase("P"))) {
				j = 0;
	%>
		<tr class="datagrid">
			<td align="center">
			<%
				if (strSno.trim().equals(strselsno.trim())) {
			%> 
			 <input type="checkbox" name="chkFac" style="border-style:none" onclick="callFacsnoChk(this)">
			 <input type="hidden" name="txtgroup" value="<%=strgroupid%>" style="border: 0; text-align: right">
			 <input type="hidden" name="hidfacilitysno" value="<%=Strfacilitysno%>" style="border: 0; text-align: right">
			 <input type="hidden" name="hidAdhocSno" value="<%=strAdhocDet%>" style="border: 0; text-align: right">
			<%
				} else {
			%> 
			 <input type="checkbox" name="chkFac" style="border-style:none" onclick="callFacsnoChk(this)">
			 <input type="hidden" name="txtgroup" value="<%=strgroupid%>" style="border: 0; text-align: right">
			 <input type="hidden" name="hidfacilitysno" value="<%=Strfacilitysno%>" style="border: 0; text-align: right"> 
			 <input type="hidden" name="hidAdhocSno" value="<%=strAdhocDet%>" style="border: 0; text-align: right">
			<%
 				}
 			%>
			</td>
			<td><%=Applicationno%> - <%=Helper.correctNull((String) vecRow.get(10)) %></td>
			<td><input type="hidden" name="txtheadid<%=intsno%>" value="<%=strHeadId%>" style="border: 0; text-align: right"> <%=strHeaddesc%></td>
			<td><input type="hidden" name="txtfacid<%=intsno%>" value="<%=strFacId%>" style="border: 0; text-align: right"> <%=strFacdesc%></td>
			<%
				if (strFlag.equalsIgnoreCase("Y")) {
			%>
			<td align="right"><%=strProposed%> <input type="hidden" name="txtexist<%=intsno%><%=intGroup%>" value="<%=strProposed%>"></td>
			<%
				}
			%>
			<td align="right"><%=strProposed%> <input type="hidden" name="txtproposed<%=intsno%><%=intGroup%>" value="<%=strProposed%>">
				<input type="hidden" name="txtfacnature<%=intsno%><%=intGroup%>" value="<%=strfacnature%>">
			</td>
			<td width="15%" align="center"><%=CBS_Accno%></td>
			<td width="15%" align="center"><%=Process_date%></td>
			<td>
			<%if(strGroup.trim().equals("0")){ %>
			    Main-Limit
			<%}else{ %>
			   Sub-Limit
			<%} %>
			</td>
			
			<td>
			<%
				if (strGroup.trim().equals("0")) {
							if (strCategory.trim().equals("R")) {
			%>
		   			Regular Limit
				<%
				} else if (strCategory.trim().equals("A")) {
			%>
					Adhoc Limit of (<%= Helper.correctNull((String) vecRow.get(18)) %>)
			<%
				}else if (strCategory.trim().equals("D")) {
			%>
					Additional Limit of (<%= Helper.correctNull((String) vecRow.get(18)) %>)
			<%
				}else if (strCategory.trim().equals("O")) {
			%>
					One Time Limit
			<%
				}
						}
			%>
			</td>
		</tr>
	
	<%
			} else {
					if (!strGroup.equals(strSubLimit)){
						strSubLimit = strGroup;
						j++;
		%>
	<%
		}
	%>
		<tr class="datagrid">
			<td align="center"> <font color="#3f3f40">
		 	<%
		 		if (strSno.trim().equals(strselsno.trim())) {
		 					strsubselsno = strGroup;
		 	%> 
				 <input type="checkbox" name="chkFac<%=intsno%>" style="border-style:none" onclick="callFacsnoChk(this)">
				 <input type="hidden" name="txtgroup" value="<%=strgroupid%>" style="border: 0; text-align: right">
				 <input type="hidden" name="hidfacilitysno" value="<%=Strfacilitysno%>" style="border: 0; text-align: right">
				 <input type="hidden" name="hidAdhocSno" value="<%=strAdhocDet%>" style="border: 0; text-align: right">
			<%
				} else {
			%> 
				 <input type="checkbox" name="chkFac" style="border-style:none" onclick="callFacsnoChk(this)">
				 <input type="hidden" name="txtgroup" value="<%=strgroupid%>" style="border: 0; text-align: right">
				 <input type="hidden" name="hidfacilitysno" value="<%=Strfacilitysno%>" style="border: 0; text-align: right">
				 <input type="hidden" name="hidAdhocSno" value="<%=strAdhocDet%>" style="border: 0; text-align: right">
			<%
				}
			%></font>
			</td>
			<td><%=Applicationno%> - <%=Helper.correctNull((String) vecRow.get(10)) %></td>
			<td align="left"> <font color="#3f3f40">
				<input type="hidden" name="txtsubheadid<%=intsno%>" value="<%=strHeadId%>" style="border: 0; text-align: right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=strHeaddesc%></font>
			</td>
			<td width="15%"> <font color="#3f3f40">
				<input type="hidden" name="txtsubfacid<%=intsno%>" value="<%=strFacId%>" style="border: 0; text-align: right"> <%=strFacdesc%></font>
			</td>
			<%
				if (strFlag.equalsIgnoreCase("Y")) {
			%>
			<td align="right"> <font color="#3f3f40">(<%=strProposed%>) 
				<input type="hidden" name="txtsubexist<%=intsno%><%=intGroup%>" value="<%=strProposed%>"></font>
			</td>
			<%
				}
			%>
			<td align="right"> <font color="#3f3f40">
				<input type="hidden" name="txtsubproposed<%=intsno%><%=intGroup%>" value="<%=strProposed%>"> (<%=strProposed%>)
				<input type="hidden" name="txtsubfacnature<%=intsno%><%=intGroup%>" value="<%=strfacnature%>"></font>
			</td>
			<td width="15%" align="center"><%=CBS_Accno%></td>
			<td width="15%" align="center"><%=Process_date%></td>
			<td><font color="#3f3f40">
			   Sub-Limit
			</font></td>
			
			<td> <font color="#3f3f40"> 
			
			<%
			if (strCategory.trim().equals("R")) {
				%>
			   			Regular Limit
					<%
					} else if (strCategory.trim().equals("A")) {
				%>
						Adhoc Limit of (<%= Helper.correctNull((String) vecRow.get(18)) %>)
				<%
					}else if (strCategory.trim().equals("D")) {
						%>
						Additional Limit of (<%= Helper.correctNull((String) vecRow.get(18)) %>)
				<%
					}else if (strCategory.trim().equals("O")) {
				%>
						One Time Limit
				<%
					}
			%>
			</font> </td>
			
		</tr>
		<%
			}
			}
		%>
		
	</table>
		
		</td>
	</tr>
	<tr> 
         <td  align="center" height="32" colspan="3"> 
         <input type="button" name="cmdOK" value="OK" class="buttonStyle"  onClick="callRenew()">
         <input type="button" name="cmdCancel" value="Cancel" class="buttonstyle"  onClick="callCancel()">
        </td>
   </tr>
</table>
<input type="hidden" name="hidFacSnoCheck" value=""> 
<input type="hidden" name="hidApplicationno" value="">  
<input type="hidden" name="var_Com_Newid" value="<%=Helper.correctNull((String) request
							.getParameter("com_newid"))%>">
<input type="hidden" name="comapp_newid" value="<%=Helper.correctNull((String) request
							.getParameter("com_newid"))%>">
<input type="hidden" name="hidappid" value="<%=Helper.correctNull((String) request
							.getParameter("hidapplicantoldid"))%>"> 
</form>
</body>
</html>