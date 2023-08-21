<%@ include file="../share/directives.jsp"%>
<%

String strUserID=Helper.correctNull((String)session.getAttribute("strUserId"));

String optformtype = Helper.correctNull(request.getParameter("optformtype"));
ArrayList g1 = new ArrayList();
java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
nf.setMinimumFractionDigits(2);
nf.setMaximumFractionDigits(2);
nf.setGroupingUsed(false);

%>
<html>
<head>
<title>Security Creation / Modification Verification</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
	<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
	<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script LANGUAGE="JavaScript">
var appURL ="<%=ApplicationParams.getAppUrl()%>";
var varchangeflag="<%=Helper.correctNull((String)hshValues.get("strchangeflag"))%>";
var varapproveflag="<%=Helper.correctNull((String)hshValues.get("strapproveflag"))%>";
var varStatus="<%=Helper.correctNull((String)hshValues.get("strStatus"))%>";
var varname="<%=Helper.correctNull((String)hshValues.get("strname"))%>";
var varError="<%=Helper.correctNull((String)hshValues.get("strError"))%>";
var varUserID="<%=strUserID%>";
var varCreatedUserID="<%=Helper.correctNull((String)hshValues.get("MSME_CREATED_BY"))%>";
var MSME_CRITERIA_SALES="<%=Helper.correctNull((String) hshValues.get("PERAPP_CRITERIA_SALES_TURNOVER"))%>";
var varcriteriainvest="<%=Helper.correctNull((String) hshValues
	.get("MSME_CRITERIA_INVESTMENT"))%>";
	var varminority="<%=Helper.correctNull((String) hshValues.get("indinfo_minority"))%>";
	var varindreligion="<%=Helper.correctNull((String) hshValues.get("indinfo_religion"))%>";
	var varcommunityminority="<%=Helper.correctNull((String) hshValues.get("cominfo_minority_community"))%>";
	var nonindreligion="<%=Helper.correctNull((String) hshValues.get("perapp_religion"))%>";
	var varmaj_member="<%=Helper.correctNull((String) hshValues.get("majority_member"))%>";
	var varstake_held="<%=Helper.correctNull((String) hshValues.get("stake_held"))%>";
	var varconstitut="<%=Helper.correctNull((String) hshValues.get("constitutionnew"))%>";
	var varcaste="<%=Helper.correctNull((String) hshValues.get("indinfo_caste"))%>";
	var vargender="<%=Helper.correctNull((String) hshValues.get("perapp_sex"))%>";

	var varMSMEsales="<%=Helper.correctNull((String) hshValues.get("MSME_SALES_TURNOVER"))%>";	
	var varMSMEdate="<%=Helper.correctNull((String) hshValues.get("MSME_SALES_DATE"))%>";	
	var VarMSMECriteria="<%=Helper.correctNull((String) hshValues.get("MSME_CRITERIA_SALES"))%>";	
	var varPersales="<%=Helper.correctNull((String) hshValues.get("PERAPP_SALES_TURNOVER"))%>";	
	var varPerdate="<%=Helper.correctNull((String) hshValues.get("PERAPP_SALES_TURNOVER_DATE"))%>";	
	var varPerCriteria="<%=Helper.correctNull((String) hshValues.get("PERAPP_CRITERIA_SALES_TURNOVER"))%>";	
	var varCRName ="<%=Helper.correctNull((String) hshValues.get("strCROrgName"))%>";	
function loadPage()
{
	if(varError!="")
	{
		alert(varError);
		document.forms[0].action = appURL + "action/inboxmails.jsp?fromlink=mailbox&optformtype=MSME";
		document.forms[0].submit();
		
	}
	 if(varStatus=="rollback")
		{
			alert("Proposal roll back done successfully to created organisation ");
			document.forms[0].action = appURL + "action/mainnav.jsp";
			document.forms[0].submit();	
		}
	else if(varStatus!="" && !(varStatus=="Success" || varStatus=="CRequest"))
	{
		if(varStatus=="Revert")
		{
			alert("Proposal has been reverted back to " +varCRName);	
		}
		else if(varStatus=="Approve")
		{
			alert("Msme Verification Approved Successfully");	
		}
		else if(varStatus=="Reject")
		{
			alert("Your Msme Proposal Verification request has been Rejected");	
		}

			document.forms[0].action = appURL + "action/inboxmails.jsp?fromlink=mailbox&optformtype=MSME";
			document.forms[0].submit();
	}
	
	disableFields(true);
	if(varapproveflag=="Y")
	{
		document.forms[0].cmdapprove.disabled=false;
		document.forms[0].cmdreject.disabled=false;
		document.forms[0].cmdrevertback.disabled=false;
		document.forms[0].cmddocuments.disabled=false;
		
		
	}
	else
	{
		document.forms[0].cmdapprove.disabled=true;
		document.forms[0].cmdreject.disabled=true;
		document.forms[0].cmdrevertback.disabled=true;
		document.forms[0].cmddocuments.disabled=true;
		
		
	}

	if(MSME_CRITERIA_SALES!=""){
		 document.forms[0].sel_sales_turnover.value=MSME_CRITERIA_SALES;
	 }
	 if(varcriteriainvest!=""){
		 document.forms[0].sel_criteria_invest_old.value=varcriteriainvest;
	 }
	
	document.forms[0].sel_sales_turnover.disabled=true;
	document.forms[0].sel_criteria_invest_old.disabled=true;
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
	 if(varMSMEsales!="" && varPersales!=""){
		 if(varMSMEsales != varPersales ){
			 alert("Sales Turnover does not match with  Sales Turnover in Customer profile page.");
			 document.forms[0].cmdapprove.disabled=true;
				document.forms[0].cmdreject.disabled=false;
				document.forms[0].cmdrevertback.disabled=false;
				document.forms[0].cmddocuments.disabled=true;
		 }
	 }
	 if(varMSMEdate!="" && varPerdate!=""){
		 if(varMSMEdate != varPerdate ){
			 alert("Sales Turnover Date does not match with  Sales Turnover Date in Customer profile page.");
			 document.forms[0].cmdapprove.disabled=true;
				document.forms[0].cmdreject.disabled=false;
				document.forms[0].cmdrevertback.disabled=false;
				document.forms[0].cmddocuments.disabled=true;
		 }
	 }
	 if(VarMSMECriteria!="" && varPerCriteria!=""){
		 if(VarMSMECriteria != varPerCriteria ){
			 alert("Sales Turnover criteria does not match with  Sales Turnover criteria in Customer profile page.");
			 document.forms[0].cmdapprove.disabled=true;
				document.forms[0].cmdreject.disabled=false;
				document.forms[0].cmdrevertback.disabled=false;
				document.forms[0].cmddocuments.disabled=true;
		 }
	 }
}

function doClose() {
	if (ConfirmMsg(100)) {
		document.forms[0].action = appURL + "action/mainnav.jsp";
		document.forms[0].submit();
	}
}

function disableFields(val)
{
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  if(document.forms[0].elements[i].type=='text'  )
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
	  }
}

function doApprove()
{
	
	var pagedate=document.forms[0].txt_effdate.value;
	var pgdt=changeDateformat(pagedate);
	var maxdt=changeDateformat(currentDate);
	if(pagedate!="")
	{
		if(Date.parse(pgdt) > Date.parse(maxdt))
		{
			alert("Date cannot be greater than " +currentDate );
			return;
		}
	}
	else
	{
		alert("Select Classification Effective Date");
		return;
	}

	if(document.forms[0].txt_remarks.value=="")
	{
		alert("Enter Remarks");
		document.forms[0].txt_remarks.focus();
		return;
	}
	if(!confirm("New Classification Effective Date "+pagedate+" captured is correct?"))
	{
		return;
	}

	if(!confirm("We have verified that \na) Relevant data points displayed in MSME details page like Sales turnover/Plant and Machinery Value/Fixed Asset value etc are in order\nb) Branch has obtained and uploaded Udyam Registration Certificate\nc) All the MSME loan accounts of the borrower are displayed above"))
	{
		return;
	}

	showProgress('imgloading');
	window.scrollTo(0, 0);
	if(varconstitut=="01"){
		if(varminority!="")
					{
			          document.forms[0].hidsel_minority.value=varminority;
					}else{
						document.forms[0].hidsel_minority.value="";
					}
					
					if(varindreligion!="")
					{
						document.forms[0].hidsel_religion.value=varindreligion;
					}else{
						document.forms[0].hidsel_religion.value="0";
					}
					document.forms[0].hidsel_firm_minority.value="";
					document.forms[0].hidsel_corp_religion.value="0";
	}else{
		if(varcommunityminority!="")
		{
			document.forms[0].hidsel_firm_minority.value=varcommunityminority;
		}else{
			document.forms[0].hidsel_firm_minority.value="0";
		}
		
		if(nonindreligion!="")
		{
			document.forms[0].hidsel_corp_religion.value=nonindreligion;
		}else{
			document.forms[0].hidsel_corp_religion.value="0";
		}
		document.forms[0].hidsel_minority.value="";
		document.forms[0].hidsel_religion.value="0";
		}
	

	document.forms[0].hidAction.value ="approve";
	document.forms[0].hidBeanId.value="inwardRegister";
	document.forms[0].hidBeanGetMethod.value="updateMsmeApproval";
	document.forms[0].action=appURL+"action/msme_proposalapprove.jsp";
	document.forms[0].submit();
}
function doReject()
{
	if(document.forms[0].txt_remarks.value=="")
	{
		alert("Enter Remarks");
		document.forms[0].txt_remarks.focus();
		return;
	}
	if(confirm("Do you want to reject this change?"))
	{
		document.forms[0].hidAction.value ="reject";
		document.forms[0].hidBeanId.value="inwardRegister";
		document.forms[0].hidBeanGetMethod.value="updateMsmeApproval";
		document.forms[0].action=appURL+"action/msme_proposalapprove.jsp";
		document.forms[0].submit();
	}
}
function doRevertBack()
{
	if(document.forms[0].txt_remarks.value=="")
	{
		alert("Enter Remarks");
		document.forms[0].txt_remarks.focus();
		return;
	}
	document.forms[0].hidAction.value ="revert";
	document.forms[0].hidBeanId.value="inwardRegister";
	document.forms[0].hidBeanGetMethod.value="updateMsmeApproval";
	document.forms[0].action=appURL+"action/msme_proposalapprove.jsp";
	document.forms[0].submit();
}
function callCalender(name) {

		showCal(appURL, name);

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
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>

<body onLoad="loadPage();">
<div id='imgloading' style="display:none;">
<img src="<%=ApplicationParams.getAppUrl()%>img/processing2.gif"></div>
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

		<table width="90%" border="1px" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr>
			<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
							align="center" class="outertable">
			<tr class="dataheader">
			<td> Proposal No : <%=Helper.correctNull((String)hshValues.get("hidappno")) %></td>
			<td> Customer ID : <%=Helper.correctNull((String)hshValues.get("strCBSID")) %></td>
			<td> Customer Name : <%=Helper.correctNull((String)hshValues.get("strBorrowerName")) %></td>
			<td> Branch Name : <%=Helper.correctNull((String)hshValues.get("strBRName")) %></td>
			<td> Status : <%=Helper.correctNull((String)hshValues.get("strstatus")) %></td>
			
			</tr>
			</table>
			</td>
			</tr>
			<tr>
			<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
							align="center" class="outertable">
							
							<tr valign="top">
								<td  colspan="8">
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
											<tr><td>&nbsp;</td></tr>
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
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="1" cellpadding="3"
					class="outertable" align="center">
					<tr>
						<td class="dataheader" align="center" colspan="4">MSME
						Details&nbsp;</td>
					</tr>
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
						<td>Sales Turnover of the Applicant (Rs.)</td>
						<td><input type="text" name="txt_salesturnover_old" size="40" style="background: #FFFFDD; font-weight: bold; text-align: right;"
							value="<%=Helper.correctNull((String)hshValues.get("PERAPP_SALES_TURNOVER")) %>"
							class="finaclefieldsbgcolor"></td>
						<td>Sales Turnover As on Date</td>
						<td><input type="text" name="txt_salesturnoverdate_old" style="background: #FFFFDD; font-weight: bold; text-align: right;"
							value="<%=Helper.correctNull((String)hshValues.get("PERAPP_SALES_TURNOVER_DATE")) %>"
							class="finaclefieldsbgcolor"></td>
					</tr>
					<tr>
						<td>Criteria for Sales Turnover</td>
						<td>
						<select name="sel_sales_turnover"
							style="background: #FFFFDD; font-weight: bold; width: 200px" class="finaclefieldsbgcolor">
							<option value="0">&lt;--Select--&gt;</option>
							<%
								 apptype = "243";
							%>
							<lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
						</select>
						</td>
						<td>Investment in Plant & Machineries/Equipments (Rs.)</td>
						<td><input type="text" name="txt_equipval_old"  style="text-align: right;"
							value="<%=Helper.correctNull((String)hshValues.get("MSME_EQUIP_VAL")) %>"
							class="finaclefieldsbgcolor" style=""></td>
					</tr>
					<tr>
					<td>Investment value as on Date </td>
					<td><input type="text" name="txt_investDate_old"
							value="<%=Helper.correctNull((String)hshValues.get("MSME_INVESTMENT_DATE")) %>"
							class="finaclefieldsbgcolor"></td>
                      	
			<td>Criteria for Investment value</td>
			<td>
			<select name="sel_criteria_invest_old"
							style="width: 200px" class="finaclefieldsbgcolor">
                          <option value="0">&lt;--Select--&gt;</option>
                          <%String strapptype = "248";%>
                          <lapschoice:StaticDataNewTag apptype='<%=strapptype%>' />
                        </select></td>
                      	</tr>
					<tr>
						<td>New Classification Effective date</td>
						<td><input type="text" name="txt_effdate"
							value="<%=Helper.correctNull((String)hshValues.get("MSME_CLASSI_DATE")) %>"
							 size="15" onBlur="checkDate(this);checkmaxdate(this,currentDate);"><a onClick="callCalender('txt_effdate')"
														title="Click to view calender" border=0><img
														src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
														width="0" border="0"></a></td>
					</tr>
					<%if(!("").equalsIgnoreCase(Helper.correctNull((String) hshValues
							.get("strComments")))) {%>
					<tr>
					<td>Recommendations</td>
					<td><textarea name="txt_comments" cols="90" rows="5" tabindex="21" disabled="disabled"><%=Helper.correctNull((String) hshValues
							.get("strComments"))%></textarea></td>
					</tr>
					<%} %>
					<tr>
					<td>Remarks</td>
					<td><textarea name="txt_remarks" cols="90" rows="5" tabindex="21"><%=Helper.correctNull((String) hshValues
							.get("strRemarks"))%></textarea></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>


<table width="35%" border="0" cellspacing="0" cellpadding="0"
	class="outertable" align="center">
	<tr><td>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable border1" align="center">
	<tr>
		<td width="45%">
		<input type="button" name="cmdapprove" value="Verify and Reclassify all accounts of the borrower" onclick="doApprove();" class="buttonOthers"></td>
		<td width="20%">
		<input type="button" name="cmdreject" value="Reject" onclick="doReject();" class="buttonOthers"></td>
		<td width="20%">
		<input type="button" name="cmdrevertback" value="Revert Back" onclick="doRevertBack();" class="buttonOthers"></td>
		<td width="20%">
		<input type="button" name="cmddocuments" value="View Documents" onclick="doDocument();" class="buttonOthers"></td>
		<td width="15%">
		<input type="button" name="close" value="Close" onclick="doClose();" class="buttonClose">
		</td>
	</tr>
</table>
</td>
</tr>
</table>
<lapschoice:hiddentag pageid="<%=PageId%>" />
<input type="hidden" name="hidPageFrom"
	value="<%=Helper.correctNull((String)request.getParameter("strPageFrom")) %>">
<input type="hidden" name="hidappno" value="<%=Helper.correctDouble((String)hshValues.get("hidappno")) %>">
<input type="hidden" name="hidappid"
			value="<%=Helper.correctNull((String) hshValues.get("strappid"))%>">
<input type="hidden" name="hidsel_minority">
<input type="hidden" name="hidsel_religion">
<input type="hidden" name="hidsel_firm_minority">
<input type="hidden" name="hidsel_corp_religion">	
<input type="hidden" name="hidperappid" value="<%=Helper.correctNull((String) hshValues.get("Strnewperappid1"))%>">			
</form>
</body>
</html>