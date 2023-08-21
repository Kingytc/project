<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*,java.io.*"%>
 <%@page import="java.text.DecimalFormat" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<lapschoice:handleerror />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<%
ArrayList arrCol=new ArrayList();
ArrayList arrRow=new ArrayList();
ArrayList cbsCol=new ArrayList();
ArrayList cbsRrow=new ArrayList();

if(hshValues!=null && hshValues.size()>0)
{
	arrRow=(ArrayList)(hshValues.get("arrRow"));
	cbsRrow=(ArrayList)(hshValues.get("cbsRrow"));
	
}

%>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script LANGUAGE="JavaScript"	src="<%=ApplicationParams.getAppUrl()%>js/share/browservalidation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
 
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/hevp/hevpborrowerpage.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/hevp/jquery.js"></script> 
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/hevp/calendar.js"></script>

<SCRIPT   LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/hevp/ProposedAssethevp.js"></script>

<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/calendar.css" type="text/css">
 
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/goldstyle.css" type="text/css">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/goldblackfont.css" type="text/css"> 
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"	type="text/css">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css"><script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";

</script>
<script type="text/javascript">
function callclose()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
	document.forms[0].submit();
}

function callOnLoad()
{

}

function appendAdditionalRow(field){
 	//alert("I am adding");
	var eleTable=document.getElementById([field]);
	var rowsLength = eleTable.rows.length;
	
	if(rowsLength<=10)
	{
		var new_Row = eleTable.insertRow(rowsLength);
		var rwlength=rowsLength-1;
		var varRowID=rowsLength-2;
		new_Row.id="row_"+rowsLength;
		new_Row.className=eleTable.rows[rowsLength-2].className;
		var previous_RowCells=eleTable.rows[rowsLength-1].cells; 
		
		for(i=0;i<=previous_RowCells.length-1;i++)
		{

			var new_RowCell=new_Row.insertCell(i);
			new_RowCell.innerHTML=previous_RowCells[i].innerHTML;
			var new_CellElement=new_RowCell.childNodes[1];
			new_RowCell.align=previous_RowCells[i].align;
			
			for(var j=0;j<new_RowCell.childNodes.length;j++)
			{
			//new_RowCell.childNodes[j].value="";
			//alert(new_RowCell.childNodes[j].type);
				if(new_RowCell.childNodes[j].type=="text")
				{
					new_RowCell.childNodes[j].value="";				
				}
				
				if(new_RowCell.childNodes[j].type=="checkbox")
				{
					new_RowCell.childNodes[j].value="";	
				}
				
			}
		}
	}
	else
	{
		alert("Cannot add more rows");
	}
	document.forms[0].hidrow1.value=rowsLength;	
}
function removeSelectedRow(field)
{
	var varCheckedFlag = false;
	var eleTable = document.getElementById([field]);
	var rowsLength = eleTable.rows.length;
	//alert(rowsLength);
	for(var i=0;i<rowsLength;i++)
	{
		var currentRow = eleTable.rows[i];
		var eleCheckBox = currentRow.cells[0].childNodes[0];
		if(eleCheckBox != null && eleCheckBox.checked==true && rowsLength>2)
		{
			eleTable.deleteRow(i);
			rowsLength--;
			i--;
			if(!varCheckedFlag)
			{
			varCheckedFlag=true;
			}
		}
	   }
	 if(!varCheckedFlag && rowsLength==2)
		{
		alert("Atleast one row should present");
		}
	 else if(!varCheckedFlag)
	 {
       alert("Please Select the Check  Box to Remove");
               
	 }	
	 document.forms[0].hidrow3.value=rowsLength-1;
}
function callsave() {
	
			document.forms[0].hidAction.value="insert";
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanMethod.value="updateNP_Dsibursment";
			document.forms[0].hidBeanGetMethod.value="getNP_Dsibursment";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/psb59Disbursement.jsp";
			document.forms[0].submit();
			
}
</script>

</head>
<body  onload="callOnLoad()">
<form name="riskanddoc" >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td valign="top" colSpan="5"> 
      <jsp:include page="psb59SancDisb.jsp"> </jsp:include>
    </td>
  </tr>
</table> 
<table width="98%" border="1" cellpadding="3" cellspacing="0" bordercolorlight="#cccccc" bordercolordark="#FFFFFB" class="shadow" align="center">
<tr><td>     
<table width="90%" cellspacing="0" cellpadding="3" align="center" class="shadow">        
<tr class="dataheader" align="center">
	<td >
	<font size="2"><b>UPDATE DISBURSEMENT DETAILS</b></font></td></tr>
	<tr class="datagrid">
		<td>
		<div id="top2">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
	    <tr height="30px">
			<td><b>Application Reference ID</b></td>
			<td></td>
		</tr>
		<tr>
		          <td>
		           <table id="tabl_DisbDet" width="50%" align="center" bordercolorlight="#8f8369" bordercolordark="#fffffb" border="0" cellspacing="0" cellpadding="3" class="outer-bdr">
					<tr>
						<td></td>
						<td align="center">Disbursement Date</td>
						<td align="center">Transaction Reference No</td>
						<td align="center">Disbursement Amount</td>
						<td align="center">Mode</td>
						<td align="center">Remarks</td>
						<td align="center">EMI</td>
						<td align="center">Status</td>
						<td align="center">Account No</td>
						<td align="center">Tenure</td>
					</tr>
						<% if (arrRow != null && arrRow.size() > 0) {
								
								for (int i = 0; i < arrRow.size(); i++) {
								
									ArrayList arrayChild = (ArrayList) arrRow.get(i);
	                     %>
						<tr class="">
							<td width="2%"><input type="checkbox" name="radval_dynarow" onclick=""></td>
							<td width="5%"><input type="text" name="txt_date" style="width: 70%;" title="disbursement_date"
								id="txt_date_<%=i %>" value="<%=arrayChild.get(1)%>" onkeyup="todate(this);" class="datepickerNorm" onblur=""></td>
							<td width="5%"><input type="text" name="txt_trans_no" style="width: 100%;" title="transaction_ref_no"
								id="txt_trans_no_<%=i %>" value="<%=arrayChild.get(2)%>"></td>
							<td width="5%"><input type="text" name="txt_disb_amt" style="width: 100%;" title="disbursement_amount"
							    id="txt_disb_amt_<%=i %>" value="<%=arrayChild.get(3)%>"></td>
							<td width="5%"><select name="mode" style="width: 100%;" title="mode" id="mode_<%=i %>">
					          <option value="s">--Select--</option>
					          <option value="RTGS">RTGS</option>
					          <option value="NEFT">NEFT</option>
					          <option value="CHEQUE">CHEQUE</option>
					          </select></td>
							<td width="5%"><input type="text" name="txt_rem" style="width: 100%;" title="remarks"
								id="txt_rem_<%=i %>" value="<%=arrayChild.get(5)%>"></td>
							<td width="5%"><input type="text" name="txt_emi" style="width: 100%;" title="emi"
								id="txt_emi_<%=i %>" value="<%=arrayChild.get(6)%>"></td>
							<td width="5%"><select name="txt_stat" style="width: 100%;" title="status" id="txt_stat_<%=i %>">
					          <option value="s">--Select--</option>
					          <option value="FULL">Fully Disbursed</option>
					          <option value="PARTIAL">Partially Disbursed</option>
					          </select></td>
							<td width="5%"><input type="text" name="txt_acc_no" style="width: 100%;" title="account_no"
								id="txt_acc_no_<%=i %>" value="<%=arrayChild.get(8)%>"></td>
							<td width="5%"><input type="text" name="txt_tenure" style="width: 100%;" title="tenure"
								id="txt_tenure_<%=i %>" value="<%=arrayChild.get(9)%>"></td>
						</tr>
						<%}}else{
							for(int j=0;j<1;j++){%>
						<tr class="">
							<td width="2%"><input type="checkbox" name="radval_dynarow" onclick=""></td>
							<td width="5%"><input type="text" name="txt_date" style="width: 70%;" title="disbursement_date"
								id="txt_date_<%=j %>" value="" onkeyup="todate(this);" class="datepickerNorm" onblur=""></td>
							<td width="5%"><input type="text" name="txt_trans_no" style="width: 100%;" title="transaction_ref_no"
								id="txt_trans_no_<%=j %>" value=""></td>
							<td width="5%"><input type="text" name="txt_disb_amt" style="width: 100%;" title="disbursement_amount"
								id="txt_disb_amt_<%=j %>" value=""></td>
							<td width="5%"><select name="mode" style="width: 100%;" title="mode" id="mode_<%=j %>">
					          <option value="s">--Select--</option>
					          <option value="RTGS">RTGS</option>
					          <option value="NEFT">NEFT</option>
					          <option value="CHEQUE">CHEQUE</option>
					          </select></td>
							<td width="5%"><input type="text" name="txt_rem" style="width: 100%;" title="remarks"
								id="txt_rem_<%=j %>" value=""></td>
							<td width="5%"><input type="text" name="txt_emi" style="width: 100%;" title="emi"
								id="txt_emi_<%=j %>" value=""></td>
							<td width="5%"><select name="txt_stat" style="width: 100%;" title="status" id="txt_stat_<%=j %>">
					          <option value="s">--Select--</option>
					          <option value="FULL">Fully Disbursed</option>
					          <option value="PARTIAL">Partially Disbursed</option>
					          </select></td>
							<td width="5%"><input type="text" name="txt_acc_no" style="width: 100%;" title="account_no"
								id="txt_acc_no_<%=j %>" value=""></td>
							<td width="5%"><input type="text" name="txt_tenure" style="width: 100%;" title="tenure"
								id="txt_tenure_<%=j %>" value=""></td>
						</tr>
						<%} }%>
					</table>
					</td>
					<td>
					<img src="<%=ApplicationParams.getAppUrl()%>/img/icon_plus.png" width="15" height="15" alt="Click to Add new row"
						onclick="appendAdditionalRow('tabl_DisbDet');"
						style="cursor: hand;" />&nbsp;&nbsp;&nbsp;&nbsp;<br>
					<img src="<%=ApplicationParams.getAppUrl()%>/img/icon_minus.png"
						width="15" height="15" style="margin-top: 15px;"
						alt="Click to Remove selected row"
						onclick="removeSelectedRow('tabl_DisbDet');" style="cursor: hand;" />
				   </td>
				</tr>
		</table>
		</div>
		</td>
	</tr>
</table>
</td></tr>
</table>
<table border="0" cellspacing="0" cellpadding="0"  align="center">
      <tr valign="middle"> 
      <td>  
            <input type="button" name="cmdsave" value="Save" style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="callsave()"> 
        </td>
        <td>  
            <input type="button" name="cmdupdate" value="Update" style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="callupdate()"> 
        </td>
        <td>  
            <input type="button" name="cmdretry" value="Retry" style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="callretry()"> 
        </td>
       <td>  
            <input type="button" name="cmdclose" value="Close" style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="callclose()"> 
        </td>
      </tr>
</table>
<input type="hidden" name="hidUserId" value="">
<input type="hidden" name="hidrow1">
<input type="hidden" name="hidrow3">
 <input type="text" name="hidBeanId" value="NationalPortal">
    <input type="text" name="hidBeanGetMethod" value="getNP_Dsibursment">
    <input type="text" name="hidSourceUrl" value="">
    <input type="text" name="hidBeanMethod" value="updateNP_Dsibursment">
    <input type="hidden" name="hidApplicantId" value="">
    <input type="hidden" name="hidId" value="">
    <input type="hidden" name="hidrefId" value="">
    <input type="hidden" name="hidRefId" value="">
    <input type="hidden" name="hidappCode" value="">
    <input type="hidden" name="hidschId" value="">
    <input type="hidden" name="hidschName" value="">
    <input type="hidden" name="hidStatusFlag" value="">
    <input type="hidden" name="hidAppStatus" value="">
     <input type="hidden" name="hidsegtype" value="">
      <input type="text" name="hidAction" value="">
</form>

</body>
</html>