<%@include file="../share/directives.jsp"%>
<%@page import="java.text.NumberFormat"%>
<%
ArrayList arrRow = new ArrayList();
ArrayList arrCol = new ArrayList();

if(hshValues!=null)
{
	arrRow = (ArrayList) hshValues.get("arrRow");
}

String strActiontype= Helper.correctNull((String)hshValues.get("alerttype"));
String strAccCount= Helper.correctNull((String)hshValues.get("Acc_Count"));
String strSortType= Helper.correctNull((String)hshValues.get("strSortType"));
String strFile_Upload= Helper.correctNull((String)hshValues.get("File_Upload"));
NumberFormat nf = NumberFormat.getNumberInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
%>

<html>
<head>
<title>Fair Value Calculation</title>
<script language="JavaScript">
var currdate = "<%=Helper.getCurrentDateTime()%>";
var varalert="<%=strActiontype%>";
var varCount="<%=strAccCount%>";
var varSortType="<%=strSortType%>";
var varFile_Upload="<%=strFile_Upload%>";
var msg="";

function callCalender(name)
{
	showCal(appURL,name);
	/*if(document.forms[0].hidReport.value=="Y")
	{
		showCal(appURL,name);
	}
	else
	{
		alert("You cannot change the date after the Accounts have been selected");
	}*/
}

function onLoading()
{
	<%if(arrRow!=null && arrRow.size()>0){%>
		document.forms[0].hidRSAccAvail.value="Y";
	<%}%>
	if(varSortType == "B")
	{
		document.forms[0].sorting[1].checked=true;
	}
	else
	{
		document.forms[0].sorting[0].checked=true;
	}

	if(varalert=="Y")
	{
		alert("Total number of accounts taken for calculating the Fair Value is "+varCount);
	}

	if(document.forms[0].hidRSAccAvail.value=="Y" && document.forms[0].hidReport.value=="")
	{
		document.forms[0].cmdCalculate.disabled=false;
	}
	else
	{
		document.forms[0].cmdCalculate.disabled=true;
	}
	doSorting();

	if(varFile_Upload == "S")
		alert("Flat file uploaded successfully");
	else if(varFile_Upload == "F")
		alert("Flat file upload failed");
}

function doFVC()
{
	if(document.forms[0].hidRSAccAvail.value=="Y" && document.forms[0].hidReport.value=="")
	{
		if(document.forms[0].hid_calc_date.value=="")
		{
			alert("Enter calculation date");
			document.forms[0].hid_calc_date.focus();
			return;
		}
		document.forms[0].cmdCalculate.disabled = true;
		document.forms[0].cmdGetAcc.disabled = true;
		document.forms[0].hidBeanId.value="proposalFVC";
		document.forms[0].hidBeanMethod.value="updateFVCaccounts";
		document.forms[0].hidBeanGetMethod.value="getFVCaccounts";
		document.forms[0].hidSourceUrl.value="/action/set_fairvaluecalc.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
		document.getElementById("form_blur").style.visibility="visible";
		document.getElementById("progress").style.visibility="visible";
		document.getElementById("FVClabel").style.visibility="visible";
	}
	else
	{
		alert("Oops!! No Accounts to Calculate the Fair Value !!!");
	}
}

function doReport()
{
	/*if(document.forms[0].txt_fromdate.value=="")
	{
		alert("Enter From Date");
		document.forms[0].txt_fromdate.focus();
		return;
	}
	else if(document.forms[0].txt_todate.value=="")
	{
		alert("Enter To Date");
		document.forms[0].txt_todate.focus();
		return;
	}
	else*/
	{
		msg = "Do you want to get the Fair value details for the accounts?";
	}
	if(confirm(msg))
	{
		document.forms[0].hidReport.value="Y";
		document.forms[0].hidBeanId.value="proposalFVC";
		document.forms[0].hidBeanGetMethod.value="getdata";
		document.forms[0].hidSourceUrl.value="/action/set_fairvaluecalc.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
	else
	{
		return false;
	}
}

function douploadFlatFile()
{
	if(confirm("Do you want to upload the Flat File available in the server location?"))
	{
		document.forms[0].hidAction.value="flatfile";
		document.forms[0].hidBeanId.value="proposalFVC";
		document.forms[0].hidBeanMethod.value="updatedata";
		document.forms[0].hidBeanGetMethod.value="getdata";
		document.forms[0].hidSourceUrl.value="/action/set_fairvaluecalc.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}

function doGetAcc()
{
	/*if(document.forms[0].txt_fromdate.value=="")
	{
		alert("Enter From Date");
		document.forms[0].txt_fromdate.focus();
		return;
	}
	else if(document.forms[0].txt_todate.value=="")
	{
		alert("Enter To Date");
		document.forms[0].txt_todate.focus();
		return;
	}
	else
	{
		msg = "Do you want to calculate the Fair value for the accounts restructured during "+document.forms[0].txt_fromdate.value+" to "+document.forms[0].txt_todate.value+"?";
	}*/
	if(confirm("Do you want to calculate the Fair value for restructured accounts?"))
	{
		document.forms[0].hidBeanId.value="proposalFVC";
		document.forms[0].hidBeanMethod.value="updatedata";
		document.forms[0].hidBeanGetMethod.value="getdata";
		document.forms[0].hidSourceUrl.value="/action/set_fairvaluecalc.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
	else
	{
		return false;
	}
}

function doSorting()
{
	if(document.forms[0].sorting[0].checked==true)
	{
		document.forms[0].hidSortType.value="A";
	}
	else if(document.forms[0].sorting[1].checked==true)
	{
		document.forms[0].hidSortType.value="B";
	}
}
function doExportExcel()
{
	var qryString=appURL+"action/FVC.zip?&hidBeanId=excelfunction&hidBeanGetMethod=getZIPFileData";
	var prop="scrollbars=yes,menubar=yes,width=20, height=20";
	window.open(qryString,"ZIPFORMAT",prop);
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onLoading()">
<form class="normal">
<div id="progress" style="position:absolute; width:106px; visibility:hidden; height:19px; z-index:9999999; left: 550px; top: 250px">
<img src="<%=ApplicationParams.getAppUrl()%>img/processing2.gif"></div>
<div id="FVClabel" style="position:absolute; width:106px; visibility:hidden; height:19px; z-index:9999999; left: 500px; top: 200px">
<img src="<%=ApplicationParams.getAppUrl()%>img/FVC.gif"></div>
<div class="overlay" id="form_blur" style="position:absolute; visibility:hidden;"></div>

<table width="98%" align="center" border="0" cellpadding="1" cellspacing="0" class="outertable">
<tr><td>
	<table width="100%" border="0" cellpadding="1" cellspacing="0" class="outertable">
	<tr>
		<td colspan="2" align="center">&nbsp;</td>
	</tr>
	<tr class="dataheader">
		<td colspan="2" align="center"><b>Fair Value Calculation for Restructured accounts</b></td>
	</tr>
	<tr>
		<td colspan="2" align="center">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2" align="center">&nbsp;</td>
	</tr>
	<tr class="datagrid" height="50px">
		<td align="center">
			<b>Sort by</b>&nbsp;&nbsp;<input type="radio" name="sorting" STYLE="border-style: none" onClick="doSorting()">&nbsp;Account&nbsp;&nbsp;<input type="radio" STYLE="border-style: none" name="sorting" onClick="doSorting()">&nbsp;Borrower
			<%--<table border="0" style="display:inline-table;" align="right" class="outertable"><tr>
			</tr></table>--%>
		</td>
		<td>Calculation Date: <input type="text" name="hid_calc_date" value=""></td>
		<%-- <td align="center" valign="middle">Sanctioned between&nbsp;&nbsp;&nbsp;<input type="text" name="txt_fromdate" onBlur="checkDate(this);checkmaxdate(this,currdate);" value="<%=Helper.correctNull((String)hshValues.get("fromdate"))%>">
			<img onClick="callCalender('txt_fromdate')"	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" align="top">
		&nbsp;&nbsp;&nbsp;&nbsp;
		and&nbsp;&nbsp;&nbsp;<input type="text" name="txt_todate" onBlur="checkDate(this);checkmaxdate(this,currdate);" value="<%=Helper.correctNull((String)hshValues.get("todate"))%>">
		<img onClick="callCalender('txt_todate')" src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" align="top">
		</td>--%>
	</tr>
	<tr>
		<td colspan="2" align="center">&nbsp;</td>
	</tr>
	<tr><td colspan="2" align="center">
	<table width="80%" border="0" cellpadding="1" cellspacing="0" class="outertable"> 
	<tr>
		<td width="15%"><input type="button" name="cmdpullacc" Value="Load the Report" onClick="doReport()" class="buttonstyle"></td>
		<td align="right" width="30%"><input type="button" name="cmdUpload" Value="Upload Schedule Flat file" onClick="douploadFlatFile()" class="buttonstyle"></td>
		<td align="center" width="20%"><input type="button" name="cmdGetAcc" Value="Get Accounts to Calculate Fair Value" onClick="doGetAcc()" class="buttonstyle"></td>
		<td align="left" width="15%"><input type="button" name="cmdCalculate" Value="Calculate Fair Value" onClick="doFVC()" class="buttonstyle"></td>
		<td align="left" width="15%"><input type="button" name="cmdCalculate" Value="Export the Excel Report" onClick="doExportExcel()" class="buttonstyle"></td>
	</tr>
	</table>
	</td></tr>
		<tr>
		<td colspan="2" align="center">&nbsp;</td>
	</tr>
	<%if(strSortType.equalsIgnoreCase("A")){ %>
	<tr>
		<td colspan="2" align="center"><b>List of Accounts restructured during the given interval</b></td>
	</tr>
	<tr><td colspan="2" align="center">
		<table width="100%" border="0" cellpadding="1" cellspacing="0" class="outertable border1">
		<tr class="dataheader" align="center">
		<td width="10%"><b>New CBS Account No.</b></td>
		<td width="10%"><b>Old CBS Account No.</b></td>
		<td width="10%"><b>Borrower CBS Id</b></td>
		<td width="25%"><b>Borrower Name</b></td>
		<td width="11%"><b>NPV Before Restructure</b></td>
		<td width="11%"><b>NPV After Restructure</b></td>
		<td width="11%"><b>Profit/Loss</b></td>
		<td width="9%"><b>Date of Calculation</b></td>
		</tr>
		
		<%
		if(arrRow!=null && arrRow.size()>0)
		{
			int intSize = arrRow.size();
			for(int i=0;i<intSize;i++)
			{
				arrCol = (ArrayList)arrRow.get(i); %>
				<tr>
				<td align="center"><%=Helper.correctNull((String)arrCol.get(0))%></td>
				<td align="center"><%=Helper.correctNull((String)arrCol.get(1))%></td>
				<td align="center"><%=Helper.correctNull((String)arrCol.get(2))%></td>
				<td><%=Helper.correctNull((String)arrCol.get(3))%></td>
				<td align="right"><%=Helper.correctNull((String)arrCol.get(4))%></td>
				<td align="right"><%=Helper.correctNull((String)arrCol.get(5))%></td>
				<td align="right"><%=Helper.correctNull((String)arrCol.get(6))%></td>
				<td align="right"><%=Helper.correctNull((String)arrCol.get(7))%></td>
				</tr>
		<%	}
		}
		else
		{%>
			<tr>
			<td align="center" colspan="8"><b>&nbsp;</b></td>
			</tr>
			<tr>
			<td align="center" colspan="8"><b>No Data Found</b></td>
			</tr>
			<tr>
			<td align="center" colspan="8"><b>&nbsp;</b></td>
			</tr>
		<%}%>
		</table>
	</td></tr>
	<%} else if (strSortType.equalsIgnoreCase("B")){ %>
	<tr>
		<td colspan="2" align="center"><b>List of Accounts restructured during the given interval</b></td>
	</tr>
	<tr><td colspan="2" align="center">
		<table width="100%" border="0" cellpadding="1" cellspacing="0" class="outertable border1">
		<tr class="dataheader" align="center">
		<td width="10%"><b>Borrower CBS Id</b></td>
		<td width="25%"><b>Borrower Name</b></td>
		<td width="11%"><b>NPV Before Restructure</b></td>
		<td width="11%"><b>NPV After Restructure</b></td>
		<td width="11%"><b>Profit/Loss</b></td>
		<td width="9%"><b>Date of Calculation</b></td>
		</tr>
		
		<%
		if(arrRow!=null && arrRow.size()>0)
		{
			int intSize = arrRow.size();
			for(int i=0;i<intSize;i++)
			{
				arrCol = (ArrayList)arrRow.get(i); %>
				<tr>
				<td align="center"><%=Helper.correctNull((String)arrCol.get(0))%></td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(1))%></td>
				<%if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("")){ %>
				<td align="right">&nbsp;</td>
				<td align="right">&nbsp;</td>
				<td align="right">&nbsp;</td>
				<%}else{ %>
				<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))%></td>
				<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))%></td>
				<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%></td>
				<%} %>
				<td align="right"><%=Helper.correctNull((String)arrCol.get(5))%></td>
				</tr>
		<%	}
		}
		else
		{%>
			<tr>
			<td align="center" colspan="6"><b>&nbsp;</b></td>
			</tr>
			<tr>
			<td align="center" colspan="6"><b>No Data Found</b></td>
			</tr>
			<tr>
			<td align="center" colspan="6"><b>&nbsp;</b></td>
			</tr>
		<%}%>
		</table>
	</td></tr>
	<%} %>
	<tr class="datagrid" height="50px">
		<td colspan="2" align="center">&nbsp;</td>
	</tr>

	</table>
</td></tr></table>
<lapschoice:hiddentag/>
<input type="hidden" name="hidRSAccAvail" value="">
<input type="hidden" name="hidSortType" value="">
<input type="hidden" name="hidReport" value="<%=Helper.correctNull((String)hshValues.get("hidReport"))%>">
</form>
</body>
</html>