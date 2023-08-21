<%@include file="../share/directives.jsp"%>
	<%
	String strSessionModuleType = Helper.correctNull((String) session.getAttribute("sessionModuleType")).trim();
	String strFacSno = Helper.correctNull((String)hshValues.get("strFacSno"));
	String strRepaytype = Helper.correctNull((String)hshValues.get("repay_type"));
	%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
	<STYLE>
	
	DIV.cellContainer {	

  width: 100%; height: 150;
  overflow: auto;
}
</STYLE>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>

<SCRIPT>
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var appstatus="<%=Helper.correctNull((String) request
							.getParameter("appstatus"))%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRepayType = "<%=strRepaytype%>";

function callCalender(name,field)
{
	if(document.forms[0].cmdfreeze.disabled == false && !document.forms[0].sel_facilitysno.value=="")
	{
		if(field=="F")
		{
			showCal(appURL,name);
		}
		else if(varRepayType == "NE")
		{
			showCal(appURL,name);
		}
	}
}

function showpage1(url,method)
{
	document.forms[0].hidBeanId.value="executive";
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
	document.forms[0].submit();
}

function callOnLoad()
{
	document.forms[0].sel_facilitysno.value = "<%=strFacSno%>";

	<%if(!Helper.correctNull((String) request.getParameter("appstatus")).equalsIgnoreCase("Open/Pending")){ %>
		document.forms[0].cmdFVC.disabled = true;
		document.forms[0].cmdfreeze.disabled = true;
		document.forms[0].cmdDelete.disabled = true;
		document.forms[0].txt_flowstartdate.disabled = true;
		document.forms[0].txt_intdmddate.disabled = true;
		document.forms[0].txt_oldvalue.disabled = true;
		document.forms[0].txt_Newvalue.disabled = true;
		document.forms[0].txt_fairvalue.disabled = true;
	<%}%>
	document.forms[0].cmdFVC.disabled = true;
	document.forms[0].cmdfreeze.disabled = true;
	document.forms[0].cmdDelete.disabled = true;
	changedatefields();
}

function changedatefields()
{
	if(varRepayType == "E")
	{
		document.all.date1.innerHTML="Installment start date";
		document.all.date2.innerHTML="Interest accumulation start date";
		document.forms[0].txt_intdmddate.value = document.forms[0].txt_flowstartdate.value;
		document.forms[0].txt_intdmddate.readOnly = true;
	}
	else if(varRepayType == "NE")
	{
		document.all.date1.innerHTML="Flow start date";
		document.all.date2.innerHTML="Interest Demand date";
	}
	else if(varRepayType == "OD")
	{
		document.all.date1.innerHTML="Due date";
		document.all.date2.innerHTML="Interest Demand date";
		document.forms[0].txt_intdmddate.readOnly = true;
	}
}

function showKFS(url,method)
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
	document.forms[0].submit();
}

function doPulldata()
{
	
	if(document.forms[0].sel_facilitysno.value=="")
	{
		alert("Select facility");
		document.forms[0].sel_facilitysno.focus();
		return;
	}
	if(document.forms[0].txt_flowstartdate.value=="")
	{
		alert("Enter "+document.all.date1.innerHTML);
		document.forms[0].txt_flowstartdate.focus();
		return;
	}
	if(document.forms[0].txt_intdmddate.value=="")
	{
		alert("Enter "+document.all.date2.innerHTML);
		document.forms[0].txt_intdmddate.focus();
		return;
	}
	
	document.forms[0].hidBeanId.value="proposalFVC";
	document.forms[0].hidBeanMethod.value="updatedata";
	document.forms[0].hidBeanGetMethod.value="getdata";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_fairvalue_proposal.jsp";
	document.forms[0].submit();
}

function doFVCone()
{
	if(document.forms[0].hidAccflag.value == "Y")
	{
		document.forms[0].hidBeanId.value="proposalFVC";
		document.forms[0].hidBeanMethod.value="updateFVCaccounts";
		document.forms[0].hidBeanGetMethod.value="getFVCaccounts";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_fairvalue_proposal.jsp";
		document.forms[0].submit();
	}
	else
	{
		alert("Please Freeze the data to Calculate the Fair Value");
	}
}

function selectAcc()
{
	document.forms[0].hidBeanId.value="proposalFVC";
	document.forms[0].hidBeanGetMethod.value="getdata";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_fairvalue_proposal.jsp";
	document.forms[0].submit();
}

function doDelete()
{
	if(document.forms[0].sel_facilitysno.value=="")
	{
		alert("Select facility");
		document.forms[0].sel_facilitysno.focus();
		return;
	}
	if(ConfirmMsg('101'))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="proposalFVC";
		document.forms[0].hidBeanMethod.value="updatedata";
		document.forms[0].hidBeanGetMethod.value="getdata";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_fairvalue_proposal.jsp";
		document.forms[0].submit();
	}
}

function Callcomments()
{
	var btnenable=document.forms[0].btnenable.value;
	var hidAppNo=document.forms[0].hidAppNo.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidCommentPage=fvccmts&appstatus="+appstatus+"&btnenable="+btnenable;
	window.open(url,"Comments",prop);
}
</SCRIPT>

</head>

<body onLoad="callOnLoad();">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">

</div></div>
<form name="frmpri" method="post" class="normal">
<%if (strSessionModuleType.equals("AGR") || strSessionModuleType.equals("CORP")) { %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colSpan=5><jsp:include
			page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="10" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />

		</jsp:include></td>
	</tr>
	<tr>
	    <%if (strSessionModuleType.equals("AGR")) { %>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Agriculture -&gt;&nbsp;Proposal&nbsp;-&gt;&nbsp;Fair Value Calculation</td>
		<%} else if (strSessionModuleType.equals("CORP")) {%>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Corporate&nbsp; &amp; SME -&gt;&nbsp;Proposal&nbsp;-&gt;&nbsp;Fair Value Calculation</td> 
		<%}%>
	</tr>
</table>
<%} else{%>
<jsp:include page="../share/Applurllinkper.jsp" flush="true">
<jsp:param name="pageid" value="10" /></jsp:include>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Appraisal -&gt; Fair Value Calculation</td>
	</tr>
</table>
<%} %>
<span style="display:none"><lapschoice:borrowertype /></span><lapschoice:application />

		
<%if (strSessionModuleType.equals("AGR") || strSessionModuleType.equals("CORP")) {%>		
<table width="60%" border="0" cellspacing="1" cellpadding="3"
	class="outertable">
	<tr>
		<td class="sub_tab_inactive" align="center"><a
			href="JavaScript:showpage1('com_delegation.jsp','getDelegationData')"
			onMouseOut="window.status='';return true;"
			onMouseOver="window.status='Cash Flow';return true;"><b>Proposal
		Flow</b></a></td>
		<td class="sub_tab_inactive" align="center"><a
			href="JavaScript:showpage1('com_mdsanctiontoec.jsp','getMDSanctiontoEC')"
			onMouseOut="window.status='';return true;"
			onMouseOver="window.status='MD Sanction to EC';return true;"><b>MD
		Sanction to EC</b></a></td>
		<td class="sub_tab_inactive" align="center"><a
			href="JavaScript:showpage1('exec_page1.jsp','getData')"
			onMouseOut="window.status='';return true;"
			onMouseOver="window.status='Cash Flow';return true;"><b>Executive
		Summary</b></a></td>
		<%if(Helper.correctNull((String) request.getParameter("appstatus")).equalsIgnoreCase("Processed/Approved")){ %>
	<td class="sub_tab_inactive" align="center"><a href="JavaScript:showKFS('com_keyfactstatement.jsp','getKeyFactStatementData')"
			onMouseOut="window.status='Key Fact Statement';return true;"
			onMouseOver="window.status='Key Fact Statement';return true;"><b>Key Fact Statement</b></a></td>
		<%} %>
		<td class="sub_tab_active" align="center">Fair Value Calculation</td>


	</tr>
</table>
<%}else{ %>
<jsp:include page="../share/apprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="105" />
		</jsp:include>
<%} %>

<table width="98%"  height="200px" border="1" cellspacing="0" cellpadding="5"
	class="shadow" align="center" bordercolordark="#B6C1D2"
	bordercolorlight="#FFFFFF">
	<tr>
		<td valign="top">
		<table width="100%" border="0" align="center" cellspacing="0" cellpadding="5"  class="outertable">
			<%if (strSessionModuleType.equals("AGR") || strSessionModuleType.equals("CORP")) {%>
			<tr>
				<td colspan="4">Select Facility
				&nbsp;&nbsp;<select name="sel_facilitysno" tabindex="1" onChange="selectAcc();">
				<option value="" selected="selected">--Select--</option>
                <lapschoice:ComMisDetailsTag apptype='<%=Helper.correctNull((String) request.getParameter("appno"))%>' page='FVC'/>
				</select>
				</td>
			</tr>
			<%}else{ %>
			<tr>
				<td colspan="4"><input type="hidden" name="sel_facilitysno" value="1"></td>
			</tr>
			<%} %>
			<tr>
			<td align="center" valign="middle"><span id="date1">Flow start date</span>&nbsp;&nbsp;&nbsp;<input type="text" name="txt_flowstartdate" onBlur="checkDate(this);changedatefields();" value="<%=Helper.correctNull((String)hshValues.get("flowstartdate"))%>">
			<img onClick="callCalender('txt_flowstartdate','F')"	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" align="top"></td>
			<td align="center" valign="middle"><span id="date2">Interest Service start date</span>&nbsp;&nbsp;&nbsp;<input type="text" name="txt_intdmddate" onBlur="checkDate(this);" value="<%=Helper.correctNull((String)hshValues.get("IntDmdDate"))%>">
			<img onClick="callCalender('txt_intdmddate','I')"	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" align="top"></td>
			</tr>
			<tr>
			<td align="center" valign="middle">Fair Value Before Restructuring&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="txt_oldvalue" size="30" readonly="readonly" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("BeforeVal"))%>"></td>
			<td align="center" valign="middle">Fair Value After Restructuring&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="txt_Newvalue" size="30" readonly="readonly" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("AfterVal"))%>"></td>			
			</tr>
			<tr>
			<td  colspan="2" align="center" valign="middle">Fair Value Profit / Loss&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="txt_fairvalue" size="30" readonly="readonly" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("Fairvalue"))%>"></td>			
			</tr>
			</table>
		</td>
	</tr>
</table>

<table border="0" class="outertable" cellpadding="2" cellspacing="0" width="10%" align="center">
<tr>
<td><input type="button" name="cmdfreeze" value="Freeze Data" class="buttonstyle" onClick="doPulldata();"></td>
<td><input type="button" name="cmdDelete" value="Delete" class="buttonstyle" onClick="doDelete();"></td>
<td><input type="button" name="cmdFVC" value="Calculate Fair Value" class="buttonstyle" onClick="doFVCone();"></td>
</tr>
<tr>
<td colspan="3" align="center">
<input type="button" name="cmdComments" value="Comments on Fair Value Calculation" class="buttonstyle" onClick="Callcomments();">
</td>
</tr>
</table>
<br>
<input type="button" name="cmdsave" disabled="disabled" style="display:none">
<input type="hidden" name="hidsno" value="">
<input type="hidden" name="hidPageTypeFrom" value="P">
<input type="hidden" name="hid_calc_date" value="<%=Helper.getCurrentDateTime()%>">
<input type="hidden" name="hidAccflag" value="<%=Helper.correctNull((String) hshValues.get("Accflag"))%>">
<INPUT TYPE="hidden" name="hidAppNo" VALUE="<%=Helper.correctNull((String) request.getParameter("appno"))%>">
<lapschoice:hiddentag pageid='<%=PageId%>' />
</form>
</body>
</html>
							