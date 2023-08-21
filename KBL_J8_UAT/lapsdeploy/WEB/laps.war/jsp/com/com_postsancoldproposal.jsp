<%@include file="../share/directives.jsp"%>
<%

ArrayList arrSecRow = new ArrayList(); 
ArrayList arrSecCol = new ArrayList(); 
ArrayList arrRepayScheduleRow = new ArrayList(); 
ArrayList arrRepayScheduleCol = new ArrayList(); 

if(hshValues!=null)
{
	arrSecRow = (ArrayList)hshValues.get("arrSecRow");
	arrRepayScheduleRow = (ArrayList)hshValues.get("arrRepayScheduleRow");
}

String strSno = Helper.correctNull((String)hshValues.get("strSno"));
String strBankScheme = Helper.correctNull((String)hshValues.get("BANKSCHEME"));
String strUtilizePlace = Helper.correctNull((String)hshValues.get("app_place"));
String strMainactivity = Helper.correctNull((String)hshValues.get("app_mainactivity"));
String strSubactivity = Helper.correctNull((String)hshValues.get("app_subactivity"));
String strPurpose = Helper.correctNull((String)hshValues.get("app_purpose"));
String strBSRcode = Helper.correctNull((String)hshValues.get("app_bsrcode"));
String strBSR1code = Helper.correctNull((String)hshValues.get("app_bsr1code"));
String strIndusType = Helper.correctNull((String)hshValues.get("app_industrytype"));
String strAssetClassi = Helper.correctNull((String)hshValues.get("app_assetclassifcation"));
String strCategory = Helper.correctNull((String)hshValues.get("strAgriIndConfig"));
String strSector = Helper.correctNull((String)hshValues.get("strPriorityType"));
String strSubSector = Helper.correctNull((String)hshValues.get("strPrioritySubsector"));
String strSensitiveSector = Helper.correctNull((String)hshValues.get("strSensitiveSector"));
String strWeakerSection = Helper.correctNull((String)hshValues.get("strWeakerSectionSubSector"));
String strTwentyProg = Helper.correctNull((String)hshValues.get("strTwentyPointPgm"));
String strInfratype = Helper.correctNull((String)hshValues.get("strInfracode"));
String strgovtannouncescheme = Helper.correctNull((String)hshValues.get("strgovtannouncescheme"));
String strstandupindia = Helper.correctNull((String)hshValues.get("strstandupindia"));

String strAdvanceNature = Helper.correctNull((String)hshValues.get("strAdvanceNature"));
String strAdvanceType = Helper.correctNull((String)hshValues.get("strAdvanceType"));
String strAdvanceMode = Helper.correctNull((String)hshValues.get("strAdvanceMode"));
String strAdvancePurpose = Helper.correctNull((String)hshValues.get("strAdvancePurpose"));
String strFreeCode3 = Helper.correctNull((String)hshValues.get("strFreeCode3"));
String strfreecode6 = Helper.correctNull((String)hshValues.get("freecode6"));
String strfreecode7 = Helper.correctNull((String)hshValues.get("freecode7"));
String strfreecode8 = Helper.correctNull((String)hshValues.get("freecode8"));
String strmodeofoper = Helper.correctNull((String)hshValues.get("modeofoper"));
String strdrwingpwrind = Helper.correctNull((String)hshValues.get("drwingpwrind"));
String strINTRATEFREQ = Helper.correctNull((String)hshValues.get("INTRATEFREQ"));
String strLBRcode = Helper.correctNull((String)hshValues.get("LBRCODE"));
String strlapscode1 = Helper.correctNull((String)hshValues.get("LAPSCODE1"));
String strlapscode2 = Helper.correctNull((String)hshValues.get("LAPSCODE2"));
String strlapscode3 = Helper.correctNull((String)hshValues.get("LAPSCODE3"));
//out.println(hshValues);
String stroldprocessingcharges = Helper.correctNull((String)hshValues.get("com_processingfee"));
%>
<html>
<head>
<title>Post Sanction Old proposal details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/mis/misdetails.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>
var currdate = "<%=Helper.getCurrentDateTime()%>";
var subactivity = "<%=strSubactivity%>";
var freecode7 =  "<%=strfreecode7%>";
var freecode8 =  "<%=strfreecode8%>";
var varSno =  "<%=strSno%>";

function selectAcc()
{
	document.forms[0].hidBeanId.value = "facilities";
	document.forms[0].hidBeanGetMethod.value = "getPSOldSanctionedData";
	document.forms[0].action = appURL + "action/com_postsancoldproposal.jsp";
	document.forms[0].submit();
}

function onMainActChange()
{
	document.all.ifrm.src=appURL+"action/iframemainactcode.jsp?hidBeanGetMethod=getMainActCode&hidBeanId=mis&strMainActCode="
					+document.forms[0].sel_MainActivity.value+"&subactval="+subactivity;
	document.forms[0].sel_SubActivity.options[0].selected=true;
}

function changeFreeCode7()
{
	var strParentRefNo= document.forms[0].sel_freecode6.value;	
	document.all.ifrm2.src=appURL+"action/iframeappfreecode7.jsp?hidBeanId=FinacleBean&hidBeanGetMethod=getFreeCodeData&strLevel=1&strParentRefNo="+strParentRefNo+"&freecode7="+freecode7;
}
function changeFreeCode8(Refno)
{	
	var strParentRefNo= Refno;
	if(strParentRefNo=="")
	{
		strParentRefNo="0";
	}	
	document.all.ifrm1.src=appURL+"action/iframeappfreecode8.jsp?hidBeanId=FinacleBean&hidBeanGetMethod=getFreeCodeData&strLevel=2&strParentRefNo="+strParentRefNo+"&freecode8="+freecode8;
}

function callOnLoad()
{
	disabledFields(true);
	
	<%if(!Helper.correctNull((String)hshValues.get("strModuleType")).equalsIgnoreCase("P")){ %>
	document.forms[0].sel_facilitysno.disabled=false;
	document.forms[0].sel_facilitysno.value = varSno;
	<%}%>
	document.forms[0].sel_BankScheme.value = "<%=strBankScheme%>";
	document.forms[0].sel_Place.value = "<%=strUtilizePlace%>";
	document.forms[0].sel_MainActivity.value = "<%=strMainactivity%>";
	document.forms[0].sel_Purpose.value = "<%=strPurpose%>";
	document.forms[0].sel_BSRCode.value = "<%=strBSRcode%>";
	document.forms[0].sel_BSR1Code.value = "<%=strBSR1code%>";
	document.forms[0].sel_IndustryType.value = "<%=strIndusType%>";
	document.forms[0].sel_AssetClassification.value = "<%=strAssetClassi%>";
	document.forms[0].sel_CategoryType.value = "<%=strCategory%>";
	document.forms[0].sel_Sector.value = "<%=strSector%>";
	document.forms[0].sel_SubSector.value = "<%=strSubSector%>";
	document.forms[0].sel_SensitiveSector.value = "<%=strSensitiveSector%>";
	document.forms[0].sel_WeakerSection.value = "<%=strWeakerSection%>";
	document.forms[0].sel_TwentyPointPgm.value = "<%=strTwentyProg%>";
	document.forms[0].sel_InfraCreditType.value = "<%=strInfratype%>";
	document.forms[0].sel_GovtAnnounceScheme.value = "<%=strgovtannouncescheme%>";
	document.forms[0].sel_StandupIndia.value = "<%=strstandupindia%>";

	document.forms[0].sel_advancenature.value = "<%=strAdvanceNature%>";
	document.forms[0].sel_mode.value = "<%=strmodeofoper%>";
	document.forms[0].sel_power_indicator.value = "<%=strdrwingpwrind%>";
	document.forms[0].sel_advancetype.value = "<%=strAdvanceType%>";
	document.forms[0].sel_advancemode.value = "<%=strAdvanceMode%>";
	document.forms[0].selintrate.value = "<%=strINTRATEFREQ%>";
	document.forms[0].sel_advancepurpose.value = "<%=strAdvancePurpose%>";
	document.forms[0].sel_freecode3.value = "<%=strFreeCode3%>";
	document.forms[0].sel_LBRCode.value = "<%=strLBRcode%>";
	document.forms[0].sel_freecode6.value = "<%=strfreecode6%>";
	document.forms[0].sel_lapscode1.value= "<%=strlapscode1%>";
	document.forms[0].sel_lapscode2.value= "<%=strlapscode2%>";
	document.forms[0].sel_lapscode3.value= "<%=strlapscode3%>";

	onMainActChange();
	changeFreeCode7();
	changeFreeCode8(freecode7);
}

function disabledFields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}
		if(document.forms[0].elements[i].type=="checkbox")
		{
			document.forms[0].elements[i].disabled=one;		  
		}
		if(document.forms[0].elements[i].type=="select-multiple" )
		{
			document.forms[0].elements[i].disabled=one;
		}
	}
}
</script>
</head>
<body onload="callOnLoad();">
<form method="post" class="normal">
<lapschoice:application />
<br>
<table width="98%" align="center" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr class="dataheader"><td align="center"><b>Details of the Old Sanctioned proposal</b></td></tr>
	
	<%if(!Helper.correctNull((String)hshValues.get("strModuleType")).equalsIgnoreCase("P")){ %>
	<tr><td align="center" class="datagrid">List of facilities&nbsp;&nbsp;<select name="sel_facilitysno" tabindex="1" onChange="selectAcc();">
				<option value="0" selected="selected">--Select--</option>
                <lapschoice:ComMisDetailsTag apptype='<%=Helper.correctNull((String) request.getParameter("appno"))%>' page='PS'/>
				</select>
	</tr>
	<%} %>
	<tr><td>&nbsp;</td></tr>
	<tr>
	<td>
		<table width="100%" border="0" cellpadding="2" cellspacing="0" class="outertable border1">
			<tr class="dataheader"><td colspan="4">Sanction details</td></tr>
			<tr>
			<td width="20%">Proposal Number</td>
			<td width="30%"><%=Helper.correctNull((String)hshValues.get("strOldSno"))%>&nbsp;-&nbsp;<%=Helper.correctNull((String)hshValues.get("strOldAppno"))%></td>
			<td width="20%">Organization</td>
			<td width="30%"><%=Helper.correctNull((String)hshValues.get("orgname"))%>&nbsp;</td>
			</tr>
			<tr>
			<td>Created on</td>
			<td><%=Helper.correctNull((String)hshValues.get("create_date"))%>&nbsp;</td>
			<td>Sanctioned on</td>
			<td><%=Helper.correctNull((String)hshValues.get("sanc_date"))%>&nbsp;</td>
			</tr>
			<tr>
			<tr>
			<td>Sanctioned by</td>
			<td><%=Helper.correctNull((String)hshValues.get("sanc_user"))%>&nbsp;</td>
			<td>Proposal type</td>
			<td><%=Helper.correctNull((String)hshValues.get("limit_type"))%>&nbsp;</td>
			</tr>
			<tr>
			<td>CBS Account No.</td>
			<td><%=Helper.correctNull((String)hshValues.get("strCBSaccno"))%>&nbsp;</td>
			<td>Sanction Reference No.</td>
			<td><%=Helper.correctNull((String)hshValues.get("sanc_refno"))%>&nbsp;</td>
			</tr>
		</table>		
	</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
	<td>
	<%if(Helper.correctNull((String)hshValues.get("strModuleType")).equalsIgnoreCase("P")){ %>
		<table width="100%" border="0" cellpadding="2" cellspacing="0" class="outertable border1">
			<tr class="dataheader"><td colspan="4">Facility details</td></tr>
			<tr>
			<td width="20%">Application No.</td>
			<td width="30%"><%=Helper.correctNull((String)hshValues.get("inward_num"))%>&nbsp;</td>
			<td width="20%">Application Created date</td>
			<td width="30%"><%=Helper.correctNull((String)hshValues.get("inward_createdon"))%>&nbsp;</td>
			</tr>
			<tr>
			<td>Facility Nature</td>
			<td><%=Helper.correctNull((String)hshValues.get("fac_nature"))%>&nbsp;</td>
			<td>Facility Description</td>
			<td><%=Helper.correctNull((String)hshValues.get("fac_desc"))%>&nbsp;</td>
			</tr>
			<tr>
			<td>Proposed Limit</td>
			<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshValues.get("fac_proposed")))%>&nbsp;</td>
			<td>Sanctioned Limit</td>
			<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshValues.get("fac_sanctioned")))%>&nbsp;</td>
			</tr>
			<tr>
			<td>Loan Period</td>
			<td><%=Helper.correctNull((String)hshValues.get("loan_period"))%>&nbsp;</td>
			<td>Holiday Period</td>
			<td><%=Helper.correctNull((String)hshValues.get("holiday_period"))%>&nbsp;</td>
			</tr>
			<tr>
			<td>Interest Type</td>
			<td><%=Helper.correctNull((String)hshValues.get("int_type"))%>&nbsp;</td>
			<td>Periodicity of Installments</td>
			<td><%=Helper.correctNull((String)hshValues.get("strInsFreq"))%>&nbsp;</td>
			</tr>
			<tr>
			<tr>
			<td>Interest rate defined</td>
			<td><%=Helper.correctNull((String)hshValues.get("fac_intrate"))%>&nbsp;</td>
			<td>Interest rate sanctioned</td>
			<td><%=Helper.correctNull((String)hshValues.get("fac_sancintrate"))%>&nbsp;</td>
			</tr>
			<tr>
			<td>Govt. Sponsor Scheme</td>
			<td><%=Helper.correctNull((String)hshValues.get("govt_scheme"))%>&nbsp;</td>
			<td>Repayment Type</td>
			<td><%=Helper.correctNull((String)hshValues.get("strRepayType"))%>&nbsp;</td>
			</tr>
			<%if(Helper.correctNull((String)hshValues.get("govt_scheme")).equalsIgnoreCase("Yes")){ %>
			<tr id="govt1">
			<td>Scheme Type</td>
			<td><%=Helper.correctNull((String)hshValues.get(""))%>&nbsp;</td>
			<td>Subsidy Amount</td>
			<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshValues.get("")))%>&nbsp;</td>
			</tr>
			<tr id="govt2">
			<td>Sponsor Agency</td>
			<td><%=Helper.correctNull((String)hshValues.get(""))%>&nbsp;</td>
			<td>Subsidy type</td>
			<td><%=Helper.correctNull((String)hshValues.get(""))%>&nbsp;</td>
			</tr>
			<%} %>
			
		</table>	
	<%}else {%>
		<table width="100%" border="0" cellpadding="2" cellspacing="0" class="outertable border1">
			<tr class="dataheader"><td colspan="4">Facility details</td></tr>
			<tr>
			<td width="20%">Application No.</td>
			<td width="30%"><%=Helper.correctNull((String)hshValues.get("inward_num"))%>&nbsp;</td>
			<td width="20%">Application Created date</td>
			<td width="30%"><%=Helper.correctNull((String)hshValues.get("inward_createdon"))%>&nbsp;</td>
			</tr>
			<tr>
			<td>Facility Nature</td>
			<td><%=Helper.correctNull((String)hshValues.get("fac_nature"))%>&nbsp;</td>
			<td>Facility Description</td>
			<td><%=Helper.correctNull((String)hshValues.get("fac_desc"))%>&nbsp;</td>
			</tr>
			<tr>
			<td>Proposed Limit</td>
			<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshValues.get("fac_proposed")))%>&nbsp;</td>
			<td>Sanctioned Limit</td>
			<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshValues.get("fac_sanctioned")))%>&nbsp;</td>
			</tr>
			<tr>
			<td>Loan Period</td>
			<td><%=Helper.correctNull((String)hshValues.get("loan_period"))%>&nbsp;</td>
			<td>Holiday Period</td>
			<td><%=Helper.correctNull((String)hshValues.get("holiday_period"))%>&nbsp;</td>
			</tr>
			<tr>
			<td>Interest Type</td>
			<td><%=Helper.correctNull((String)hshValues.get("int_type"))%>&nbsp;</td>
			<td>Interest Sub Type</td>
			<td><%=Helper.correctNull((String)hshValues.get("strIntSubtype"))%>&nbsp;</td>
			</tr>
			<tr>
			<tr>
			<td>Interest rate defined</td>
			<td><%=Helper.correctNull((String)hshValues.get("fac_intrate"))%>&nbsp;</td>
			<td>Interest rate sanctioned</td>
			<td><%=Helper.correctNull((String)hshValues.get("fac_sancintrate"))%>&nbsp;</td>
			</tr>
			<tr>
			<td>Proposed Banking Arrangement</td>
			<td><%=Helper.correctNull((String)hshValues.get("strBankArrgmt"))%>&nbsp;</td>
			<td>Leader bank Name</td>
			<%if(Helper.correctNull((String)hshValues.get("strBankArrgmt")).equalsIgnoreCase("Consortium")){ %>
			<td><%=Helper.correctNull((String)hshValues.get("leader_bank"))%>&nbsp;</td>
			<%} else {%>
			<td>Not Applicable&nbsp;</td>
			<%} %>
			</tr>
			<tr>
			<td>Periodicity of Installments</td>
			<td><%=Helper.correctNull((String)hshValues.get("strInsFreq"))%>&nbsp;</td>
			<td>Repayment Type</td>
			<td><%=Helper.correctNull((String)hshValues.get("strRepayType"))%>&nbsp;</td>
			</tr>
			<tr>
			<td>Govt. Sponsor Scheme</td>
			<td><%=Helper.correctNull((String)hshValues.get("govt_scheme"))%>&nbsp;</td>
			<td>Due date</td>
			<td><%=Helper.correctNull((String)hshValues.get("due_date"))%>&nbsp;</td>
			</tr>
			<tr>
			<td>Processing Charges</td>
			<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshValues.get("com_processingfee")))%>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			</tr>
			<%if(Helper.correctNull((String)hshValues.get("govt_scheme")).equalsIgnoreCase("Yes")){ %>
			<tr id="govt1">
			<td>Scheme Type</td>
			<td><%=Helper.correctNull((String)hshValues.get("scheme_type"))%>&nbsp;</td>
			<td>Subsidy Amount</td>
			<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshValues.get("subsidy_amount")))%>&nbsp;</td>
			</tr>
			<tr id="govt2">
			<td>Sponsor Agency</td>
			<td><%=Helper.correctNull((String)hshValues.get("spons_agency"))%>&nbsp;</td>
			<td>Subsidy type</td>
			<td><%=Helper.correctNull((String)hshValues.get("subs_type"))%>&nbsp;</td>
			</tr>
			<%} %>
		</table>
	<%} %>
	</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
	<td>
		<table width="100%" border="0" cellpadding="2" cellspacing="0" class="outertable border1">
			<tr class="dataheader"><td colspan="5">Attached Security details</td></tr>
			<tr class="datagrid">
			<td width="15%" align="center">Security Id</td>
			<td width="40%" align="center">Security Type</td>
			<td width="10%" align="center">Attached as</td>
			<td width="20%" align="center">Security Value</td>
			<td width="15%" align="center">Margin</td>
			</tr>
			
			<!-- Loop for security array -->
			<%if(arrSecRow!=null && arrSecRow.size()>0)
			{
				for(int i=0;i<arrSecRow.size();i++)
				{ arrSecCol = (ArrayList)arrSecRow.get(i); %>
					<tr>
					<td><%=Helper.correctNull((String) arrSecCol.get(0))%></td>
					<td><%=Helper.correctNull((String) arrSecCol.get(1))%></td>
					<td><%=Helper.correctNull((String) arrSecCol.get(2))%></td>
					<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String) arrSecCol.get(3)))%>&nbsp;</td>
					<td><%=Helper.correctNull((String) arrSecCol.get(4))%></td>
					</tr>
				<%}
			}else
				{%>
					<tr>
					<td colspan="5"  align="center">No securities attached</td>
					</tr>
				<%} %>
			
			<!-- End of loop -->
		</table>		
	</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
	<td>
		<table width="100%" border="0" cellpadding="2" cellspacing="0" class="outertable border1">
			<tr class="dataheader"><td colspan="5">Repayment schedule details</td></tr>
			<tr class="datagrid">
					<td align="center" width="4%"><b>S.No</b></td>
					<td align="center" width="32%"><b>Frequency</b></td>
					<td align="center" width="20%"><b>No of Installments</b></td>
					<td align="center" width="20%"><b>Installment Amount</b></td>
					<td align="center" width="20%"><b>Total</b></td>
					</tr>
					<%
					String strFreq = "",strDesc="";
					if(arrRepayScheduleRow!=null && arrRepayScheduleRow.size()>0)
					{
						for(int count = 0;count<arrRepayScheduleRow.size();count++)
						{					
						arrRepayScheduleCol = new ArrayList();
					    arrRepayScheduleCol = (ArrayList)arrRepayScheduleRow.get(count);
					    strFreq = Helper.correctInt((String)arrRepayScheduleCol.get(0));
					    if(strFreq.equalsIgnoreCase("m"))
			    		{
					    	strDesc = "Monthly";
			    		}					    
					    else if(strFreq.equalsIgnoreCase("q"))
			    		{
					    	strDesc = "Quarterly";
			    		}
					    else if(strFreq.equalsIgnoreCase("h"))
			    		{
					    	strDesc = "Half-Yearly";
			    		}
					    else if(strFreq.equalsIgnoreCase("y"))
			    		{
					    	strDesc = "yearly";
			    		}
					    else if(strFreq.equalsIgnoreCase("n"))
			    		{
					    	strDesc = "Not Applicable";
			    		}
					    %>
					    <tr>
					    <td><%=count+1%></td>
					    <td><%=strDesc%></td>
					    <td align="right"><%=Helper.correctInt((String)arrRepayScheduleCol.get(1))%></td>
					     <td align="right"><%=Helper.checkDecimal(Helper.correctInt((String)arrRepayScheduleCol.get(3)))%></td>
					    <td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrRepayScheduleCol.get(2)))%></td>
					    </tr>						    						    					
						<%}%>
					<tr>
					    <td colspan="4" align="right"><b>Total :</b>&nbsp;&nbsp;</td>					    
					    <td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshValues.get("RepaySheduleTotal")))%></td>
					</tr>
					<%}else{ %>
					<tr>
					<td colspan="5"  align="center">No data found</td>
					</tr>
					<%} %>
			
			<!-- End of loop -->
		</table>		
	</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
	<td>	<!-- Guhan MIS page -->
		<table width="100%" border="0" cellpadding="2" cellspacing="0" class="outertable border1">
			<tr class="dataheader"><td colspan="4">MIS details</td></tr>
			<tr>
				<td>Bank's Scheme</td>
				<td colspan="3"><select name="sel_BankScheme" style="width: 70%" tabindex="1">
					<option value="" selected="selected">--Select--</option>
               		<lapschoice:BanksSchemeStaticDataNewTag apptype="1" />
					</select>
				</td>
			</tr>
			<tr>
				<td width="20%">Loan Amount</td>
				<td width="30%" align="right"><%=Helper.checkDecimal(Helper.correctDouble((String)hshValues.get("strLoanAmt")))%></td>
				<td width="20%">Total Limit of the Borrower</td>
				<td width="20%" align="right"><%=Helper.checkDecimal(Helper.correctDouble((String)hshValues.get("app_totlim")))%></td>
			</tr>
			<tr>
				<td>Total Limit of the Borrower(Under Service Category)</td>
				<td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String)hshValues.get("app_totlimser")))%></td>
				<td>Total Limit of the Borrower(Under Agriculture Category)</td>
				<td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String)hshValues.get("app_totlimagri")))%></td>
			</tr>
			<tr class="datagrid"><td colspan="4"><b>Utilization of Credit</b></td></tr>
				<tr>
					<td>City</td>
					<td><%=Helper.correctNull((String)hshValues.get("strCity"))%>&nbsp;</td>
					<td>State</td>
					<td><%=Helper.correctNull((String)hshValues.get("strState"))%>&nbsp;</td>
				</tr>
				<tr>
					<td>District</td>
					<td><%=Helper.correctNull((String)hshValues.get("strDistrict"))%>&nbsp;</td>
					<td>Place</td>
					<td><select name="sel_Place" tabindex="15">
								<option value="" selected="selected">--Select--</option>
								<lapschoice:StaticDataNewTag apptype="128" />
							</select>
					</td>
				</tr>
				<tr><td class="datagrid" colspan="4"><b>Activity Code details</b></td></tr>
				<tr>
					<td>Activity Code</td>
					<td colspan="3"><%=Helper.correctNull((String)hshValues.get("app_activitycode"))%>&nbsp;</td>
				</tr>
				<tr>
					<td>Main Activity</td>
					<td colspan="3"><select name="sel_MainActivity" style="width: 80%">
						<option value="" selected="selected">--Select--</option>
						<lapschoice:MISDataTag apptype="2"/>
						</select>
					</td>
				</tr>
				<tr>
				<td>Sub Activity</td>
				<td colspan="3"><select name="sel_SubActivity" style="width: 80%">
						<option value="" selected="selected">--Select--</option>
						</select>
				</td>
				</tr>
				<tr>
				<td>Purpose</td>
				<td  colspan="3"><select name="sel_Purpose" style="width: 80%">
					<option value="" selected="selected">--Select--</option>
					<lapschoice:MISPurposeDataTag apptype="3"/>
					</select>
				</td>
				</tr>
				<tr>
				<td>BSR Code</td>
				<td colspan="3">
					<select name="sel_BSRCode" style="width: 80%">
						<option value="" selected="selected">--Select--</option>
						<lapschoice:BSRCodeTag apptype="1" />
					</select>
				</td>
				</tr>
				<tr>
				<td>BSR1 Code</td>
				<td colspan="3">
					<select name="sel_BSR1Code" style="width: 80%">
						<option value="" selected="selected">--Select--</option>
						<lapschoice:MISDataTag apptype="6"/>
					</select>
				</td>
				</tr>
				<tr id="id_IndustryType">
					<td>Industry Type</td>
					<td colspan="3">
								<select name="sel_IndustryType" style="width: 80%">
									<option value="" selected="selected">--Select--</option>
									<lapschoice:MISDataTag apptype="5"/>
								</select>
					</td>
				</tr>
				<tr>
				<td>Asset Classification</td>
				<td colspan="3">
								<select name="sel_AssetClassification" style="width: 80%">
									<option value="" selected="selected">--Select--</option>
									<lapschoice:BanksSchemeStaticDataNewTag apptype="16" />
								</select>
				</td>
				</tr>
		<tr id="id_misclassification" class="datagrid">	<td colspan="4"><b>MIS Classification</b></td>	</tr>
				<tr>
					<td>Agriculture/Industry/Service Category type</td>
							<td colspan="3">
								<select name="sel_CategoryType" style="width: 80%">
									<option value="" selected="selected">--Select--</option>
									<lapschoice:BanksSchemeStaticDataNewTag apptype="12" />
								</select>
							</td>
				</tr>
				<tr>
					<td>Sector</td>
					<td  colspan="3">
						<select name="sel_Sector" style="width: 80%">
							<option value="" selected="selected">--Select--</option>
							<option value="01">Priority Sector</option>
							<option value="02">Non Priority Sector</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>Sub sector</td>
					<td  colspan="3">
						<select name="sel_SubSector" style="width: 80%">
							<option value="" selected="selected">--Select--</option>
							<lapschoice:BanksSchemeStaticDataNewTag apptype="7" />
							<lapschoice:BanksSchemeStaticDataNewTag apptype="8" />
						</select>
					</td>
				</tr>
				<tr>
					<td>Sensitive sector</td>
					<td  colspan="3">
						<select name="sel_SensitiveSector" style="width: 80%">
							<option value="0" selected="selected">--Select--</option>
							<lapschoice:BanksSchemeStaticDataNewTag apptype="11" />
						</select>
					</td>
				</tr>
				<tr>
					<td>Weaker Section</td>
					<td  colspan="3">
						<select name="sel_WeakerSection" style="width: 80%">
							<option value="" selected="selected">--Select--</option>
							<lapschoice:BanksSchemeStaticDataNewTag apptype="9" />
						</select>
					</td>
				</tr>
				<tr>
					<td>Twenty Point Program</td>
					<td  colspan="3">
						<select name="sel_TwentyPointPgm" style="width: 80%">
							<option value="" selected="selected">--Select--</option>
							<lapschoice:BanksSchemeStaticDataNewTag apptype="10" />
						</select>
					</td>
				</tr>
				<tr>
					<td>Infrastructure Credit Type</td>
					<td colspan="3">
						<select name="sel_InfraCreditType" style="width: 80%">
							<option value="" selected="selected">--Select--</option>
							<lapschoice:BanksSchemeStaticDataNewTag apptype="22" />
						</select>
					</td>
				</tr>
				<tr>
					<td>Government announced scheme</td>
					<td>
						<select name="sel_GovtAnnounceScheme" style="width: 80%">
							<option value="" selected="selected">--Select--</option>
							<lapschoice:BanksSchemeStaticDataNewTag apptype="23" />
						</select>
					</td>
				</tr>
				<tr>
					<td>Stand Up India</td>
					<td>
						<select name="sel_StandupIndia" style="width: 80%">
							<option value="" selected="selected">--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select>
					</td>
				</tr>
		</table>
		<!-- End of MIS page -->
	</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
	<td>
		<table width="100%" border="0" cellpadding="2" cellspacing="0" class="outertable border1">
			<tr class="dataheader"><td colspan="4">CBS details</td></tr>
			<tr>
			<td width="20%">Nature of Advance </td>
			<td width="30%">
				<select name="sel_advancenature" tabindex="1" style="width: 90%">
     				<option value="" selected="selected">--Select--</option>
					<lapschoice:CBSStaticDataNewTag apptype="21" />
    			</select>
    		</td>
			<td width="20%">Mode of Operation </td>
			<td width="30%">
				<select name="sel_mode" tabindex="1" style="width: 90%">
     				<option value="0" selected="selected">--Select--</option>
					<lapschoice:CBSStaticDataNewTag apptype="17" />
    			</select>
    		</td>
		</tr>
		<tr>
			<td>Drawing Power Indicator </td>
			<td>
				<select name="sel_power_indicator" onChange="getdrawingPower();" tabindex="3" style="width: 90%">
      				<option value="0" selected="selected">--Select--</option>
					<lapschoice:CBSStaticDataNewTag apptype="16" />
     			</select>
     		</td>
     		<td>Type of Advance </td>
			<td>
				<select name="sel_advancetype" tabindex="1" style="width: 90%">
     				<option value="" selected="selected">--Select--</option>
					<lapschoice:CBSStaticDataNewTag apptype="22" />
    			</select>
    		</td>
		</tr>
		<tr>
			<td>Drawing Power </td>
			<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshValues.get("drwingpwr")))%>&nbsp;</td>
			<td>Mode of Advance</td>
			<td>
				<select name="sel_advancemode" tabindex="1" style="width: 90%">
     				<option value="" selected="selected">--Select--</option>
					<lapschoice:CBSStaticDataNewTag apptype="23" />
    			</select>
    		</td>
		</tr>
		<tr>
			<td>Interest Rate Frequency&nbsp;</td>
			<td><select name="selintrate" tabindex="18">
				<option value="M" selected="selected">Monthly</option>
				<option value="Q">Quartely</option>
				<option value="H">Half-yearly</option>
				<option value="Y">Yearly</option>
			</select></td>
			<td>Purpose of Advance </td>
			<td>
				<select name="sel_advancepurpose" tabindex="1" style="width: 90%">
     				<option value="" selected="selected">--Select--</option>
					<lapschoice:CBSStaticDataNewTag apptype="24" />
    			</select>
    		</td>
		</tr>
		<tr>
			<td>Free Code 3 </td>
      		<td> 
       			<select name="sel_freecode3" tabindex="2" style="width: 90%">
      				<option value="" selected="selected" >--Select--</option>
					<lapschoice:StaticDataNewTag apptype="129" />
    			</select>
			</td>
			<td width="20%">
				LBR Code
			</td>
			<td>
				<select name="sel_LBRCode" style="width: 90%">
				<option value="">--Select--</option>
				<lapschoice:MISDataTag apptype="21"/>
				</select>
			</td>
			</tr>
		<tr>
			<td>Free Code 6 </td>
      		<td> 
       			<select name="sel_freecode6" tabindex="2" onchange="changeFreeCode7()" style="width: 90%">
      				<option value="0" selected="selected" >--Select--</option>
					<lapschoice:StaticDataNewTag apptype="127" />
    			</select>
			</td>
			<td>Loan Disbursing Branch </td>
			<td><%=Helper.correctNull((String)hshValues.get("strOrgName"))%>&nbsp;</td>
		</tr>
		<tr>
			<td>Free Code 7 </td>
      		<td> 
       			<select name="sel_freecode7" tabindex="4" onchange="changeFreeCode8(document.forms[0].sel_freecode7.value);setText7();" style="width: 90%">
      				<option value="" selected="selected">--Select--</option> 
    			</select>
			</td>
			<td rowspan="2">Gist of Securities<input type="hidden" name="sel_securitycode" value=""></td>
			<td rowspan="2"><textarea name="txt_gistofsecurities" rows="3" cols="40" onKeyPress="textlimitcorp1(this,'240');if(event.keyCode==13){return false;}" onkeyup="textlimitcorp1(this,240);" onkeydown="textlimitcorp1(this,240);" wrap="VIRTUAL"><%=Helper.correctNull((String)hshValues.get("CER_GISTOFSECURITUES"))%></textarea></td>
		</tr>
		<tr>
			<td>Free Code 8 </td>
      		<td> 
       			<select name="sel_freecode8" tabindex="6" onchange="setText8();" style="width: 90%">
      				<option value="" selected="selected">--Select--</option>
    			</select>
			</td>
		</tr>
		
		<tr>
			<td>LAPS code 1 </td>
			<td>
				<select name="sel_lapscode1" tabindex="1" style="width: 90%">
     				<option value="" selected="selected">--Select--</option>
					<lapschoice:StaticDataNewTag apptype="183" />
    			</select>
    		</td>
			<td>LAPS code 2 </td>
			<td>
				<select name="sel_lapscode2" tabindex="1" style="width: 90%">
     				<option value="" selected="selected">--Select--</option>
					<lapschoice:StaticDataNewTag apptype="184" />
    			</select>
    		</td>
		</tr>
		<tr>
			<td>LAPS code 3</td>
			<td>
				<select name="sel_lapscode3" tabindex="1" style="width: 90%">
     				<option value="" selected="selected">--Select--</option>
					<lapschoice:StaticDataNewTag apptype="185" />
    			</select>
    		</td>
    	</tr>
		</table>		
	</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
</table>

<lapschoice:hiddentag pageid='<%=PageId%>'/>
<iframe height="0" width="0" id="ifrm" frameborder="0" style="border: 0"></iframe> 
<iframe height="0" width="0" id="ifrm2" frameborder="0" style="border:0" ></iframe>
<iframe height="0" width="0" id="ifrm1" frameborder="0" style="border:0" ></iframe>
<input type="hidden" name="hidFreeCode7">
<input type="hidden" name="hidFreeCode8">
</form>
</body>
</html>