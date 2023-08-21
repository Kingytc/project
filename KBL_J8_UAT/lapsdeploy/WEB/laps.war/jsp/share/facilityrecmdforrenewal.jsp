<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	arrRow = (ArrayList) hshValues.get("arrRow");
	String strSector = Helper.correctNull((String) request
			.getParameter("hidsector"));
	String strSaral = Helper.correctNull((String) request
			.getParameter("hidsaral"));
	String strApploantype = Helper.correctNull((String) request
			.getParameter("apploantype"));
	String strApplevel = Helper.correctNull((String) request
			.getParameter("applevel"));

	String strValuesin = Helper.correctNull((String) request
			.getParameter("valuesin"));

	if (strValuesin.equals("L")) {
		strValuesin = " in Lacs";
	} else {
		strValuesin = "";
	}
	String strappholder = Helper.correctNull((String) request
			.getParameter("appholder"));
	String strappliedfor = Helper.correctNull((String) request
			.getParameter("appliedfor"));
	String strProposal = Helper.correctNull(request
			.getParameter("hidproposal"));
	
	//Added by Zahoorunnisa.S for button functionality
    String strapplevel = Helper.correctNull((String)request.getParameter("applevel"));
	String strstatus = Helper.correctNull((String) request.getParameter("hidstatus"));
	if (strstatus.equals(""))
		strstatus = Helper.correctNull((String) hshValues.get("status"));
		//end
%>

<html>
<head>
<title>Facility For Recommendation</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"> </script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varOrgLevel="<%=strOrgLevel%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";
function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16)
{
	document.forms[0].hidsno.value=val2;	
	document.forms[0].txt_factype.value=val4;
	document.forms[0].txt_limit.value=val5;
	document.forms[0].txt_outstanding.value=val6;
	document.forms[0].txt_stock.value=val7;
	document.forms[0].txt_drawingpower.value=val8;
	document.forms[0].txt_maxavailment.value=val9;
	document.forms[0].txt_minavailment.value=val10;
	document.forms[0].txt_turnoverdebit.value=val11;
	document.forms[0].txt_turnovercredit.value=val12;
	document.forms[0].txt_avgutil.value=val13;
	document.forms[0].txt_amtcommission.value=val14;
	document.forms[0].txt_overdue.value=val15;
	document.forms[0].txt_cbsaccno.value=val16;
		
	//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh

	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		if("<%=strstatus%>"=="O"  &&  varright=="w"){
		    enableButtons(true,false,true,true,true,false);
		}else{
			enableButtons(true,true,true,true,true,false);	
		}
			
	} else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		
		enableButtons(true,true,true,true,true,false);	
		
    }else{
		
		if("<%=strapplevel%>" == "S"){
			enableButtons(true,true,true,true,true,false);
		}else{
			if(document.forms[0].btnenable.value=="Y"){
				enableButtons(true,false,true,true,true,false);
				
			}else {
				
				enableButtons(true,true,true,true,true,false);
			}
		}

		
	}

	//End
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text'  )
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=='textarea'  )
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=='select-one'  )
		{
			document.forms[0].elements[i].disabled=val;
		}
	}
}

function onloading()
{	  
	//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh
	
	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		if("<%=strstatus%>"=="O"  &&  varright=="w"){
		    enableButtons(false,true,true,true,true,false);
		}else{
			enableButtons(true,true,true,true,true,false);	
		}
			
	} else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		
		enableButtons(true,true,true,true,true,false);
			
    }else{
		
		if("<%=strapplevel%>" == "S"){
			enableButtons(true,true,true,true,true,false);
		}
	}

	//End

	disableFields(true);
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	document.forms[0].hideditflag.value="Y";
	disableCommandButtons(true,true,false,false,false,true);
	document.forms[0].txt_factype.focus();
}

function doSave()
{
    if(document.forms[0].txt_asondate.value=="")
	{    	 
	 	ShowAlert('121','As on');	
	 	return false;
	}
    document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="inwardRegister";		
	document.forms[0].hidSourceUrl.value="/action/facilityrecmdforrenewal.jsp";
	document.forms[0].hidBeanMethod.value="updateAccountOperationalDetails";
	document.forms[0].hidBeanGetMethod.value="getAccountOperationalDetails";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doDelete()
{
	if(varRecordFlag=="Y")
	{
	 	if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value ="delete";
			document.forms[0].hidBeanMethod.value="updateAccountOperationalDetails";
			document.forms[0].hidBeanGetMethod.value="getAccountOperationalDetails";	
			document.forms[0].hidBeanId.value="inwardRegister";
			document.forms[0].hidSourceUrl.value="action/facilityrecmdforrenewal.jsp";	
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();	
	 	}	
    }
	else
	{
		ShowAlert(158);
	}
}	

function doNew()
{
	disableFields(false);
    document.forms[0].hidAction.value ="insert";
    document.forms[0].hideditflag.value="Y";
    disableCommandButtons(true,true,false,true,false,true);
  	document.forms[0].txt_factype.value.value='';
	document.forms[0].txt_limit.value='';
	document.forms[0].txt_outstanding.value='';
	document.forms[0].txt_stock.value='';
	document.forms[0].txt_drawingpower.value='';
	document.forms[0].txt_maxavailment.value='';
	document.forms[0].txt_minavailment.value='';
	document.forms[0].txt_turnoverdebit.value='';
	document.forms[0].txt_turnovercredit.value='';
	document.forms[0].txt_avgutil.value='';
	document.forms[0].txt_amtcommission.value='';
	document.forms[0].txt_overdue.value='';
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="inwardRegister";
		document.forms[0].hidBeanGetMethod.value="getAccountOperationalDetails";
		document.forms[0].action=appURL+"action/facilityrecmdforrenewal.jsp";
		document.forms[0].submit();
	}
}
   
function disableCommandButtons(cmdnew, cmdedit, cmdapply, cmddel, cmdcancel, cmdclose)
{  
	document.forms[0].cmdnew.disabled =cmdnew;
	document.forms[0].cmdedit.disabled=cmdedit;	  
	document.forms[0].cmdsave.disabled=cmdapply;
	document.forms[0].cmddelete.disabled=cmddel;
	document.forms[0].cmdcancel.disabled=cmdcancel;
	document.forms[0].cmdclose.disabled=cmdclose;
}
 
function doClose()
{
	if(ConfirmMsg(100))
	{
		if(document.forms[0].hidsaral.value=="saral")
		{
			document.forms[0].method="post";
			document.forms[0].action=appURL+"action/mainnav.jsp";
			document.forms[0].submit();
		}
		else
		{
			document.forms[0].method="post";
			document.forms[0].action=appURL+"action/corppge.jsp";
			document.forms[0].submit();
		}
	}
}
 
function enableButtons(valnew, valedit, valapply, valcancel, valdel, valclose)
{
	document.forms[0].cmdnew.disabled=valnew;
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
}

function callCalender(fname)
{
 	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}
function comparedate(date1,date2)
{	
	var pgdt=changeDateformat(date1);
	var maxdt=changeDateformat(date2);
	if(pgdt.value!="")
	{
		if(Date.parse(pgdt) > Date.parse(maxdt))
		{
			alert("To Date cannot be lesser than From Date");
			document.forms[0].txt_todate.value="";
			document.forms[0].txt_todate.focus();								
		}			
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form method="post" name="frmbrrecmd" class="normal">
<%
	if (strSaral.equalsIgnoreCase("saral")) {
%> <lapschoice:saralreportTag tabid="8" sector='<%=strSector%>'
	applied='<%=strappliedfor%>' proposal='<%=strProposal%>' /> <lapschoice:inward />
<%
	} else if (strApploantype.equalsIgnoreCase("c")||strApploantype.equalsIgnoreCase("a")) {
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="15" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Corporate&nbsp;&amp;
		SME -&gt;&nbsp;Proposal&nbsp;-&gt; &nbsp;Business Turn
		Over&nbsp;-&gt;&nbsp;Account Operational Details</td>
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%
	} else if (strApploantype.equalsIgnoreCase("T")) {
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top"><jsp:include
			page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="10" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<b><i>Home -&gt; Tertiary -&gt; Application -&gt; Reports -&gt;
Recommendation by Branch</i></b> 
<span style="display: none"><lapschoice:borrowertype /></span>
<lapschoice:application /> <lapstab:TerReportTab tabid="3"
	applevel='<%=strApplevel%>' applied='<%=strappliedfor%>' /> <%
 	} else if ((strCategoryType.equals("ADC"))) {
 %>
<table border="0" width="100%" class="outertable">
	<tr>
		<td valign="top"><jsp:include
			page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="12" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Adhoc
		Limit -&gt; Business Turn Over -&gt; Account Operational Details</td>
	</tr>
	<tr>
		<td><span style="display: none"><lapschoice:borrowertype /></span><lapschoice:application />
		</td>
	</tr>
</table>
<%
	}
%>
<table border="0" cellspacing="1" cellpadding="3" class="outertable"
	width="60%">
	<tr>
		<td class="sub_tab_active" align="center"><b>
		 Term Loan </b></td>
		<td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getOdCcLimits','facilityremdforbusiess.jsp')"
			onMouseOut="window.status='';return true;">Conduct of Working Capital Facilities</a> </b></td>
		<td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getBusinessOperationsDetails','facilityremdforadverse.jsp?hidbustype=AF')"
			onMouseOut="window.status='';return true;">Non Funded Loans</a> </b></td>
		<td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','compro','getFinancialComments','facilityremdforinstallment.jsp?hidbustype=DI')"
			onMouseOut="window.status='';return true;">Comments</a> </b></td>
	   <td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getOthersDetails','com_others.jsp')"
			onMouseOut="window.status='';return true;">Others</a> </b></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="80%" border="0" cellspacing="0" cellpadding="0"
							align="center" class="outertable border1">
							<tr>
								<td>
								<table width="100%" border="0" class="outertable">
									<tr>
										<td valign="top">As on<b><span class="mantatory">*&nbsp;</span></b></td>
										<td valign="top"><input type="text" name="txt_asondate"
											value="<%=Helper.correctNull((String) hshValues
							.get("accoprationalasondate"))%>"
											size="13" maxlength="10"
											onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')">
										<a alt="Select date from calender"
											href="javascript:callCalender('txt_asondate')"> <img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											width="21" border="0"></a></td>
											<%
						if (strSaral.equalsIgnoreCase("saral")) {
					%>
									<td valign="top" align="right" colspan="2"><span class="mantatory"><b>(<%=ApplicationParams.getCurrency()%><%=strValuesin%>)</b></span></td>	
										<%
							}else{
											
						%>
						<td valign="top" colspan="2">&nbsp;</td>
						<%} %>
									</tr>
									<tr>
										<td width="25%">Facility</td>
										<td width="16%"><input type="text" name="txt_factype"
											size="25" maxlength="50"></td>
										<td width="29%">CBS AccountNo</td>
										<td width="30%"><input type="text" name="txt_cbsaccno"
											size="18" maxlength="15" onKeyPress="allowNumber(this)">
										</td>
									</tr>
									<tr>
										<td>Limit</td>
										<td><lapschoice:CurrencyTag name="txt_limit" size="18"
											maxlength="12" /></td>
										<td width="29%">Outstanding</td>
										<td width="30%"><lapschoice:CurrencyTag
											name="txt_outstanding" size="18" maxlength="12" /></td>
									</tr>
									<tr>
										<td>Total Value of Security</td>
										<td><lapschoice:CurrencyTag name="txt_stock" size="18"
											maxlength="12" /></td>
										<td width="29%">Drawing Power</td>
										<td width="30%"><lapschoice:CurrencyTag
											name="txt_drawingpower" size="18" maxlength="12" /></td>
									</tr>
									<tr>
										<td>Present Overdues/ Excess</td>
										<td><lapschoice:CurrencyTag name="txt_overdue" size="18"
											maxlength="12" /></td>
										<td width="29%">&nbsp;</td>
										<td width="30%">&nbsp;</td>
									</tr>
									<tr>
										<td colspan="4">
										<hr />
										</td>
									</tr>
									<tr>
										<td width="29%">From Date</td>
										<td width="30%"><input type="text" name="txt_fromdate"
											value="<%=Helper.correctNull((String) hshValues
							.get("accntoper_fromdate"))%>"
											size="13" maxlength="10"
											onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')">
										<a alt="Select date from calender"
											href="javascript:callCalender('txt_fromdate')"> <img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											width="21" border="0"></a></td>
										<td>To Date</td>
										<td width="30%"><input type="text" name="txt_todate"
											value="<%=Helper.correctNull((String) hshValues
							.get("accntoper_todate"))%>"
											size="13" maxlength="10"
											onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>');comparedate(document.forms[0].txt_fromdate.value,document.forms[0].txt_todate.value)">
										<a alt="Select date from calender"
											href="javascript:callCalender('txt_todate')"> <img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											width="21" border="0"></a></td>
									</tr>
									
									<tr>
										<td width="29%">Maximum Availment</td>
										<td width="30%"><lapschoice:CurrencyTag
											name="txt_maxavailment" size="18" maxlength="12" /></td>
										<td>Minimum Availment</td>
										<td><lapschoice:CurrencyTag name="txt_minavailment"
											size="18" maxlength="12" /></td>
									</tr>
									<tr>
										<td width="29%">Turnover Debit</td>
										<td width="30%"><lapschoice:CurrencyTag
											name="txt_turnoverdebit" size="18" maxlength="12" /></td>
										<td>Turnover Credit</td>
										<td><lapschoice:CurrencyTag name="txt_turnovercredit"
											size="18" maxlength="12" /></td>
									</tr>
									<tr>
										<td width="29%">Average Utilization</td>
										<td width="30%"><lapschoice:CurrencyTag
											name="txt_avgutil" size="18" maxlength="12" /></td>
										<td width="29%">Amount of Income/ Commission</td>
										<td width="30%"><lapschoice:CurrencyTag
											name="txt_amtcommission" size="18" maxlength="12" /></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						<lapschoice:combuttonnew
							btnnames='New_Edit_Save_Cancel_Delete_Audit Trail'
							btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="3"
									class="outertable linebor">
									<tr class="dataheader">
										<td width="5%">&nbsp;</td>
										<td align="CENTER" width="20%"><b>Facility</b></td>
										<td align="CENTER" width="20%"><b>Limit Sanc</b></td>
										<td align="CENTER" width="15%"><b>Outstanding</b></td>
										<td align="CENTER" width="22%"><b>Drawing Power</b></td>
										<td align="CENTER" width="18%" nowrap="nowrap"><b>Turnover
										Debit</b></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td>
								<%
									if (arrRow.size() > 6) {
								%><div class="cellContainer">
								<%
									}
								%>
								<table width="100%" border="0" cellspacing="1" cellpadding="3"
									class="outertable">
									<%
										if (arrRow != null && arrRow.size() > 0) {
											if (arrRow.size() > 0) {
												for (int i = 0; i < arrRow.size(); i++) {
													arrCol = (ArrayList) arrRow.get(i);
									%>
									<tr class="datagrid">
										<td width="5%" align="center"><input type="radio"
											style="border: none" name="rdoUser"
											onClick="javascript:selectValues(
						'<%=Helper.correctNull((String) arrCol.get(0))%>'
						,'<%=Helper.correctNull((String) arrCol.get(1))%>'
						,'<%=Helper.correctNull((String) arrCol.get(2))%>'	
						,'<%=Helper.correctNull((String) arrCol.get(3))%>'
						,'<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(4))))%>'
						,'<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(5))))%>'
						,'<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(6))))%>'
						,'<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(7))))%>'
						,'<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(8))))%>'
						,'<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(9))))%>'
						,'<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(10))))%>'
						,'<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(11))))%>'
						,'<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(12))))%>'
						,'<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(13))))%>'
						,'<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(14))))%>'
						,'<%=Helper.correctNull((String) arrCol.get(15))%>'
						)">
										</td>
										<td width="20%">&nbsp; <%=Helper.correctNull((String) arrCol.get(3))%></td>
										<td width="20%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(4))))%></td>
										<td width="15%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(5))))%></td>
										<td align="right" width="22%">&nbsp;<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(7))))%></td>
										<td align="right" width="18%">&nbsp;<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(10))))%></td>
									</tr>
									<%
										}
											}
									%>
									<%
										if (arrRow.size() > 6) {
									%>
									<%
										}
									%>
									<%
										} else {
									%>
									<tr class="datagrid">
										<td align="center" colspan="6">No Data Found</td>
									</tr>
									<%
										}
									%>
								</table>
								</div>
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
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="hidsno"> <input type="hidden" name="cattype"
	value="<%=strCategoryType%>"> <input type="hidden"
	name="ssitype" value="<%=strSSIType%>"></form>

</body>
</html>
