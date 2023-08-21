<%@include file="../share/directives.jsp"%>
<% 
	ArrayList arrList=null;
	arrList = (ArrayList) hshValues.get("arrRow");
%>
<html>
<head>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
function SelectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16,val17,val18,val19,val20,val21,val22,val23,val24,val25,val26,val27,val28)
{
	if(val12=="P")
	{
		document.all.idprod.innerText="Product";
	}
	else
	{
		document.all.idprod.innerText="Facility";
	}
	document.all.idproddesc.style.color="#942188";
	document.forms[0].txtaccountno.value=val1;
	document.forms[0].txtproposalno.value=val2;
	document.forms[0].hidsno.value=val3;
	document.all.idproddesc.innerText=val4;
	document.forms[0].txtNPADate.value=val5;
	document.forms[0].txtoldNPADate.value=val5;
	document.forms[0].txtsancamt.value=val6;
	document.forms[0].txtoldsancamt.value=val6;
	document.forms[0].txtoutstandingamt.value=val7;
	document.forms[0].txtoldoutstandingamt.value=val7;
	document.forms[0].txtinterestval.value=val8;
	document.forms[0].txtoldinterestval.value=val8;
	document.forms[0].hidCBSID.value=val10;
	document.forms[0].txt_appname.value=val11;
	document.forms[0].txtLoantype.value=val13;
	document.forms[0].hidModule.value=val13;
	document.forms[0].txtexecutionno.value=val14;
	document.forms[0].txt_executiondate.value=val15;
	document.forms[0].txtorgsolid.value=val16;
	document.forms[0].txtorgname.value=val17;
	document.forms[0].txtclearbalance.value=val18;
	document.forms[0].txtoldclearbalance.value=val18;
	document.forms[0].txt_secvalue.value=val19;
	document.forms[0].txt_oldsecvalue.value=val19;
	document.forms[0].txt_provisionvalue.value=val20;
	document.forms[0].txt_oldprovisionvalue.value=val20;
	document.forms[0].sel_fraudapplicant.value=val21;
	document.forms[0].sel_oldfraudapplicant.value=val21;
	document.forms[0].sel_npanormstatus.value=val22;
	document.forms[0].sel_oldnpanormstatus.value=val22;
	document.forms[0].txt_regionname.value=val23;
	document.forms[0].txtmannualFlag.value=val24;
	document.forms[0].sel_writeoffflag.value=val25;
	document.forms[0].sel_oldwriteoffflag.value=val25;
	document.forms[0].txt_othercharges.value=val26;
	document.forms[0].txt_oldothercharges.value=val26;
	document.forms[0].txt_SBCA_Flag.value=val27;
	document.forms[0].txt_reason.value=val28;
	
	document.all.iddesc.style.display="table-cell";
	document.all.idproddesc.style.display="table-cell";
	if(val24=="Y")
	{
		
		document.forms[0].txtLoantype.className='';
		document.forms[0].txtproposalno.className='';
		document.forms[0].hidsno.className='';
		document.forms[0].txtaccountno.className='';
		document.forms[0].txtorgsolid.className='';
		document.forms[0].txtorgname.className='';
		document.forms[0].txt_regionname.className='';
		
	}
	else
	{
		document.forms[0].txtLoantype.className='finaclefieldsbgcolor';
		document.forms[0].txtproposalno.className='finaclefieldsbgcolor';
		document.forms[0].hidsno.className='finaclefieldsbgcolor';
		document.forms[0].txtaccountno.className='finaclefieldsbgcolor';
		document.forms[0].txtorgsolid.className='finaclefieldsbgcolor';
		document.forms[0].txtorgname.className='finaclefieldsbgcolor';
		document.forms[0].txt_regionname.className='finaclefieldsbgcolor';
		document.all.idsearch.style.display="none";
	}
	
}
function doVerification() {

	
	document.forms[0].hidAction.value = "verify";
	document.forms[0].hidBeanId.value = "borrowersearch";
	document.forms[0].hidBeanMethod.value = "updateNPAVERFAccountDetails";
	document.forms[0].hidBeanGetMethod.value = "getNPAverfAccountDetails";
	document.forms[0].hidSourceUrl.value = "/action/npaverfaccountdetails.jsp";
	document.forms[0].action = appURL + "controllerservlet";			
	
	document.forms[0].submit();
	alert("Your application has been verified successfully");
	
}
function doReject() {

	
	document.forms[0].hidAction.value = "reject";
	document.forms[0].hidBeanId.value = "borrowersearch";
	document.forms[0].hidBeanMethod.value = "updateNPAVERFAccountDetails";
	document.forms[0].hidBeanGetMethod.value = "getNPAverfAccountDetails";
	document.forms[0].hidSourceUrl.value = "/action/npaverfaccountdetails.jsp";
	document.forms[0].action = appURL + "controllerservlet";			
	
	document.forms[0].submit();
	alert("Your application has been Rejected");
	 
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onLoad();">
<form method ="post" class="normal">
<br/>
<table width="90%" border="1" cellspacing="1" cellpadding="3" class="outertable" align="center">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
			<tr class="dataheader">
							<td colspan="6" align="center"> Customer Details</td>
						</tr>
			<tr>
			<td width="20%">Customer CBSID</td>
				<td width="15%"><input type="text"  name="hidCBSID" value="<%=Helper.correctNull((String)hshValues.get("strCBSID")) %>" class="finaclefieldsbgcolor" size="15">&nbsp;</td>
				<td width="15%">Customer Name</td>
				<td width="15%"  colspan="3"><input type="text" name="txt_appname" value="<%=Helper.correctNull((String)hshValues.get("strName")) %>" class="finaclefieldsbgcolor" size="45">&nbsp;</td>
			</tr>
			<tr class="dataheader">
					<td colspan="6" align="center"> Account Infomation</td>
				</tr>
				<tr>
					<td width="15%">Execution Number</td>
					<td width="15%"><input type="text" name="txtexecutionno" class="finaclefieldsbgcolor"></td>
					<td width="20%">Execution Date</td>
					<td width="15%"><input type="text" name="txt_executiondate"  class="finaclefieldsbgcolor"></td>
					<td width="15%">Loan type</td>
					<td width="15%"><select name="txtLoantype" class="finaclefieldsbgcolor" ">
						<option value=""><--select--></option>
						<option value="P">Retail</option>
						<option value="A">Agriculture</option>
						<option value="C">Corporate</option>
						<option value="S">SBCA </option>
						</select>&nbsp;</td>
				</tr>
				<tr>
					<td>Proposal Number</td>
					<td><input type="text" name="txtproposalno" id="txtproposalno" class="finaclefieldsbgcolor"></td>
					<td>Proposal S.No</td>
					<td><input type="text" name="hidsno" id="hidsno" class="finaclefieldsbgcolor"></td>
					<td id="iddesc"><span id="idprod">Facility</span>&nbsp; Description</td>
					<td><span id="idproddesc">&nbsp;</span><input type="hidden" name="hidModule"></td>
				</tr>
				<tr>
					<td width="15%"><span id="idcbsacc">CBS Account Number</span></td>
					<td width="15%"><input type="text" name="txtaccountno" id="txtaccountno" class="finaclefieldsbgcolor"></td>
					<td width="20%">Organisation</td>
					<td width="15%" colspan="3"><input type="text" name="txtorgsolid" id="txtorgsolid" class="finaclefieldsbgcolor" size="5">&nbsp;&nbsp;<input type="text" name="txtorgname" id="txtorgname" class="finaclefieldsbgcolor" size="35">&nbsp;&nbsp;<input type="text" name="txt_regionname" id="txt_regionname" class="finaclefieldsbgcolor" size="40">
					<span onClick="javascript:showOrganizationSearch('<%=ApplicationParams.getAppUrl()%>','txtorgsolid','txtorgname');" style="cursor: hand"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													id="idsearch" border="0" ></span>
					</td>
				</tr>
				
				<tr>
					<td><span style="float:left">Sanctioned Amount</span> <span style="float:right">Rs.</span></td>
					<td><input type="text" name="txtsancamt" style="text-align: right;" onblur="" onkeypress="allowNumber(this);">
					<input type="hidden" name="txtoldsancamt"></td>
					<td><span style="float:left">CBS Security Value</span> <span style="float:right">Rs.</span></td>
					<td><input type="text" name="txt_secvalue"  style="text-align: right;" onkeypress="allowNumber(this);"
						  onblur=""><input type="hidden" name="txt_oldsecvalue"></td>
					
					<td>NPA Date</td>
					<td><input type="text" name="txtNPADate" size="14" onBlur="checkDate(this);checkmaxdate(this,currentDate);">
					&nbsp;<a alt="Select date from calender" href="#"
																	onClick="callCalender('txtNPADate')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border="0" alt="Select date from calender"></a>
																	<input type="hidden" name="txtoldNPADate">
					</td>
				</tr>
				
				<tr>
				<td width="20%"><span style="float:left">Outstanding Amount</span> <span style="float:right">Rs.</span></td>
					<td width="15%"><input type="text" name="txtoutstandingamt"  style="text-align: right;"  onkeypress="allowNumber(this);" 
					onblur="calclearbalance();"><input type="hidden" name="txtoldoutstandingamt"></td>
					<td><span style="float:left">Unrealized Interest Value</span> <span style="float:right">Rs.</span></td>
					<td><input type="text" name="txtinterestval"  style="text-align: right;" onkeypress="allowNumber(this);" 
						 onblur="calclearbalance();"><input type="hidden" name="txtoldinterestval"></td>
					<td><span style="float:left">Clear Balance Amount</span> <span style="float:right">Rs.</span></td>
					<td><input type="text" name="txtclearbalance"  style="text-align: right;" 
						 onblur="roundtxt(this);calclearbalance();"><input type="hidden" name="txtoldclearbalance"></td>
				</tr>
				<tr>
				<td>Write Off Flag</td>
				<td><select name="sel_writeoffflag">
						<option value=""><--select--></option>
						<option value="Y">Yes</option>
						<option value="N">No</option>
						</select>
						<input type="hidden" name="sel_oldwriteoffflag">
				</td>
				<td>Other Charges</td>
				<td><input type="text" name="txt_othercharges"  style="text-align: right;" onkeypress="allowNumber(this);"  
					onblur=""><input type="hidden" name="txt_oldothercharges"></td>
				</tr>
				<tr>
				<td>Fraud Applicant</td>
					<td>
						<select name="sel_fraudapplicant">
						<option value=""><--select--></option>
						<option value="Y">Yes</option>
						<option value="N">No</option>
						</select>
						<input type="hidden" name="sel_oldfraudapplicant">
					</td>
				<td>NPA Norm Status</td>
				<td>
					<select name="sel_npanormstatus">
						<option value=""><--select--></option>
						<option value="SS">SS</option>
						<option value="DS1">DS1</option>
						<option value="DS2">DS2</option>
						<option value="DS3">DS3</option>
						<option value="LOSS">LOSS</option>
						</select>
						<input type="hidden" name="sel_oldnpanormstatus">
				</td>
				<td><span style="float:left">Provision Value</span> <span style="float:right">Rs.</span></td>
					<td><input type="text" name="txt_provisionvalue"  style="text-align: right;" onkeypress="allowNumber(this);"  
					onblur=""><input type="hidden" name="txt_oldprovisionvalue"></td>
				</tr>
				<tr>
				<td>Reason for MOC&nbsp;</td>
				<td colspan="5"><textarea name="txt_reason"
													cols="90" rows="5"  onKeyPress="notAllowSingleQuote();textlimit(this,499)" onKeyUp="textlimit(this,499)"></textarea>&nbsp;</td>
				</tr>
				<tr><td colspan="6">&nbsp;</td></tr>
			</table>
		</td>
	</tr>
</table>

<table  width="95%" border="0" cellspacing="0" cellpadding="3" class="outertable"  align="center">
<tr><td>&nbsp;</td></tr>
<tr>
	
</tr>
<tr><td>&nbsp;</td></tr>
</table>

  <table width="90%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor"  align="center">   
   <%
   if( arrList!=null && arrList.size()>0)
   {%>
   
	  <tr class="dataheader" align="center">
	  <td width="3%">&nbsp;</td>
	   <td width="8%">Loan Type</td>
	  <td width="10%">Proposal No</td>
	  <td width="5%">S.No</td>
	   <td width="10%">CBS Account No</td>
	  <td width="10%">Sanction Amount</td>
	  <td width="10%">Outstanding</td>
	  <td width="10%">Clear Balance Amount</td>
	  <td width="10%">CBS security Value</td>
	  <td width="10%">Fraud Applicant</td>
	  <td width="10%">NPA Norm Status</td>
	  <td width="10%">Provision Value</td>
	  <td colspan="2">Verification Status</td>
	  </tr> 
	   
	   <%int arrSize=arrList.size();	   
	   ArrayList  arrData=null;
	   for(int i=0;i<arrSize;i++)
		   {
		   		arrData=(ArrayList)arrList.get(i);
		   		
%> 
		    	<tr class="datagrid"> 
		    	<td align="center"><input type="radio" id="myRadio" name="radiobutton" onclick="SelectValues('<%=Helper.correctNull((String)arrData.get(0))%>','<%=Helper.correctNull((String)arrData.get(1))%>',
		    	'<%=Helper.correctNull((String)arrData.get(2))%>','<%=Helper.correctNull((String)arrData.get(3))%>',
		    	'<%=Helper.correctNull((String)arrData.get(4))%>','<%=Helper.correctNull((String)arrData.get(5))%>',
		    	'<%=Helper.correctNull((String)arrData.get(6))%>','<%=Helper.correctNull((String)arrData.get(7))%>',
		    	'<%=Helper.correctNull((String)arrData.get(8))%>','<%=Helper.correctNull((String)arrData.get(9))%>',
		    	'<%=Helper.correctNull((String)arrData.get(10))%>','<%=Helper.correctNull((String)arrData.get(11))%>'
		    	,'<%=Helper.correctNull((String)arrData.get(12))%>','<%=Helper.correctNull((String)arrData.get(13))%>'
		    	,'<%=Helper.correctNull((String)arrData.get(14))%>','<%=Helper.correctNull((String)arrData.get(15))%>'
		    	,'<%=Helper.correctNull((String)arrData.get(16))%>','<%=Helper.correctNull((String)arrData.get(17))%>'
		    	,'<%=Helper.correctNull((String)arrData.get(18))%>','<%=Helper.correctNull((String)arrData.get(19))%>'
		    	,'<%=Helper.correctNull((String)arrData.get(20))%>','<%=Helper.correctNull((String)arrData.get(21))%>'
		    	,'<%=Helper.correctNull((String)arrData.get(23))%>','<%=Helper.correctNull((String)arrData.get(24))%>'
		    	,'<%=Helper.correctNull((String)arrData.get(25))%>','<%=Helper.correctNull((String)arrData.get(26))%>'
		    	,'<%=Helper.correctNull((String)arrData.get(27))%>','<%=Helper.correctNull((String)arrData.get(28))%>')" style="border: none;">&nbsp;</td>
      			<td align="center"><%=Helper.correctNull((String)arrData.get(11))%>&nbsp;</td>
      			<td align="center"><%=Helper.correctNull((String)arrData.get(1))%>&nbsp;</td>
      			<td align="center"><%=Helper.correctNull((String)arrData.get(2))%>&nbsp;</td>
      			<td><b><%=Helper.correctNull((String)arrData.get(0))%>&nbsp;</b></td>
      			<td align="right"><%=Helper.correctNull((String)arrData.get(5))%>&nbsp;</td>
      			<td align="right"><%=Helper.correctNull((String)arrData.get(6))%>&nbsp;</td>
      			<td align="right"><%=Helper.correctNull((String)arrData.get(17))%>&nbsp;</td>
      			<td align="right"><%=Helper.correctNull((String)arrData.get(18))%>&nbsp;</td>
      			<td align="center"><%=Helper.correctNull((String)arrData.get(22))%>&nbsp;</td>
      			<td align="center"><%=Helper.correctNull((String)arrData.get(21))%>&nbsp;</td>
      			<td align="right"><%=Helper.correctNull((String)arrData.get(19))%>&nbsp;</td>
      			
      			<%if(Helper.correctNull((String)arrData.get(29)).equalsIgnoreCase("Y")||Helper.correctNull((String)arrData.get(30)).equalsIgnoreCase("Y")){ %>
      			<td align="center"><input type="button" name="cmdverification" value="Verification"  disabled align="center" onClick="doVerification()" class="buttonStyle"></td>
      			<td align="center"><input type="button" name="cmdreject" value="Reject"  disabled align="center" onClick="doReject()" class="buttonStyle"></td>
      			
      			<%}else{ %>
      			<td align="center"><input type="button" name="cmdverification" value="Verification" align="center" onClick="doVerification()" class="buttonStyle"></td>
      			<td align="center"><input type="button" name="cmdreject" value="Reject" align="center" onClick="doReject()" class="buttonStyle"></td>
      			<%}%>
      			
       			</tr>
      <%}}%>
  </table>
  <br/><br/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="txtinsertFlag">
<input type="hidden" name="txtmannualFlag">
<input type="hidden" name="txt_SBCA_Flag">
</form>
</body>
</html>
