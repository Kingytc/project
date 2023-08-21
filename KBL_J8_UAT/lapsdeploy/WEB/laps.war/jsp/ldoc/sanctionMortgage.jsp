<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
 
<%
String installment=Helper.correctNull((String)hshValues.get("loan_periodicity"));
if(installment.equalsIgnoreCase("m"))
{
	 installment="Monthly";
}else if(installment.equalsIgnoreCase("q"))
{
	 installment="Quarterly";
}else if(installment.equalsIgnoreCase("h"))
{
	 installment="Haly-Yearly";  
}else if(installment.equalsIgnoreCase("y"))
{
	 installment="Yearly";
}
//ArrayList arrydocCol = null;
//ArrayList arrydocRow = (ArrayList) hshValues.get("arrDocsId");
ArrayList vecCoApp_col = null;
ArrayList vecCoApp_Row = (ArrayList) hshValues.get("vecCoApplicant");
//ArrayList arrCol1 = null;
//ArrayList arrRow1 = (ArrayList) hshValues.get("arrDocsId");


String loan_inttype=Helper.correctNull((String) hshValues.get("loan_inttype"));
int calMonth=0;
String date="";
String Month="0";
String year="0";
String calYear="";
//String loan_noofinstallment = "0";	
String dates=Helper.correctNull((String) hshValues.get("app_processdate"));
String installments=Helper.correctNull((String)hshValues.get("loan_noofinstallment"));

int x=0;
 x=Integer.parseInt(installments)+1;

if(!dates.equals(""))
{

	StringTokenizer tokenizer1 = new StringTokenizer(dates, "/");

	while (tokenizer1.hasMoreTokens()) 
	{
		date=Helper.correctNull((String)tokenizer1.nextToken()).trim();
		Month=Helper.correctNull((String)tokenizer1.nextToken()).trim();
		year=Helper.correctNull((String)tokenizer1.nextToken()).trim();
		calYear=year;
		
	}

}
else
{
	 Month="0";
}

int month=0;
month=Integer.parseInt(Month);
int TOTMonths=0;
TOTMonths=month+x;
int valMonth1=0;
int valMonth2=0;
int valMonth=TOTMonths;
int a=0;
int temp=0;
int curyear=0;

if(valMonth<12 || valMonth==12)
{
	if(!calYear.equalsIgnoreCase(""))
	{
		curyear=0+Integer.parseInt(calYear);
	}
	else
	{
		curyear=0;
	}
}
if(valMonth>12)
{
	 valMonth1=valMonth/12;
	 valMonth2=valMonth%12;
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
		
		 valMonth2=valMonth-temp;
		 calMonth=valMonth2;	 
	}
}
else
{
	 calMonth=valMonth;
}
	
	 //String Months[]={"","January","February","March","April","May","June","July","August","September","October","November","December"};
	 if(!dates.equals(""))
	 {
	 	a=calMonth;
	 }
	 else
	 {
		 a=0;
	 }


  ArrayList arryCol = null;
 ArrayList arryRow = (ArrayList) hshValues.get("arrTermsId");
%>
<html>
<head>
<title>Sanction Letter for Mortgage</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css"
	type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000"> 
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
  <tr> 
          <td colspan="2" align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>          		
         </tr> 
   <tr>
    <td colspan="2"> 
      <div align="center"><b><font size="+1">KARNATAKA BANK LTD. </font></b> <br>
      <b> &nbsp; <%=Helper.correctNull((String)hshValues.get("orgname"))%> Branch</b></div>
    </td>
  </tr>
  <tr> 
  			
    <td align="center" colspan="2"><strong ><b> <%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp; 
      <%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp; <%=Helper.correctNull((String)hshValues.get("orgcity"))%>,&nbsp; 
      <%=Helper.correctNull((String)hshValues.get("orgstate"))%>-&nbsp; <%=Helper.correctNull((String)hshValues.get("orgzip"))%>&nbsp; 
      .<br> Tel No : <%=Helper.correctNull((String)hshValues.get("orgphone"))%></b></strong>
      <hr/>
		</td>
</tr>
  <tr> 
                <td width="64%">Ref.No.&nbsp;:<b>&nbsp;<%=Helper.correctNull((String) hshValues.get("appno"))%></b></td>
    <td width="36%">Date:&nbsp;<b><%=Helper.correctNull((String) hshValues.get("app_processdate"))%></b></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" height="1650">
  <tr> 
    <td> 
       
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="3%">To</td>
          <td width="97%">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%">&nbsp;</td>
          <td width="97%"><b><%=Helper.correctNull((String)hshValues.get("Title"))%> 
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
            <b><%=Helper.correctNull((String)hshValues.get("perapp_address2"))%> 
            ,</b><br>
            <b><%=Helper.correctNull((String)hshValues.get("perapp_city"))%> -<%=Helper.correctNull((String)hshValues.get("perapp_zip"))%>. 
            </b> <br>
            <b> <%=Helper.correctNull((String)hshValues.get("perapp_state"))%>.</b> 
          </td>
        </tr>
      </table>
       
        
      
      <p>Dear Sir/Madam,</p>
      <p align="center"><b><u>Sub: Your request for sanction of TL/SOD under Union 
        Mortgage Scheme<br>
        </u></b></p>
    </td>
  </tr>
  <tr>
    <td>
      <p>&nbsp;&nbsp;&nbsp;&nbsp; With reference to your loan application dated &nbsp;<b><%=Helper.correctNull((String) hshValues.get("loan_receivedate"))%>, 
        </b> we are pleased to inform you that a Term Loan/SOD of<b> Rs.&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("sancamount"))))%></b>
        [ Rs. &nbsp;<b><%=Helper.figtoWords((String) hshValues.get("sancamount"))%></b>] 
        is sanctioned in your favour for the purpose of &nbsp;<b><%=Helper.correctNull((String) hshValues.get("loan_purposeofloan"))%></b> 
        under Union Mortgage Loan scheme, on the following terms and conditions. 
      </p>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <%if(loan_inttype.equalsIgnoreCase("Fixed")){%>
        <tr> 
          <td width="4%" valign="top">1)</td>
          <td width="96%"> 
            <p align="justify"> A <b><%=Helper.correctNull((String) hshValues.get("loan_inttype"))%></b> interest of &nbsp;<b><%=Helper.correctNull((String) hshValues.get("mintrate"))%>% </b>
              per annum at monthly rests will be charged to your loan /SOD account.<br>
              <br>
            </p>
          </td>
        </tr>
		<%}%>
		 <%if(loan_inttype.equalsIgnoreCase("Floating")){%>
        <tr> 
          <td width="4%" valign="top">1)</td>
          <td width="96%"> 
            <p align="justify"> A floating interest of &nbsp;<b><%=Helper.correctNull((String) hshValues.get("mintrate"))%>% </b>
              per annum at monthly rests will be charged to your loan /SOD account.<br>
              <br>
            </p>
          </td>
        </tr>
		<%}%>
		
        <tr> 
          <td width="4%" valign="top">2)</td>
          <td width="96%"> 
            <p align="justify">The loan amount will be credited to your SB/Current 
              account [in case of a term loan].<br>
              <br>
            </p>
          </td>
        </tr>
         <%int val1=0,val2=0;
        String str1= Helper.correctNull((String)hshValues.get("lreqterms"));
        String str2= Helper.correctNull((String)hshValues.get("loan_noofinstallment"));
        if(!str1.equals(""))
        {
        	 val1=Integer.parseInt(str1);
        }
        if(!str2.equals(""))
        {
        	 val2=Integer.parseInt(str2);
        }
        
        int val=0;
        val=val1-val2;
        %>
        <tr> 
        <%
					String installment_year="";
          			installment_year = Integer.toString(curyear);
          			if(installment_year.equalsIgnoreCase("0"))
          			{
          				installment_year="";
          			}
          			
          	%>
          <td width="4%" valign="top">3)</td>
          <td width="96%"> 
            <p align="justify">The loan shall be repayable in &nbsp;<b><%=val%> </b>
              Equated <b><%=installment%> </b> Instalments of <b>Rs.&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("loan_emi"))))%></b> 
              commencing from <b>(<%=installment_year%>)<%=Helper.getMonths(a)%></b> 
              month [in case of a term loan].<br>
              <br>
            </p>
          </td>
        </tr>
        <tr> 
          <td width="4%" valign="top">4)</td>
          <td width="96%"> 
            <p align="justify">SOD Limit to be adjusted by reducing the limit 
              by 1/5th every year commencing from 5 years prior to the date of 
              retirement [in case of salaried persons] or 5 years prior to attaining 
              the age of 60 whichever is earlier. A penal interest @ <b> 2%</b> 
              will be levied on the overdue installments, if any.<br>
              <br>
            </p>
          </td>
        </tr>
        <tr> 
          <td width="4%" valign="top">5)</td>
          <td width="96%"> 
            <p align="justify"> Takeover penalty of <b>2%</b> shall be levied 
              in case the loan account is taken over by other banks or financial 
              institutions or the loan is adjusted out of funds borrowed from 
              third party.However, no penalty will be levied if the loan account 
              is adjusted out of own verifiable and legitimate sources offunds. 
              The onus of proof for the same rests with the borrower.<br>
              <br>
            </p>
          </td>
        </tr>
        <tr> 
          <td width="4%" valign="top">6)</td>
          <td width="96%"> 
            <p align="justify"> No moratorium period will be allowed. Repayment 
              to commence immediately from the succeeding month of advance.<br>
              <br>
            </p>
          </td>
        </tr>
        <tr> 
          <td width="4%" valign="top">7)</td>
          <td width="96%"> 
            <p align="justify"> An irrevocable undertaking from your employer 
              is to be submitted to recover the EMIs directly from your salary 
              every month and to remit the proceeds regularly to the Bank.<br>
              <br>
            </p>
          </td>
        </tr>
        <tr> 
          <td width="4%" valign="top">8)</td>
          <td width="96%"> 
            <p align="justify"> An irrevocable undertaking from your employer 
              to adjust the loan dues if any, directly from the terminal benefits 
              payable to you in case of any eventuality/ cessation in service 
              by you.<br>
              <br>
            </p>
          </td>
        </tr>
        <tr> 
          <td width="4%" valign="top">9)</td>
          <td width="96%"> 
            <p align="justify"> The loan will be secured by equitable mortgage 
              of land/land and buildings/commercial property situated at<b><%=Helper.correctNull((String)hshValues.get("prop_houseno"))%>
              <%=Helper.correctNull((String)hshValues.get("prop_area"))%>&nbsp;,<%=Helper.correctNull((String)hshValues.get("prop_city"))%>&nbsp;-
             <%=Helper.correctNull((String)hshValues.get("prop_pin"))%>&nbsp;,<%=Helper.correctNull((String)hshValues.get("prop_state"))%>.</b> ,held 
              by <b><%=Helper.correctNull((String)hshValues.get("Title"))%> <%=Helper.correctNull((String)hshValues.get("appname"))%>&nbsp;/&nbsp;
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
        	}%></b><br>
              <br>
            </p>
          </td>
        </tr>
        <tr> 
          <td width="4%" valign="top">10)</td>
          <td width="96%"> 
            <p align="justify"> Processing charges @<b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("procfee"))))%></b> 
              (excluding Service Tax) shall be levied on the loan amount.<br>
              <br>
            </p>
          </td>
        </tr>
        <tr> 
          <td width="4%" valign="top">11)</td>
          <td width="96%"> 
            <p align="justify"> Term loan is subject to review every year and 
              SOD limit is subject to review/ renewal every year.<br>
              <br>
            </p>
          </td>
        </tr>
        <tr> 
          <td width="4%" valign="top">12)</td>
          <td width="96%"> 
            <p align="justify"> Interest on SOD is to be serviced every month.<br>
              <br>
            </p>
          </td>
        </tr>
        <tr> 
          <td width="4%" valign="top">13)</td>
          <td width="96%"> 
            <p align="justify"> The Bank has every right to modify/ add/ delete 
              any of the terms and conditions during the currency of loan at its 
              discretion, without prior intimation.<br>
            </p>
          </td>
        </tr>
		 <tr> 
                <td width="4%" valign="top">13)</td>
                <td width="96%"> 
                  <p align="justify">All other terms and conditions as applicable 
                    to the scheme from time to time.</p>
                 
              
              <% 
                     if(arryRow!=null)
                     {
                       for(int i=0;i<arryRow.size();i++)
                       {				
                    	  arryCol=(ArrayList)arryRow.get(i);
							if(arryCol!=null)
							{
							%>
                      <br> 	<b><%=i+1%>)&nbsp;<%=Helper.correctNull((String)arryCol.get(1))%></b>
                      <%
							}
                       }
                       	}
                       %><br><br>
             </td>
              
              </tr>
        <tr> 
          <td width="4%">&nbsp;</td>
          <td width="96%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="4%">&nbsp;</td>
          <td width="96%"> 
            <p align="justify">We request you to convey your acceptance or otherwise 
              of the above terms and conditions by signing the copy of this letter.</p>
          </td>
        </tr>
        <tr> 
          <td width="4%">&nbsp;</td>
          <td width="96%">&nbsp;</td>
        </tr>
        <tr>
          <td width="4%">&nbsp;</td>
          <td width="96%">Thanking you and assuring our best services at all times.</td>
        </tr>
      </table>
      <p>&nbsp;</p>
      <p align="right"> Yours faithfully,</p>
<p align="right">&nbsp;</p>
      <p align="right"><b>Branch Manager/ Chief Manager</b></p>
      <table width="100%" border="1" cellspacing="0" cellpadding="3">
        <tr>
          <td>
      <p align="justify">Accepted the above Terms and Condition:</p>
            <p>&nbsp;</p>
            <table width="100%" border="0" cellspacing="0" cellpadding="3">
              <tr> 
                <td width="61%"><br>
                  <br>
                  <b>Signature of Borrower[s]</b></td>
                <td width="39%"><br>
                  <br>
                  <b>Signature of guarantor</b></td>
                   <tr> 
                <td width="58%">&nbsp;</td>
                <td width="42%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="58%">&nbsp;</td>
                <td width="42%">&nbsp;</td>
              </tr>
               <tr> 
                <td width="58%">&nbsp;</td>
                <td width="42%">&nbsp;</td>
              </tr>
              <tr>
                <td width="58%">Date: <b><%//=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
                <td width="42%">Date: <b><%//=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
              </tr>
           
            </table>
            <p>&nbsp;</p>
          </td>
        </tr>
      </table>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
    </td>
  </tr>
</table>
</body>
</html>
