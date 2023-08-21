<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror /> 
<%
int instalments=0;
int intLoanterms=0;
int intHolidayperiod=0;
int val=0;
	intLoanterms= Integer.parseInt(Helper.correctInt((String)hshValues.get("lreqterms")));
	intHolidayperiod=Integer.parseInt(Helper.correctInt((String)hshValues.get("loan_noofinstallment")));
	val=intLoanterms-intHolidayperiod;
	String installment=Helper.correctNull((String)hshValues.get("loan_periodicity"));
	if(installment.equalsIgnoreCase("m"))
	{
		installment="Monthly";
		instalments=val;
	}
	else if(installment.equalsIgnoreCase("q"))
	{
		installment="Quarterly";
		instalments=val/4;
	}
	else if(installment.equalsIgnoreCase("h"))
	{
		installment="Half-Yearly";  
		instalments=val/6;
	}
	else if(installment.equalsIgnoreCase("y"))
	{
		installment="Yearly";
		instalments=val/12;
	}
ArrayList vecCoApp_col = null;
ArrayList vecCoApp_Row = (ArrayList) hshValues.get("vecCoApplicant");
ArrayList arrCol1 = null;
ArrayList arrRow1 = (ArrayList) hshValues.get("arrDocsId");
ArrayList arryCol = null;
ArrayList arryRow = (ArrayList) hshValues.get("arrTermsId");

int calMonth=0;
String processMonth="0";
String processyear="0";
String calYear="";

 	String strDateProcessed=Helper.correctNull((String) hshValues.get("app_processdate"));
	int intInstallmet=intHolidayperiod+1;

	if(!strDateProcessed.equals(""))
	{
		StringTokenizer tokenizer1 = new StringTokenizer(strDateProcessed, "/");
		while (tokenizer1.hasMoreTokens()) 
		{
			String processdate=Helper.correctNull((String)tokenizer1.nextToken()).trim();
			processMonth=Helper.correctNull((String)tokenizer1.nextToken()).trim();
			processyear=Helper.correctNull((String)tokenizer1.nextToken()).trim();
			calYear=processyear;
		}
	}
	else
	{
		processMonth="0";
	}

	int intProcessMonth=Integer.parseInt(processMonth);
	int intInstallmentstartmth=intProcessMonth+intInstallmet;
	int intDueMonth=intProcessMonth+intLoanterms;
	int valMonth1=0;
	int valMonth2=0;
	int dueMonth=0;
	
	int a=0;
	int temp=0;
	int curyear=0;
	int intDueYear=0;
	
	if(intInstallmentstartmth<12 || intInstallmentstartmth==12)
	{
		if(!calYear.equalsIgnoreCase(""))
		{
			curyear=Integer.parseInt(calYear);
		}
		else
		{
			curyear=0;
		}
	}
	else if(intInstallmentstartmth>12)
	{
		valMonth1=intInstallmentstartmth/12;
		valMonth2=intInstallmentstartmth%12;
		if(valMonth2==0)
		{
			calMonth=12;
		 }
	 	else
	 	{	 
			temp=valMonth1*12;
			if(!calYear.equals(""))
			{				
				curyear=(valMonth1)+Integer.parseInt(calYear);
			}
			valMonth2=intInstallmentstartmth-temp;
		 	calMonth=valMonth2;	 
		}
	}
	else
	{
		calMonth=intInstallmentstartmth;
	}
	if(!strDateProcessed.equals(""))
	{
		a=calMonth;
	}
	else
	{
		a=0;
	}
	
	
	if(intDueMonth<=12)
	{
		
	}
	else
		if(intDueMonth>12)
		{
			valMonth1=intDueMonth/12;
			valMonth2=intDueMonth%12;
			if(valMonth2==0)
			{
				calMonth=12;
			 }
		 	else
		 	{	 
				temp=valMonth1*12;
				if(!calYear.equals(""))
				{				
					intDueYear=(valMonth1)+Integer.parseInt(calYear);
				}
				valMonth2=intDueMonth-temp;
			 	dueMonth=valMonth2;	 
			}
		}
	
	
		String installment_year="";
		installment_year = Integer.toString(curyear);
		if(installment_year.equalsIgnoreCase("0"))
		{
			installment_year="";
		}
		
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Gold Loan Sanction Letter</title>

<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 5px;
	margin-right: 0px;
	margin-bottom: 5px;
	font-family:Tahoma;
	line-height:20px;
	font-size:11px;
	color:#000000;
}
td {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	height:20px;
	font-family:Tahoma;
	line-height:20px;
	font-size:11px;
	color:#000000;
}
.td_bg {
	background-color: #E9E9E9;
}
-->
</style>


</head>

<body>
<form>

<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
  <tr> 
          <td colspan="2" align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>          		
         </tr>
        <tr> 
    <td valign="top">
	<p style="page-break-after: always">
	<table width="100%" border="0" cellspacing="0" cellpadding="5" bordercolor="#999999">
      <tr>
            <td width="100%" align="center"><strong >Karnataka Bank Ltd.<br>
		
			&nbsp;<%=Helper.correctNull((String)hshValues.get("orgname"))%>&nbsp;Branch</strong></td>
      </tr>
	  <tr> 
  			
    <td align="center"><strong > <%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp; 
      <%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp; <%=Helper.correctNull((String)hshValues.get("orgcity"))%>,&nbsp; 
      <%=Helper.correctNull((String)hshValues.get("orgstate"))%>-&nbsp; <%=Helper.correctNull((String)hshValues.get("orgzip"))%>&nbsp; 
      .<br> Tel No : <%=Helper.correctNull((String)hshValues.get("orgphone"))%></strong>
      <hr/>
		</td>
</tr>
      <tr>
        <td align="center"><table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td width="64%">Ref.No.&nbsp;:<b>&nbsp;<%=Helper.correctNull((String) hshValues.get("appno"))%></b></td>
            <td width="36%">Date:&nbsp;<b><%=Helper.correctNull((String) hshValues.get("app_processdate"))%></b></td>
          </tr>
          <tr>
            <td colspan="2" align="center">
              <strong>LETTER OF SANCTION</strong><br /></td>
            </tr>
          <tr>
            <td>To<br />
             <b><%=Helper.correctNull((String)hshValues.get("Title"))%> 
      <%=Helper.correctNull((String)hshValues.get("appname"))%>,<br>
            <% if(vecCoApp_Row!=null)
        	{
        		for(int i=0;i<vecCoApp_Row.size();i++)
        		{
        			vecCoApp_col=(ArrayList)vecCoApp_Row.get(i);
        			if(vecCoApp_col!=null)
        			{	
        				String title=Helper.correctNull((String) vecCoApp_col.get(0));
        				String CoApplicantName=Helper.correctNull((String) vecCoApp_col.get(1));
        %>
        				<b><%=title%>.&nbsp;<%=CoApplicantName%></b><br>
        <%			}
        		}
        	}%>
      </b><b><%=Helper.correctNull((String)hshValues.get("perapp_address1"))%>,</b><br>
      <%if(!(Helper.correctNull((String)hshValues.get("perapp_address2")).equalsIgnoreCase(""))){%>
      <b><%=Helper.correctNull((String)hshValues.get("perapp_address2"))%> ,</b><br>
      <%} %>
      <b><%=Helper.correctNull((String)hshValues.get("perapp_city"))%> -<%=Helper.correctNull((String)hshValues.get("perapp_zip"))%>. 
      </b> <br>
      <b> <%=Helper.correctNull((String)hshValues.get("perapp_state"))%>.</b></td>
            <td>&nbsp;</td>
          </tr>
         
          <tr>
         
            <td colspan="2"><p>Dear Sir/Madam,</p>
              <p align="center"><strong>                Sub: GOLD LOAN SCHEME
                  <br />
                  Conveying of sanction Terms and Conditions</strong></p>
                    <p>With reference to your loan application 
                    dated&nbsp;<b><%=Helper.correctNull((String) hshValues.get("loan_receivedate"))%></b>&nbsp;we 
                      are pleased to inform you that a Term Loan of 
                      Rs. <b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("sancamount"))))%></b>&nbsp;[ 
                      Rupees &nbsp;<b><%=Helper.figtoWords((String) hshValues.get("sancamount"))%></b>] 
                      is sanctioned to you
                       @ <b><%=Helper.correctNull((String) hshValues.get("mintrate"))%></b> % 
                       <b><%=Helper.correctNull((String) hshValues.get("loan_inttype"))%></b> interest for the purpose of&nbsp;<b><%=Helper.correctNull((String) hshValues.get("loan_purposeofloan"))%>&nbsp;</b>under 
                      Gold Loan Scheme against pledge of gold ornaments 
                      on the following terms and conditions:</p>
                    <ul>
                    
                    <%
                    if(arryRow!=null && arryRow.size()>0)
                    {
                    	for(int i=0;i<arryRow.size();i++)
                    	{
                    		arryCol=(ArrayList)arryRow.get(i);
                    		
                    %>
                    	<li><%out.print(arryCol.get(1));%></li>
                    <%
                    }
                    }
                   // arryCol
                    %>
                      
                    </ul>
                    <p>The following security documents are to be executed at 
                      the time of disbursement of loan:</p>
                      
                       
                <% 
                     if(arrRow1!=null)
                     {
                       for(int i=0;i<arrRow1.size();i++)
                       {				
                    	   arrCol1=(ArrayList)arrRow1.get(i);
							if(arrCol1!=null)
							{
							%>
                      <b><%=i+1%>)&nbsp;<%=Helper.correctNull((String)arrCol1.get(1))%></b><br> 	
                      <%
							}
                       }
                       	}
                       %>
             
                   <p>
                    The loan is repayable in <b><%=instalments%> <%=installment%> </b>instalments of Rs. 
                    <%if(Helper.correctNull((String)hshValues.get("loan_repaymenttype")).equalsIgnoreCase("1")) { %>
                    <b><%= Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("loan_emi"))))%></b>
                    <%}else{ %>
                    _______________ <%} %>commencing from _____________________  month (after moratorium period if any 
                    given). The total repayment period includes the period of 
                    moratorium. A moratorium period of <b><%=intHolidayperiod %></b> month/s 
                    is allowed.</p>  
                    <P>&nbsp;</P>
                    <p>&nbsp;</p>
				 <p align="right">Yours faithfully, <br> <strong>For Karnataka Bank Ltd.</strong></p>
				 <p>&nbsp;</p>
               <p align="right"> <strong>CHIEF/BRANCH MANAGER</strong></p>
               <p align="left"><strong>Accepted the above Terms &amp; Conditions</strong></p>
               <p align="left"><strong> Signature of the Applicant [s]</strong></p>
			   <p>&nbsp;</p>
                <p align="left"><strong>Date :</strong></p>    
                  
                  </td>
                </tr>
              </table>              </td>
            </tr>
        </table>
	<hr>
	 <table width="100%" border="0" cellspacing="0" cellpadding="3">
	 	<tr>
			<td width="50%">
				 <table width="100%" border="0" cellspacing="0" cellpadding="1" align="center">
				 	<tr align="center">
						<td colspan="2"> <img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg" width="15" height="15"></td>
					</tr>
					<tr align="center">
						<td colspan="2"><strong>Karnataka Bank Ltd. <br>
					&nbsp;<%=Helper.correctNull((String)hshValues.get("branchName"))%>&nbsp;Branch</strong></td>
					</tr>
					<tr align="center">
						<td colspan="2">Gold Loan Identification Card</td>
					</tr>
					<tr>
						<td width="50%">Name:&nbsp;<b><%=Helper.correctNull((String)(hshValues.get("Title")))%>&nbsp;<%=Helper.correctNull((String) hshValues.get("appname"))%></b>
						</td>
						<td width="50%">Ref. No:&nbsp;<b><%=Helper.correctNull((String) hshValues.get("appno"))%></b></td>
					</tr>
					<tr>
						<td>Loan Account No:
						</td>
						<td>Amount: <b><%=ApplicationParams.getCurrency()%>&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("sancamount"))))%></b></td>
					</tr>
					<tr>
						<td>Loan Date:&nbsp;<b><%=Helper.correctNull((String) hshValues.get("app_processdate"))%></b>
						</td>
						<td>Due Date:&nbsp;<b><%=Helper.getMonths(dueMonth)%> <%=intDueYear%></b></td>
					</tr>
					<tr>
						<td colspan="2">&nbsp;</td>
					</tr>
					<tr>
						<td>Signature of the Appraiser
						</td>
						<td>Branch Manager</td>
					</tr>
					<tr>
						<td colspan="2"><b>Note:</b> Please bring this card without fail while remitting cash
						</td>
					</tr>
				 </table>
			</td>
			<td width="50%">
				  <table width="100%" border="0" cellspacing="0" cellpadding="1" align="center">
				 	<tr align="center">
						<td colspan="2"> <img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg" width="15" height="15"></td>
					</tr>
					<tr align="center">
						<td colspan="2"><strong>Karnataka Bank Ltd. <br>
					&nbsp;<%=Helper.correctNull((String)hshValues.get("branchName"))%>&nbsp;Branch</strong></td>
					</tr>
					<tr align="center">
						<td colspan="2">Gold Loan Identification Card</td>
					</tr>
					<tr>
						<td width="50%">Name:&nbsp;<b><%=Helper.correctNull((String)(hshValues.get("Title")))%>&nbsp;<%=Helper.correctNull((String) hshValues.get("appname"))%></b>
						</td>
						<td width="50%">Ref. No:&nbsp;<b><%=Helper.correctNull((String) hshValues.get("appno"))%></b></td>
					</tr>
					<tr>
						<td>Loan Account No:
						</td>
						<td>Amount: <b><%=ApplicationParams.getCurrency()%>&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("sancamount"))))%></b></td>
					</tr>
					<tr>
						<td>Loan Date:&nbsp;<b><%=Helper.correctNull((String) hshValues.get("app_processdate"))%></b>
						</td>
						<td>Due Date:&nbsp;<b><%=Helper.getMonths(dueMonth)%> <%=intDueYear%></b></td>
					</tr>
					<tr>
						<td colspan="2">&nbsp;</td>
					</tr>
					<tr>
						<td>Signature of the Appraiser
						</td>
						<td>Branch Manager</td>
					</tr>
					<tr>
						<td colspan="2"><b>Note:</b> Please bring this card without fail while remitting cash
						</td>
					</tr>
				 </table>
			</td>
		</tr>
		<tr><td colspan="2"><hr></td></tr>
		<tr><td>&nbsp;</td></tr>
			<tr>
			<td width="50%">
				<table width="100%" border="0" cellspacing="0" cellpadding="1" align="center">
				 	<tr align="center">
						<td colspan="2"> <img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg" width="15" height="15"></td>
					</tr>
					<tr align="center">
						<td colspan="2"><strong>Karnataka Bank Ltd. <br>
					&nbsp;<%=Helper.correctNull((String)hshValues.get("branchName"))%>&nbsp;Branch</strong></td>
					</tr>
					<tr align="center">
						<td colspan="2">Gold Loan Identification Card</td>
					</tr>
					<tr>
						<td width="50%">Name:&nbsp;<b><%=Helper.correctNull((String)(hshValues.get("Title")))%>&nbsp;<%=Helper.correctNull((String) hshValues.get("appname"))%></b>
						</td>
						<td width="50%">Ref. No:&nbsp;<b><%=Helper.correctNull((String) hshValues.get("appno"))%></b></td>
					</tr>
					<tr>
						<td>Loan Account No:
						</td>
						<td>Amount: <b><%=ApplicationParams.getCurrency()%>&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("sancamount"))))%></b></td>
					</tr>
					<tr>
						<td>Loan Date:&nbsp;<b><%=Helper.correctNull((String) hshValues.get("app_processdate"))%></b>
						</td>
						<td>Due Date:&nbsp;<b><%=Helper.getMonths(dueMonth)%> <%=intDueYear%></b></td>
					</tr>
					<tr>
						<td colspan="2">&nbsp;</td>
					</tr>
					<tr>
						<td>Signature of the Appraiser
						</td>
						<td>Branch Manager</td>
					</tr>
					<tr>
						<td colspan="2"><b>Note:</b> Please bring this card without fail while remitting cash
						</td>
					</tr>
				 </table>
			</td>
			<td width="50%">
				 <table width="100%" border="0" cellspacing="0" cellpadding="1" align="center">
				 	<tr align="center">
						<td colspan="2"> <img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg" width="15" height="15"></td>
					</tr>
					<tr align="center">
						<td colspan="2"><strong>Karnataka Bank Ltd. <br>
					&nbsp;<%=Helper.correctNull((String)hshValues.get("branchName"))%>&nbsp;Branch</strong></td>
					</tr>
					<tr align="center">
						<td colspan="2">Gold Loan Identification Card</td>
					</tr>
					<tr>
						<td width="50%">Name:&nbsp;<b><%=Helper.correctNull((String)(hshValues.get("Title")))%>&nbsp;<%=Helper.correctNull((String) hshValues.get("appname"))%></b>
						</td>
						<td width="50%">Ref. No:&nbsp;<b><%=Helper.correctNull((String) hshValues.get("appno"))%></b></td>
					</tr>
					<tr>
						<td>Loan Account No:
						</td>
						<td>Amount: <b><%=ApplicationParams.getCurrency()%>&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("sancamount"))))%></b></td>
					</tr>
					<tr>
						<td>Loan Date:&nbsp;<b><%=Helper.correctNull((String) hshValues.get("app_processdate"))%></b>
						</td>
						<td>Due Date:&nbsp;<b><%=Helper.getMonths(dueMonth)%> <%=intDueYear%></b></td>
					</tr>
					<tr>
						<td colspan="2">&nbsp;</td>
					</tr>
					<tr>
						<td>Signature of the Appraiser
						</td>
						<td>Branch Manager</td>
					</tr>
					<tr>
						<td colspan="2"><b>Note:</b> Please bring this card without fail while remitting cash
						</td>
					</tr>
				 </table>
				 
			</td>
		</tr>
	</table>
	
	</td>
  </tr>
</table>

</form>
</body>
</html>
