<%@include file="../share/directives.jsp"%>
<%
java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
jtn.setMaximumFractionDigits(2);
jtn.setMinimumFractionDigits(2);
jtn.setGroupingUsed(false);

HashMap hsh=new HashMap();
ArrayList arrRow=(ArrayList) hshValues.get("arrRow");
ArrayList arrCol=new ArrayList();

ArrayList arrRow1=new ArrayList();
ArrayList arrCol1=new ArrayList();
%>
<html>
<head>
<title>EBLR Annexure</title>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<style type="text/css">
body,table td {
	FONT-SIZE: 16px !important;
	COLOR: #000000 !important;
	FONT-FAMILY: "Book Antiqua" !important;
}

#top {
	background-color: #ffffff;
}

#top table {
	border-collapse: collapse;
}

#top td {
	border: 0.5pt solid #000000;
	FONT-SIZE: 16px;
	COLOR: #000000;
	LINE-HEIGHT: 16px;
	FONT-FAMILY: "Book Antiqua"
}

.title {
	FONT-SIZE: 16px !important;
	COLOR: #000000 !important;
	FONT-FAMILY: "Book Antiqua" !important;
	font-weight: bold !important;
}
</style>
</head>
<body>

<%
if(arrRow!=null && arrRow.size()>0)
{
for(int i=0;i<arrRow.size();i++)
{
	arrCol=(ArrayList)arrRow.get(i);
	if(i!=0){%><br style='page-break-before:always'><%}
%>
<table width="95%" align="center" cellpadding="3" cellspacing="0"
	border="0">
	
	<tr>
			<td>
				<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="outertable">
				<tr> 
					<td align="center"><br>
						<img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg">
					</td>
				</tr>
				<tr align="center"> 
					<td> <b>Branch&nbsp;/&nbsp;Office:&nbsp;<%=Helper.correctNull((String)arrCol.get(7))%> </b></td>
				</tr>
				</table>
			</td>
		</tr>
	<tr>
		<td align="center" class="title"><br>
		FORMAT OF THE LETTER TO BE ADDRESSED TO THE BOROWER INTIMATING ABOUT
		THE PERMISSION FOR MIGRATION FROM MCLR/ BASE RATE / PLR TO EBLR</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>

	<tr>
		<td>

		<table width="98%" align="center" cellpadding="3" cellspacing="0"
			border="0">
			<tr>
				<td>To,</td>
			</tr>
			<tr>
				<td><b><%=Helper.correctNull((String)hshValues.get("strAppName")) %>&nbsp;</b></td>
			</tr>
			<tr>
				<td><%=Helper.correctNull((String)hshValues.get("strAppAddress")) %>&nbsp;</td>
			</tr>

			<tr>
				<td>&nbsp;</td>
			</tr>

			<tr>
				<td><b>Sub:</b> Your Loan A/c No/s <%=Helper.correctNull((String)arrCol.get(1)) %>
				Request for switch over to 'External Benchmark based lending rate'
				(EBLR)</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td><b>Ref:</b> Your request letter dated <%=Helper.correctNull((String)hshValues.get("strInwardCreatedDate")) %></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>With reference to the above, we agree to your request to
				change the existing interest rate system to the EBLR interest
				system.</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>Accordingly, your loan/s mentioned below will carry
				interest at the rate mentioned against them, with effect from <%=Helper.correctNull((String)arrCol.get(4)) %></td>
			</tr>

			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>
				<div id="top">
				<table width="100%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<tr>
					<td width="20%">Loan Account No</td>
					<td width="15%">Sanction Limit</td>
					<td width="30%">Rate of Interest</td>
					</tr>
					<%
	String[] strMCLRVal=Helper.correctNull((String)arrCol.get(2)).split("@");  
	if(strMCLRVal.length<=1)
	{
		strMCLRVal=new String[3];
		strMCLRVal[0]="";
		strMCLRVal[1]="";
		strMCLRVal[2]="";
	}
	String strMCLRValue="";
	 if(strMCLRVal[0].equalsIgnoreCase("ST"))
	{
		strMCLRValue="Six Months T-bills";
	}
	else if(strMCLRVal[0].equalsIgnoreCase("TG"))
	{
		strMCLRValue="10 years G-Sec";
	}
	
	%>
					<tr>
					<td valign="top"><%=Helper.correctNull((String)arrCol.get(1)) %></td>
					<td valign="top"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(0))))%></td>
						<td>External Bench Mark Rate that is to say <%=strMCLRValue %>
						Rate (*) presently being <%=jtn.format(Double.parseDouble(strMCLRVal[1]))%>%per annum,
						plus<br /><br />
						Spread at <%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))%>%per
						annum for three years from the date of this application, subject
						to change every three years, plus<br /><br />
						Credit risk premium presently at <%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))%>%
						per annum, variable depending on the credit assessment of the
						Borrower.<br /><br />
						In total presently at <%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))%>%
						per annum compound monthly/quarterly/half yearly/annually(*)
						variable as above.<br /><br />
						(*)delete whichever is not applicable</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<tr>
			<td>a.	The Bank may reset above stated EBLR once in a month and modify the interest rate accordingly.</td>
			</tr>
			<tr>
			<td>b.	The Bank may modify the above stated spread above EBLR if there is change in Borrower's Credit Risk Profile and the decision of the Bank in this regard shall be final and binding on the Borrower.</td>
			</tr>
			<tr>
			<td>c.	Interest will be compounded monthly.</td>
			</tr>
			<tr>
			<td>d.	In case of non-payment of installments and/or any interest by the due date, such arrears shall bear overdue interest at 5% per annum over and above the rate chargeable as above compounded monthly.</td>
			</tr>
			
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>Thanking You,</td></tr>
			
			<tr><td>&nbsp;</td></tr>
			<tr><td>Your faithfully</td></tr>
			
			<tr><td>&nbsp;</td></tr>
			<tr><td>(Branch Head)</td></tr>
			
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

<br style='page-break-before:always'>

<table width="95%" align="center" cellpadding="3" cellspacing="0"
	border="0">
	<tr>
		<td>&nbsp;</td>
	</tr>

	<tr>
		<td>

		<table width="98%" align="center" cellpadding="3" cellspacing="0"
			border="0">
			<tr>
				<td>The Manager</td>
			</tr>
			<tr>
				<td>Karnataka Bank Ltd&nbsp;</td>
			</tr>
			<tr>
				<td><%=Helper.correctNull((String)arrCol.get(7))%> Branch&nbsp;</td>
			</tr>

			<tr>
				<td>&nbsp;</td>
			</tr>

			<tr>
				<td>I/We accept the switching over to EBLR Interest system on the terms and conditions mentioned above and agree that our liability under the existing documents shall not in any way be affected by the said change, in particular the Guarantors/Co-obligants/Mortgagers shall not be discharged by the said change in the terms and conditions.</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>We further waive notice of variation of Bank's External benchmark based lending rate (EBLR) and further agree that publication of such variation in Bank's notice board / Website shall be sufficient notice to me/us.</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			
			
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
			<td>
			<table width="98%" align="center" cellpadding="3" cellspacing="0"
			border="0">
			<%
			 arrRow1=(ArrayList)arrCol.get(8);
			if(arrRow1!=null && arrRow1.size()>0){
			for(int j=0;j<arrRow1.size();j++)
			{
				 arrCol1=(ArrayList)arrRow1.get(j);
				 String strTemp="";
				 
				 if(Helper.correctNull((String)arrCol1.get(0)).equalsIgnoreCase("a")){ 
					 strTemp="Borrower";
				 }
				else if(Helper.correctNull((String)arrCol1.get(0)).equalsIgnoreCase("c")){ 
					strTemp="Borrower";
				}
				else if(Helper.correctNull((String)arrCol1.get(0)).equalsIgnoreCase("o")||Helper.correctNull((String)arrCol1.get(0)).equalsIgnoreCase("CO")){ 
					strTemp="Co-obligant";
				}
				else if(Helper.correctNull((String)arrCol1.get(0)).equalsIgnoreCase("g")){
					strTemp="Guarantor";
				}
				 
			if(j%2==0){
			%>
			<tr><td align="left" width="50%"><%=Helper.correctNull((String)arrCol1.get(1)) %><br/>
			(<%=strTemp%>)
			<%}else{ %>
			<td align="right" width="50%"><%=Helper.correctNull((String)arrCol1.get(1)) %><br/>
			(<%=strTemp%>)</td></tr>
			<%} %>
			
			<%}
			}%>
			</table>
			</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>Place :&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>Date :&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

<%}} %>

</body>
</html>