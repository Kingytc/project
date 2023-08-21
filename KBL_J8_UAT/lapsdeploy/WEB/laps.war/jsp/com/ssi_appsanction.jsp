 <%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror />
<%
if(objValues instanceof java.util.HashMap)
   {
	   hshValues=(java.util.HashMap)objValues;
   }
/*
//out.println(hshValues);
  //ArrayList vecid1 = (ArrayList)hshValues.get("vecid1");
 // ArrayList vecid2 = (ArrayList)hshValues.get("vecid2");
 // ArrayList vecid3 = (ArrayList)hshValues.get("vecid3");
 // ArrayList vecid4 = (ArrayList)hshValues.get("vecid4");
 // ArrayList vecid5 = (ArrayList)hshValues.get("vecid5");
 
  String bgclr="";

  int p=0,sizeyear=0,from=0,to=0,vecModSize  =0;
   String temp="",totcount="",upto="",pageval="",strCurModule="";
  
	totcount = Helper.correctNull((String)hshValues.get("totalyear"));
	upto = Helper.correctNull((String)hshValues.get("upto"));
	pageval=Helper.correctNull((String)hshValues.get("page"));
	strCurModule = pageval;
	
	ArrayList g1= new ArrayList();
	ArrayList g2= new ArrayList();
	ArrayList g3= new ArrayList();
	ArrayList year1= new ArrayList();
	ArrayList year2= new ArrayList();
	ArrayList year3= new ArrayList();
	ArrayList year4= new ArrayList();
	ArrayList year5= new ArrayList();
	g2=(ArrayList) hshValues.get("yearvalue");
	g3  = (ArrayList) hshValues.get("value");
	year1 = (ArrayList) hshValues.get("year1");
	year2 = (ArrayList) hshValues.get("year2");
	year3 = (ArrayList) hshValues.get("year3");
	year4 = (ArrayList) hshValues.get("year4");
	year5 = (ArrayList) hshValues.get("year5");
	ArrayList	vecModule = (ArrayList)hshValues.get("tabdetails");
	if(vecModule!=null)
	{
		vecModSize = vecModule.size();
	}
	String yearval[] = new String[5];
	String comboselect[] = new String[5];

	
	int y = 0,n=0;
	
	 if (g2.size() != 0)
	 {
		 sizeyear=g2.size();
		  
	for (int k=0;k<=g2.size()-1;k++)
	{
	
			if ((k % 2 ) == 0)
				{
				
				temp=Helper.correctNull((String)g2.get(k));
				yearval[y]=temp;
				y =y+1;
				}
			else if ((k % 2) == 1)
				{
				temp=Helper.correctNull((String)g2.get(k));
					if (temp == "fin_audit")
					{
						temp = "Audited";
					}
					else if (temp == "fin_unaudit")
					{
						temp = "Unaudited";
					}
					else if (temp == "fin_estimated")
					{
						temp = "Estimated";
					}
					else if (temp == "fin_projection")
					{
					temp = "Projection";
					}
				comboselect[n]=temp;
				n = n+1;
				}
	 		
		}
		
		for (int d = 0 ; d <= 4 ; d++)
		 {
			
			if (comboselect[d] == null)
			 {
			comboselect[d] = " ";
			
			 }
			if (yearval[d] == null)
			 {
			yearval[d]="";
			
			 }
			
			 
		 }
		 
	 }
	 else
	 {
		
		 for ( p=0;p<=4;p++)
		 {

			comboselect[p]= " ";
		
			yearval[p]= "";
			

		 }

	 }
	*/
%>
<html>
<head>
<title>Financial</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
td {font-family: "arial"; font-size: 12px;}
-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 250;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
.tabfont {  font-family: "MS Sans Serif"; font-size: 10px; color: #000000; text-decoration: none}
a:hover {  color: #FF3300}
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/blackfont.css" type="text/css">

</STYLE>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/com/finmain.js">
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">


</head>
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3" onLoad="">
<form name ="" method="post" >
 <span style="display:none"><laps:borrowertype /></span> <laps:application/> <br>
  <div align="center"><font face="Times New Roman, Times, serif" size="3"><b></b></font><br>
    <br>
  </div>
  <jsp:include page="../share/help.jsp" flush="true"/> 

              

              
  <table width="98%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" onMouseOver=" " align="center">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" height="100%">
          <tr> 
            <td valign="top">
              <table width="100%" border="0" cellspacing="0" cellpadding="5">
                <tr> 
                  <td bgcolor="#71694F"><b><font color="#FFFFFF">Illustrative 
                    Appraisal-cum-Sanction Memo (For SSI Units) For Amount Upto 
                    Rs. One Crore</font></b></td>
                </tr>
                <tr> 
                  <td> 
                    <table width="50%" border="1" cellspacing="0" cellpadding="3" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                      <tr> 
                        <td width="50%">Asset Classification</td>
                        <td width="50%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td>Credit Rating</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr> 
                        <td rowspan="2" valign="top">Yield</td>
                        <td>Rs. &nbsp;&nbsp;&nbsp;%</td>
                      </tr>
                      <tr> 
                        <td>(Period &nbsp;&nbsp;&nbsp;&nbsp;to&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;)</td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                      <tr> 
                        <td width="5%">1.</td>
                        <td width="50%">Name of the Borrower</td>
                        <td width="50%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="5%">2.</td>
                        <td width="50%">Dealing with us since</td>
                        <td width="50%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="5%">3.</td>
                        <td width="50%">Nature of Activity</td>
                        <td width="50%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="5%">4.</td>
                        <td width="50%">Whether Fresh Sanction/Review</td>
                        <td width="50%">&nbsp;</td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td>5. Details of facilities: </td>
                        <td align="right">(Rs. in Lacs)</td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                      <tr> 
                        <td colspan="3">Requested by the Party</td>
                        <td colspan="3">Proposed by the Appraising Officer</td>
                      </tr>
                      <tr bgcolor="#71694F"> 
                        <td width="5%"><b><font color="#FFFFFF">Sl.No.</font></b></td>
                        <td width="50%"><b><font color="#FFFFFF">Name of the Facility</font></b></td>
                        <td width="50%"><b><font color="#FFFFFF">Limit</font></b></td>
                        <td width="5%"><b><font color="#FFFFFF">Sl.No.</font></b></td>
                        <td width="50%" bgcolor="#71694F"><b><font color="#FFFFFF">Nature 
                          of Facility</font></b></td>
                        <td width="50%"><b><font color="#FFFFFF">Limit</font></b></td>
                      </tr>
                      <tr> 
                        <td width="5%">&nbsp;</td>
                        <td width="50%">&nbsp;</td>
                        <td width="50%">&nbsp;</td>
                        <td width="5%">&nbsp;</td>
                        <td width="50%">&nbsp;</td>
                        <td width="50%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="5%">&nbsp;</td>
                        <td width="50%">&nbsp;</td>
                        <td width="50%">&nbsp;</td>
                        <td width="5%">&nbsp;</td>
                        <td width="50%">&nbsp;</td>
                        <td width="50%">&nbsp;</td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td>6. Financial Highlights (Existing Units):</td>
                        <td align="right">(Rs. in Lacs)</td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                      <tr bgcolor="#71694F"> 
                        <td><b><font color="#FFFFFF">Sl.No.</font></b></td>
                        <td width="20%"><b><font color="#FFFFFF">Particulars</font></b></td>
                        <td width="20%" align="center"><b><font color="#FFFFFF">(Actuals)</font></b></td>
                        <td width="20%" align="center"><b><font color="#FFFFFF">(Actuals)</font></b></td>
                        <td width="20%" align="center"><b><font color="#FFFFFF">(Estimated)</font></b></td>
                        <td width="20%" align="center"><b><font color="#FFFFFF">(Projected)</font></b></td>
                      </tr>
                      <tr> 
                        <td width="5%">1.</td>
                        <td width="20%">Net Sales</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="5%">2.</td>
                        <td width="20%">Gross Profit</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="5%">3.</td>
                        <td width="20%">Depreciation</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="5%">4.</td>
                        <td width="20%">Net Profit</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="5%">5.</td>
                        <td width="20%">Cash Profit</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="5%" height="28">6.</td>
                        <td width="20%" height="28">Capital</td>
                        <td width="20%" height="28">&nbsp;</td>
                        <td width="20%" height="28">&nbsp;</td>
                        <td width="20%" height="28">&nbsp;</td>
                        <td width="20%" height="28">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="5%">7.</td>
                        <td width="20%">Reserves &amp; Surplus</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="5%">8.</td>
                        <td width="20%">Net Worth</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="5%">9.</td>
                        <td width="20%">Current Ratio</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="5%">10.</td>
                        <td width="20%">Debt Equity Ratio</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="5%">11.</td>
                        <td width="20%">DSCR</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="5%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td>Comments/Observations on Financial Highlights:</td>
                </tr>
                <tr> 
                  <td height="175">&nbsp;</td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                      <tr bgcolor="#71694F"> 
                        <td width="70%"><b><font color="#FFFFFF">Name of the Proprietor/partners/Directors</font></b></td>
                        <td width="30%"><b><font color="#FFFFFF">Worth (Rs. in 
                          Lacs)</font></b></td>
                      </tr>
                      <tr> 
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr> 
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr> 
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr> 
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr> 
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                      <tr bgcolor="#71694F"> 
                        <td width="70%"><b><font color="#FFFFFF">Name of the Guarantors</font></b></td>
                        <td width="30%"><b><font color="#FFFFFF">Worth (Rs. in 
                          Lacs)</font></b></td>
                      </tr>
                      <tr> 
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr> 
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr> 
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr> 
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr> 
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td>7. Assessment of Term Loan/Working Capital Requirements</td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td bgcolor="#71694F"><b><font color="#FFFFFF">I. Term 
                          Loan</font></b></td>
                        <td align="right" bgcolor="#71694F"><b><font color="#FFFFFF">(Rs. 
                          in Lacs)</font></b></td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                      <tr bgcolor="#71694F"> 
                        <td width="5%" height="25"><b></b></td>
                        <td width="30%" height="25"><b><font color="#FFFFFF">Cost 
                          of Project</font></b></td>
                        <td width="20%" height="25"><b><font color="#FFFFFF">Amount</font></b></td>
                        <td width="5%" height="25"><b><font color="#FFFFFF"></font></b></td>
                        <td width="30%" height="25"><b><font color="#FFFFFF">Source 
                          of Finance</font></b></td>
                        <td width="20%" height="25"><b><font color="#FFFFFF">Amount</font></b></td>
                      </tr>
                      <tr> 
                        <td width="5%">1.</td>
                        <td height="29">Land</td>
                        <td height="29">&nbsp;</td>
                        <td width="5%">1.</td>
                        <td height="29">Bank Loan</td>
                        <td height="29">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="5%">2.</td>
                        <td>Building</td>
                        <td>&nbsp;</td>
                        <td width="5%">2.</td>
                        <td>Borrower's Contribution</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="5%">3.</td>
                        <td>Plant and Machinery</td>
                        <td>&nbsp;</td>
                        <td width="5%">3.</td>
                        <td>Other Sources (give breakup)</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="5%">4.</td>
                        <td>Others</td>
                        <td>&nbsp;</td>
                        <td width="5%">4.</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="5%">5.</td>
                        <td>Margin for Working Capital</td>
                        <td>&nbsp;</td>
                        <td width="5%">5.</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="5%">&nbsp;</td>
                        <td>Total</td>
                        <td>&nbsp;</td>
                        <td width="5%">&nbsp;</td>
                        <td>Total</td>
                        <td>&nbsp;</td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td>Average DSCR:</td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                </tr>
                <tr> 
                  <td bgcolor="#71694F"><b><font color="#FFFFFF">II. Working Capital</font></b></td>
                </tr>
                <tr> 
                  <td>Assessment of Working Capital Finance:</td>
                </tr>
                <tr> 
                  <td height="27">Please use the following formats (enclosed) 
                    for assessment of Working Capital limits:</td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
                      <tr> 
                        <td width="20%" height="26"><b>Format A</b></td>
                        <td width="5%" height="26">&nbsp;</td>
                        <td width="75%" height="26">For assessment of WC limits 
                          up to Rs. 500 lacs.</td>
                      </tr>
                      <tr> 
                        <td width="20%" height="26"><b>Format B</b></td>
                        <td width="5%" height="26">&nbsp;</td>
                        <td width="75%" height="26">Counter check on PBF in respect 
                          of WC limits up to Rs. 200 lacs.</td>
                      </tr>
                      <tr> 
                        <td width="20%" height="26"><b>Format C</b></td>
                        <td width="5%" height="26">&nbsp;</td>
                        <td width="75%" height="26">Counter check on PBF in respect 
                          of WC limits more than Rs. 200 lacs but upto Rs. 500 
                          lacs. </td>
                      </tr>
                      <tr> 
                        <td width="20%" height="26"><b>Encloser</b></td>
                        <td width="5%" height="26"> 1.</td>
                        <td width="75%" height="26">Salient Financial Indicators</td>
                      </tr>
                      <tr> 
                        <td width="20%" height="26"><b>Encloser</b></td>
                        <td width="5%" height="26"> 2.</td>
                        <td width="75%" height="26">Quarterly Monitoring Report</td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td>8. Facilities with other Bank/Financial Institutions:</td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
                      <tr bgcolor="#71694F"> 
                        <td><b><font color="#FFFFFF">Nature of Facilities</font></b></td>
                        <td><b><font color="#FFFFFF">Limit</font></b></td>
                        <td><b><font color="#FFFFFF">Outstanding</font></b></td>
                        <td><b><font color="#FFFFFF">Overdues</font></b></td>
                      </tr>
                      <tr> 
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr> 
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr> 
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td>9. Details of Collateral Security Offered:</td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
                      <tr bgcolor="#71694F"> 
                        <td width="5%"><b><font color="#FFFFFF">I</font></b></td>
                        <td width="45%"><b><font color="#FFFFFF">Nature of Security</font></b></td>
                        <td width="50%"><b><font color="#FFFFFF">Value (Rs. in 
                          Lacs) (As per Bank's approved Valuer)</font></b></td>
                      </tr>
                      <tr> 
                        <td width="5%">&nbsp;</td>
                        <td width="45%">&nbsp;</td>
                        <td width="50%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="5%">&nbsp;</td>
                        <td width="45%">&nbsp;</td>
                        <td width="50%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="5%">&nbsp;</td>
                        <td width="45%">Total</td>
                        <td width="50%">&nbsp;</td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td>II. Security Coverage:</td>
                </tr>
                <tr> 
                  <td>10. Ancillary business/deposit relationship:</td>
                </tr>
                <tr> 
                  <td>11.Brief comments/observations of the sanctioning authority.</td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="10">
                      <tr> 
                        <td><b>SANCTIONED / REJECTED</b></td>
                        <td align="right"><b>RECOMMENDED / REJECTED</b></td>
                      </tr>
                      <tr> 
                        <td><b>BRANCH MANAGER</b></td>
                        <td align="right"><b></b></td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td>Additional condition/stipulations, if any:</td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                </tr>
                <tr> 
                  <td align="right"><b>Signature of Loan Committee Members&nbsp;&nbsp;</b></td>
                </tr>
                <tr>
                  <td>Note: If the proposal is found not suitable for sanction, 
                    the application is to be referred to next higher authority 
                    with supportive grounds for rejections.</td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>

</form>
</body>
</html>
