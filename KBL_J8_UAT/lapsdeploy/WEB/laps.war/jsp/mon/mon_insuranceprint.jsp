<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%

			ArrayList vec = new ArrayList();
			ArrayList vecrec = new ArrayList();
			int vecsize = 0;
			
			if (hshValues != null) {
				vec = (ArrayList) hshValues.get("vecData");
				vecrec = (ArrayList) hshValues.get("vecData2");
			}
			if (vec != null) {
				vecsize = vec.size();
			}
			
			
			ArrayList g1 = new ArrayList();
			ArrayList g2 = new ArrayList();
			
	%>

<html>
<head>
<title>Annx</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css"/>
</head>

<body>

<table border="0" width="89%" cellspacing="0">
  <tr>
    <td width="73%"></td>
    <td width="27%"><p align="left">Annx. XIII (contd.)<br>
    Annexure to Stock Statement<br>
    as On :<%= Helper.correctNull((String)hshValues.get("stockdate"))%></td>
  </tr>
</table>

<p><b>Details of the INSURANCE COVER held on record<br>
</b><br>
Account No:<%= Helper.correctNull((String)hshValues.get("mon_accno"))%></p>

<p>Account Name:<%= Helper.correctNull((String)hshValues.get("strcbsname"))%></p>
<div id="top">
<table border="0" width="100%"  cellspacing="0" cellpadding="0">
  <tr class="tblhead">
    <td width="3%" align="center" height="57">No.</td>
    <td width="11%" align="center" height="57">Details of Security Cover</td>
    <td width="9%" align="center" height="57">Insurance Amount</td>
	<td nowrap width="16%" align="center">Insurance No</td>
    <td width="13%" align="center" height="57">Expiry Date</td>
    <td width="12%" align="center" height="57">Whether endorsed 
      in Bank's favour with Bank's Clause</td>
    <td width="15%" align="center" height="57">Whether Policies 
      submitted to Bank</td>
    <td width="21%" align="center" height="57">Remarks</td>
  </tr>
  <%
  if (vecsize > 0)
	{
		for (int l=0;l<vecsize;l++) 
		{
			g1 = (ArrayList)vec.get(l);
			g2 = (ArrayList)vecrec.get(l);
	%>
									
	<tr>
	<td width="3%" valign="center" align="center"><%= l + 1%></td>
	<td width="11%" align="center"> <%= Helper.correctNull((String) g1.get(0))%>&nbsp;</td>
	<td width="9%" align="center"><%= Helper.correctNull((String)g2.get(4))%>&nbsp;</td>
	<td width="16%" align="center"><%= Helper.correctNull((String)g2.get(10))%>&nbsp;</td>
	<td width="13%" align="center"><%= Helper.correctNull((String)g2.get(5))%>&nbsp;</td>
	<td width="12%" align="center"> <%= Helper.correctNull((String)g2.get(6))%>&nbsp;</td>
      <!--  <%//String str1 = Helper.correctNull((String) g2.get(6));%>
      <% //if (str1.equalsIgnoreCase("y")){%>
      Yes 
      <% //} else if(str1.equals("n")) { %>
      No 
      <% //} else if(str1.equals(" ")) { %>
      &nbsp; 
      <% //} else {} %>
      &nbsp; </td>-->
	<td width="15%" align="center" > 
      <%String str2 = Helper.correctNull((String) g2.get(7));%>
      <% if (str2.equalsIgnoreCase("y")){ %>
      Yes 
      <% } else if(str2.equals("n")){ %>
      No 
      <%} else if(str2.equals(" ")) { %>
      &nbsp; 
      <% } else {} %>
      &nbsp; </td>
	<td valign="center" width="21%" ><%=Helper.correctNull((String)g2.get(8))%>&nbsp;</td>
	<%}%>
	<%}%>
</tr>
<tr>
	<td width="3%">&nbsp;</td>
	<td width="11%" align="center"><b>Total</b></td>
	<td width="9%" align="center"><%= Helper.correctNull((String)hshValues.get("insuamount"))%>&nbsp;</td>
	<td width="16%" align="center">&nbsp;</td>
	<td width="13%" align="center">&nbsp;</td>
	<td width="12%" align="center">&nbsp;</td>
	<td valign="center" width="15%">&nbsp;</td>
	<td valign="center" width="21%">&nbsp;</td>
</tr>
  
</table>
</div>
<p class="MsoNormal">We certify that -&nbsp; 

<ol style="margin-top:0in" start="1" type="a">
  <li class="MsoNormal" style="mso-list:l0 level1 lfo1;tab-stops:list .5in">The stocks
    detailed above are our exclusive property and other than the bank no person whatsoever has
    any interest, lien or charge thereon.<br>
  </li>
  <li class="MsoNormal" style="mso-list:l0 level1 lfo1;tab-stops:list .5in">The quantity of
    the raw materials, goods-in-progress and finished goods shown above represent the true and
    accurate stocking positions obtained as on the date of the statement and are in conformity
    with our permanent books of accounts.<br>
  </li>
  <li class="MsoNormal" style="mso-list:l0 level1 lfo1;tab-stops:list .5in">The rates of
    valuation indicated above truly reflected the invoice rates or the contract rates or the
    controlled rates whichever are the lowest<br>
  </li>
  <li class="MsoNormal" style="mso-list:l0 level1 lfo1;tab-stops:list .5in">No order of
    attachment or any notice or process from any court has been received by us in respect of
    the whole/ any part of the said assets pledged/ hypothecated to the bank.<br>
  </li>
  <li class="MsoNormal" style="mso-list:l0 level1 lfo1;tab-stops:list .5in">Entire declared
    stocks are fully insured. All the conditions and warranties contained in the insurance
    policy have been complied with. The policies are valid and enforceable and the permia due
    there under has been paid up to date. Details of insurance Cover held on record attached
    separately.<br>
  </li>
  <li class="MsoNormal" style="mso-list:l0 level1 lfo1;tab-stops:list .5in">Select operational
    data also attached separately.<br>
  </li>
  <li class="MsoNormal" style="mso-list:l0 level1 lfo1;tab-stops:list .5in">Eligible Drawing
    power worked out based on the statement is enclosed.</li>
</ol>
<div id="top">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td colspan="2" align="center"><b>Signature Verified</b></td>
    <td width="4%" align="center">&nbsp;</td>
    <td colspan="2" align="center"><b>Authorised Signatory</b></td>
  </tr>
  <tr>
    <td width="16%" height="32">Name</td>
    <td width="30%" height="32">&nbsp;</td>
    <td width="4%" height="32">&nbsp;</td>
    <td width="14%" height="32">Name</td>
    <td width="36%" height="32">&nbsp;</td>
  </tr>
  <tr>
    <td width="16%" height="32">PF No</td>
    <td width="30%" height="32">&nbsp;</td>
    <td width="4%" height="32">&nbsp;</td>
    <td width="14%" height="32">Designation</td>
    <td width="36%" height="32">&nbsp;</td>
  </tr>
  <tr>
    <td width="16%" height="36">Designation</td>
    <td width="30%" height="36">&nbsp;</td>
    <td width="4%" height="36">&nbsp;</td>
    <td width="14%" height="36">&nbsp;</td>
    <td width="36%" height="36">&nbsp;</td>
  </tr>
  <tr>
    <td height="55" colspan="2" align="center"><em>*Seal and Signature 
      of the Bank's Official in Print Out</em></td>
    <td width="4%" align="center" height="55">&nbsp;</td>
    <td height="55" colspan="2" align="center"><em>*Seal and Signature 
      of the Customer in Print Out</em></td>
  </tr>
</table>
</div>

</body>
</html>
