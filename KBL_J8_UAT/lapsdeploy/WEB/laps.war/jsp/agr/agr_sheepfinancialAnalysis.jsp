<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%

	String appstatus = Helper.correctNull((String) session
			.getAttribute("appstatus"));

	String prd_type = Helper.correctNull((String) session
			.getAttribute("strProductType"));
	String strYear[] = { "I", "II", "III", "IV", "V", "VI" };
	java.text.NumberFormat nf = java.text.NumberFormat
			.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(3);
	nf.setMinimumFractionDigits(3);
%>

<%
	ArrayList arryCol = null;
	ArrayList arryRow = (ArrayList) hshValues.get("arryRow");
	String strschemetype = Helper.correctNull((String)request.getParameter("schemetype"));
	if(strschemetype. trim().equalsIgnoreCase(""))
	{
		strschemetype="0";
	}
	
	
	String strCategoryType = Helper.correctNull((String) request
			.getParameter("hidCategoryType"));
	
	
	String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
	if(schemetype. trim().equalsIgnoreCase(""))
	{
		schemetype="0";
	}
	String strSSIType = Helper.correctNull((String) request
			.getParameter("hidSSIType"));
	
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 150;
	overflow: auto;
}
</STYLE>

<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var varAcctype=new Array();
var varApptype=new Array();
var varchkClick=new Array();
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var selrepay = "";
var strvalue="";
var prd_type="<%=prd_type%>";
function enableButtons(bool1, bool2, bool3, bool4,  bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	
	document.forms[0].cmdclose.disabled=bool6;
}
function callOnload()
{
	disableFields(true);
	if(selrepay!="")
	{
		document.forms[0].sel_repay.value=selrepay;
	}
	
	 document.forms[0].sel_scheme.disabled=false;
	document.forms[0].sel_scheme.value="<%=strschemetype%>";
	
}


function disableFields(one)
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
	} 	
}
function callLink(page,bean,method)
{	
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}


function callExistingLoans()
{
		document.forms[0].hidBeanId.value="retailappraisal";		
		document.forms[0].hidBeanGetMethod.value="getExistingLoandetailsData";
		document.forms[0].hidAppType.value="";
		document.forms[0].action=appURL+"action/perexistingloandetails.jsp";	
		document.forms[0].submit();
	
}
function callAssessment()
{
			document.forms[0].hidBeanId.value="agriloanassessment";		
			document.forms[0].hidBeanGetMethod.value="getFarmMechanisationLoanAssessment";
			document.forms[0].hidAppType.value="";
			document.forms[0].action=appURL+"action/agrFarmMechLoanAssessment.jsp";	
			document.forms[0].submit();
		
}

function callLoanDetails()
{
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].hidBeanGetMethod.value="getloandetails";
		document.forms[0].action=appURL+"action/loandetails.jsp";	
		document.forms[0].submit();

}
function callTermsandConditions()
{
			
		document.forms[0].hidBeanId.value="retailtermsdocuments";		
		document.forms[0].hidBeanGetMethod.value="getAppTermsconditionsData";
		document.forms[0].hidAppType.value="";
		document.forms[0].action=appURL+"action/perapptermsconditions.jsp";	
		document.forms[0].submit();
	
}

function callBorrowerTermsandConditions()
{
		document.forms[0].hidBeanId.value="retailtermsdocuments";		
		document.forms[0].hidBeanGetMethod.value="getAppTermsconditionsData";
		document.forms[0].hidAppType.value="";
		document.forms[0].action=appURL+"action/perborrowertermscondition.jsp";	
		document.forms[0].submit();
	
}

function callRecommendations()
{
		
		document.forms[0].hid_pagename.value="RA";		
		document.forms[0].hidBeanId.value="retailappraisal";		
		document.forms[0].hidBeanGetMethod.value="getAppraisalRecommendationsData";
		document.forms[0].action=appURL+"action/perrecommendations.jsp";	
		document.forms[0].submit();
	
}
function callLoanDetails()
{
			
		document.forms[0].hidBeanId.value="retailappraisal";
		document.forms[0].hidBeanGetMethod.value="getAppraisalLoandetailsData";
		document.forms[0].action=appURL+"action/perapploandetails.jsp";	
		document.forms[0].submit();
	
}

function callOtherTab(val)
{
	 if(val=="history")
	 {
		 document.forms[0].hidBeanGetMethod.value="getWorkFlowHistory";
		 document.forms[0].action=appURL+"action/perappworkflowhistory.jsp";
		 document.forms[0].submit();
	 }
	 else if(val=="checklist")
	 {
			document.forms[0].hidBeanId.value="retailappraisal";		
			document.forms[0].hidBeanGetMethod.value="getAppChecklistData";
			document.forms[0].action=appURL+"action/perappchecklist.jsp";	
			document.forms[0].submit();
	
	}
	 else if(val=="DSCR")
	 {
		 	document.forms[0].hidBeanId.value="agrfarmmachinery";		
			document.forms[0].hidBeanGetMethod.value="getDSCRData";
			document.forms[0].action=appURL+"action/agrDSCR.jsp";	
			document.forms[0].submit();
				
	 }
}
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callOnload()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">
				if (document.all && window.print)
				{
					ie5menu.className = menuskin;
					document.oncontextmenu = showmenuie5;
					document.body.onclick = hidemenuie5;
				}
				</script></div>
</div>
<form name="finForm" action="" method="post" class="normal">


<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="999" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
	<tr>
	<td class="page_flow">Home -> Agriculture -> Financial Analysis </td>
	
	</tr>
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="73" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>


<br>
<table width="60%" border="0" cellpadding="0" cellspacing="0"
	align="center" class="outertable border1">
	<tr>
		<td valign="top">
		<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3" class="outertable">
			<TR ALIGN="center" CLASS="dataHeader">
				<TD WIDTH="25%">Year</TD>
				<!--<TD nowrap WIDTH="10%">Capital Expenditure</TD>
				--><TD nowrap WIDTH="25%">Recurring Expenditure</TD>
				<!--<TD nowrap WIDTH="10%">Total Expenditure</TD>
				--><TD WIDTH="25%">Total Income</TD>
				<TD WIDTH="25%">Net Income</TD>
				<!-- 
				<TD WIDTH="12%">DF @ <%=Helper.correctNull((String) hshValues.get("df"))%>%</TD>
				<TD WIDTH="14%">Discounted Benefits</TD>
				<TD nowrap WIDTH="10%">Discounted Costs</TD> -->
			</TR>
			<%
				if (arryRow != null && arryRow.size() > 0) {
					for (int i = 0; i < 6; i++) {

						arryCol = (ArrayList) arryRow.get(i);
			%>
			<TR CLASS="dataGridColor">
				<TD ALIGN="left" WIDTH="25%"><b><%=strYear[i]%> YEAR</b></TD>
				<!--<TD ALIGN="right" WIDTH="10%"><INPUT TYPE="text"
					NAME="txt_capitalExp"
					VALUE="<%=Helper.checkDecimal(Helper
									.correctNull((String) arryCol.get(0)))%>"
					SIZE="15" MAXLENGTH="9" ONKEYPRESS="allowDecimals(this)"
					ONBLUR="roundtxt(this);"
					style="text-align: right; background-color: #e7edf8; border-style: none; color: #000000;"></TD>
				--><TD ALIGN="right" WIDTH="25%"><INPUT TYPE="text"
					NAME="txt_recurringExp"
					VALUE="<%=Helper.checkDecimal(Helper
									.correctNull((String) arryCol.get(1)))%>"
					SIZE="15" MAXLENGTH="9" ONKEYPRESS="allowDecimals(this)"
					ONBLUR="roundtxt(this);"
					style="text-align: right; background-color: #e7edf8; border-style: none; color: #000000;"></TD>
				<!--<TD ALIGN="right" WIDTH="10%"><INPUT TYPE="text"
					NAME="txt_totExp"
					VALUE="<%=Helper.checkDecimal(Helper
									.correctNull((String) arryCol.get(2)))%>"
					SIZE="15" MAXLENGTH="9" ONKEYPRESS="allowDecimals(this)"
					ONBLUR="roundtxt(this);"
					style="text-align: right; background-color: #e7edf8; border-style: none; color: #000000;"></TD>
				--><TD WIDTH="25%" ALIGN="right"><INPUT TYPE="text"
					NAME="txt_totIncome"
					VALUE="<%=Helper.checkDecimal(Helper
									.correctNull((String) arryCol.get(3)))%>"
					SIZE="15" MAXLENGTH="9" ONKEYPRESS="allowDecimals(this)"
					ONBLUR="roundtxt(this);"
					style="text-align: right; background-color: #e7edf8; border-style: none; color: #000000;"></TD>
				<TD ALIGN="right" WIDTH="25%"><INPUT TYPE="text"
					NAME="txt_netincome"
					VALUE="<%=Helper.checkDecimal(Helper
									.correctNull((String) arryCol.get(4)))%>"
					SIZE="15" MAXLENGTH="9" ONKEYPRESS="allowDecimals(this)"
					ONBLUR="roundtxt(this);"
					style="text-align: right; background-color: #e7edf8; border-style: none; color: #000000;"></TD>
					<!-- 
				<TD WIDTH="12%" ALIGN="right"><INPUT TYPE="text" NAME="txt_df"
					VALUE="<%=nf.format(Double.parseDouble(Helper
									.correctDouble((String) arryCol.get(5))))%>"
					SIZE="15" MAXLENGTH="9" ONKEYPRESS="allowDecimals(this)"
					onBlur="roundToPrecision(this,3)"
					style="text-align: right; background-color: #e7edf8; border-style: none; color: #000000;"></TD>
				<TD WIDTH="14%" ALIGN="right"><INPUT TYPE="text"
					NAME="txt_discountedbenefits"
					VALUE="<%=Helper.checkDecimal(Helper
									.correctNull((String) arryCol.get(7)))%>"
					SIZE="15" MAXLENGTH="9" ONKEYPRESS="allowDecimals(this)"
					onBlur="roundtxt(this);"
					style="text-align: right; background-color: #e7edf8; border-style: none; color: #000000;"></TD>
				<TD WIDTH="10%" ALIGN="center"><INPUT TYPE="text"
					NAME="txt_discountcost"
					VALUE="<%=Helper.checkDecimal(Helper
									.correctNull((String) arryCol.get(6)))%>"
					MAXLENGTH="9" ONKEYPRESS="allowDecimals(this)"
					ONBLUR="roundtxt(this);"
					style="text-align: right; background-color: #e7edf8; border-style: none; color: #000000; SIZE: 20;"></TD>
					 -->
			</TR>
			<%
				}
				}
			%>
			<tr CLASS="dataGridColor">
				<td colspan="3" align="right"><b>Net Present Worth :</b></td>
				<td align="right"><b><%=Helper.checkDecimal(Helper.correctNull((String) hshValues
							.get("NetWorth")))%></b>
					
				</td>
			</tr>
		</TABLE>
		</td>
	</tr>
</table>
<br>
	
	<table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td>
		<table width="43%" border="0" cellspacing="0" cellpadding="1">
			<tr valign="top">
				<td><input type="button" name="cmdClose" value="Close"
					onClick="doClose()" class="buttonClose"></td>
					<td><input type="button" name="cmdsave" value="Save"
					onClick="" class="buttonClose" style="visibility:hidden;" disabled="disabled"></td>
			</tr>
			
		</table>
		</td>
	</tr>
</table>
<br>
<INPUT TYPE="hidden" name="hidBeanGetMethod" value=""> <INPUT
	TYPE="hidden" name="hidBeanId" value=""> <input type="hidden"
	name="hidappno"
	value="<%=Helper.correctNull((String) request
									.getParameter("appno"))%>">
<input type="hidden" name="hidAction" value=""> <input
	type="hidden" name="hidBeanMethod" value=""> <input
	type="hidden" name="hidSourceUrl" value=""> <input
	type="hidden" name="hideditflag" value=""> <input type="hidden"
	name="hidAppType" value=""> <input type="hidden"
	name="cmdApply" value="" disabled="sdisabled"> <input
	type="hidden" name="hid_pagename" value=""></form>
</body>
</html>


