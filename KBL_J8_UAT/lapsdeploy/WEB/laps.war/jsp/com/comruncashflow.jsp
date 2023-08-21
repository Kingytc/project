<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />

<%
		int colcount=Integer.parseInt((String)hshValues.get("cols"));
		ArrayList arryRow = (ArrayList)hshValues.get("arryRow");
		double dbval=0.00;
		ArrayList arryCol = null;
		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setGroupingUsed(true);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
%>
<html>
<head>
<title>Cash Flow Analysis</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script>
function closeWindow()
{
	if (ConfirmMsg("100"))
	{
		window.close();
	}
	
}

function menuOptionDivMouseDown (url) {
		//if (! isMac) {
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			//window.location=url;
			document.forms[0].action=url;
			document.forms[0].submit();
			//}
		}
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000">
<form name="cashrep">
  <p align="center"> <font face="Arial, Helvetica, sans-serif"><b>Cash Flow Analysis</b></font></p>
<%
	if (colcount > 0)
	{
%>
  <table width="100%" border="0" cellspacing="0" cellpadding="3">
    <tr> 
      <td width="20%" height="20"><b><font size="1" face="MS Sans Serif">Application 
        Number</font></b></td>
      <td width="25%" height="20"><b><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)hshValues.get("appno"))%></font></b></td>
      <td width="16%" height="20"><b><font size="1" face="MS Sans Serif">Company 
        Name</font></b></td>
      <td width="28%" height="20"><b><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)hshValues.get("name"))%></font></b></td>
      <td width="19%" height="20" align="center"><b><font size="1" face="MS Sans Serif">Date</font></b></td>
      <td width="10%" height="20"><b></b></td>
    </tr>
    <tr> 
      <td width="20%">&nbsp;</td>
      <td width="25%">&nbsp;</td>
      <td width="16%"></td>
      <td width="28%"></td>
      <td width="19%" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:window.print()" style="text-decoration:none"><font color="#990000">Print</font></a></b></font></td>
      <td width="10%" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:window.close()" style="text-decoration:none"><font color="#990000">Close</font></a></b></font></td>
    </tr>
  </table>
  <table width="100%" border="0" cellpadding="4" cellspacing="1">
    <%
if(arryRow!=null && colcount > 0)
{
	for(int i=0;i<2;i++)
	{
		arryCol=(ArrayList)arryRow.get(i);
%>
    <tr>
      <td width="3%" align="right" >&nbsp;</td>
      <%
		for(int j=0;j<arryCol.size();j++)
		{
			
	%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font size="1"><b><%=(String)arryCol.get(j)%></b></font></font></td>
      <%
		}%>
    </tr>
    <%	}
	
%>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="64%" ><font face="MS Sans Serif" size="1" color="#000000"><b><font color="#0000FF">SOURCES</font></b></font></td>
      <td width="12%" align="right" >&nbsp;</td>
    </tr>
    <tr>
      <td width="3%" ><font face="MS Sans Serif" size="1" color="#000000"><b>A)</b></font></td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><b> 
        Profit Before Tax</b></font></td>
      <%		
		arryCol= (ArrayList)hshValues.get("profit");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
			
%>
      <td width="25%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><%=nf.format(dbval)%></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">Add 
        : Depreciation</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("adddep");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><%=nf.format(dbval)%></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">Gross 
        Funds Generated</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("sougf");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><%=nf.format(dbval)%></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">Less 
        Taxes Paid</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("soult");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><%=nf.format(dbval)%></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">Less 
        Dividends</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("sould");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><%=nf.format(dbval)%></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">Prior 
        Period Adjustment</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("souprior");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><%=nf.format(dbval)%></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" ><font face="MS Sans Serif" size="1" color="#000000"><b>A.</b></font></td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><b> 
        Sub Total</b></font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("totsouA");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><%=nf.format(dbval)%></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" ><font face="MS Sans Serif" size="1" color="#000000"><b>B)</b></font></td>
      <td width="20%" ><font face="MS Sans Serif" size="1" color="#000000"><b> 
        Increase in</b></font></td>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">-Capital</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("scap");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">-Term 
        Loans</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("sterm");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">-Increase 
        in reserves</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("sres");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" ><font face="MS Sans Serif" size="1" color="#000000"><b>B.</b></font></td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><b> 
        Sub Total</b></font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("totsouB");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" ><font face="MS Sans Serif" size="1" color="#000000"><b>C)</b></font></td>
      <td width="20%" ><font face="MS Sans Serif" size="1" color="#000000"><b> 
        Decrease in</b></font></td>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">-Gross 
        Fixed Assets</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("sgf");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">-Non 
        Current Assets</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("snon");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">-Intangible 
        Assets</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("sintan");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" ><font face="MS Sans Serif" size="1" color="#000000"><b>C.</b></font></td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><b> 
        Sub Total</b></font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("totsouC");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" ><font face="MS Sans Serif" size="1" color="#000000"><b>D)</b></font></td>
      <td width="20%" ><font face="MS Sans Serif" size="1" color="#000000"><b> 
        Decrease in :</b></font></td>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">-Cash 
        &amp; Bank Balances</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("scash");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">-- 
        Receivables</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("srec");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">-- 
        Inventory</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("sinven");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">- 
        Advances to suppliers of Raw Materials</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("sadvance");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">- 
        Other Cr. Assets</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("socrasset");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" ><font face="MS Sans Serif" size="1" color="#000000"><b>D.</b></font></td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><b>Sub 
        Total</b></font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("totsouD");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" ><font face="MS Sans Serif" size="1" color="#000000"><b>E)</b></font></td>
      <td width="20%" ><font face="MS Sans Serif" size="1" color="#000000"><b> 
        Increase in :</b></font></td>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">- 
        Short term bank borrowings</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("sshort");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">- 
        Sundry Creditors (RM + others)</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("ssun");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">- 
        Other current liabilities</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("socur");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" ><font face="MS Sans Serif" size="1" color="#000000"><b>E.</b></font></td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><b> 
        Sub Total</b></font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("totsouE");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><b>Total 
        Funds Available</b></font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("totfundsou");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><%=nf.format(dbval)%></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" ><font face="MS Sans Serif" size="1" color="#000000"><b><font color="#0000FF">USES</font></b></font></td>
    </tr>
    <tr>
      <td width="3%" ><font face="MS Sans Serif" size="1" color="#000000"><b>A.</b></font></td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><b> 
        Net Loss</b></font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("totusesA");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><%=nf.format(dbval)%></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" ><font face="MS Sans Serif" size="1" color="#000000"><b>B)</b></font></td>
      <td width="20%" ><font face="MS Sans Serif" size="1" color="#000000"><b> 
        Increase in</b></font></td>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">-Gross 
        Fixed Assets</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("ugf");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">-Non 
        Current Assets</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("unon");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">-Intangible 
        Assets</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("uintan");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" ><font face="MS Sans Serif" size="1" color="#000000"><b>B.</b></font></td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><b> 
        Sub Total</b></font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("totusesB");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    <tr>
      <td width="3%" ><font face="MS Sans Serif" size="1" color="#000000"><b>C)</b></font></td>
      <td width="20%" ><font face="MS Sans Serif" size="1" color="#000000"><b> 
        Decrease in</b></font></td>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">-Capital</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("ucap");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">-Term 
        Loans</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("uterm");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">-Reserves</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("ures");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" ><font face="MS Sans Serif" size="1" color="#000000"><b>C.</b></font></td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><b> 
        Sub Total</b></font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("totusesC");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" ><font face="MS Sans Serif" size="1" color="#000000"><b>D)</b></font></td>
      <td width="20%" ><font face="MS Sans Serif" size="1" color="#000000"><b> 
        Decrease in :</b></font></td>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">- 
        Short term bank borrowings</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("ushort");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">- 
        Sundry Creditors (RM + others)</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("usun");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">- 
        Other current liabilities</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("uocur");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" ><font face="MS Sans Serif" size="1" color="#000000"><b>D.</b></font></td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><b> 
        Sub Total</b></font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("totusesD");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" ><font face="MS Sans Serif" size="1" color="#000000"><b>E)</b></font></td>
      <td width="20%" ><font face="MS Sans Serif" size="1" color="#000000"><b> 
        Increase in :</b></font></td>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">-Cash 
        &amp; Bank Balances</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("ucash");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">-- 
        Receivables</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("urec");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">-- 
        Inventory</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("uinven");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">- 
        Advances to suppliers of Raw Materials</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("uadvance");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000">- 
        Other Cr. Assets</font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("uocrasset");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" ><font face="MS Sans Serif" size="1" color="#000000"><b>E.</b></font></td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><b> 
        Sub Total</b></font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("totusesE");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><b>Total 
        Funds Used</b></font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("totfund");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><%=nf.format(dbval)%></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><b>LT 
        Sources</b></font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("ltsources");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><%=nf.format(dbval)%></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><b>LT 
        Uses</b></font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("ltuses");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1" color="#000000"><%=nf.format(dbval)%></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000"><b>LT 
        Surplus/(Deficit)</b></font></font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("ltsurplus");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000"><b>ST 
        Sources</b></font></font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("stsources");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000"><b>ST 
        Uses</b></font></font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("stuses");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <tr>
      <td width="3%" >&nbsp;</td>
      <td width="20%" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000"><b>ST 
        Surplus/(Deficit)</b></font></font></td>
      <%		
		arryCol=(ArrayList)hshValues.get("stsurplus");
		for(int j=0;j<arryCol.size();j++)
		{
			dbval =Double.parseDouble((String)arryCol.get(j));
%>
      <td width="12%" align="right" bgcolor="#F5F5F5" ><font face="MS Sans Serif" size="1"><font color="#000000" size="1"><%=nf.format(dbval)%></font></font></td>
      <%		}%>
    </tr>
    <%
		
}// end
%>
  </table>
  <br>
<br>
<table width="0%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td> 
      <div align="center">
          <input type="button" name="close1" value="Close"  style="background-color:#CC3300;font-weight:bold;color:white;font-size=7;font-family:mssansserif;width:40;font-weight:bold" onClick="closeWindow()">
      </div>
    </td>
  </tr>
</table>

<%
}
else
{
%>
 <p><h2><center>No Data Found</center></h2>
<%
}%>
</form>
</body>
</html>
