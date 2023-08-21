<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<%
	ArrayList arryCol = null;
			ArrayList arryRow = (ArrayList) hshValues.get("arryRow");
			
			String crop_cost=Helper.correctNull((String)hshValues.get("crop_cost"));
			String crop_grossincomee=Helper.correctNull((String)hshValues.get("crop_grossincomee"));
			String crop_costp=Helper.correctNull((String)hshValues.get("crop_costp"));
			String crop_grossincomep=Helper.correctNull((String)hshValues.get("crop_grossincomep"));
			
			String TotalC=Helper.correctNull((String)hshValues.get("TotalC"));
			String TotalF=Helper.correctNull((String)hshValues.get("TotalF"));
			String Total=Helper.correctNull((String)hshValues.get("Total"));
			
			
			
%>
<laps:handleerror />
<html>
<head>
<title>calculation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<style type="text/css">
td{font-family: "verdana"; font-size: 11px;}
</style>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="0" cellpadding="2">
  <tr> 
    <td align="center" colspan="2"><b>KARNATAKA BANK LTD.</b></td>
  </tr>
  <tr> 
    <td align="center" colspan="2">CALCULATION OF INCREMENTAL INCOME</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="2">
        <tr> 
          <td width="67%">Pre-investment Income :</td>
          <td width="33%">Name of the Borrower&nbsp;:- <%=Helper.correctNull((String)hshValues.get("appname"))%></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2"> 
      <table width="100%" border="1" cellspacing="0" cellpadding="4">
        <tr> 
          <td width="4%" height="37">S.No</td>
          <td width="5%" height="37">Season</td>
          <td width="5%" height="37">Crop</td>
          <td width="10%" height="37">Acreage</td>
          <td width="13%" height="37">Cost of cultivation per ac (Rs.)</td>
          <td width="11%" height="37">Total Expenditure(Rs.)</td>
          <td width="10%" height="37">Yield per Acre (Qtl)</td>
          <td width="14%" height="37">Total Yield (Q)</td>
          <td width="14%" height="37">Rate Per Unit</td>
          <td width="14%" height="37">Total Income (Rs.)</td>
        </tr>
        <%for (int i = 1; i <=arryRow.size(); i++)
			    {
				
				if (arryRow != null && arryRow.size() >= i) {
					arryCol = (ArrayList) arryRow.get(i - 1);
					
					%>
        <tr> 
          <% 
		String season=Helper.correctNull((String)arryCol.get(1));
			String season1="";
		if(season.equalsIgnoreCase("1"))
			{
			season1="Kharif";
			}
			if(season.equalsIgnoreCase("2"))
			{
			season1="Rabi";
			}
			if(season.equalsIgnoreCase("3"))
			{
			season1="Summer";
			}
			if(season.equalsIgnoreCase("4"))
			{
			season1="Annual";
			}
			if(season.equalsIgnoreCase("5"))
			{
			season1="Perrenial";
			}
		%>
          <td width="4%">&nbsp;<%=i%></td>
          <td width="5%">&nbsp;<%=season1%></td>
          <td width="5%">&nbsp;<%=arryCol.get(3)%></td>
          <%			double val,val1,val2=0.00;
                      String valacer1=Helper.correctNull((String)arryCol.get(4));
					   String valacer2=Helper.correctNull((String)arryCol.get(5));
                     val1=Double.parseDouble(valacer1);
					 val2=Double.parseDouble(valacer2);
                      val=val1+val2;
                      %>
          <td width="10%">&nbsp;<%=val%></td>
          <td width="13%">&nbsp;<%=arryCol.get(16)%></td>
          <td width="11%">&nbsp;<%=arryCol.get(6)%></td>
          <td width="10%">&nbsp;<%=arryCol.get(17)%></td>
          <td width="14%">&nbsp;<%=arryCol.get(7)%></td>
          <td width="14%">&nbsp;<%=arryCol.get(18)%></td>
          <td width="14%">&nbsp;<%=arryCol.get(8)%></td>
        </tr>
        <%}
		else
		{%>
        <tr> 
          <td width="4%">&nbsp;</td>
          <td width="5%">&nbsp;</td>
          <td width="5%">&nbsp;</td>
          <td width="10%">&nbsp;</td>
          <td width="13%">&nbsp;</td>
          <td width="11%">&nbsp;</td>
          <td width="10%">&nbsp;</td>
          <td width="14%">&nbsp;</td>
          <td width="14%">&nbsp;</td>
          <td width="14%">&nbsp;</td>
        </tr>
        <%}}%>
        <tr> 
          <td width="4%">&nbsp;</td>
          <td width="5%">&nbsp;</td>
          <td width="5%">&nbsp;</td>
          <td width="10%">&nbsp;</td>
          <td width="8%">Total(A)&nbsp;&nbsp;&nbsp;&nbsp;Rs.</td>
          <td width="10%"><%=crop_cost%></td>
          <td width="10%">&nbsp;</td>
          <td width="14%">&nbsp;</td>
          <td width="14%" >Total(B)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Rs.</td>
          <td width="14%"><%=crop_grossincomee%></td>
        </tr>
        <!--<tr> 
          <td width="4%">&nbsp;</td>
          <td width="5%">&nbsp;</td>
          <td width="5%">&nbsp;</td>
          <td width="10%">&nbsp;</td>
          <td width="13%">&nbsp;</td>
          <td width="11%">&nbsp;</td>
          <td width="10%">&nbsp;</td>
          <td width="14%">&nbsp;</td>
          <td width="14%">&nbsp;</td>
          <td width="14%">&nbsp;</td>
        </tr>-->
      </table>
    </td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="4">
        <tr> 
          <td>Net Pre-investment Income:C=(B-A) Rs.<%=TotalC%></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">Post Investment Income:</td>
  </tr>
  <tr> 
    <td colspan="2"> 
      <table width="100%" border="1" cellspacing="0" cellpadding="4">
        <tr> 
          <td width="4%" height="37">S.No</td>
          <td width="5%" height="37">Season</td>
          <td width="5%" height="37">Crop</td>
          <td width="10%" height="37">Acreage</td>
          <td width="13%" height="37">Cost of cultivation per ac (Rs.)</td>
          <td width="11%" height="37">Total Expenditure(Rs.)</td>
          <td width="10%" height="37">Yield per Acre (Qtl)</td>
          <td width="14%" height="37">Total Yield (Q)</td>
          <td width="14%" height="37">Rate Per Unit</td>
          <td width="14%" height="37">Total Income (Rs.)</td>
        </tr>
        <%for (int i = 1; i <=arryRow.size(); i++)
			    {
				
				if (arryRow != null && arryRow.size() >= i) {
					arryCol = (ArrayList) arryRow.get(i - 1);
					
					%>
        <tr> 
          <% String season=Helper.correctNull((String)arryCol.get(1));
			String season1="";
		if(season.equalsIgnoreCase("1"))
			{
			season1="Kharif";
			}
			if(season.equalsIgnoreCase("2"))
			{
			season1="Rabi";
			}
			if(season.equalsIgnoreCase("3"))
			{
			season1="Summer";
			}
			if(season.equalsIgnoreCase("4"))
			{
			season1="Annual";
			}
			if(season.equalsIgnoreCase("5"))
			{
			season1="Perrenial";
			}
		%>
          <td width="4%" height="26">&nbsp;<%=i%></td>
          <td width="5%" height="26">&nbsp;<%=season1%></td>
          <td width="5%" height="26">&nbsp;<%=arryCol.get(3)%></td>
          <%			double val,val1,val2=0.00;
                      String valacer1=Helper.correctNull((String)arryCol.get(10));
					   String valacer2=Helper.correctNull((String)arryCol.get(11));
                     val1=Double.parseDouble(valacer1);
					 val2=Double.parseDouble(valacer2);
                      val=val1+val2;
                      %>
          <td width="10%" height="26">&nbsp;<%=val%></td>
          <td width="13%" height="26">&nbsp;<%=arryCol.get(19)%></td>
          <td width="11%" height="26">&nbsp;<%=arryCol.get(12)%></td>
          <td width="10%" height="26">&nbsp;<%=arryCol.get(20)%></td>
          <td width="14%" height="26">&nbsp;<%=arryCol.get(13)%></td>
          <td width="14%" height="26">&nbsp;<%=arryCol.get(21)%></td>
          <td width="14%" height="26">&nbsp;<%=arryCol.get(14)%></td>
        </tr>
        <%}
		else
		{%>
        <tr> 
          <td width="4%">&nbsp;</td>
          <td width="5%">&nbsp;</td>
          <td width="5%">&nbsp;</td>
          <td width="10%">&nbsp;</td>
          <td width="13%">&nbsp;</td>
          <td width="11%">&nbsp;</td>
          <td width="10%">&nbsp;</td>
          <td width="14%">&nbsp;</td>
          <td width="14%">&nbsp;</td>
          <td width="14%">&nbsp;</td>
        </tr>
        <%}}%>
        <tr> 
          <td width="4%">&nbsp;</td>
          <td width="5%">&nbsp;</td>
          <td width="5%">&nbsp;</td>
          <td width="10%">&nbsp;</td>
          <td width="7%">Total(D)&nbsp;&nbsp;&nbsp;&nbsp;Rs.</td>
          <td width="7%"><%=crop_costp%></td>
          <td width="10%">&nbsp;</td>
          <td width="14%">&nbsp;</td>
          <td width="17%" >Total(E)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Rs.</td>
          <td width="14%"><%=crop_grossincomep%></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="4">
        <tr> 
          <td colspan="3">Net Post -investment Income:F=(E-D) Rs.<br>
          </td>
          <td width="9%"><%=TotalF%></td>
          <td width="12%">&nbsp;</td>
          <td width="12%" align="center">&nbsp;</td>
          <td width="17%">&nbsp;</td>
          <td width="14%" align="center">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="3">NET INCREMENTAL INCOME (F-C) Rs.</td>
          <td width="7%" colspan="-3"><%=Total%><br>
          </td>
          <td width="11%">&nbsp;</td>
          <td width="12%" align="center">&nbsp;</td>
          <td width="17%">&nbsp;</td>
          <td width="14%" align="center">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp; </td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp; </td>
  </tr>
  <tr> 
    <td width="60%">&nbsp; </td>
    <td width="40%" align="center"> Signature of the processing officer</td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr> 
    <td width="60%">&nbsp; </td>
    <td width="40%" align="center">Name of the processing officer</td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp; </td>
  </tr>
</table>

	

</body>
</html>
