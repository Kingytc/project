<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" type="java.util.HashMap" scope="request" />
<%
	ArrayList arrRow =null;
	ArrayList arrCol =null;
	
	
	
	String[] auditDate = new String[5];
	String[] auditorComments = new String[5];
	String[] officersComments = new String[5];
	
	
	
					arrRow=(ArrayList)hshValues.get("arrRow6");
				  
					if(arrRow!=null && arrRow.size()>0 )
					{
						int size=arrRow.size();
						for(int i=0;i<arrRow.size();i++)
						{
							arrCol = (ArrayList)arrRow.get(i);
							if(arrCol!=null && arrCol.size()>0)
							{
								auditDate[Integer.parseInt(Helper.correctInt((String)arrCol.get(0)))-1] = (String) arrCol.get(1);
								auditorComments[Integer.parseInt(Helper.correctInt((String)arrCol.get(0)))-1] = (String) arrCol.get(2);
								officersComments[Integer.parseInt(Helper.correctInt((String)arrCol.get(0)))-1] = (String) arrCol.get(3);
							}	
						}
					}	
%>

<html>
<head>
<title>Monitoring Report Print</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css"
	type="text/css">

</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="40"> 
            <div align="center"><img
					src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg" ></div>
          </td>
        </tr>
        <tr> 
          <td> 
            <div align="center"><b>KARNATAKA BANK LTD.</b></div>
          </td>
        </tr>
        <tr> 
          <td> 
            <div align="center"><b>Monitoring of Large Borrowal Accounts </b></div>
          </td>
        </tr>
        <tr> 
          <td height="27"> 
            <div align="center">Monthly Credit Monitoring Report for the month 
              of <u><i><b><%=Helper.correctNull((String)hshValues.get("str_Month_alp"))%></b></i></u></div>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td> 
            <div id="top"> 
              <table width="98%" border="0" cellspacing="0" cellpadding="0">
	        <tr> 
	          <td>&nbsp;</td>
	        </tr>
	        <tr> 
	          <td><b>PART A - BASIC INFORMATION.</b></td>
	        </tr>
        <tr> 
              <td align="right"><b>[ Rs. in lacs ]</b></td>
        </tr>
        <tr> 
          <td> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td><b>1. Name of the Branch-</b></td>
                  <td><b>1 -a. Name of the Region -</b></td>
                </tr>
                <tr> 
                  <td height="37"><%=Helper.correctNull((String)hshValues.get("branch"))%></td>
                  <td height="37">&nbsp;<%=Helper.correctNull((String)hshValues.get("RespectiveRegion"))%></td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="47%"><b>2. Name of the Borrower (Title of the Account) 
                    -</b></td>
                  <td width="53%"><b>2-a. CBS Customer ID</b></td>
                </tr>
                <tr> 
                  <td width="47%">&nbsp;<%=Helper.decodeAmpersand(Helper.correctNull((String)request.getParameter("strcbsname")))%></td>
                  <td width="53%">&nbsp;<%=Helper.correctNull((String)hshValues.get("cbsid"))%></td>
                </tr>
                <tr> 
                  <td width="47%"><b>2-b. Nature of Business activity</b></td>
                  <td width="53%">&nbsp;<%=Helper.correctNull((String)hshValues.get("activity"))%></td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="47%"><b>3. Name of the contact person of the borrower 
                    and his / her position / designation. </b></td>
                  <td width="53%"><b>Contact nos. (with STD Code)</b></td>
                </tr>
                <tr> 
                  <td width="47%"><%=Helper.correctNull((String)hshValues.get("contactname"))%> 
                    - <%=Helper.correctNull((String)hshValues.get("contact_per_design"))%></td>
                  <td width="53%">Land Line : <%=Helper.correctNull((String)hshValues.get("contact_landline"))%><br>
                    Mobile : <%=Helper.correctNull((String)hshValues.get("contact_mobile"))%></td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
       
        <tr> 
          <td height="139"> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0" height="121">
                <tr> 
                  <td width="47%"><b>4. Whether the account is Restructured one. 
                    </b></td>
                  <td width="53%">&nbsp;<%=(Helper.correctNull((String)hshValues.get("acc_restructered")).equals("S"))?"":(Helper.correctNull((String)hshValues.get("acc_restructered")).equals("Y"))?"Yes":"NO"%> 
                  </td>
                </tr>
                <%if(Helper.correctNull((String)hshValues.get("acc_restructered")).equals("Y"))
				{%>
                <tr> 
                  <td width="47%"><b>If yes, whether all the terms of restructuring 
                    complied with. </b></td>
                  <td width="53%">&nbsp;&nbsp;<%=(Helper.correctNull((String)hshValues.get("acc_restructterms")).equals("S"))?"":(Helper.correctNull((String)hshValues.get("acc_restructterms")).equals("Y"))?"Yes":"NO"%><BR>
                    <%=Helper.correctNull((String)hshValues.get("acc_restructtermsreasons"))%> 
                  </td>
                </tr>
                <%}%>
                <%
			  	String bankArrange = Helper.correctNull((String)hshValues.get("arrange"));
				
				if(bankArrange.equals("1"))
				bankArrange ="Sole";
				else if(bankArrange.equals("2"))
				bankArrange ="Consortium";
				else if(bankArrange.equals("3"))
				bankArrange ="Multiple";
				else
				bankArrange ="";
				
			  %>
                <tr> 
                  <td width="47%"> <b>5. Banking Arrangement</b> </td>
                  <td width="53%"> &nbsp;<%=bankArrange%> </td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
       
        <%if(bankArrange.equals("Consortium"))
		{%>
        <tr> 
          <td> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="47%"><b>5 - a. If under consortium, Name of the Leader</b></td>
                  <td width="53%">&nbsp;<%=Helper.correctNull((String)hshValues.get("LeadBankName"))%></td>
                </tr>
                <tr> 
		          <td>&nbsp;</td>
		        </tr>
              </table>
            </div>
          </td>
        </tr>
        <%}%>
        <%if(bankArrange.equals("Consortium"))
		{%>
        <tr> 
          <td><b>5 - b. Our Share :</b></td>
        </tr>
        <tr> 
          <td> 
            <div id="top"> 
              <table width="100%"  cellspacing="0" cellpadding="0">
                <tr> 
                  <td colspan="2"> 
                    <div align="center"><b>Fund Based</b></div>
                  </td>
                  <td colspan="2"> 
                    <div align="center"><b>Non - Fund Based</b></div>
                  </td>
                </tr>
                <tr> 
                  <td> 
                    <div align="center"><b>Amt. Rs. In Crore</b></div>
                  </td>
                  <td> 
                    <div align="center"><b>% of share</b></div>
                  </td>
                  <td> 
                    <div align="center"><b>Amt. Rs. In Crore</b></div>
                  </td>
                  <td> 
                    <div align="center"><b>% of share</b></div>
                  </td>
                </tr>
                <%
                    
                  arrRow=(ArrayList)hshValues.get("arrRow3");
				  
					if(arrRow!=null && arrRow.size()>0 )
					{
						int size=arrRow.size();
						for(int i=0;i<arrRow.size();i++)
						{
						arrCol = (ArrayList)arrRow.get(i);
						if(arrCol!=null && arrCol.size()>0)
						{
							if(Helper.correctNull((String)arrCol.get(0)).equals("1"))
							{
							
							
		%>
                <tr> 
                  <td align="right">&nbsp;<%=Helper.correctNull((String)arrCol.get(2))%>&nbsp;</td>
                  <td align="right">&nbsp;<%=Helper.correctNull((String)arrCol.get(6))%></td>
                  <td align="right">&nbsp;<%=Helper.correctNull((String)arrCol.get(3))%>&nbsp;</td>
                  <td align="right">&nbsp;<%=Helper.correctNull((String)arrCol.get(5))%></td>
                </tr>
                <%}}}}%>
              </table>
            </div>
          </td>
        </tr>
        <%}%>
        <tr> 
          <td><b>6. Credit Ratings :</b></td>
        </tr>
        <tr> 
          <td> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td> 
                    <div align="center"><b>Present </b></div>
                  </td>
                  <td> 
                    <div align="center"><b>Previous </b></div>
                  </td>
                  <td> 
                    <div align="center"><b>Reasons for down gradation, if any. 
                      </b></div>
                  </td>
                </tr>
                <tr> 
                  <td><%=Helper.correctNull((String)hshValues.get("presentrating"))%> 
                    </td>
                  <td><%=Helper.correctNull((String)hshValues.get("prevrating"))%></td>
                  <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("downgradereason"))%></td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td><b>Part - B DETAILS OF FACILITIES ENJOYED </b></td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr align="center"> 
                  <td width="25%"><b>B-1. Sanctioning Authority</b></td>
                  <td width="25%"><b>Sanctioning Level</b></td>
                  <td width="25%"><b>Month of Next Review</b></td>
				      <td width="25%"><b>If due for renewal, date on which renewal 
                        submitted</b></td>
                </tr>
				<%
                    
                  arrRow=(ArrayList)hshValues.get("arrRow8");
				  
					if(arrRow!=null && arrRow.size()>0 )
					{
						int size=arrRow.size();
						for(int i=0;i<arrRow.size();i++)
						{
							arrCol = (ArrayList)arrRow.get(i);
							if(arrCol!=null && arrCol.size()>0)
							{
							
							
							
		%>
                <tr> 
                  <td width="25%">&nbsp;<%=Helper.correctNull((String)arrCol.get(0))%></td>
                  <td width="25%">&nbsp;<%=Helper.correctNull((String)arrCol.get(1))%></td>
                  <td width="25%">&nbsp;<%=Helper.correctNull((String)arrCol.get(2))%></td>
				   <td width="25%">&nbsp;<%=(Helper.correctNull((String)hshValues.get("renewalcompiled")).equals("S"))?"":(Helper.correctNull((String)hshValues.get("renewalcompiled")).equals("Y"))?"Yes":"NO"%> 
                    <br>
                    <%=Helper.correctNull((String)hshValues.get("ren_submitted"))%> 
                    <%=Helper.correctNull((String)hshValues.get("ren_submitted_reasons"))%> 
                  </td>
                </tr>
				<%}}}%>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
     
        <tr> 
          <td> 
                <div align="left"><b>B - 2</b></div>
          </td>
        </tr>
        <tr> 
          <td> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td rowspan="4" width="3%" align="center"><b>Sl.No</b></td>
                  <td rowspan="4" width="17%" align="center"><b>Nature of Facilities 
                    </b> </td>
                  <td rowspan="4" width="10%" align="center"><b>Limits<br>(Inclusive of adhoc limits)</b></td>
                  <td rowspan="4" width="10%" align="center"><b>D.P.</b></td>
                  <td rowspan="4" width="10%" align="center"><b>O/s as on </b><%=Helper.correctNull((String)hshValues.get("appcreatedate")) %></td>
                  <td colspan="2" rowspan="3" align="center"><b>Excess /Overdues 
                    / irregular amount </b></td>
                  <td colspan="3" align="center"><b>Turnover</b></td>
                </tr>
                <tr> 
                  <td width="9%" rowspan="2" align="center"><b>Debit Current month</b></td>
                  <td colspan="2" align="center"> <b>Credit</b> </td>
                </tr>
                <tr> 
                  <td width="10%" align="center"><b>Current Month</b></td>
                  <td width="10%" align="center"><b>Cumu-lative from 1st April</b></td>
                </tr>
                <tr> 
                  <td width="10%" height="43" align="center"><b>Amount</b></td>
                  <td width="10%" height="43" align="center"><b>Since when</b></td>
                  <td width="10%">&nbsp;</td>
                  <td width="10%">&nbsp;</td>
                  <td width="10%">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="3%" align="center">&nbsp;</td>
                  <td colspan="9"><b>Fund Based</b></td>
                </tr>
                <%
                    
                  arrRow=(ArrayList)hshValues.get("arrRow");
				  
					if(arrRow!=null && arrRow.size()>0 )
					{
						int size=arrRow.size();
						for(int i=0;i<arrRow.size();i++)
						{
						arrCol = (ArrayList)arrRow.get(i);
						if(arrCol!=null && arrCol.size()>0)
						{
					%>
                <tr> 
                  <td width="3%" align="center">&nbsp;<%=i+1%></td>
                  <td width="17%"><%=Helper.correctNull((String)arrCol.get(2))%></td>
                  <td width="10%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))%>&nbsp;</td>
                  <td width="10%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%>&nbsp;</td>
                  <td width="10%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))%>&nbsp;</td>
                  <td width="10%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))%>&nbsp;</td>
                  <%if(Helper.correctNull((String)arrCol.get(7)).equals("") || Helper.correctNull((String)arrCol.get(7)).equals("01/01/1900")){%>
                  <td width="10%" align="center">&nbsp;-</td>
                  <%}else{%>
                  <td width="10%" align="center">&nbsp;<%=Helper.correctNull((String)arrCol.get(7))%></td>
                  <%}%>
                  <td width="10%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(8))))%>&nbsp;</td>
                  <td width="10%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(9))))%>&nbsp;</td>
                  <td width="10%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(10))))%>&nbsp;</td>
                </tr>
                <%}}}%>
                <tr> 
                  <td  width="3%" align="center">&nbsp;</td>
                  <td  width="17%" align="center"><b>Sub - Total</b></td>
                  <td  width="10%" align="right"><b>&nbsp;<%=Helper.correctDouble((String)hshValues.get("sanction_amount"))%>&nbsp;</b></td>
                  <td  width="10%" align="right">&nbsp;</td>
                  <td  width="10%" align="right"><b>&nbsp;<%=Helper.correctDouble((String)hshValues.get("os_amount"))%>&nbsp;</b></td>
                  <td width="10%" align="right"><b>&nbsp;<%=Helper.correctDouble((String)hshValues.get("excess_fundbasedoverdues"))%>&nbsp;</b></td>
                  <td width="10%" align="left">&nbsp;</td>
                  <td width="10%" align="left">&nbsp;</td>
                  <td width="10%" align="left">&nbsp;</td>
                  <td width="10%" align="left">&nbsp;</td>
                </tr>
                
                <tr> 
                  <td  width="3%" align="center">&nbsp;</td>
                  <td colspan="9" align="left"><b>Other Loans</b></td>
                </tr>
                <tr> 
                  <td  width="3%" align="center">&nbsp;1.</td>
                  <td  width="17%" align="left">Bullion Loan</td>
                  <td  width="10%" align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("MMRBL_SANCAMT"))%></td>
                  <td  width="10%" align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("MMRBL_DRAWINGPOWER"))%></td>
                  <td  width="10%" align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("MMRBL_OSAMT"))%></td>
                  <td width="10%" align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("MMRBL_OVERDUEAMT"))%></td>
                  <td width="10%" align="center"><%=Helper.correctNull((String)hshValues.get("MMRBL_OVERDUESINCE"))%>&nbsp;</td>
                  <td width="10%" align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("MMRBL_DEBITCURRMONTH"))%></td>
                  <td width="10%" align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("MMRBL_CREDITCURRMONTH"))%></td>
                  <td width="10%" align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("MMRBL_CREDITURNOVER"))%></td>
                </tr>
                <tr> 
                  <td  width="3%" align="center">&nbsp;</td>
                  <td colspan="4" align="left">&nbsp;<b>Non Fund Based</b></td>
                  <td colspan="2" align="center">&nbsp;<b>Devolved (LC) / Invoked 
                    (LG)</b></td>
                  <td colspan="3" align="left">&nbsp;</td>
                </tr>
                
                <tr> 
                  <td  width="3%" align="center">&nbsp;1.</td>
                  <td  width="17%" align="left">Letter of Credit</td>
                  <td  width="10%" align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("MMRLC_SANCAMT"))%></td>
                  <td  width="10%" align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("MMRLC_DRAWINGPOWER"))%></td>
                  <td  width="10%" align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("MMRLC_OSAMT"))%></td>
                  <td width="10%" align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("MMRLC_OVERDUEAMT"))%></td>
                  <td width="10%" align="center">&nbsp;<%=Helper.correctNull((String)hshValues.get("MMRLC_OVERDUESINCE"))%>&nbsp;</td>
                  <td width="10%" align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("MMRLC_DEBITCURRMONTH"))%></td>
                  <td width="10%" align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("MMRLC_CREDITCURRMONTH"))%></td>
                  <td width="10%" align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("MMRLC_CREDITURNOVER"))%></td>
                </tr>
                <tr> 
                  <td  width="3%" align="center">&nbsp;2.</td>
                  <td  width="17%" align="left">Letter of Guarantee</td>
                  <td  width="10%" align="right"><%=Helper.correctNull((String)hshValues.get("MMRLG_SANCAMT"))%></td>
                  <td  width="10%" align="right"><%=Helper.correctNull((String)hshValues.get("MMRLG_DRAWINGPOWER"))%></td>
                  <td  width="10%" align="right"><%=Helper.correctNull((String)hshValues.get("MMRLG_OSAMT"))%></td>
                  <td width="10%" align="right"><%=Helper.correctNull((String)hshValues.get("MMRLG_OVERDUEAMT"))%></td>
                  <td width="10%" align="center">&nbsp;<%=Helper.correctNull((String)hshValues.get("MMRLG_OVERDUESINCE"))%>&nbsp;</td>
                  <td width="10%" align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("MMRLG_DEBITCURRMONTH"))%></td>
                  <td width="10%" align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("MMRLG_CREDITCURRMONTH"))%></td>
                  <td width="10%" align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("MMRLG_CREDITURNOVER"))%></td>
                </tr>
                <tr> 
                  <td  width="3%" align="center">&nbsp;</td>
                  <td  width="17%" align="center"><b>Sub - Total</b></td>
                  <td  width="10%" align="right"><b><%=Helper.correctDouble((String)hshValues.get("nonfundbasedsanctionamout"))%>&nbsp;</b></td>
                  <td  width="10%" align="right">&nbsp;</td>
                  <td  width="10%" align="right"><b>&nbsp;<%=Helper.correctDouble((String)hshValues.get("nonfundbasedos_amount"))%>&nbsp;</b></td>
                  <td width="10%" align="right"><b>&nbsp;<%=Helper.correctNull((String)hshValues.get("excess_nonfundbasedoverdues"))%>&nbsp;</b></td>
                  <td width="10%" align="center">&nbsp;</td>
                  <td width="10%" align="left">&nbsp;</td>
                  <td width="10%" align="left">&nbsp;</td>
                  <td width="10%" align="left">&nbsp;</td>
                </tr>
                <tr> 
                  <td  width="3%" align="center">&nbsp;</td>
                      <td  width="17%" align="center"><b>Grand - Total</b></td>
                  <td  width="10%" align="right"><b><%=Helper.correctDouble((String)hshValues.get("grandsanction_amount"))%></b>&nbsp;</td>
                  <td  width="10%" align="right">&nbsp;</td>
                  <td  width="10%" align="right"><b><%=Helper.correctDouble((String)hshValues.get("grandos_amount"))%>&nbsp;</b></td>
                  <td width="10%" align="right"><b>&nbsp;<%=Helper.correctNull((String)hshValues.get("grand_overduestotal"))%>&nbsp;</b></td>
                  <td width="10%" align="center">&nbsp;</td>
                  <td width="10%" align="left">&nbsp;</td>
                  <td width="10%" align="left">&nbsp;</td>
                  <td width="10%" align="left">&nbsp;</td>
                </tr>
              </table>
             </div>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="52%"><i><b>** Date of commencement of first instalment 
                    should be invariably reported in TL accounts where repayment 
                    not yet started. </b></i></td>
                  <td width="48%">&nbsp;<%=Helper.correctNull((String)hshValues.get("downgradecommencement"))%></td>
                </tr>
                <tr> 
                  <td colspan="2">&nbsp; <b>Note : - Above details are directly 
                    captured from finacle. The limits include sub limits (Within 
                    which limits) and Ad-hoc limits. Whenever the sublimits and 
                    ad-hoc limits are sanctioned, use the annexure provided to 
                    specify the Limits / Sub limits. There is a Provision to print 
                    the said annexure seperately which can be attached to the 
                    MMR report</b></td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
              <td><b>B-3.</b> </td>
        </tr>
        <tr> 
          <td> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="5%" height="28" valign="top">a)</td>
                      <td width="61%" height="28">Interest on working capital 
                        recovered upto <%=Helper.correctNull((String)hshValues.get("mon_recworkmonth"))%>. 
                        Quantify arrears if any.</td>
                  <td width="34%" height="28" align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("mon_recworkvalue"))%>&nbsp;</td>
                </tr>
                <tr> 
                  <td width="5%" height="32" valign="top">b)</td>
                  <td width="61%" height="32" valign="top">Interest on Term Loan recovered 
                    upto <%=Helper.correctNull((String)hshValues.get("mon_rectermmonth"))%>. 
                    Quantify arrears if any. </td>
                  <td width="34%" height="32" valign="top" align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("mon_rectermvalue"))%>&nbsp;</td>
                </tr>
                <tr> 
                  <td width="5%" height="28" valign="top">c)</td>
                  <td width="61%" height="28" valign="top">Term Loan installments recovered 
                    upto <%=Helper.correctNull((String)hshValues.get("mon_rectermins"))%>. 
                    Quantify arrears if any. </td>
                  <td width="34%" height="28" valign="top" align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("mon_recterminsvalue"))%>&nbsp;</td>
                </tr>
                <tr> 
                  <td width="5%" height="40" valign="top">d)</td>
                  <td width="61%" height="40" valign="top">Age -wise break up of overdue 
                    bills</td>
                  <td width="34%" height="40" valign="top" align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("mon_recage"))%>&nbsp;</td>
                </tr>
              </table>
			  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="48%" height="25" ><b>Period</b></td>
                  <td width="23%" height="25" align="center">&nbsp;<b>Inland</b></td>
                  <td width="29%" height="25" align="center"><b>&nbsp;Foreign</b></td>
                </tr>
                <tr> 
                  <td width="48%" height="32">Up to 3 Months</td>
                  <td width="23%" height="32" align="right"><%=Helper.correctNull((String)hshValues.get("mon_inlandthreemonth"))%>&nbsp;</td>
                  <td width="29%" height="32" align="right"><%=Helper.correctNull((String)hshValues.get("mon_foreignthreemonth"))%>&nbsp;</td>
                </tr>
                <tr> 
                  <td width="48%" height="28">3 Months to 6 Months </td>
                  <td width="23%" height="28" align="right"><%=Helper.correctNull((String)hshValues.get("mon_inlandsixmonth"))%>&nbsp;</td>
                  <td width="29%" height="28" align="right"><%=Helper.correctNull((String)hshValues.get("mon_foreignsixmonth"))%>&nbsp;</td>
                </tr>
                <tr> 
                  <td width="48%" height="40">More than 6 Months</td>
                  <td width="23%" height="40" align="right"><%=Helper.correctNull((String)hshValues.get("mon_inlandmorethansixmonth"))%>&nbsp;</td>
                  <td width="29%" height="40" align="right"><%=Helper.correctNull((String)hshValues.get("mon_foreignmorethansixmonth"))%>&nbsp;</td>
                </tr>
                <tr>
                  <td width="48%" height="40" >Total</td>
                  <td width="23%" height="40" align="right"><%=Helper.correctNull((String)hshValues.get("mon_inlandtotal"))%>&nbsp;</td>
                  <td width="29%" height="40" align="right"><%=Helper.correctNull((String)hshValues.get("mon_foreigntotal"))%>&nbsp;</td>
                </tr>
              </table>
            
            </div>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
              <td><b>B -4. Details of Prime Securities: -</b></td>
        </tr>
        <tr> 
          <td> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="16%" align="center"><b>Nature</b></td>
                  <td width="15%" align="center"><b>Valuation Report as on</b></td>
                  <td width="15%" align="center"><b>Value as per last stock statement 
                    </b></td>
                  <td width="12%" align="center"><b>Last Inspected on</b></td>
                  <td width="20%" align="center"><b>Whether adequately Insured 
                    </b></td>
                  <td width="10%" align="center"><b>Amount of Insurance</b></td>
                  <td width="12%" align="center"><b>Expiry Date of Insurance</b></td>
                </tr>
                <%
			  		String str_Check_Option="";	
	                arrRow=(ArrayList)hshValues.get("arrRow2");
				  	
					//System.out.println(arrRow);
					
					if(arrRow!=null && arrRow.size()>0 )
					{
						int size=arrRow.size();
						for(int i=0;i<arrRow.size();i++)
						{
						arrCol = (ArrayList)arrRow.get(i);
						if(arrCol!=null && arrCol.size()>0)
						{
							
							if(Helper.correctNull((String)arrCol.get(2)).equals("1"))
							{
							
							if((Double.parseDouble(Helper.correctDouble((String)arrCol.get(12))) < Double.parseDouble(Helper.correctDouble((String)arrCol.get(6)))))
							{
								str_Check_Option ="No";
							}
							else
							{
								str_Check_Option ="Yes";
							}
					%>
                <tr> 
                  <td width="16%" align="center">&nbsp;<%=Helper.correctNull((String)arrCol.get(13))%></td>
                  <td width="15%" align="center">&nbsp;<%=Helper.correctNull((String)arrCol.get(7))%></td>
                  <td width="15%" align="right"><%=Helper.correctNull((String)arrCol.get(6))%>&nbsp;</td>
                  <td width="12%" align="center">&nbsp;<%=Helper.correctNull((String)arrCol.get(10))%></td>
                  <td width="20%" align="center">&nbsp;<%=(Helper.correctNull((String)arrCol.get(13)).equalsIgnoreCase("Book Debts"))?"NA" : str_Check_Option%></td>
                  <td width="10%" align="right">&nbsp;<%=(Helper.correctNull((String)arrCol.get(13)).equalsIgnoreCase("Book Debts"))?"NA" : Helper.correctNull((String)arrCol.get(12))%>&nbsp;</td>
                  <td width="12%" align="center">&nbsp;<%=(Helper.correctNull((String)arrCol.get(13)).equalsIgnoreCase("Book Debts"))?"NA" : Helper.correctNull((String)arrCol.get(11))%></td>
                </tr>
                <%}}}}%>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td>
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="52%"><b>Whether any shortfall noticed, if so corrective 
                    action initiated</b></td>
                  <td width="48%">&nbsp;<%=Helper.correctNull((String)hshValues.get("primeSecurities"))%></td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
              <td><b>B - 5. Details of Collateral Securities: - </b></td>
        </tr>
        <tr> 
          <td> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0" height="145">
                <tr align="center"> 
                  <td width="13%" height="70" align="center"><b>Nature</b></td>
                  <td width="12%" height="70"><b>Value of security</b></td>
                  <td width="10%" height="70"><b>Date of latest valuation </b></td>
                  <td width="10%" height="70"><b>Last Inspected on</b></td>
                  <td width="17%" height="70"><b>Whether adequately Insured </b></td>
                  <td width="18%" height="70"><b>Amount of Insurance. </b></td>
                  <td width="20%" height="70"><b>Expiry Date of Insurance </b></td>
                </tr>
                <% if(arrRow!=null && arrRow.size()>0 )
					{
						int size=arrRow.size();
						for(int i=0;i<arrRow.size();i++)
						{
						arrCol = (ArrayList)arrRow.get(i);
						if(arrCol!=null && arrCol.size()>0)
						{
							if(Helper.correctNull((String)arrCol.get(2)).equals("2")){
							
							
							if(Double.parseDouble(Helper.correctDouble((String)arrCol.get(12))) < Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))
							{
								str_Check_Option ="No";
							}
							else
							{
								str_Check_Option ="Yes";
							}
					%>
                <tr align="center"> 
                  <td width="13%"  align="center">&nbsp;<%=Helper.correctNull((String)arrCol.get(13))%></td>
                  <td width="12%" align="right" >&nbsp;<%=Helper.correctNull((String)arrCol.get(6))%>&nbsp;</td>
                  <td width="10%" >&nbsp;<%=Helper.correctNull((String)arrCol.get(7))%></td>
                  <td width="10%" >&nbsp;<%=Helper.correctNull((String)arrCol.get(10))%></td>
                  <td width="17%"  >&nbsp;<%=(Helper.correctNull((String)arrCol.get(13)).equalsIgnoreCase("Book Debts"))? "NA" : str_Check_Option%></td>
                  <td width="18%" align="right" >&nbsp;<%=(Helper.correctNull((String)arrCol.get(13)).equalsIgnoreCase("Book Debts"))? "NA" : Helper.correctNull((String)arrCol.get(12))%>&nbsp;</td>
                  <td width="20%"  >&nbsp;<%=(Helper.correctNull((String)arrCol.get(13)).equalsIgnoreCase("Book Debts"))? "NA" : Helper.correctNull((String)arrCol.get(11))%></td>
                </tr>
                <%}}}}%>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="52%"><b>Whether any shortfall noticed, if so corrective 
                    action initiated</b></td>
                  <td width="48%">&nbsp;<%=Helper.correctNull((String)hshValues.get("colateralSecurity"))%></td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td><b>PART C - MONITORING INFORMATION</b> </td>
        </tr>
        <tr> 
          <td height="15">&nbsp;</td>
        </tr>
        <tr> 
          <td> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="7%" valign="top">1.</td>
                  <td width="60%">Whether documents as stipulated are obtained</td>
                  <td width="33%">&nbsp;<%=(Helper.correctNull((String)hshValues.get("documentobtained")).equals("S"))?"":(Helper.correctNull((String)hshValues.get("documentobtained")).equals("Y"))?"Yes":"NO"%></td>
                </tr>
                <tr> 
                  <td width="7%">&nbsp;</td>
                  <td width="60%"><b>Date of Document</b></td>
                  <td width="33%">&nbsp;</td>
                </tr>
                <tr> 
                  <td><b>Facility Name</b></td>
                  <td><b>Document Name</b></td>
                  <td><b>Date of Document</b></td>
                </tr>
                <%
				  ArrayList arrCol1 = new ArrayList();
				  ArrayList arrRow1 = new ArrayList();
				  				
                  arrRow=(ArrayList)hshValues.get("arrRow5");
				  int arrCol1_Size=0;
				  int tempCheckSize=0;
				  int tempRowcheck=0;
					if(arrRow!=null && arrRow.size()>0 )
					{
							int size=arrRow.size();
							for(int i=0;i<arrRow.size();i++)
							{
								arrCol = (ArrayList)arrRow.get(i);
								if(arrCol!=null && arrCol.size()>0)
								{
									
										tempCheckSize = Integer.parseInt(Helper.correctInt((String)arrCol.get(3)));
									
									 tempRowcheck++;
									//if(i!=0)
									{	
										if(tempCheckSize==(tempRowcheck))
										{
											tempRowcheck =0;
										}
									}	
								
								%>
                <tr> 
                  <%if(tempRowcheck==1 || tempCheckSize==1)
							{%>
                  <td rowspan="<%=tempCheckSize%>">&nbsp;<%=Helper.correctNull((String)arrCol.get(0))%></td>
                  <%}%>
                  <td>&nbsp;<%=Helper.correctNull((String)arrCol.get(1))%></td>
                  <td>&nbsp;<%=Helper.correctNull((String)arrCol.get(2))%></td>
                </tr>
                <%}}}%>
                <tr> 
                  <td width="7%">&nbsp;</td>
                  <td width="60%">- Date of Credit Process Audit conducted (If 
                    applicable)</td>
                  <td width="33%">&nbsp;<%=Helper.correctNull((String)hshValues.get("creditauditdate"))%></td>
                </tr>
                <tr> 
                  <td width="7%">&nbsp;</td>
                  <td width="60%">- Date of latest DBC obtained</td>
                  <td width="33%">&nbsp;<%=Helper.correctNull((String)hshValues.get("mon_dbcdate"))%></td>
                </tr>
                <tr> 
                  <td width="7%">&nbsp;</td>
                  <td width="60%">- Whether the above Documents are vetted by 
                    the Law Officer / Advocate </td>
                  <td width="33%">&nbsp;<%=(Helper.correctNull((String)hshValues.get("documentvetted")).equals("S"))?"":(Helper.correctNull((String)hshValues.get("documentvetted")).equals("Y"))?"Yes":"NO"%>
                  <%if(Helper.correctNull((String)hshValues.get("documentvetted")).equals("Y")){%>
                  -&nbsp;<%=Helper.correctNull((String)hshValues.get("lawyername"))%>
                  <%}%>
                  <br>
                    &nbsp;<%=Helper.correctNull((String)hshValues.get("docvettedreasons"))%> 
                  </td>
                </tr>
                <%if(bankArrange.equals("Consortium"))
				{%>
                <tr> 
                  <td width="7%">&nbsp;</td>
                  <td width="60%">- In case of joint documentation whether lead 
                    bank has obtained and got vetted the stipulated documents</td>
                  <td width="33%">&nbsp;<%=(Helper.correctNull((String)hshValues.get("personal_leadbankvetted")).equals("1"))?"NO":"YES"%></td>
                </tr>
                <tr> 
                  <td width="7%">&nbsp;</td>
                  <td width="60%">whether branch is holding confirmation to that 
                    effect</td>
                  <td width="33%">&nbsp;<%=(Helper.correctNull((String)hshValues.get("personal_stipdocuments")).equals("1"))?"NO":"YES"%></td>
                </tr>
                <%}%>
                <tr> 
                  <td width="7%">&nbsp;</td>
                  <td width="60%">- Whether any deficiencies pointed out in Documentation 
                    and rectification action initiated</td>
                  <td width="33%">&nbsp;<%=Helper.correctNull((String)hshValues.get("docdeficiencies"))%></td>
                </tr>
                <tr> 
                  <td width="7%" valign="top">2.</td>
                  <td width="60%">Terms and conditions not complied if any (with 
                    specific mention about creation / extension of mortgage / 
                    charge over Fixed Assets / Current Assets / Collateral Securities 
                    / bringing in promoter's contribution etc.)</td>
                  <td width="33%">&nbsp;<%=(Helper.correctNull((String)hshValues.get("mmr_infotermscond")).equals("0"))?"":(Helper.correctNull((String)hshValues.get("mmr_infotermscond")).equals("1"))?"Yes":"NO"%><br>
                    <%=Helper.correctNull((String)hshValues.get("mmr_infotermreason"))%> 
                  </td>
                </tr>
                <tr> 
                  <td width="7%">&nbsp;</td>
                  <td width="60%">Deviation / Non - compliance, if any, whether 
                    approved by the Competent Authority</td>
                  <td width="33%">&nbsp;<%=Helper.correctNull((String)hshValues.get("mon_deviation"))%> 
                  </td>
                </tr>
                <tr> 
                  <td width="7%">&nbsp;</td>
                  <td width="60%">Permitted date for compliance</td>
                  <td width="33%">&nbsp;<%=Helper.correctNull((String)hshValues.get("mon_compliance"))%> 
                  </td>
                </tr>
                <tr> 
                  <td width="7%" valign="top">3.</td>
                  <td width="60%">Whether charges stipulated as per sanction terms are registered with ROC </td>
                  <td width="33%">&nbsp;<%=(Helper.correctNull((String)hshValues.get("mon_roc")).equals("y"))?"Yes":Helper.correctNull((String)hshValues.get("mon_roc")).equals("n")?"No":Helper.correctNull((String)hshValues.get("mon_roc")).equals("na")?"Not Applicable":""%> 
                    <br>
                    &nbsp;<%=Helper.correctNull((String)hshValues.get("roc_reasons"))%> 
                  </td>
                </tr>
                <%
                if(Helper.correctNull((String)hshValues.get("mon_roc")).equals("y"))
                { %>
                <tr> 
                  <td width="7%">&nbsp;</td>
                  <td width="60%">Date of latest ROC certificate held </td>
                  <td width="33%">&nbsp;<%=Helper.correctNull((String)hshValues.get("mon_rocdate"))%></td>
                </tr>
                <%}%>
                <tr> 
                  <td width="7%" valign="top">4.</td>
                  <td width="60%">Date of latest factory / unit inspection (for 
                    mfg. Unit) and adverse feature observed, if any :</td>
                  <td width="33%">&nbsp;<%=Helper.correctNull((String)hshValues.get("mmr_infoinspectiondate"))%> 
                    - <%=Helper.correctNull((String)hshValues.get("mmr_infoadversedreason"))%> 
                  </td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td><b>5. AUDIT / INSPECTION<br>
            </b></td>
        </tr>
        <tr> 
          <td> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="46%"><b>Stock</b></td>
                  <td width="54%"><b>Date of Inspection: <%=Helper.correctNull(auditDate[0])%></b></td>
                </tr>
                <tr> 
                  <td width="46%"><b>Major observations / irregularities pointed 
                    out. If so, corrective action initiated and whether irregularities 
                    are rectified. </b></td>
                  <td width="54%"><b>If not rectified, reasons : </b></td>
                </tr>
                <tr> 
                  <td width="46%">&nbsp;<%=Helper.correctNull(auditorComments[0])%></td>
                  <td width="54%">&nbsp;<%=Helper.correctNull(officersComments[0])%></td>

                </tr>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="46%"><b>Concurrent</b></td>
                  <td width="54%"><b>Date of Inspection: <%=Helper.correctNull(auditDate[1])%></b></td>
                </tr>
                <tr> 
                  <td width="46%"><b>Major observations / irregularities pointed 
                    out. If so, corrective action initiated and whether irregularities 
                    are rectified. </b></td>
                  <td width="54%"><b>If not rectified, reasons : </b></td>
                </tr>
                <tr> 
                  <td width="46%">&nbsp;<%=Helper.correctNull(auditorComments[1])%></td>
                  <td width="54%">&nbsp;<%=Helper.correctNull(officersComments[1])%></td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="46%" height="17"><b> Internal Audit</b></td>
                  <td width="54%" height="17"><b>Date of Inspection: <%=Helper.correctNull(auditDate[2])%></b></td>
                </tr>
                <tr> 
                  <td width="46%"><b>Major observations / irregularities pointed 
                    out. If so, corrective action initiated and whether irregularities 
                    are rectified. </b></td>
                  <td width="54%"><b>If not rectified, reasons : </b></td>
                </tr>
                <tr> 
                  <td width="46%">&nbsp;<%=Helper.correctNull(auditorComments[2])%></td>
                  <td width="54%">&nbsp;<%=Helper.correctNull(officersComments[2])%></td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="46%"><b>RBI Inspection</b></td>
                  <td width="54%"><b>Date of Inspection: <%=Helper.correctNull(auditDate[3])%></b></td>
                </tr>
                <tr> 
                  <td width="46%"><b>Major observations / irregularities pointed 
                    out. If so, corrective action initiated and whether irregularities 
                    are rectified. </b></td>
                  <td width="54%"><b>If not rectified, reasons : </b></td>
                </tr>
                <tr> 
                  <td width="46%">&nbsp;<%=Helper.correctNull(auditorComments[3])%></td>
                  <td width="54%">&nbsp;<%=Helper.correctNull(officersComments[3])%></td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="46%"><b>Statutory Audit</b></td>
                  <td width="54%"><b>Date of Inspection: <%=Helper.correctNull(auditDate[4])%></b></td>
                </tr>
                <tr> 
                  <td width="46%"><b>Major observations / irregularities pointed 
                    out. If so, corrective action initiated and whether irregularities 
                    are rectified. </b></td>
                  <td width="54%"><b>If not rectified, reasons : </b></td>
                </tr>
                <tr> 
                  <td width="46%">&nbsp;<%=Helper.correctNull(auditorComments[4])%></td>
                  <td width="54%">&nbsp;<%=Helper.correctNull(officersComments[4])%></td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="7%" valign="top">6.</td>
                  <td width="59%">a) Date of last Consortium Meeting</td>
                  <td width="34%">&nbsp;<%=Helper.correctNull((String)hshValues.get("mon_dateofmet"))%><br>
                  </td>
                </tr>
                <tr> 
                  <td width="7%">&nbsp;</td>
                  <td width="59%"> b) Minutes of Meeting / Major Observations</td>
                  <td width="34%">&nbsp;<%=Helper.correctNull((String)hshValues.get("mon_minutesmet"))%></td>
                </tr>
                <tr> 
                  <td width="7%">&nbsp;</td>
                  <td width="59%">c) No of Meetings held during the Financial 
                    year.</td>
                  <td width="34%">&nbsp;<%=Helper.correctNull((String)hshValues.get("mon_noofmeetingheld"))%> 
                  </td>
                </tr>
                <tr> 
                  <td width="7%" valign="top">7.</td>
                  <td width="59%">Date of last meeting with the borrower</td>
                  <td width="34%">&nbsp;<%=Helper.correctNull((String)hshValues.get("borrower_Date"))%></td>
                </tr>
                <tr> 
                  <td width="7%" valign="top">8.</td>
                  <td width="59%">Whether sales/profitability is showing downward 
                    trend. If so, reasons thereof and corrective action initiated.</td>
                  <td width="34%">&nbsp;<%=(Helper.correctNull((String)hshValues.get("mmr_infoprofitabilty")).equals("0"))?"":(Helper.correctNull((String)hshValues.get("mmr_infoprofitabilty")).equals("1"))?"Yes":"No"%><br>
                    &nbsp;<%=Helper.correctNull((String)hshValues.get("mmr_infoprofitabiltyreason"))%> 
                  </td>
                </tr>
                <tr> 
                  <td width="7%" valign="top">9.</td>
                  <td width="59%">Any adverse report from the co-lenders/market, 
                    about the borrower. If so, give gist.</td>
                    
                  <td width="34%">&nbsp;
                  <%=(Helper.correctNull((String)hshValues.get("mmr_infocolenders")).equals("0"))?"":(Helper.correctNull((String)hshValues.get("mmr_infocolenders")).equals("1"))?"Yes":"No"%> 
                    <br>
                    &nbsp;<%=Helper.correctNull((String)hshValues.get("mmr_infocolendersreason"))%> 
                  </td>
                </tr>
                <tr> 
                  <td width="7%" valign="top">10.</td>
                  <td width="59%">Any change in the key management persons ?.</td>
                  <td width="34%">&nbsp;<%=(Helper.correctNull((String)hshValues.get("mmr_infomanageperson")).equals("0"))?"":(Helper.correctNull((String)hshValues.get("mmr_infomanageperson")).equals("1"))?"Yes":"No"%></td>
                </tr>
                <tr> 
                  <td width="7%" valign="top">11.</td>
                  <td width="59%">Any labour / legal problems / natural calamities 
                    / change in Govt. policy that may affect unit's viability.</td>
                  <td width="34%">&nbsp;<%=(Helper.correctNull((String)hshValues.get("mon_monitinfgovtpolicy")).equals("0"))?"":(Helper.correctNull((String)hshValues.get("mon_monitinfgovtpolicy")).equals("1"))?"Yes":"No"%><br>
                    &nbsp;<%=Helper.correctNull((String)hshValues.get("mon_monitinfgovtpolicyrson"))%></td>
                </tr>
                <tr> 
                  <td width="7%" valign="top">12.</td>
                  <td width="59%">Whether submission of Monthly /Quarterly statements 
                    / data such as Stock / Book Debt statements / MSOD / QPRs 
                    etc. is regular? If not whether applicable penal interest 
                    recovered?</td>
                  <td width="34%">&nbsp;<%=(Helper.correctNull((String)hshValues.get("mon_monitinfqpr")).equals("0"))?"":(Helper.correctNull((String)hshValues.get("mon_monitinfqpr")).equals("1"))?"Yes":"No"%> 
                    <br>
                    <%if(Helper.correctNull((String)hshValues.get("mon_monitinfqpr")).equals("2")){%>
                    &nbsp;<%=(Helper.correctNull((String)hshValues.get("mon_monitinfpenalinterst")).equals("0"))?"":(Helper.correctNull((String)hshValues.get("mon_monitinfpenalinterst")).equals("1"))?"Yes":"No"%><br>
                    &nbsp;<%=Helper.correctNull((String)hshValues.get("mon_monitinfpenalinterstrson"))%> 
                    <%}%>
                  </td>
                </tr>
                <tr> 
                  <td width="7%" valign="top">13.</td>
                  <td width="59%">Whether ledger operations are scrutinized by 
                    Nominated Officer ? </td>
                  <td width="34%">&nbsp;<%=(Helper.correctNull((String)hshValues.get("mon_monitinfledger")).equals("0"))?"":(Helper.correctNull((String)hshValues.get("mon_monitinfledger")).equals("1"))?"Yes":"No"%></td>
                </tr>
                <tr> 
                  <td width="7%" valign="top">14.</td>
                  <td width="59%">Any adverse features observed and action initiated 
                    for rectification. </td>
                  <td width="34%">&nbsp;<%=(Helper.correctNull((String)hshValues.get("mon_monitinfrectification")).equals("0"))?"":(Helper.correctNull((String)hshValues.get("mon_monitinfrectification")).equals("1"))?"Yes":"No"%> 
                    <%if(Helper.correctNull((String)hshValues.get("mon_monitinfrectification")).equals("1"))
				{%>
                    <%=Helper.correctNull((String)hshValues.get("mon_monitinfrectificationrson"))%> 
                    <%}%>
                  </td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td><b>PART - D</b><br>
            This column is mandatory and should be filled in by the Branch Head. 
            He should give specific comments on the following : 
            <p></p>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                  <td width="7%" valign="top">1.</td>
                      <td width="60%">Whether limits are valid and in force ( 
                        Y / N. If no, reasons. )</td>
                  <td width="33%">&nbsp;<%=(Helper.correctNull((String)hshValues.get("mon_limits")).equals("n"))?"No":"Yes"%><br>
                    &nbsp;<%=Helper.correctNull((String)hshValues.get("mon_limitsreason"))%></td>
                </tr>
                <tr> 
                  <td width="7%" valign="top">2.</td>
                      <td width="60%">Are you satisfied with the operations in 
                        the account ? ( Y / N. If no, reasons and corrective action 
                        initiated. )</td>
                  <td width="33%">&nbsp;<%=(Helper.correctNull((String)hshValues.get("mon_operation")).equals("n"))?"No":"Yes"%><br>
                    &nbsp;<%=Helper.correctNull((String)hshValues.get("mon_operationdetails"))%></td>
                </tr>
                <tr> 
                  <td width="7%" valign="top">3.</td>
                      <td width="60%">Whether all the sanction stipulations including 
                        creation of EM / ROC are complied with. ( Y / N. If no, 
                        reasons and corrective action initiated. )</td>
                  <td width="33%">&nbsp;<%=(Helper.correctNull((String)hshValues.get("mon_sanction")).equals("n"))?"No":"Yes"%><br>
                    &nbsp;<%=Helper.correctNull((String)hshValues.get("mon_sanctiondetails"))%></td>
                </tr>
                <tr> 
                  <td width="7%" valign="top">4.</td>
                      <td width="60%">Whether irregularities of earlier monitoring 
                        report observed by you and pointed out by RO /FGMO / CO 
                        are rectified. If not, reasons thereof. ( Y / N. If no, 
                        reasons and corrective action initiated. )</td>
                  <td width="33%">&nbsp;<%=(Helper.correctNull((String)hshValues.get("mon_irregular")).equals("n"))?"No":"Yes"%><br>
                    &nbsp;<%=Helper.correctNull((String)hshValues.get("mon_irregulardetails"))%></td>
                </tr>
                <tr> 
                  <td width="7%" valign="top">5.</td>
                  <td>Any other observations / Adverse features : </td>
                  <td width="33%">&nbsp;<%=Helper.correctNull((String)hshValues.get("mon_observationdetails"))%></td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td height="11"> 
            <%
		  		String cat_Type =Helper.correctNull((String)hshValues.get("acc_categorization"));
				
				if(cat_Type.equals("1"))
					cat_Type="Standard";
				else if(cat_Type.equals("2"))
					cat_Type="EAS-I";
				else if(cat_Type.equals("3"))
					cat_Type="EAS-II";
				else if(cat_Type.equals("4"))
					cat_Type="SMA";
				else
					cat_Type ="";	
							
					
				
		  %>
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td colspan="2"><b>The account categorized as under :</b></td>
                  <td colspan="2" width="69%">&nbsp;<%=cat_Type%></td>
                </tr>
                <tr> 
                  <td colspan="2"><b>If account under stress, reasons</b> </td>
                  <td colspan="2" width="69%">&nbsp;<%=(Helper.correctNull((String)hshValues.get("acc_stress")).equals("S"))?"":(Helper.correctNull((String)hshValues.get("acc_stress")).equals("Y"))?"Yes":"NO"%><br>
                    &nbsp;<%=Helper.correctNull((String)hshValues.get("acc_stress_reason"))%> 
                  </td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td>
            <table width="100%" border="0">
              <tr>
            		<td colspan="3" align="center" class="td_bg"><strong>Remarks</strong></td>
       			</tr>
             		<%
             		 ArrayList arrRowMailComments=(ArrayList)hshValues.get("mailcomments");
             		if(arrRowMailComments!=null && arrRowMailComments.size()>0)
          				{
          				for(int i=0; i<arrRowMailComments.size();i++)
          					{
          					ArrayList arrColMailComments=new ArrayList();
          					arrColMailComments=(ArrayList)arrRowMailComments.get(i);
       					%>
   					 
              <tr valign="top"> 
                <td width="19%"><%=arrColMailComments.get(0)%>&nbsp;</td>
                <td width="1%">:&nbsp;</td>
                <td width="80%"> 
                  <P><%=arrColMailComments.get(1)%>&nbsp;</P></td>
			         </tr>
			          <% 
            			}
			            }
          				%>
            </table>
</td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
		<tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td colspan="2">Nominated Officer</td>
                <td  colspan="2">Advances Incharge/Accountant </td>
                <td  colspan="2">Branch Head</td>
              </tr>
              <tr> 
                    <td width="18%" >Name</td>    <td width="16%" >&nbsp;<%=Helper.correctNull((String)hshValues.get("mon_noname"))%></td>
                    <td width="17%"  >Name</td>
                    <td width="16%"  >&nbsp;<%=Helper.correctNull((String)hshValues.get("mon_ainame"))%></td>
                    <td width="17%"  >Name </td>    <td  width="16%" >&nbsp;<%=Helper.correctNull((String)hshValues.get("mon_bhname"))%></td>
              </tr>
			   <tr> 
                    <td width="18%" >Designation</td>
                    <td  width="16%"  >&nbsp;<%=Helper.correctNull((String)hshValues.get("mon_nodesgn"))%></td>
                    <td width="17%"  >Designation</td>   <td  width="16%" >&nbsp;<%=Helper.correctNull((String)hshValues.get("mon_aidesgn"))%></td>
                    <td  width="17%"  >Designation</td>    <td   width="16%" >&nbsp;<%=Helper.correctNull((String)hshValues.get("mon_bhdesgn"))%></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="14%">BRANCH</td>
                  <td width="86%">&nbsp;<%=Helper.correctNull((String)session.getAttribute("strOrgName"))%></td>
                </tr>
                <tr> 
                  <td width="14%">DATE</td>
                  <td width="86%">&nbsp;<%=Helper.getCurrentDateTime()%></td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
         <tr> 
          <td><i><b>Note : 1. All columns must be filled in. Appropriate remarks should be put 
            in the columns <br>
            which are not applicable. But no column should be left blank in any 
            case. If any <br>
            column is kept blank, it will be viewed as suppression of facts. <br>
            </b> </i> </td>
        </tr>
       
      </table>
    </td>
  </tr>
</table>
</body>
</html>

