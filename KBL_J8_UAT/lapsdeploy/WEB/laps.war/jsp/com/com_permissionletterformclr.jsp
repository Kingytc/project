<%@include file="../share/directives.jsp"%>
<%


java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
jtn.setMaximumFractionDigits(2);
jtn.setMinimumFractionDigits(2);
jtn.setGroupingUsed(false);

ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();

arrRow=(ArrayList)hshValues.get("arrRow");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Permission Letter</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<style type="text/css">
body, table td
{
FONT-SIZE: 16px !important; COLOR: #000000 !important; FONT-FAMILY: "Book Antiqua" !important;
}
#top{background-color: #ffffff;}
#top table{ border-collapse: collapse;}
#top td {border: 0.5pt solid #000000; FONT-SIZE: 16px; COLOR: #000000; LINE-HEIGHT: 16px; FONT-FAMILY: "Book Antiqua"}

.title
{
FONT-SIZE: 16px !important; COLOR: #000000 !important; FONT-FAMILY: "Book Antiqua" !important;font-weight: bold !important;
}
</style>
</head>
<body>
<form name="dopost();">
<table width="98%" style="border: solid 1px #000000" cellspacing="0" cellpadding="0" align="center" class="outertable">
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
<tr>
	<td>
		<table width="90%" border="0" cellpadding="3" cellspacing="0"  align="center" class="outertable">
		<tr>
			<td>
				<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="outertable">
				<tr> 
					<td align="center"><br>
						<img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg">
					</td>
				</tr>
				<tr align="center"> 
					<td> <b>Branch&nbsp;/&nbsp;Office:&nbsp;<%=Helper.correctNull((String)hshValues.get("strInwardOrgname"))%> </b></td>
				</tr>
				<tr align="right"> 
					<td> <b>Date &nbsp;:&nbsp;<%=Helper.correctNull((String) hshValues.get("strAppSancDate"))%> </b></td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td>&nbsp;</td>
</tr>
<tr>
	<td>
	<table width="90%" border="0" cellpadding="5" cellspacing="0"  align="center" class="outertable">
	<tr>
		<td>To,</td>
	</tr>
	<tr>
		<td>
		<b><%=Helper.correctNull((String)hshValues.get("strAppName")) %> </b>from <%=Helper.correctNull((String)hshValues.get("strAppAddress")) %>
		</td>
	</tr>
	<tr>
		<td><b>SUB : </b>Your Loan A/c No/s : <%=Helper.correctNull((String)hshValues.get("strAccNo")) %> - Request for switch over to <b>Marginal Cost of funds based lending rate</b> (MCLR)</td>
	</tr>
	<tr>
	<td><b>REF : </b> Your request letter dated <%=Helper.correctNull((String)hshValues.get("strInwardCreatedDate")) %>  </td>
	</tr>
	<tr>
	<td>
	With reference to the above, we agree to your request to change the existing interest rate system to the MCLR interest system.
	</td>
	</tr>
	<tr>
	<td>
	Accordingly, your loan/s mentioned below will carry interest at the rate mentioned against them, with effect from ---------------. 
	</td>
	</tr>
	
	
	<tr>
	<td>
	<div id="top">
	<table width="90%" border="0" cellpadding="5" cellspacing="0"  align="center" class="outertable">
	<tr align="center" class="tblhead">
		<td width="5%">S.No</td>
		<td width="20%">Loan A/c No.</td>
		<td width="15%">Sanction Limit</td>
		<td width="35%">Rate of Interest</td>
	</tr>
	
	<%
	String strMCLR="";
	if(arrRow!=null && arrRow.size()>0){ 
	for(int i=0;i<arrRow.size();i++)
	{
	arrCol=(ArrayList)arrRow.get(i);%>
	<tr>
	<td align="center"><%=i+1 %></td>
	<td><%=Helper.correctNull((String)arrCol.get(1)) %></td>
	<td align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(0)))) %></td>
	<%String[] strMCLRVal=Helper.correctNull((String)arrCol.get(2)).split("@");  
	if(strMCLRVal.length<=1)
	{
		strMCLRVal=new String[3];
		strMCLRVal[0]="";
		strMCLRVal[1]="";
		strMCLRVal[2]="";
	}
	String strMCLRValue="";
	if(!strMCLR.equalsIgnoreCase(""))
		strMCLR=strMCLR+"/";
	
	if(strMCLRVal[0].equalsIgnoreCase("M"))
	{
		strMCLRValue="Monthly";
		strMCLR=strMCLR+"Monthly";
	}
	else if(strMCLRVal[0].equalsIgnoreCase("H"))
	{
		strMCLRValue="Half Yearly";
		strMCLR=strMCLR+"Half Yearly";
	}
	else if(strMCLRVal[0].equalsIgnoreCase("Q"))
	{
		strMCLRValue="Quaterly";
		strMCLR=strMCLR+"Quaterly";
	}
	else if(strMCLRVal[0].equalsIgnoreCase("Y"))
	{
		strMCLRValue="Yearly";
		strMCLR=strMCLR+"Yearly";
	}
	else if(strMCLRVal[0].equalsIgnoreCase("O"))
	{
		strMCLRValue="Over Night";
		strMCLR=strMCLR+"Daily";
	}
	
	double dblValue=Double.parseDouble(Helper.correctDouble((String)arrCol.get(3)))-
	Double.parseDouble(Helper.correctDouble(strMCLRVal[1]));
	%>
	<td nowrap="nowrap"><%=strMCLRValue%> + <%=jtn.format(dblValue) %>&nbsp;% p.a presently at <%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3)))) %>%&nbsp; p.a.</br>
	Current MCLR being  <%=jtn.format(Double.parseDouble(Helper.correctDouble(strMCLRVal[1]))) %> %</td>
	</tr>
	<%}
	}else{ %>
	<tr>
	<td colspan="4">&nbsp;</td>
	</tr>
	<%} %>
	</table>
	</div>
	</td>
	</tr>
	
	<tr>
	<td>
	
	<ol type="a">
	<li>The Bank may reset above stated MCLR <%=strMCLR %> and modify the interest Rate accordingly.</li>
	<li>The Bank may modify the above stated spread above MCLR if there is change in Borrower's Credit Risk Profile and the decision of the Bank in this regard shall be final and binding on the Borrower.</li>
	<li>Interest will be compounded monthly.</li>
	<li>In case of non-payment of installments and/or any interest by the due date, such arrears shall bear overdue interest at 5% per annum over and above the rate chargeable as above compounded monthly.</li>
	</ol>
	</td></tr>
	
	<tr><td>&nbsp;</td></tr>
	
	<tr>
	<td align="center">Thanking you,
	</td>
	</tr>
	<tr>
	<td>Yours faithfully,</br></br></br></td>
	</tr>
	<tr>
	<td>(Branch Head)</br></br></td>
	</tr>
		</table>
	</td>
</tr>

</table>
</form>
</body>
</html>