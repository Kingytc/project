<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%ArrayList g1 = new ArrayList();	
int intLoanterms=0;
String processdate="";
String processMonth="";
String processyear="";


intLoanterms= Integer.parseInt(Helper.correctInt((String)hshValues.get("txt_installment")));
String strDateProcessed=Helper.correctNull((String) hshValues.get("app_processdate"));
String sel_payment = Helper.correctNull((String) hshValues.get("sel_payment"));

if(!strDateProcessed.equals(""))
{
	StringTokenizer tokenizer1 = new StringTokenizer(strDateProcessed, "/");
	while (tokenizer1.hasMoreTokens()) 
	{
		processdate=Helper.correctNull((String)tokenizer1.nextToken()).trim();
		processMonth=Helper.correctNull((String)tokenizer1.nextToken()).trim();
		processyear=Helper.correctNull((String)tokenizer1.nextToken()).trim();
		
	}
}
else
{
	processMonth="0";
}
int intProcessMonth=Integer.parseInt(processMonth);
int intDueMonth=intProcessMonth+intLoanterms;
int valMonth1=0;
int valMonth2=0;
int dueMonth=0;

int temp=0;
int intDueYear=0;

if(intDueMonth<=12)
{
	if(!processyear.equals(""))
	{
		intDueYear=Integer.parseInt(processyear);
	}
	else
	{
		intDueYear=0;
	}
}
else
	if(intDueMonth>12)
	{
		valMonth1=intDueMonth/12;
		valMonth2=intDueMonth%12;
		if(valMonth2==0)
		{
			dueMonth=12;
		 }
	 	else
	 	{	 
			temp=valMonth1*12;
			if(!processyear.equals(""))
			{				
				intDueYear=(valMonth1)+Integer.parseInt(processyear);
			}
			valMonth2=intDueMonth-temp;
		 	dueMonth=valMonth2;	 
		}
	}


	String strinstallmentdue="";
	strinstallmentdue = Integer.toString(intDueYear);
	if(strinstallmentdue.equalsIgnoreCase("0"))
	{
		strinstallmentdue="__/__/____";
	}
	else
	{
		strinstallmentdue=Helper.getMonths(dueMonth)+"  "+strinstallmentdue;
	}
	
	String strinstallment="";
	if(Helper.correctNull((String)hshValues.get("ProductType")).equalsIgnoreCase("pG")){
		int noofinstallment = Integer.parseInt(Helper.correctInt(((String)hshValues.get("loan_noofinstallment"))));
		if (sel_payment.equalsIgnoreCase("m")) {
			intLoanterms = (intLoanterms - noofinstallment) / 1;
		}
		if (sel_payment.equalsIgnoreCase("q")) {
			intLoanterms = (intLoanterms - noofinstallment) / 3;
		}
		if (sel_payment.equalsIgnoreCase("h")) {
			intLoanterms = (intLoanterms - noofinstallment) / 6;
		}
		if (sel_payment.equalsIgnoreCase("y")) {
			intLoanterms = (intLoanterms - noofinstallment) / 12;
		}
		strinstallment=""+intLoanterms;
	}
	else if(Helper.correctNull((String)hshValues.get("ProductType")).equalsIgnoreCase("aH"))
	{
		strinstallment=Helper.correctNull((String) hshValues.get("txt_holiday"));
	}

%>
<html>
<head>
<title>Appraiser's valuation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>
<body>
<table width="100%" border="1" cellspacing="0" cellpadding="2">
	<tr>
		<td>
		
    <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
    <td>&nbsp;</td>
    </tr>
    <tr align="center">
    <td ><img src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg"
							width="350" height="70">
    </td>
    </tr>
      <tr align="center" > 
                <td align="center"> <b>KARNATAKA BANK LTD.</b><br>
                  <b><%=Helper.correctNull((String) hshValues.get("orgname"))%> 
                  </b> Branch<br>
                </td>
              </tr>
              <tr> 
                <td align="center" ><b> <%=Helper.correctNull((String) hshValues.get("orgadd1"))%>,&nbsp; 
                  <%=Helper.correctNull((String) hshValues.get("orgadd2"))%>,&nbsp; 
                  <%=Helper.correctNull((String) hshValues.get("orgcity"))%>,&nbsp; 
                  <%=Helper.correctNull((String) hshValues.get("orgstate"))%>-&nbsp; 
                  <%=Helper.correctNull((String) hshValues.get("orgzip"))%>&nbsp; 
                  .<br>
                  Tel No : <%=Helper.correctNull((String) hshValues.get("orgphone"))%></b> 
                  <hr />
                </td>
              </tr>
    </table>
    <br>
<table width="100%" border="" cellspacing="0" cellpadding="2">
	<tr>
		<td width="50%">
			<b>Applicant Name: </b> <%=Helper.correctNull((String)hshValues.get("appname"))%>
		</td>
		<td width="50%" align="right">
			<b>Application Number : </b><%=Helper.correctNull((String)hshValues.get("appno")) %>&nbsp;&nbsp;&nbsp;&nbsp;
		</td>
	</tr>
<!--	<tr>-->
<!--		<td width="50%">-->
<!--			<b>Branch Name:</b>  <%=Helper.correctNull((String)hshValues.get("cus_org_name")) %>-->
<!--		</td>-->
<!--		<td width="50%">&nbsp;</td>-->
<!--	</tr>-->
	<tr>
		<td colspan="2">
		<div id="top"> 
			<table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr class="tblhead ">
					<td width="3%" align="center" rowspan="2"><b> Sr.No</b></td>
					<td width="20%" align="center" rowspan="2"><b> Description of Articles</b></td>
					<td width="6%" align="center" rowspan="2"><b> Quantity</b></td>
					<td colspan="2" align="center"><b> Weight Of Articles(gm.)</b></td>
					<td width="10%" align="center" rowspan="2"><b>Quality Touch </b></td>
					<td width="15%" align="center" rowspan="2"><b> Today's Market rate per 10 gm.Gold </b></td>
					<td width="15%" align="center" rowspan="2"><b> Rate per 10 gm. of the Article as per Bank Circular</b></td>
					<td width="15%" align="center" rowspan="2"><b> Estimated value of the article </b></td>
				</tr>
				<tr class="tblhead ">
					<td width="8%" align="center"><b> Gross</b></td>
					<td width="8%" align="center"><b> Net</b></td>
				</tr>
				<%
					ArrayList v = null;
					v = (ArrayList) hshValues.get("vecRow");
					if (v != null && v.size() > 0) 
						{
						int vecsize = v.size();
						for (int l = 0; l < vecsize; l++) 
							{
							g1 = (ArrayList) v.get(l);
				%>
				<tr>
					<td width="3%" align="center">&nbsp;<%=Helper.correctNull((String) g1.get(1))%></td>
					<td width="20%" align="left">&nbsp;<%=Helper.correctNull((String) g1.get(2))%></td>
					<td width="6%" align="left">&nbsp;<%=Helper.correctNull((String) g1.get(9))%></td>
					<td width="8%" align="left">&nbsp;<%=Helper.correctNull((String) g1.get(3))%></td>
					<td width="8%" align="left">&nbsp;<%=Helper.correctNull((String) g1.get(4))%></td>
					<td width="10%" align="left">&nbsp;<%=Helper.correctNull((String) g1.get(5))%></td>
					<td width="15%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) g1.get(6))))%></td>
					<td width="15%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) g1.get(7))))%></td>
					<td width="15%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) g1.get(8))))%></td>
				</tr>
				<%
					}
				}
				%>
					
			</table>
		</div>
		</td>
	</tr>

	<tr>
		<td colspan="2">
			<p>(Give Particulars viz. touch and valuation of each
			article separately)</p>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<p>Verified the weight and fineness of the gold ornaments proposed to be pledged.
			I declare that I have tested and valued the above gold
			ornaments to the best of my knowledge and skills.</p>
		</td>
	</tr>
	<tr>
		<td align="right" colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td align="right" colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td align="right" colspan="2">SIGNATURE OF APPRAISER</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	
	<tr>
		<td align="left" width="36%">DATE</td>
		<td align="right" width="64%">NAME OF APPRAISER</td>
	</tr>
	
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2"><strong><u>FOR BRANCH USE</u></strong></td>
	</tr>
	<tr>
		<%
			if (sel_payment.equalsIgnoreCase("m")) {
				sel_payment = "Monthly";
			} else if (sel_payment.equalsIgnoreCase("q")) {
				sel_payment = "Quarterly";
			} else if (sel_payment.equalsIgnoreCase("h")) {
				sel_payment = "Half-Yearly";
			} else if (sel_payment.equalsIgnoreCase("y")) {
				sel_payment = "Yearly";
			}
			else if (sel_payment.equalsIgnoreCase("n")) {
				sel_payment = "";
			}

			%>
		<td colspan="2">
			<p>Recommended for sanction a loan of <%=ApplicationParams.getCurrency()%>&nbsp;
			<%if(Helper.correctNull((String)hshValues.get("ProductType")).equalsIgnoreCase("pG")){ %>
			<b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("sancamount"))))%></b>
			<%}else if(Helper.correctNull((String)hshValues.get("ProductType")).equalsIgnoreCase("aH")){%>
			<b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("recommendedamt"))))%></b>
			<%} %>
			
			&nbsp;against pledge of gold ornaments worth of <%=ApplicationParams.getCurrency()%>&nbsp;
			<b><%=Helper.correctNull((String) hshValues.get("dbESTRATE1"))%></b>
			at <b><%=Helper.correctNull((String) hshValues.get("mintrate"))%> %</b>
			interest at <b><%=sel_payment%></b> rests. The loan is repayable on or
			before <b><%=strinstallmentdue%></b> / in
			<b> <%=strinstallment%></b>
			<%if(!sel_payment.equals("")){ %>
			&nbsp;equal <b> <%=sel_payment%> </b>instalments.
			<%}else{ %>
			months.
			<%} %></p>
		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td align="right" colspan="2">SIGNATURE OF RDO/ACCOUNTANT /OFFICER</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td align="left">DATE</td>
		<td ALIGN="RIGHT">NAME&nbsp; OF RDO/ACCOUNTANT /OFFICER</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<%String tempValue = Helper.correctDouble((String) hshValues
					.get("sancamount"));
			if (tempValue.equals(""))
				tempValue = "0.0f";
			float str = Float.parseFloat(tempValue);
			int a = Math.round(str);
			String str2 = Integer.toString(a);
			String str1 = Helper.figtoWords(str2);
			str1 = str1.toUpperCase();

			%>
		<td colspan="2">
			<p>SANCTIONED <%=ApplicationParams.getCurrency()%>&nbsp; 
			<b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("sancamount"))))%></b>
			&nbsp;(Rupees &nbsp;<b><%=str1%></b>) at &nbsp;
			<b><%=Helper.correctNull((String) hshValues.get("mintrate"))%>%</b> interest rate.</td>
	</tr>
	<tr>
		<td colspan="2" align="center">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
		<table width="65%" border="0" align="center" cellpadding="5"
			cellspacing="0">
			<tr>
				<td colspan="3" align="center" class="td_bg"><strong>SANCTIONING
				AUTHORITY</strong></td>
			</tr>
			<tr>
				<td width="53%">SIGNATURE</td>
				<td width="2%">:</td>
				<td width="45%">&nbsp;</td>
			</tr>
			<tr>
				<td width="53%">NAME</td>
				<td width="2%">:</td>
				<td width="45%">&nbsp;</td>
			</tr>
			<tr>
				<td width="53%">DESIGNATION</td>
				<td width="2%">:</td>
				<td width="45%">&nbsp;</td>
			</tr>
			<tr>
				<td width="53%">P.F.NO</td>
				<td width="2%">:</td>
				<td width="45%">&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</td>
</tr></table>

</body>
</html>
