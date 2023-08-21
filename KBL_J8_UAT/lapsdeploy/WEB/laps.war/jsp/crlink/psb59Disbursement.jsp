<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*,java.io.*"%>
 <%@page import="java.text.DecimalFormat" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<lapschoice:handleerror />
   
<%
   	DecimalFormat dc = new DecimalFormat();
   	dc.setGroupingUsed(false);
   	dc.setMinimumFractionDigits(2);
   	dc.setMaximumFractionDigits(2);

   	java.text.NumberFormat nf = java.text.NumberFormat
   			.getNumberInstance();
   	nf.setGroupingUsed(false);
   	nf.setMaximumFractionDigits(2);
   	nf.setMinimumFractionDigits(2);
   %> 

<%

String strOrgShortCode = Helper.correctNull((String)session.getAttribute("strOrgShortCode"));
String lib_total_amount=Helper.correctNull((String) hshValues.get("lib_total_amount"));
if(lib_total_amount=="")
{
	lib_total_amount="0";
}

 	String strAppNo = Helper.correctNull((String) hshValues.get("hidAppNo"));
	String strAppstatus=Helper.correctNull((String) hshValues.get("strAppstatus"));
	String strAppId = Helper.correctNull((String) hshValues.get("Appid"));
	String COMAPP_CBSID = Helper.correctNull((String) hshValues.get("COMAPP_CBSID"));
	String RefId= Helper.correctNull((String) session.getAttribute("apprefid")); 
	String SegType= Helper.correctNull((String) session.getAttribute("SegType"));
	if (SegType.equals("")) {
		SegType = Helper.correctNull((String) session.getAttribute("strHidsegType"));
	}
	
	String strOrgLevel=Helper.correctNull((String)hshValues.get("strOrgLevel"));
	String strBranchHead=Helper.correctNull((String)hshValues.get("strBranchHead"));
	String strhidAppno = Helper.correctNull((String)hshValues.get("hidappno"));
	String hidApplicantId1 =Helper.correctNull((String)hshValues.get("RefId"));
	String hidschemeName=Helper.correctNull((String)hshValues.get("schemeName"));
	
	if (hidApplicantId1.equalsIgnoreCase("")) {
		hidApplicantId1 = Helper.correctNull((String) session.getAttribute("strapprefid"));
	}

	
 %>
	

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>PROPERTY AND DETAILED BORROWERS</title>
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
String APIresp=Helper.correctNull((String)hshValues.get("respmesg"));
%>
<style type="text/css">
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 370;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
a:hover {  color: #FF3300}
textarea {  font-family: "MS Sans Serif"; font-size: 10px; border-style: groove; color: #003399}
</STYLE>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>

<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/NationalPortal.css" type="text/css">
 
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varOrgLevel="<%=strOrgLevel%>";
var varBranchHead="<%=strBranchHead%>";
var varschemeName="<%=hidschemeName%>";

function callclose()
{
	window.close();
}

function callOnLoad()
{

	var status="<%=APIresp%>";
	if(status!=""){
	alert(status);
	document.forms[1].cmdupdate.disabled = true;
	}
	var Buttondisable="<%=Helper.correctNull((String) hshValues.get("ButtondisableFalg"))%>";
	if(Buttondisable!=""){
	//document.forms[1].cmdupdate.disabled = true;
	}
	
	
	
	<%
	 int intEMsize1 = 0;
	 ArrayList arrayChildss =new ArrayList();
		if (arrRow != null && arrRow.size() > 0) {
			intEMsize1 = arrRow.size();
		
			if(intEMsize1 > 1){
				
				for (int i = 0; i < arrRow.size(); i++) {

					arrayChildss = (ArrayList) arrRow.get(i);
	%>
			   	document.forms[1].mode[<%=i%>].value = "<%=arrayChildss.get(15)%>";
			 	document.forms[1].txt_stat[<%=i%>].value = "<%=arrayChildss.get(7)%>";
	<%}}
				else{
					 
					for( int j = 0; j < 1; j++ ){	
						arrayChildss = (ArrayList) arrRow.get(j);
						if(arrayChildss!=null && arrayChildss.size()>0)
						{ 
		%>			
					document.forms[1].mode.value = "<%=arrayChildss.get(15)%>" ;
					document.forms[1].txt_stat.value = "<%=arrayChildss.get(7)%>" ;
<%}	}}}%>

if(varOrgLevel=="A" && varBranchHead == "N")
{
	document.forms[1].cmdupdate.disabled = true;
}
else
{

<% if (arrRow != null && arrRow.size() > 0) {
	
	for (int i = 0; i < arrRow.size(); i++) {
	   
	%>
document.forms[1].radval_dynarow[<%=i%>].disabled = true;	
document.forms[1].txt_date[<%=i%>].disabled = true;
document.forms[1].txt_trans_no[<%=i%>].disabled = true;
document.forms[1].txt_disb_amt[<%=i%>].disabled = true;
document.forms[1].mode[<%=i%>].disabled = true;
document.forms[1].txt_rem[<%=i%>].disabled = true;
document.forms[1].txt_emi[<%=i%>].disabled = true;
document.forms[1].txt_stat[<%=i%>].disabled = true;
document.forms[1].txt_acc_no[<%=i%>].disabled = true;
document.forms[1].txt_tenure[<%=i%>].disabled = true;
//document.forms[1].txt_tot_disb[<%=i%>].disabled = true;
<%	
	}
}
%>
//document.forms[1].cmdsave.disabled = true;
}
document.forms[1].cmdupdate.disabled = false;
}
function roundtxt(trate)
{
	
	var temp2="";
	if (trate.value==".") trate.value=0;
	var temp1= new Number(trate.value);
	var floc=0;

	temp=new String(Math.round(temp1*100));
	temp2=String(temp/100);
	if (temp==0)
	{
		temp2="0.00";
	}
	if (temp2.substr(0,1)==".") temp2="0"+temp2;
	if (temp2.substr(temp2.length-2,1)==".") temp2=temp2+"0";
	if (parseInt(temp2.lastIndexOf("."))<0)
	{	
		temp2 = temp2+".00";
	}
	trate.value = temp2;
	return trate.value;
}

function allowNumberNew(obj) {
	
	var key = window.event.keyCode;
	var val=obj.value;
	if(key==46 && val.indexOf(".")!=-1)
	{
		return false; 
	}
	if(!((key>47 && key<58)||(key==46)))
	{
		return false; 
	}else{
		return true;
	}
	
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
	document.forms[1].hidrow1.value=rowsLength;	
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
	 document.forms[1].hidrow3.value=rowsLength-1;
}
function callsave() {

	var varLength = document.forms[1].radval_dynarow.length;
	 if(varLength>1){	 	
	 	for(var i=0;i<varLength;i++){
		 		 
	 		if(document.forms[1].txt_date[i].value==""){
	 			alert("Disbursement Date Can Not Be Empty.");
	 			document.forms[1].txt_date[i].focus();
	 			return;
	 		}
	 		if(document.forms[1].txt_trans_no[i].value== ""){
	 			alert("Transaction Reference Number Can Not Be Empty.");
	 			document.forms[1].txt_trans_no[i].focus();
	 			return;
	 		}
	 		if(document.forms[1].txt_disb_amt[i].value== ""){
	 			alert("Disbursement Amount Can Not Be Empty.");
	 			document.forms[1].txt_disb_amt[i].focus();
	 			return;
	 		}
	 		if(document.forms[1].mode[i].value== ""){
	 			alert("Mode Can Not Be Empty.");
	 			document.forms[1].mode[i].focus();
	 			return;
	 		}
	 		if(document.forms[1].txt_rem[i].value== ""){
	 			alert("Remarks Can Not Be Empty.");
	 			document.forms[1].txt_rem[i].focus();
	 			return;
	 		}
	 		if(document.forms[1].txt_emi[i].value== ""){
	 			alert("EMI Can Not Be Empty.");
	 			document.forms[1].txt_emi[i].focus();
	 			return;
	 		}
	 		if(document.forms[1].txt_stat[i].value== ""){
	 			alert("Status Can Not Be Empty.");
	 			document.forms[1].txt_stat[i].focus();
	 			return;
	 		}
	 		if(document.forms[1].txt_acc_no[i].value== ""){
	 			alert("Account Number Can Not Be Empty.");
	 			document.forms[1].txt_acc_no[i].focus();
	 			return;
	 		}
	 		if(document.forms[1].txt_tenure[i].value== ""){
	 			alert("Tenure(In Months) Can Not Be Empty.");
	 			document.forms[1].txt_tenure[i].focus();
	 			return;
	 		}
	 		
	 	}
	 }else{ 

		 if(document.forms[1].txt_date.value==""){
	 			alert("Disbursement date Can Not Be Empty.");
	 			document.forms[1].txt_date.focus();
	 			return;
	 		}
	 		if(document.forms[1].txt_trans_no.value== ""){
	 			alert("Transaction Reference Number Can Not Be Empty.");
	 			document.forms[1].txt_trans_no.focus();
	 			return;
	 		}
	 		if(document.forms[1].txt_disb_amt.value== ""){
	 			alert("Disbursement Amount Can Not Be Empty.");
	 			document.forms[1].txt_disb_amt.focus();
	 			return;
	 		}
	 		if(document.forms[1].mode.value== ""){
	 			alert("Mode Can Not Be Empty.");
	 			document.forms[1].mode.focus();
	 			return;
	 		}
	 		if(document.forms[1].txt_rem.value== ""){
	 			alert("Remarks Can Not Be Empty.");
	 			document.forms[1].txt_rem.focus();
	 			return;
	 		}
	 		if(document.forms[1].txt_emi.value== ""){
	 			alert("EMI Can Not Be Empty.");
	 			document.forms[1].txt_emi.focus();
	 			return;
	 		}
	 		if(document.forms[1].txt_stat.value== ""){
	 			alert("Status Can Not Be Empty.");
	 			document.forms[1].txt_stat.focus();
	 			return;
	 		}
	 		if(document.forms[1].txt_acc_no.value== ""){
	 			alert("Account Number Can Not Be Empty.");
	 			document.forms[1].txt_acc_no.focus();
	 			return;
	 		}
	 		if(document.forms[1].txt_tenure.value== ""){
	 			alert("Tenure(In Months) Can Not Be Empty.");
	 			document.forms[1].txt_tenure.focus();
	 			return;
	 		}
	 		
	 }
	 document.forms[1].hidschName.value=varschemeName;
		
			document.forms[1].hidAction.value="insert";
			document.forms[1].hidBeanId.value="NationalPortal";
			document.forms[1].hidBeanMethod.value="updateNP_Dsibursment";
			document.forms[1].hidBeanGetMethod.value="getNP_Dsibursment";
			document.forms[1].action=appURL+"controllerservlet";
			document.forms[1].hidSourceUrl.value="/action/psb59Disbursement.jsp";
			document.forms[1].submit();

			alert("Saved Successfully");
}
function doSearch()
{
	document.all.ifrmexistdata.src=appURL+"action/msme_cbsidClassfaci_canara.jsp?hidBeanId=cbsMigration&hidBeanGetMethod=NewMsmeCanaraCustomerDemograhicSearch&txtvalue="+document.forms[0].txt_cbsid_msme.value+
	"&constitutionVal="+document.forms[0].sel_consti.value+"&strAppliNum="+strAppliNum;
}
function callupdate(){


	alert("once disbursemt details Uploaded to online protal, it cannot be modified plz ensure corretcness data");
	document.forms[1].hidschName.value=varschemeName;
	document.forms[1].cmdupdate.disabled = true;
	document.forms[1].hidBeanId.value="NationalPortal";
	document.forms[1].hidBeanGetMethod.value="invokeUpdateDsibursmentAPI";
	document.forms[1].action = appURL+"action/psb59Disbursement.jsp";
	document.forms[1].submit();

	
	
	alert("Saved Successfully");
}
</script>


</style>
</head>
<body onload="callOnLoad()">
<form>
<!--<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td valign="top" colSpan="5"> 
      <jsp:include page="psb59SancDisb.jsp"/>
    </td>
  </tr>
</table>
--></form>
<form name="riskanddoc" name="" method="post">
<table width="98%" border="1" cellpadding="3" cellspacing="0" bordercolorlight="#cccccc" bordercolordark="#FFFFFB" class="shadow" align="center">
<tr><td>     
<table width="90%" cellspacing="0" cellpadding="3" align="center" class="shadow">        
<tr class="dataheader" align="center">
	<td >
	<font size="2"><b>UPDATE DISBURSEMENT DETAILS</b></font></td></tr>
	<tr class="datagrid">
		<td>
		<div id="top2">
		<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="left">
		<col width="6%">
		<col width="10%">
		<col width="6%">
		<col width="10%">
		<tr height="30px" align="center">
				<td><b>Application Reference ID</b></td>
				<td><%=hidApplicantId1%></td>
				
			</tr>
			</table>
		</td></tr>
		<!-- <tr>
		<td>
		<table width="40%" border="0" cellspacing="0" cellpadding="3" align="left">
		<col width="6%">
		<col width="8%">
		<col width="6%">
		<tr height="50px">
		  <td><b>Application No</b></td>
		  <td><input type="text" name="txt_application" style="width: 100%;" value=""> </td>
		  <td>
			&nbsp;&nbsp;<a href="javascript:doSearch()" id="search_icon" class="blackfont" tabindex="6"> 
				<img src="<%=ApplicationParams.getAppUrl()%>img/Search.png" style="border: none" align="middle" > 
			</a>
			</td>
		</tr>
		</table>
		</td></tr>-->
		<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="4" align="center" class="outertable">
		<tr>
		          <td>
		           <table id="tabl_DisbDet" width="100%" align="center"  border="0" cellspacing="0" cellpadding="3" class="outer-bdr">
					<tr>
						<td></td>
						<td align="center">Disbursement Date<font size="1" face="MS Sans Serif" color="#FF0000">*</font></td>
						<td align="center">Transaction Reference No.<font size="1" face="MS Sans Serif" color="#FF0000">*</font></td>
						<td align="center">Disbursement Amount<font size="1" face="MS Sans Serif" color="#FF0000">*</font></td>
						<td align="center">Mode<font size="1" face="MS Sans Serif" color="#FF0000">*</font></td>
						<td align="center">Remarks<font size="1" face="MS Sans Serif" color="#FF0000">*</font></td>
						<td align="center">EMI<font size="1" face="MS Sans Serif" color="#FF0000">*</font></td>
						<td align="center">Status<font size="1" face="MS Sans Serif" color="#FF0000">*</font></td>
						<td align="center">Account No.<font size="1" face="MS Sans Serif" color="#FF0000">*</font></td>
						<td align="center">Tenure<font size="1" face="MS Sans Serif" color="#FF0000">*</font></td>
						<!-- <td align="center">Total Disbursement<font size="1" face="MS Sans Serif" color="#FF0000">*</font></td> -->
					</tr>
						<% if (arrRow != null && arrRow.size() > 0) {
								
								for (int i = 0; i < arrRow.size(); i++) {
								
									ArrayList arrayChild = (ArrayList) arrRow.get(i);
	                     %>
						<tr class="">
							<td width="2%"><input type="checkbox" name="radval_dynarow" onclick=""></td>
							<td width="5%"><input type="text" name="txt_date" style="width: 70%;" title="disbursement_date"
								id="txt_date_<%=i %>" value="<%=arrayChild.get(1)%>" class="datepickerNorm" onkeypress="allowDate()" onBlur="checkDate(this);" onkeyup="todate(this)"></td>
							<td width="5%"><input type="text" name="txt_trans_no" style="width: 100%;" title="transaction_ref_no"
								id="txt_trans_no_<%=i %>" value="<%=arrayChild.get(2)%>"></td>
							<td width="5%"><input type="text" name="txt_disb_amt" style="text-align:right;" title="disbursement_amount" onBlur="return roundtxt(this)"
							    id="txt_disb_amt_<%=i %>" value="<%=arrayChild.get(3)%>" style="text-align:right;" onKeyPress="return allowNumberNew(this)"></td>
							<td width="5%"><select name="mode" style="width: 100%;" title="mode" id="mode_<%=i %>">
					          <option value="s">--Select--</option>
					          <option value="RTGS">RTGS</option>
					          <option value="NEFT">NEFT</option>
					          <option value="CHEQUE">CHEQUE</option>
					          <option value="SAVINGS">SAVINGS</option>
					          <option value="OTHERS">OTHERS</option>
					          </select></td>
							<td width="5%"><input type="text" name="txt_rem" style="width: 100%;" title="remarks"
								id="txt_rem_<%=i %>" value="<%=arrayChild.get(5)%>"></td>
							<td width="5%"><input type="text" name="txt_emi" style="text-align:right;" title="emi"
								id="txt_emi_<%=i %>" value="<%=arrayChild.get(6)%>" onBlur="return roundtxt(this)" onKeyPress="return allowNumberNew(this)" ></td>
							<td width="5%"><select name="txt_stat" style="width: 100%;" title="status" id="txt_stat_<%=i %>">
					          <option value="s">--Select--</option>
					          <option value="FULL">Fully Disbursed</option>
					          <option value="PARTIAL">Partially Disbursed</option>
					          </select></td>
							<td width="5%"><input type="text" name="txt_acc_no" style="width: 100%;" title="account_no"
								id="txt_acc_no_<%=i %>" value="<%=arrayChild.get(8)%>"></td>
							<td width="5%"><input type="text" name="txt_tenure" style="text-align:right;" title="tenure"
								id="txt_tenure_<%=i %>" value="<%=arrayChild.get(9)%>"  onBlur="return roundtxt(this)" onKeyPress="return allowNumberNew(this)"></td>
							<!-- <td width="5%"><input type="text" name="txt_tot_disb" style="width: 100%;" title="total_disb"
								id="txt_tot_disb_<%=i %>" value="0" onkeypress="allowInteger('this')"></td> -->
						</tr>
						<%}}else{
							for(int j=0;j<1;j++){%>
						<tr class="">
							<td width="2%"><input type="checkbox" name="radval_dynarow" onclick=""></td>
							<td width="5%"><input type="text" name="txt_date" style="width: 70%;" title="disbursement_date"
								id="txt_date_<%=j %>" value="" class="datepickerNorm" onkeypress="allowDate();" onBlur="checkDate(this);"></td>
							<td width="5%"><input type="text" name="txt_trans_no" style="width: 100%;" title="transaction_ref_no"
								id="txt_trans_no_<%=j %>" value=""></td>
							<td width="5%"><input type="text" name="txt_disb_amt" onBlur=" return roundtxt(this)" style="width: 100%;" title="disbursement_amount"
								id="txt_disb_amt_<%=j %>" value="" onKeyPress="return allowNumberNew(this)"></td>
							<td width="5%"><select name="mode" style="width: 100%;" title="mode" id="mode_<%=j %>">
					          <option value="s">--Select--</option>
					          <option value="RTGS">RTGS</option>
					          <option value="NEFT">NEFT</option>
					          <option value="CHEQUE">CHEQUE</option>
					          <option value="SAVINGS">SAVINGS</option>
					          <option value="OTHERS">OTHERS</option>
					          </select></td>
							<td width="5%"><input type="text" name="txt_rem" style="width: 100%;" title="remarks"
								id="txt_rem_<%=j %>" value=""></td>
							<td width="5%"><input type="text" name="txt_emi" style="width: 100%;" title="emi"
								id="txt_emi_<%=j %>" value="" onBlur="roundtxt(this)" onKeyPress="return allowNumberNew(this)"></td>
							<td width="5%"><select name="txt_stat" style="width: 100%;" title="status" onkeypress="allowInteger('this')" id="txt_stat_<%=j %>">
					          <option value="s">--Select--</option>
					          <option value="FULL">Fully Disbursed</option>
					          <option value="PARTIAL">Partially Disbursed</option>
					          </select></td>
							<td width="5%"><input type="text" name="txt_acc_no" style="width: 100%;" title="account_no"
								id="txt_acc_no_<%=j %>" value="" onkeypress="allowInteger('this')"></td>
							<td width="5%"><input type="text" name="txt_tenure" onBlur="roundtxt(this)" style="width: 100%;" title="tenure"
								id="txt_tenure_<%=j %>" value="" onKeyPress="return allowNumberNew(this)"></td>
						</tr>
						<%} }%>
					</table>
					</td>
					<%if(strOrgLevel.equalsIgnoreCase("A") && strBranchHead.equalsIgnoreCase("N")){ %>
					 <td>
					<img src="<%=ApplicationParams.getAppUrl()%>img/add.png" width="15" height="15" alt="Click to Add new row"
						onclick="appendAdditionalRow('tabl_DisbDet');"
						style="cursor: hand;" />&nbsp;&nbsp;&nbsp;&nbsp;<br>
					<img src="<%=ApplicationParams.getAppUrl()%>img/cancel.png"
						width="15" height="15" style="margin-top: 15px;"
						alt="Click to Remove selected row"
						onclick="removeSelectedRow('tabl_DisbDet');" style="cursor: hand;" />
				   </td> 
				   <%} %>
				</tr>
		</table>
		</td>
		</tr>
		</div>
		</td>
	</tr>
</table>
</td></tr>
</table>
<table border="0" cellspacing="0" cellpadding="0"  align="center">
      <tr valign="middle"> 
      <td>  
            <input type="button" name="cmdsave" value="Save" class="buttonStyle" onClick="callsave()"> 
        </td>
        <td>  
            <input type="button" name="cmdupdate" value="Authorize"  class="buttonStyle" onClick="callupdate()"> 
        </td>
       
       <td>  
            <input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="callclose()"> 
        </td>
      </tr>
</table>

<iframe height="0" width="0" id="ifrmexistdata" frameborder="0" style="border: 0"></iframe>
<input type="hidden" name="hidUserId" value="">
<input type="hidden" name="hidrow1">
<input type="hidden" name="hidrow3">
 <input type="hidden" name="hidBeanId" value="NationalPortal">
    <input type="hidden" name="hidBeanGetMethod" value="getNP_Dsibursment">
    <input type="hidden" name="hidSourceUrl" value="">
    <input type="hidden" name="hidBeanMethod" value="updateNP_Dsibursment">
    <input type="hidden" name="hidApplicantId" value="<%=hidApplicantId1%>">
    <input type="hidden" name="hidId" value="">
    <input type="hidden" name="hidrefId" value="">
    <input type="hidden" name="hidRefId" value="<%=RefId%>">
    <input type="hidden" name="hidappCode" value="">
    <input type="hidden" name="hidschId" value="">
    <input type="hidden" name="hidschName" value="">
    <input type="hidden" name="hidStatusFlag" value="">
    <input type="hidden" name="hidAppStatus" value="">
     <input type="hidden" name="hidsegtype" value="<%=SegType%>">
      <input type="hidden" name="hidAction" value="">
      <input type="hidden" name="hidappno" value="<%=strhidAppno%>">

</form>
</body>
</html>