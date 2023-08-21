<%@include file="../share/directives.jsp"%>
<%ArrayList vecRow = new ArrayList();
			ArrayList vecCol = new ArrayList();
			String strgenid = "";
			int vecrowsize = 0;
			if (hshValues.size() > 0 && hshValues != null) {
				vecRow = (ArrayList) hshValues.get("vecRow");
				vecrowsize = vecRow.size();
				if (vecrowsize > 0)
					for (int i = 0; i < 10; i++) {
						vecCol = (ArrayList) vecRow.get(i);
						strgenid = strgenid
								+ Helper.correctNull((String) vecCol.get(0)) + ",";
					}
				if (!strgenid.equals("")) {
					strgenid = strgenid.substring(0, (strgenid.length()) - 1);
				}
			} else {
				strgenid = "0";
			}
			String strBorrowerType = Helper.correctNull((String) request.getParameter("hidBorrowerType"));
			String strcat = "";
			if (!strCategoryType.equalsIgnoreCase("")) {
				if (strCategoryType.equalsIgnoreCase("OPS")) {
					strcat = "Tertiary";
				} else {
					strcat = "Corporate";
				}
			}%>
<html>
<head>
<title>Small Scale Industries</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var genid = "<%=strgenid%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varRecordflag = "<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
function callDisable(one)
{
	for( i=1;i<=9;i++)		
	{	
		document.forms[0].elements["txt_costofprojectraised1"+i].readOnly=one;
		document.forms[0].elements["txt_costofprojectraised2"+i].readOnly=one;	
	}
	document.forms[0].comm1.readOnly=one;
	document.forms[0].comm2.readOnly=one;
	document.forms[0].comm3.readOnly=one;
	document.forms[0].comm4.readOnly=one;
	document.forms[0].comm5.readOnly=one;
}
function totalreadOnly()
{
	for( i=1;i<=10;i++)		
	{	
		document.forms[0].elements["txt_costofprojectraised3"+i].readOnly=true;
	}		
}
function disableControls(bcmdEdit,bcmdApply,bcmdCancel,bcmddel,bcmdClose)
{
	document.forms[0].cmdedit.disabled=bcmdEdit;
	document.forms[0].cmdsave.disabled=bcmdApply;
	document.forms[0].cmdcancel.disabled=bcmdCancel;
	document.forms[0].cmddelete.disabled=bcmddel;
	document.forms[0].cmdclose.disabled=bcmdClose;
}
function onloading()
{	
	document.forms[0].hidGenID.value=genid;
	totalreadOnly();
	callDisable(true);
	document.forms[0].hidparam.value="CAPITAL^RESERVES^TERMLOANS^UNSECUREDLOANS^DEFERREDPAYMENTS^SUBSIDYGOVT^SEEDCAPITAL^INTERNALCASHACCRUALS^OTHERSOURCES";
	document.forms[0].hidTabName.value="MeansOfFinancing";
	document.forms[0].hidMethod.VALUE="getCostofProject";
}
function doEdit()
{
	callDisable(false);
	disableControls(true,false,false,false,true);
	document.forms[0].hideditflag.value="Y";
}
function doSave()
{	
	document.forms[0].hidRecordflag.value = varRecordflag;
	document.forms[0].hidMethod.value="getCostofProject";
	document.forms[0].hidBeanMethod.value="updateCostofProjectData";
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].hidSourceUrl.value="/action/ssi_above10_meansoffinancing.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	document.forms[0].hidAction.value="Delete";
	if(varRecordflag == "Y"){
	if(ConfirmMsg("101"))
    {
	document.forms[0].hidMethod.value="getCostofProject";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].hidBeanMethod.value="updateCostofProjectData";
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].hidSourceUrl.value="/action/ssi_above10_meansoffinancing.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
    }
	}

	
	
}
function doCancel()
{	
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidMethod.value="getCostofProject";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].action=appUrl+"action/ssi_above10_meansoffinancing.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{ 
		document.forms[0].action=appUrl+"action/agrpage.jsp";
		document.forms[0].submit();
	 }
}
</script>
</head>
<body onload="onloading()">
<form name="fininc" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="20" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
				<td class="page_flow">Home -&gt; <%=strcat%>-&gt; Application-&gt; Cost &amp; Means -&gt;Means of Financing</td>
			</tr>
</table>
<span style="display:none"><lapschoice:borrowertype /></span><lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<table width="70%" border="0" cellspacing="1" cellpadding="3" class="utertable">
			<tr align="center">
				<td class="sub_tab_inactive"><b><a
					href="javascript:callFunction('ssi_above10_costofprojectincurred.jsp','getCostofProject','LAND^BULIDING^INDIGENOUSPLANTMC^IMPORTEDPLANTMC^TOOLSSPARES^TESTEQUIPMENTS^MISCFIXEDASSETS^INSTALLATIONCHRG^PRELIMEXPEMSES^PREOPTEXPENSES^BUILDINGCONTINGENCIES^PLANTMACHCONTINGENCIES^FIXEDASSETSCONTINGENCIES^MARGINWCREQ','getCostofProject')"
					> Cost of Project </a></b>
				</td>
				<td  class="sub_tab_inactive"><b><a
					href="javascript:callFunction('ssi_above10_accrualsexpenditure.jsp','getGeneralDetails','InternalAccruals^FinanceOfExpenditureIncurred^PromotersPercentToTheProject','AccrualsExpenditure')"
					>Accruals </a></b>
				</td>
				<td  class="sub_tab_active"><b> Means of Financing </b>
				</td>
				<td class="sub_tab_inactive"><b><a
					href="javascript:callFunction('Ssi_schdu.jsp','','','')"
					> Schedule of Implementation </a></b>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable linebor">
							<tr class="dataheader">
								<td colspan="7">Cost of Project (Please furnish
								estimates of cost of project under the following heads. Indicate
								the basis for arriving at the cost of project).</td>
							</tr>
							<tr class="dataheader">
								<td align="center"  width="3%">S.No</td>
								<td align="center"  width="20%">Particulars</td>
								<td align="center" height="12" width="25%">&nbsp;&nbsp;</td>
								<td  align="center" colspan="2">Amount Already Raised<b>(<%=ApplicationParams.getCurrency()%>)</b></td>
								<td width="19%" align="center" >Amount Proposed to be
								Raised<b>(<%=ApplicationParams.getCurrency()%>)</b></td>
								<td width="19%" align="center" >Total<b>(<%=ApplicationParams.getCurrency()%>)</b></td>
							</tr>
							<%if (hshValues.size() > 0 && hshValues != null && vecrowsize > 0) {
				vecCol = (ArrayList) vecRow.get(0);

				%>
							<tr class="datagrid">
								<td align="center" width="3%" >1.</td>
								<td width="20%" >Capital (Specify
								resources contribution capital)</td>
								<td align="center" width="25%" >
								<div align="center"><textarea name="comm1" cols="30"
									wrap="VIRTUAL" rows="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("comm1"))%></textarea>
								</div>
								</td>
								<td align="center" colspan="2" ><input
									type="text" name="txt_costofprojectraised11" size="15"
									value="<%=vecCol.get(2)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised21" size="15"
									value="<%=vecCol.get(3)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised31" size="15"
									value="<%=vecCol.get(4)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
							</tr>
							<%vecCol = (ArrayList) vecRow.get(1);%>
							<tr class="datagrid">
								<td align="center" width="3%" >2.</td>
								<td width="20%" >Reserves</td>

								<td align="center" width="25%" >&nbsp;</td>
								<td align="center" colspan="2" ><input
									type="text" name="txt_costofprojectraised12" size="15"
									value="<%=vecCol.get(2)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised22" size="15"
									value="<%=vecCol.get(3)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised32" size="15"
									value="<%=vecCol.get(4)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
							</tr>
							<%vecCol = (ArrayList) vecRow.get(2);%>
							<tr class="datagrid">
								<td align="center" width="3%" >3.</td>
								<td width="20%" >Term Loans (give
								full particulars)</td>

								<td align="center" width="25%" >
								<div align="center"><textarea name="comm2" cols="30"
									wrap="VIRTUAL" rows="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("comm2"))%></textarea>
								</div>
								</td>
								<td align="center" colspan="2" ><input
									type="text" name="txt_costofprojectraised13" size="15"
									value="<%=vecCol.get(2)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised23" size="15"
									value="<%=vecCol.get(3)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised33" size="15"
									value="<%=vecCol.get(4)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
							</tr>
							<%vecCol = (ArrayList) vecRow.get(3);%>
							<tr class="datagrid">
								<td align="center" width="3%" >4.</td>
								<td width="20%" >Unsecured Loans and
								Deposits (indicate sources, rate of interest, repayment period
								etc.)</td>

								<td align="center" width="25%" >
								<div align="center"><textarea name="comm3" cols="30"
									wrap="VIRTUAL" rows="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("comm3"))%></textarea>
								</div>
								</td>
								<td align="center" colspan="2" ><input
									type="text" name="txt_costofprojectraised14" size="15"
									value="<%=vecCol.get(2)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised24" size="15"
									value="<%=vecCol.get(3)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised34" size="15"
									value="<%=vecCol.get(4)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
							</tr>
							<%vecCol = (ArrayList) vecRow.get(4);%>
							<tr class="datagrid">
								<td align="center" width="3%" >5.</td>
								<td width="20%" >Deferred Payment
								Arrangements including Supplier's Credit</td>

								<td align="center" width="25%" >&nbsp;</td>
								<td align="center" colspan="2" ><input
									type="text" name="txt_costofprojectraised15" size="15"
									value="<%=vecCol.get(2)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised25" size="15"
									value="<%=vecCol.get(3)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised35" size="15"
									value="<%=vecCol.get(4)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
							</tr>
							<%vecCol = (ArrayList) vecRow.get(5);%>
							<tr class="datagrid">
								<td align="center" width="3%" >6.</td>
								<td width="20%" >Subsidy Central
								Govt. State Govt.</td>

								<td align="center" width="25%" >&nbsp;</td>
								<td align="center" colspan="2" ><input
									type="text" name="txt_costofprojectraised16" size="15"
									value="<%=vecCol.get(2)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised26" size="15"
									value="<%=vecCol.get(3)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised36" size="15"
									value="<%=vecCol.get(4)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
							</tr>
							<%vecCol = (ArrayList) vecRow.get(6);%>
							<tr class="datagrid">
								<td align="center" width="3%" >7.</td>
								<td width="20%" >Seed Capital
								(indicate source)</td>

								<td align="center" width="25%" >
								<div align="center"><textarea name="comm4" cols="30"
									wrap="VIRTUAL" rows="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("comm4"))%></textarea>
								</div>
								</td>
								<td align="center" colspan="2" ><input
									type="text" name="txt_costofprojectraised17" size="15"
									value="<%=vecCol.get(2)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised27" size="15"
									value="<%=vecCol.get(3)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised37" size="15"
									value="<%=vecCol.get(4)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
							</tr>
							<%vecCol = (ArrayList) vecRow.get(7);%>
							<tr class="datagrid">
								<td align="center" width="3%" >8.</td>
								<td width="20%" >Internal Cash
								Accruals </td>

								<td align="center" width="25%" >&nbsp;</td>
								<td align="center" colspan="2" ><input
									type="text" name="txt_costofprojectraised18" size="15"
									value="<%=vecCol.get(2)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised28" size="15"
									value="<%=vecCol.get(3)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised38" size="15"
									value="<%=vecCol.get(4)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
							</tr>
							<%vecCol = (ArrayList) vecRow.get(8);%>
							<tr class="datagrid">
								<td align="center" width="3%" >9.</td>
								<td width="20%" >Other Sources
								(Specify)</td>

								<td align="center" width="25%" >
								<div align="center"><textarea name="comm5" cols="30"
									wrap="VIRTUAL" rows="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("comm5"))%></textarea>
								</div>
								</td>
								<td align="center" colspan="2" ><input
									type="text" name="txt_costofprojectraised19" size="15"
									value="<%=vecCol.get(2)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised29" size="15"
									value="<%=vecCol.get(3)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised39" size="15"
									value="<%=vecCol.get(4)%>"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right"></td>
							</tr>
							<%vecCol = (ArrayList) vecRow.get(9);%>
							<tr class="datagrid">
								<td align="center" width="3%" >10.</td>
								<td width="20%" ><b>Total</b></td>

								<td align="center" width="25%" >&nbsp;</td>
								<td align="center" colspan="2" ><input
									type="text" name="txt_costofprojectraised110" size="15"
									value="<%=vecCol.get(2)%>"
									onKeyPress="allowDecimals(this)" onBlur="" readOnly="readonly"
									maxlength="8" style="text-align:right"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised210" size="15"
									value="<%=vecCol.get(3)%>"
									onKeyPress="allowDecimals(this)" onBlur="" readOnly="readonly"
									maxlength="8" style="text-align:right"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised310" size="15"
									value="<%=vecCol.get(4)%>"
									onKeyPress="allowDecimals(this)" onBlur="" readOnly="readonly"
									maxlength="8" style="text-align:right"></td>
							</tr>
							<%} else {%>
							<tr class="datagrid">
								<td align="center" width="3%" >1.</td>
								<td width="20%" >Capital (Specify
								resources contributin capital) </td>

								<td align="center" width="25%" >
								<div align="center"><textarea name="comm1" cols="30"
									wrap="VIRTUAL" rows="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea></div>
								</td>
								<td align="center" colspan="2" ><input
									type="text" name="txt_costofprojectraised11" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised21" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised31" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
							</tr>
							<tr class="datagrid">
								<td align="center" width="3%" >2.</td>
								<td width="20%">Reserves</td>

								<td align="center" width="25%" >&nbsp;</td>
								<td align="center" colspan="2" ><input
									type="text" name="txt_costofprojectraised12" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised22" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised32" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
							</tr>
							<tr class="datagrid">
								<td align="center" width="3%" >3.</td>
								<td width="20%" >Term Loans (give
								full particulars)</td>

								<td align="center" width="25%" ><textarea
									name="comm2" cols="30" wrap="VIRTUAL" rows="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea></td>
								<td align="center" colspan="2" ><input
									type="text" name="txt_costofprojectraised13" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised23" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised33" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
							</tr>
							<tr class="datagrid">
								<td align="center" width="3%" >4.</td>
								<td width="20%" >Unsecured Loans and
								Deposits (indicate sources, rate of interest, repayment period
								etc.)</td>

								<td align="center" width="25%" ><textarea
									name="comm3" cols="30" wrap="VIRTUAL" rows="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea></td>
								<td align="center" colspan="2" ><input
									type="text" name="txt_costofprojectraised14" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised24" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised34" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
							</tr>
							<tr class="datagrid">
								<td align="center" width="3%" >5.</td>
								<td width="20%" >Deferred Payment
								Arrangements including Supplier's Credit</td>

								<td align="center" width="25%" >&nbsp;</td>
								<td align="center" colspan="2" ><input
									type="text" name="txt_costofprojectraised15" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised25" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised35" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
							</tr>
							<tr class="datagrid">
								<td align="center" width="3%" >6.</td>
								<td width="20%" >Subsidy Central
								Govt. State Govt.</td>

								<td align="center" width="25%" >&nbsp;</td>
								<td align="center" colspan="2" ><input
									type="text" name="txt_costofprojectraised16" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised26" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised36" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
							</tr>
							<tr class="datagrid">
								<td align="center" width="3%" >7.</td>
								<td width="20%" >Seed Capital
								(indicate source)</td>

								<td align="center" width="25%" ><textarea
									name="comm4" cols="30" wrap="VIRTUAL" rows="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea></td>
								<td align="center" colspan="2" ><input
									type="text" name="txt_costofprojectraised17" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised27" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised37" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
							</tr>
							<tr class="datagrid">
								<td align="center" width="3%" >8.</td>
								<td width="20%" >Internal Cash
								Accruals </td>

								<td align="center" width="25%" >&nbsp;</td>
								<td align="center" colspan="2" ><input
									type="text" name="txt_costofprojectraised18" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised28" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised38" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
							</tr>
							<tr class="datagrid">
								<td align="center" width="3%" >9.</td>
								<td width="20%" >Other Sources
								(Specify)</td>

								<td align="center" width="25%" ><textarea
									name="comm5" cols="30" wrap="VIRTUAL" rows="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea></td>
								<td align="center" colspan="2" ><input
									type="text" name="txt_costofprojectraised19" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised29" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised39" size="15"
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
									maxlength="8" style="text-align:right" value="0.00"></td>
							</tr>
							<tr class="datagrid">
								<td align="center" width="3%" >10.</td>
								<td width="20%" ><b>Total</b></td>

								<td align="center" width="25%" >&nbsp;</td>
								<td align="center" colspan="2" ><input
									type="text" name="txt_costofprojectraised110" size="15"
									onKeyPress="allowDecimals(this)" onBlur="" readOnly="readonly"
									maxlength="8" style="text-align:right" value="0.00"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised210" size="15"
									onKeyPress="allowDecimals(this)" onBlur="" readOnly="readonly"
									maxlength="8" style="text-align:right" value="0.00"></td>
								<td width="19%" align="center" ><input
									type="text" name="txt_costofprojectraised310" size="15"
									onKeyPress="allowDecimals(this)" onBlur="" readOnly="readonly"
									maxlength="8" style="text-align:right" value="0.00"></td>
							</tr>
							<%}%>
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
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
 <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidDesc1" value="CAPITAL"> 
<input type="hidden" name="hidDesc2" value="RESERVES"> 
<input type="hidden" name="hidDesc3" value="TERMLOANS"> 
<input type="hidden" name="hidDesc4" value="UNSECUREDLOANS"> 
<input type="hidden" name="hidDesc5" value="DEFERREDPAYMENTS"> 
<input type="hidden" name="hidDesc6" value="SUBSIDYGOVT"> 
<input type="hidden" name="hidDesc7" value="SEEDCAPITAL"> 
<input type="hidden" name="hidDesc8" value="INTERNALCASHACCRUALS"> 
<input type="hidden" name="hidDesc9" value="OTHERSOURCES"> 

<input type="hidden" name="hidTotalDesc" value="9"> 
<input type="hidden" name="hidFieldPrefix" value="txt_costofprojectraised">
<INPUT TYPE="hidden" NAME="hidGenID" VALUE="">
<input type="hidden" name="otherGenTable" value=""> 
</form>
</body>
</html>
