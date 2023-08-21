<%@include file="../share/directives.jsp"%>
<%
ArrayList arrproposedsecurityRow=(ArrayList)hshValues.get("arrproposedFacility");
ArrayList arrpropsecCollRow=(ArrayList)hshValues.get("arrproposedCollateralSec");
ArrayList arrpropsecurityCol=new ArrayList();
ArrayList arrpropsecurity=new ArrayList();
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();

ArrayList arrBorrarr= new ArrayList();
ArrayList arrBorrcol= new ArrayList();

arrRow=(ArrayList)hshValues.get("arrRow");
arrBorrarr=(ArrayList)hshValues.get("arrBorrarr");
String secValue = "";
int sno=1;

String strIntIndx = Helper.correctNull((String)hshValues.get("strIntIndexid"));
String strProcessFee = Helper.correctNull((String)hshValues.get("strProcessingFee"));
if(strProcessFee .equalsIgnoreCase("0.00"))
{
	strProcessFee = Helper.correctNull((String)hshValues.get("KF_APP_FEE"));
}

String strAppno = Helper.correctNull((String)hshValues.get("appno"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Key Fact Statement</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<style type="text/css">
.fstyle
{
	font-family: 'Book Antiqua', Palatino, 'Palatino Linotype'; 
	font-size:45px;
}
</style>
</head>
<body>
<form name="dopost();">
<table width="98%" cellspacing="0" cellpadding="0" align="center" class="outertable">
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
<tr>
	<td>
		<table width="90%" border="0" cellpadding="3" cellspacing="0"  align="center" class="outertable">
		<tr>
			<td align="center"><br>
			<img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg">
			</td>
		</tr>
		<tr align="center"> 
			<td> <b>Branch&nbsp;/&nbsp;Office:&nbsp;<%=Helper.correctNull((String) hshValues.get("strInwardBranch"))%> </b></td>
		</tr>
		<tr align="center"> 
			<td> <b>Key Fact Statement </b></td>
		</tr>
		<tr align="center"> 
			<td> <b>NAME OF THE LOAN : <%=Helper.correctNull((String)hshValues.get("strDesc")) %> </b></td>
		</tr>
		</table>
	</td>
</tr>

<tr>
	<td>
		<table width="90%" border="1" cellpadding="3" cellspacing="0"  align="center" class="outertable;fstyle;">
		<tr>
		  <td align="center" width="5%"><b>S.No</b></td>		
		  <td align="center" width="50%"><b>Description</b></td>
		  <td align="center" width="40%"><b>Value</b></td>	
		</tr>
		<tr>
		<td align="center"><%=sno++%></td>
		<td>Name of the borrower/Co-applicant/Guarantor</td>
		<td>
			<table border="0" width="100%">
			<%
			String strType="",strName="";
			boolean c=true,g=true,o=true;
			if(arrBorrarr!=null && arrBorrarr.size()>0){ 
			for(int i=0;i<arrBorrarr.size();i++){ 
			arrBorrcol = (ArrayList)arrBorrarr.get(i); 
			strType = Helper.correctNull((String)arrBorrcol.get(0));
			strName = Helper.correctNull((String)arrBorrcol.get(1));
			if(strType.equalsIgnoreCase("a")){ %>
			<tr>
			<td colspan="2">Applicant:</td>
			</tr>
			<tr>
			<td width="10%">&nbsp;</td>
			<td width="90%"><%=strName%></td>
			</tr>
			<%}%>
			
			<%if(c==true && (strType.equalsIgnoreCase("c")||strType.contains("C@"))){ %>
			<tr>
			<td colspan="2">Co-Applicant/s:</td>
			</tr>
			<%c=false;}
			if(strType.equalsIgnoreCase("c")||strType.contains("C@")) {%>
			<tr>
			<td>&nbsp;</td>
			<td><%=strName%></td>
			</tr>
			<%}%>
			
			<%if(g==true && (strType.equalsIgnoreCase("g")||strType.contains("G@"))){ %>
			<tr>
			<td colspan="2">Guarantor/s:</td>
			</tr>
			<%g=false;}
			if(strType.equalsIgnoreCase("g")||strType.contains("G@")) {%>
			<tr>
			<td>&nbsp;</td>
			<td><%=strName%></td>
			</tr>
			<%}%>
			<%if(o==true && (strType.equalsIgnoreCase("o")||strType.contains("O@"))){ %>
			<tr>
			<td colspan="2">Co-Obligant/s:</td>
			</tr>
			<%g=false;}
			if(strType.equalsIgnoreCase("o")||strType.contains("O@")) {%>
			<tr>
			<td>&nbsp;</td>
			<td><%=strName%></td>
			</tr>
			<%}%>
			
			<% } } %>
			</table>
		</td>
		</tr>
		<!--<tr>
		<td align="center"><%//=sno++%></td>
		<td>Proposal Number</td>
		<td><%//=strAppno%> </td>
		</tr>
		<tr>
		<td align="center"><%//=sno++%></td>
		<td>Terms of Repayment</td>
		<td><%//=Helper.correctNull((String)hshValues.get("strPeriodicitydesc")) %></td>
		</tr>
		--><tr>
		<td align="center"><%=sno++%></td>
		<td>Loan Amount</td>
		<td><img src="<%=ApplicationParams.getAppUrl()%>img/INRsymbol.png"><%=Helper.correctNull((String)hshValues.get("strSancAmt")) %> </td>
		</tr>
		<tr>
		<td align="center"><%=sno++%></td>
		<td>Loan Term</td>
		<%if(Helper.correctNull((String)hshValues.get("strHolidayPeriod")).equalsIgnoreCase("0")) {%>
		<td><%=Helper.correctNull((String)hshValues.get("strTenor")) %> Months</td>
		<%}else{ %>
		<td>Repayable in <%=Helper.correctNull((String)hshValues.get("strTenor")) %> Months after an initial holiday period of <%=Helper.correctNull((String)hshValues.get("strHolidayPeriod")) %>  Months.</td>
		<%} %>
		</tr>
		<tr>
		<td align="center"><%=sno++%></td>
		<td>Interest Type</td>
		<td><%=Helper.correctNull((String)hshValues.get("strInterestType")) %></td>
		</tr>
		<tr>
		<td align="center"><%=sno++%></td>
		<td> Interest Chargeable </td>
		<%if(!Helper.correctNull((String)hshValues.get("strMCLRtype")).equalsIgnoreCase("")){
			strIntIndx = "MCLR";}
		else if(!Helper.correctNull((String)hshValues.get("int_comm")).equalsIgnoreCase("")){
		strIntIndx = "Commission";}
		else{
			if(Helper.correctNull((String)hshValues.get("strInterestType")).equalsIgnoreCase("Floating"))
				if(Helper.correctNull((String)hshValues.get("strMCLRtype_ID")).equalsIgnoreCase("S"))
					strIntIndx="Six Month Treaury Bill";
				else if(Helper.correctNull((String)hshValues.get("strMCLRtype_ID")).equalsIgnoreCase("T")||Helper.correctNull((String)hshValues.get("strMCLRtype_ID")).equalsIgnoreCase("HC"))
					strIntIndx="Ten Years Govt Security";
				else
					strIntIndx = "Base Rate";
			}%>
		<%if(strIntIndx.equalsIgnoreCase("Base Rate")) {%>
		<td>Base Rate + <%=Helper.correctNull((String)hshValues.get("strInterest")) %> % p.a presently at <%=Helper.correctNull((String)hshValues.get("strModifiedInterest")) %>&nbsp;%</td>
		<%}else if(strIntIndx.equalsIgnoreCase("Commission")) {%>
		<td><%=Helper.correctNull((String)hshValues.get("int_comm")) %>&nbsp;</td> 
		<%} else {
		if(Helper.correctNull((String)hshValues.get("strInterestType")).equalsIgnoreCase("Floating")){ %>
		<td> 
		<%if(Helper.correctNull((String)hshValues.get("strMCLRtype_ID")).equalsIgnoreCase("S")){%>
			Six Months Treasury Bill
		<%}else if(Helper.correctNull((String)hshValues.get("strMCLRtype_ID")).equalsIgnoreCase("T")||Helper.correctNull((String)hshValues.get("strMCLRtype_ID")).equalsIgnoreCase("HC")){ %>
			Ten Years Govt Security
			<%}else{ %>
			<%=Helper.correctNull((String)hshValues.get("strMCLRtype"))%><% }%> 
		(<%=Helper.correctNull((String)hshValues.get("strMCLRpercent"))%> %) + <%=Helper.correctNull((String)hshValues.get("strMCLRsplit"))%> % presently at <%=Helper.correctNull((String)hshValues.get("strModifiedInterest")) %>&nbsp;%</td>
		<%}else{ %>
		<td><%=Helper.correctNull((String)hshValues.get("strModifiedInterest")) %>&nbsp;%</td>
		<%}} %>
		</tr>
		<tr>
		<td align="center"><%=sno++%></td>
		<td>Date of Reset of Interest</td>
		<%String mclrval="";
			if(Helper.correctNull((String)hshValues.get("strMCLRtype_ID")).equalsIgnoreCase("Y"))
				mclrval = "Yearly";
			else if(Helper.correctNull((String)hshValues.get("strMCLRtype_ID")).equalsIgnoreCase("H"))
				mclrval = "Half Yearly";
			else if(Helper.correctNull((String)hshValues.get("strMCLRtype_ID")).equalsIgnoreCase("Q"))
				mclrval = "Quarterly";
			else if(Helper.correctNull((String)hshValues.get("strMCLRtype_ID")).equalsIgnoreCase("M"))
				mclrval = "Monthly";
			else if(Helper.correctNull((String)hshValues.get("strMCLRtype_ID")).equalsIgnoreCase("O"))
				mclrval = "daily";
		%>
		
		<%if(mclrval.equalsIgnoreCase("")){ %>
		<td>Not Applicable</td>
		<%}else{ %>
		<td>Rate Of Interest will be reset <%=mclrval%> reckoned from the date of first disbursement of the loan / credit facility</td>
		<%} %>
		</tr>
		<tr>
		<td align="center"><%=sno++%></td>
		<td>Mode of Communication of Changes Interest Rates</td>
		<td>Letter or E-mail</td>
		</tr>
		<tr>
		<td align="center"><%=sno++%></td>
		<td COLSPAN="2">Fee Payable</td>
		</tr>
		<tr>
		<td align="center">a</td>
		<td>On Application /Sanction (Pl individually specify All Type of Fee)</td>
		<% if(Helper.correctNull((String)hshValues.get("strProFeeFlag")).equals("W")){ %>
			<td> Waived &nbsp; </td>
		<%} else {
			String APP_LOANSUBTYPE_DIGI=Helper.correctNull((String)session.getAttribute("APP_LOANSUBTYPE_DIGI"));
			if(APP_LOANSUBTYPE_DIGI.equalsIgnoreCase("PC") || APP_LOANSUBTYPE_DIGI.equalsIgnoreCase("PR")){%>
			<td><%=Helper.correctDouble(strProcessFee)%>&nbsp; (Inclusive of all Taxes)</td>
			<% }else{ %>
			<td><%=Helper.correctDouble(strProcessFee)%>&nbsp;+ Applicable Taxes</td>
		<% }} %>
		</tr>
		<tr>
		<td align="center">b</td>
		<td>On Foreclosure (Pl individually specify All Type of Fee)</td>
		<td><%=Helper.correctNull((String)hshValues.get("KF_FORECLOSURE_FEE")) %>&nbsp;</td>
		</tr>
		<tr>
		<td align="center">c</td>
		<td>Fee Refundable if Loan not Sanctioned/Disbursed</td>
		<td><%=Helper.correctNull((String)hshValues.get("KF_REFUND_FEE")) %>&nbsp;</td>
		</tr>
		<tr>
		<td align="center">d</td>
		<td>Conversion Charges for switching from Floating to Fixed Interest and vice-versa</td>
		<td><%=Helper.correctNull((String)hshValues.get("KF_CONVERSION_FEE")) %>&nbsp;</td>
		</tr>
		<tr>
		<td align="center">e</td>
		<td colspan="2">Penalty for Delayed Payments :<br>
		<%=Helper.correctNull((String)hshValues.get("KF_PENALTY_FEE")) %></td>
		</tr>
		<tr>
		<td align="center">f</td>
		<td colspan="2">During the Term of the Loan (Pl individually specify All Type of Fee) :<br>
		<%=Helper.correctNull((String)hshValues.get("KF_TERM_FEE")) %></td>
		</tr>
		<tr>
		<td align="center"><%=sno++%></td>
		<td>EMI payable</td>
		<%if(Helper.correctNull((String)hshValues.get("strPeriodicity")).equalsIgnoreCase("1")) {%>
		<td><%=Helper.correctNull((String)hshValues.get("strTenor")) %> EMI of Rs. <%=Helper.correctNull((String)hshValues.get("strEMIamt"))%> each.</td>
		<%} else if(Helper.correctNull((String)hshValues.get("strPeriodicity")).equalsIgnoreCase("8") || Helper.correctNull((String)hshValues.get("strPeriodicity")).equalsIgnoreCase("12")) {%>
		<td><%=Helper.correctNull((String)hshValues.get("strPeriodicitydesc")) %> </td>
		<%}else if(Helper.correctNull((String)hshValues.get("strPeriodicity")).equalsIgnoreCase("13")) {%>
		<td>
		<%if(arrRow!=null && arrRow.size()>0){ 
		for(int i=0;i<arrRow.size();i++){
		arrCol=(ArrayList)arrRow.get(i);%>
		<%=Helper.correctInt((String)arrCol.get(0)) %> Installments of  <img src="<%=ApplicationParams.getAppUrl()%>img/INRsymbol.png"><%=Helper.correctInt((String)arrCol.get(1)) %> each, <br>
		
		<%}%> plus interest as and when debited. <%}%>&nbsp; </td>
		<%}else{ %>
		<td><%=Helper.correctNull((String)hshValues.get("strPeriodicitydesc")) %> </td>
		<%} %>
		</tr>
		<tr>
		<td valign="top" align="center" ><%=sno++%></td>
		<td colspan="2" >Details of Security/Collateral Obtained :<br><br>
		
		<%if((arrproposedsecurityRow!=null && arrproposedsecurityRow.size()>0)||(arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
		
 		
		<div id="top">
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0" style="border-top:0px;">
		<tr>
		<td  align="center" width="45.5%"><b>Details of Security</b></td>
		<td  align="center" width="15%"><b>Value</b></td>
		<td  align="center" width="20%"><b>Date of Valuation</b></td></tr>
		<%if(arrproposedsecurityRow!=null && arrproposedsecurityRow.size()>0){ %>
		<tr align="left">
		<td colspan="3"><b>Prime :</b></td>
		</tr>
		<%for(int i=0;i<arrproposedsecurityRow.size();i++)
		{
		arrpropsecurityCol=(ArrayList)arrproposedsecurityRow.get(i);
		  for(int k=0;k<arrpropsecurityCol.size();k++) {
			  arrpropsecurity=(ArrayList)arrpropsecurityCol.get(k);
		secValue = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(1))));
		if(secValue.equals("0.00")) secValue=" ";
		%>
		<tr>
		 <td> <%=Helper.changetoTitlecase(Helper.correctNull((String)arrpropsecurity.get(0)))%></td>
		 <td align="right"><%=Helper.correctNull(secValue)%></td>
		 <td><%=Helper.correctNull((String)arrpropsecurity.get(2))%></td>
		</tr>		
		<%	}
		}
	}
	arrproposedsecurityRow=(ArrayList)hshValues.get("arrproposedCollateralSec");
	arrpropsecurity=new ArrayList();
	arrpropsecurityCol=new ArrayList();
	secValue = "";
	%>
	<%if(arrproposedsecurityRow!=null && arrproposedsecurityRow.size()>0){%>
	<tr align="left">
	<td colspan="3"><b>Collateral :</b></td>
	</tr>
	<%for(int i=0;i<arrproposedsecurityRow.size();i++)
	{
		arrpropsecurityCol=(ArrayList)arrproposedsecurityRow.get(i);
		  for(int k=0;k<arrpropsecurityCol.size();k++) {
			  arrpropsecurity=(ArrayList)arrpropsecurityCol.get(k);
		secValue = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(1))));
		if(secValue.equals("0.00")) secValue=" ";
		%>
		<tr>
		 <td> <%=Helper.changetoTitlecase(Helper.correctNull((String)arrpropsecurity.get(0)))%></td>
		 <td align="right"><%=Helper.correctNull(secValue)%></td>
		 <td><%=Helper.correctNull((String)arrpropsecurity.get(2))%></td>
		</tr>		
		<%	}
	}
	}

%>
</table>
</div>
		</td>
		</tr>
		<%}else{ %>
		<span style="text-align: center;display:block;">- Nil - </span>&nbsp;</td></tr>
		<%} %>
		<tr>
		<td align="center"><%=sno++%></td>
		<td>Date on which Annual Outstanding Balance Statement will be Issued</td>
<!--		<td align="center"><%=Helper.correctNull((String)hshValues.get("strFinancialyr")) %></td>-->
		<td align="center">First week of April every year.</td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<table width="80%" border="0" cellpadding="3" cellspacing="0"  align="center" class="outertable">
		<tr height="50px">
			<td width="15%">Date&nbsp;:</td>
			<td  width="15%" colspan="2">&nbsp;</td>
			
		</tr>
		<tr  height="50px">
		<td colspan="2"></td>
		<td  width="70%">(Name and signature of the bank Official)&nbsp;</td>
		</tr>
		<tr  height="50px">
			<td>Date&nbsp;:</td>
			<td colspan="2">&nbsp;</td>
			
		</tr>
		<tr height="50px">
		<td colspan="2"></td>
		<td>(Name and signatures of the borrower/s for having accepted the sanction details as above)</td>
		</tr>
		</table>
	</td>
</tr>
</table>
</td>
</tr>
</table>
<br>
<br>
<br>
</form>
</body>
</html>