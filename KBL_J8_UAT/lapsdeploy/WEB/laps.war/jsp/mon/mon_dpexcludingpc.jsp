<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>

<%@ page import="java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />

  <%
double totalstock=Double.parseDouble(Helper.correctDouble((String)hshValues.get("mmr_totalstock")));
double grandtotal=Double.parseDouble(Helper.correctDouble((String)hshValues.get("grand_total")));
double marginpercent=Double.parseDouble(Helper.correctDouble((String)hshValues.get("marginpercent"))); 


double totalsub=grandtotal-totalstock;
//out.print("totalsub---->"+totalsub);
double totalwithmargin=totalsub*marginpercent/100;
//out.print("totalwithmargin---->"+totalwithmargin);
double totalsub1=totalsub-totalwithmargin;
//out.print("totalsub1---->"+totalsub1);



java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);


String strbankname=Helper.correctNull((String)hshValues.get("mmr_bankname"));

String banknamepercent=Helper.correctNull((String)hshValues.get("mmr_sharepercent"));

double  strsharepercent=Double.parseDouble(Helper.correctDouble((String)hshValues.get("mmr_sharepercent")));
double ownbank=0.00;
if(strbankname.equalsIgnoreCase("1")) {
	ownbank=totalsub1*strsharepercent/100;
	
}else {
	ownbank=0.00;
	strbankname="NIL";
	
}




%>
<html>
<head>
<title>Karnataka Bank Ltd.</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css"
	type="text/css">
</head>


<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0" font-family="arial" font-size="11px">
	
<br>

<table width="100%" border="0" cellspacing="0" cellpadding="4" >
        <tr>
       
          <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>          		
      
        </tr>
 </table>
<table cellSpacing="0" cellPadding="0" width="100%" border="0">
<TBODY>
  <tr>

    <td width="33%" colSpan="4"> <div align="center"><b>KARNATAKA BANK LTD.</b></div></td>
   
  </tr>
  
  <tr>
    <td width="100%" colSpan="4"><div align="center"><b>CALCULATION OF DRAWING POWER
    against STOCKS<br>
    (Excluding Stocks meant for PACKING CREDIT)</b></div></td>
  </tr>
 
  
  <tr>
    <td width="100%" colSpan="4"></td>
  </tr>
</TBODY>
</table>
<br>
<table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="2"
	align="center" height="100%">
  <tr>
		
    <td valign="top" height=""> 
      <table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="3">
        <tr> 
          <td align="center" width="5%">&nbsp;I</td>
          <td  width="46%" colspan="2"><font size="1" face="MS Sans Serif">Grand 
            Total </font></td>
          <td width="49%"> <%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("grand_total"))))%></td>
        </tr>
        <tr> 
          <td align="center" height="26" width="5%">II</td>
          <td  height="26" width="46%" colspan="2">&nbsp;<font size="1" face="MS Sans Serif">Total 
            Stock to be excluded for calculation of Drawing Power for Cash Credit/Demand 
            Loan (A+B+C+D+E+F) </font> </td>
          <td  width="49%"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mmr_totalstock"))))%> 
          </td>
        </tr>
        <tr> 
          <td align="center" width="5%"><font size="1" face="MS Sans Serif">III</font></td>
          <td  width="46%" colspan="2"><font size="1" face="MS Sans Serif">&nbsp;Stock 
            eliglible for calculation of Drawing Power for CASH CREDIT/DEMAND 
            LOAN ACCOUNTS (I-II)</font></td>
          <td align="left" width="49%"><%=nf.format(totalsub) %></td>
        </tr>
        <tr> 
          <td align="center" width="5%">IV</td>
          <td  width="46%" colspan="2">&nbsp;<font size="1" face="MS Sans Serif">Margin 
            % </font></td>
          <td align="left" width="49%"><%=Helper.correctNull((String)hshValues.get("marginpercent"))%> 
          </td>
        </tr>
        <tr> 
          <td align="center" width="5%">V</td>
          <td  width="46%" colspan="2"><font size="1" face="MS Sans Serif"> Total 
            Available DP against stocks (III-IV)</font></td>
          <td  width="49%"><%=nf.format(totalsub1) %></td>
        </tr>
        <tr> 
          <td ALIGN="center" width="5%" rowspan="2">VI</td>
          <td  width="23%" rowspan="2"><font size="1" face="MS Sans Serif">Our 
            Share in DP </font></td>
          <td  width="23%" height="27"><font size="1" face="MS Sans Serif">Consortium 
            share</font></td>
          <td  width="49%" height="27"> <%=banknamepercent %>%</td>
        </tr>
        <tr> 
          <td  width="23%"><font size="1" face="MS Sans Serif">Consortium Amount</font></td>
          <td  width="49%"><%=nf.format(ownbank) %></td>
        </tr>
        <tr> 
          <td width="5%">&nbsp;</td>
          <td align="right" width="46%" colspan="2">&nbsp;</td>
          <td align="right" width="49%">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="5%"> </td>
        </tr>
      </table>
		</td>
	</tr>
</table>
</body>
</html>
