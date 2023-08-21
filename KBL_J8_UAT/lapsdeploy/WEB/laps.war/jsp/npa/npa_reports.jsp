
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>

<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror />
<%String strAppno=request.getParameter("app_no");
String strAppID=request.getParameter("comapp_id");
ArrayList arryColLiqAsset=null;
ArrayList facilities=(ArrayList)hshValues.get("facilities");

ArrayList arryColLiqAsset1=null;
ArrayList promoters=(ArrayList)hshValues.get("promoters");

ArrayList arryColLiqAsset2=null;
ArrayList promoters1=(ArrayList)hshValues.get("promoters1");


ArrayList arryColLiqAsset3=null;
ArrayList promoters2=(ArrayList)hshValues.get("promoters2");

ArrayList arryColLiqAsset4=null;
ArrayList promoters3=(ArrayList)hshValues.get("promoters3");


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>KARNATAKA BANK LTD.</title>
</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="5"> <tr> <td><table width="100%" border="0" cellspacing="0" cellpadding="3"> 
<tr> <td align="center"><strong>UNION BANK OF INIDA </strong></td></tr> <tr> <td align="center"><strong>CREDIT 
RECOVERY &amp; LEGAL SERVICES DEPARTMENT </strong>
</td>
</tr>
<tr>
<td align="center"><strong>CENTRAL 
OFFICE, MUMBAI. </strong>
</td>
</tr>
<tr>
<td align="center"><strong>-------------------------------------------------------------------------------------------------------------------------</strong></td>
</tr> 
<tr>
<td align="center"><strong><U>STATUS NOTE - NPAs AS ON  <%=Helper.correctNull((String)hshValues.get("npa_date"))%></U>
</strong>
</td>
</tr> 
</table>
</td>
</tr>
<tr>
<td>
<table width="100%" border="1" cellspacing="0" cellpadding="3"> 

<tr>
<td width="59%"><table width="100%" border="0" cellspacing="0" cellpadding="3"> 
<tr> 
<td>Name of the Account </td>
</tr>
<tr>
<td>Branch</td>
</tr>
<tr> 
<td>Region</td>
</tr> 
<tr>
<td>Zone</td>
</tr>
</table>
</td>
<td width="41%">
<table width="100%" border="0" cellspacing="0" cellpadding="3"> 
<tr>
<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("appname"))%></td>
</tr>
<tr>
<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("org_name"))%></td>
</tr>
<tr>
<td>&nbsp;</td>
</tr> 
<tr>
<td>&nbsp;</td>
</tr> 
</table>
</td>
</tr>
</table>
</td>
</tr>
<tr> 
<td> 
<table width="100%" border="1" cellspacing="0" cellpadding="3"> 
<tr> 
<td width="6%">&nbsp;</td>
<td width="53%">Registered Office at: </td>
<td width="41%">&nbsp; 
<%=Helper.correctNull((String)hshValues.get("prer"))%><br> <%=Helper.correctNull((String)hshValues.get("comapp_regadd1"))%><br> 
<%=Helper.correctNull((String)hshValues.get("comapp_regadd2"))%><br> <%=Helper.correctNull((String)hshValues.get("comapp_regcity"))%><br> 
<%=Helper.correctNull((String)hshValues.get("comapp_regstate"))%><br> <%=Helper.correctNull((String)hshValues.get("comapp_regphone"))%><br> 
<%=Helper.correctNull((String)hshValues.get("comapp_regfax"))%><br> <%=Helper.correctNull((String)hshValues.get("comapp_regpin"))%>
</td>
</tr> 
<tr>
<td width="6%">&nbsp;</td>
<td width="53%">Factory at: <br /> ( Also specify whether 
the office / factory is owned or rented or leased .) </td><td width="41%">&nbsp; 
<%=Helper.correctNull((String)hshValues.get("pre"))%><br> <%=Helper.correctNull((String)hshValues.get("comapp_factaddress1"))%><br> 
<%=Helper.correctNull((String)hshValues.get("comapp_factaddress2"))%><br> <%=Helper.correctNull((String)hshValues.get("comapp_factcity"))%><br> 
<%=Helper.correctNull((String)hshValues.get("comapp_factstate"))%><br> <%=Helper.correctNull((String)hshValues.get("comapp_factpin"))%><br> 
<%=Helper.correctNull((String)hshValues.get("comapp_factphone"))%><br> <%=Helper.correctNull((String)hshValues.get("comapp_factfax"))%>
</td>
</tr> 
<tr> 
<td valign="top">1.</td>
<td>Bannking since <br /> Advance since </td>
<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("comapp_bankdealing"))%><br>
<%=Helper.correctNull((String)hshValues.get("npa_advance"))%>
</td>
</tr> 
<tr> <td>2.</td>
<td>Constitution</td>
<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("owener"))%><br></td>
</tr> 
<tr> <td>3.</td>
<td>Activity</td>
<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("comapp_businessnature"))%></td>
</tr> 
<%
            if(promoters!=null && promoters.size()>0)
		{
   		   for(int j=1;j<promoters.size()+1;j++)
		   {
			arryColLiqAsset1=(ArrayList)promoters.get(j-1);
			
		        %>
				<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="2"> 

<tr>
<td>4.</td>
<td>(a)</td>
</tr> 
<tr>
<td>&nbsp;</td>
<td>(b)</td>
</tr>
<tr> 
<td>&nbsp;</td>
<td>(c)</td>
</tr> 
</table>
</td>
<td>Name /s of Directors  Telephone / Mobile No. / Res. 
Nos. <br /> Means &amp; Date <br /> Present activity other than above </td>
<td><%=arryColLiqAsset1.get(2)%><br>
<%=arryColLiqAsset1.get(3)%><br>
<%=arryColLiqAsset1.get(4)%><br> 
<%=arryColLiqAsset1.get(5)%><br>
<%=arryColLiqAsset1.get(6)%><br> 
<%=arryColLiqAsset1.get(7)%><br> 
<%=arryColLiqAsset1.get(8)%><br>
</td>
</tr>
<%
		 }
	      }
      	     %>




<tr> 
<td valign="top">

<table width="100%" border="0" cellspacing="0" cellpadding="1">
<tr>
<td valign="top">5.</td>
<td> 
</td>
</tr> 
<tr>
<td>&nbsp;</td>
<td>
</td>
</tr>
<tr> 
<td>&nbsp;</td>
<td>(c)</td>
</tr>
</table>
</td>

<td>Names of Guarantor(s) <br /> Telephone 
/ Mobile No. <br /> Means &amp; Date <br /> Present activity </td>
<td>&nbsp;
<%
            if(promoters1!=null && promoters1.size()>0)
		{
   		   for(int j=1;j<promoters1.size()+1;j++)
		   {
			arryColLiqAsset2=(ArrayList)promoters1.get(j-1);
			
		        %>
<%=arryColLiqAsset2.get(2)%><br>
<%=arryColLiqAsset2.get(3)%><br> 
<%=arryColLiqAsset2.get(4)%><br> 
<%=arryColLiqAsset2.get(5)%><br>
<%=arryColLiqAsset2.get(6)%><br> 
<%=arryColLiqAsset2.get(7)%><br> 
<%=arryColLiqAsset2.get(8)%><br>
</td>
      	     </tr><%
		 }
	      }
      	     %>
			 
		
			
			
			 <tr>
			 <td valign="top">&nbsp;</td>
			 <td>Names of Proprietor(s) <BR /> 

Telephone / Mobile No. <BR /> 
Means &amp; Date <BR /> 
Present activity </td>
	<%
            if(promoters3!=null && promoters3.size()>0)
		{
   		   for(int j=1;j<promoters3.size()+1;j++)
		   {
			arryColLiqAsset3=(ArrayList)promoters3.get(j-1);
			
		        %>
<td>&nbsp;<%=arryColLiqAsset3.get(2)%><br>
<%=arryColLiqAsset3.get(3)%><br> 
<%=arryColLiqAsset3.get(4)%><br> 
<%=arryColLiqAsset3.get(5)%><br>
<%=arryColLiqAsset3.get(6)%><br> 
<%=arryColLiqAsset3.get(7)%><br> 
<%=arryColLiqAsset3.get(8)%><br></td>
</tr><%
		 }
	      }
      	     %>

	
<tr>
<td valign="top">&nbsp;</td>
<td>Names 
of Partner(s) <BR /> 
Telephone / Mobile No. <BR /> 
Means &amp; Date <BR /> 
Present activity
 </td>
 <%
            if(promoters2!=null && promoters2.size()>0)
		{
   		   for(int j=1;j<promoters2.size()+1;j++)
		   {
			arryColLiqAsset4=(ArrayList)promoters2.get(j-1);
			
		        %>
 
 <td>&nbsp;<%=arryColLiqAsset4.get(2)%><br>
<%=arryColLiqAsset4.get(3)%><br> 
<%=arryColLiqAsset4.get(4)%><br> 
<%=arryColLiqAsset4.get(5)%><br>
<%=arryColLiqAsset4.get(6)%><br> 
<%=arryColLiqAsset4.get(7)%><br> 
<%=arryColLiqAsset4.get(8)%><br></td>
 </tr> <%
		 }
	      }
      	     %>
 <tr>
 <td valign="top"> <table width="100%" border="0" cellspacing="0" cellpadding="1"> 
<tr>
<td valign="top">6.</td>
<td>(a)<br /> <br /> <br /> </td>
</tr>
<tr>
<td>&nbsp;</td>
<td>(b)<br /> 
<br /> </td>
</tr>
<tr>
<td>&nbsp;</td>
<td>(c)</td>
</tr> 
</table>
</td>
<td>Banking arrangement 
( Indicate Sole, Consortium or Multiple Banking. If Consortium indicate names 
of consortium members and sharing pattern with limits, present O/s., status of 
A/c., whether regular / NPA)<br /> Indicate names of Term Lendinginstitutions, 
if any, alongwithsharing pattern and R / L O/ s.<br /> Details of connected A/c., 
if any with name, partners, directors, their Bankers, limit enjoyed and present 
status of the A/c. </td>
<td><%=Helper.correctNull((String)hshValues.get("com_propmulbank"))%><br>
<%=Helper.correctNull((String)hshValues.get("npa_bname"))%><br><%=Helper.correctNull((String)hshValues.get("npa_bankers"))%><br>
<%=Helper.correctNull((String)hshValues.get("npa_limit"))%><br>
<%=Helper.correctNull((String)hshValues.get("npa_pstatus"))%><br>
</td>

</tr> 
<tr>
<td valign="top">7.</td>
<td>Whether 
unit is working / closed since when. If working, whether own account or doing 
job work. If closed, borrowers source of livelihood. </td>
<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("unitval"))%><br> 

<%=Helper.correctNull((String)hshValues.get("npa_unitstopdate"))%><br>
</td>
</tr> 
<tr>
<td valign="top">8.</td>
<td>NPA since &nbsp;<br /> Present Asset Classification&nbsp;<br /> 
Provision held ( as of _______ * ______ )</td>
<td><%=Helper.correctNull((String)hshValues.get("npa_date"))%><br> 
<%=Helper.correctNull((String)hshValues.get("value"))%><br> <%=Helper.correctNull((String)hshValues.get("npa_provision"))%> 
</td>
</tr>
<tr>
<td valign="top">9.</td>
<td>Date of last review <br /> Last reviewed 
by ( give design with scale )<br /> Last finanacial statement held on record </td>
<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("com_proplastrevdate"))%><br>
<%=Helper.correctNull((String)hshValues.get("com_confactauth"))%><br>

</td>
</tr> 
<tr> 
<td valign="top">10.</td>
<td>Date since A / c. <br /> w<br /> is in excess 
Maximum excess allowed<br /> <br /> Steps taken for adjustment </td>
<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_since"))%><br>
<%=Helper.correctNull((String)hshValues.get("npa_excess"))%><br>
<%=Helper.correctNull((String)hshValues.get("npa_steps"))%><br>
</td>
</tr> 
<tr>
<td valign="top">11.</td>
<td>Whether the account was classified as 'EAS / 
SMA ' category.<br /> <br /> Reasons for classifying A / c. as 'EAS / SMA ' category, 
such as overdued turnover below projected sales, non - submission of statements 
/ DBC, saction stipulation not complied / audit irregularities not rectified, 
continuous lossess etc. and efforts made to upgrade the same. </td>
<td><%=Helper.correctNull((String)hshValues.get("value"))%></td>
</tr> 
<tr>
<td rowspan="2" valign="top">12. (a)<br /> <br /> <br /> <br /> <br /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(b)</td>
<td>Whether 
account placed under nursing / rehabilitation. If not, whether rehabilitation 
likely to improve status of account, It yes, whether the account suffers from 
any previous history of serious material irregularity, diversion of funds, non 
- viability or fraud. <br> </td>
<td><%=Helper.correctNull((String)hshValues.get("val"))%><br> 
<%=Helper.correctNull((String)hshValues.get("npa_detail"))%><br>
</td>
</tr>
<tr> 
<td>Whether OTS possible? </td>
<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_ots"))%></td>
</tr>
<tr>
<td>13.</td>
<td>Position of 
ECGC claim / ROD lodged </td>
<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_rod"))%><br> 
<br>
</td>
</tr>
<tr> 
<td>14.</td>
<td>Whether account is referred to BIFR. If yes reference nos. &amp; 
Date </td>
<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_selbifr"))%><br>
<%=Helper.correctNull((String)hshValues.get("npa_bifrregno"))%><br> 
<%=Helper.correctNull((String)hshValues.get("npa_bifrdate"))%><br>
</td>
</tr>
<tr> 
<td valign="top">15.</td>
<td>
Whether account is a take-over account .If yes,give bank from whom taken over </td>
<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_take"))%><br>
<%=Helper.correctNull((String)hshValues.get("npa_banks"))%></td>
</tr>
<tr>
<td valign="top">16.</td>
<td>Whether 
State / Central government guarantee is available. If yes brief particulars of 
guarantee. </td>
<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_state"))%><br>
<%=Helper.correctNull((String)hshValues.get("npa_gur"))%>
</td>
</tr>
<tr> 
<td>17.</td>
<td>Whether account is reported 
as Fraud, If yes date when 1st reported. </td>
<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_fraud"))%><br>
<%=Helper.correctNull((String)hshValues.get("npa_report"))%>
</td>
</tr>
<tr>
<td valign="top"> 
<table width="100%" border="0" cellspacing="0" cellpadding="1"> 
<tr>
<td valign="top">18.</td>
<td>(a)<br /> 
<br /> </td>
</tr>
<tr>
<td>&nbsp;</td>
<td>(b)<br /> <br /> </td>
</tr>
<tr>
<td>&nbsp;</td>
<td>(c)</td>
</tr> 
</table>
</td>
<td>Whether all terms of sanction complied with. If not, specify 
those not complied with. <br /> <br /> Date of latest documents / DBC. Whether 
documents are vetted by advocates, <br /> <br /> date of certificate and name 
of advocates, Descrepancies mentioned if any, specify </td>
<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_suitfilled"))%><br>
<%=Helper.correctNull((String)hshValues.get("npa_san"))%><br>
<%=Helper.correctNull((String)hshValues.get("npa_terms"))%><br>
<%=Helper.correctNull((String)hshValues.get("npa_dbc"))%><br>
<%=Helper.correctNull((String)hshValues.get("npa_adv"))%><br>
<%=Helper.correctNull((String)hshValues.get("npa_cert"))%><br>
<%=Helper.correctNull((String)hshValues.get("npa_name"))%><br>
<%=Helper.correctNull((String)hshValues.get("npa_dis"))%><br>

</td>
</tr>
<tr> 
<td valign="top">19.</td>
<td>Whether suit filed / Decreed: <br /> <br /> Date 
of suit / Decree<br /> Amount of suit / Decree <br /> Present position thereof 
<br /> <br /> name of the Advocate &amp; Tel. No. </td>
<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_suitdate"))%><br> 
<%=Helper.correctNull((String)hshValues.get("npa_suitamt"))%><br> <%=Helper.correctNull((String)hshValues.get("npa_suitstatus"))%><br> 
<%=Helper.correctNull((String)hshValues.get("npa_name"))%><br>
<%=Helper.correctNull((String)hshValues.get("npa_no"))%>
</td>
</tr> 
<tr> 
<td>20.</td>
<td>Whether action taken under SARFAESIA? If yes, give date of Notice 
issued, possession notice issued, possession taken, asset sold etc. </td>
<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_sel_sarf"))%><br>
<%=Helper.correctNull((String)hshValues.get("npa_posdate"))%><br> 
<%=Helper.correctNull((String)hshValues.get("npa_pos"))%><br> 
<%=Helper.correctNull((String)hshValues.get("npa_posiss"))%><br>
</td>
</tr> 
<tr>
<td>21.</td>
<td>Whether any agent appointed. If yes give details </td>
<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_agent"))%><br>
<%=Helper.correctNull((String)hshValues.get("npa_detail1"))%></td>
</tr> 
</table>
</td>
</tr>
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="3"> 
<tr> 
<td><strong><U>PRESENT POSITION OF ACCOUNT:</U> </strong></td>
</tr>
<tr> 
<td>
<table width="100%" border="1" cellspacing="0" cellpadding="3">
<tr> 
<td width="18%" align="center"><strong>Nature 
of Facility* ( Fund Based and Non - Fund Based ) </strong>
</td>
<td width="14%" align="center"><strong>Limit</strong></td>
<td width="12%" align="center"><strong>O 
/s as of<br /> __________ </strong></td>
<td width="24%" align="center"><strong>Dummy 
Ledger Interest from __________ to __________ </strong></td>
<td width="18%" align="center"><strong>Nature 
&amp; Value of Securities incl. of Coll. Security </strong></td>
<td width="14%" align="center"><strong>Date 
of Valuation and Valuer </strong></td>
</tr> <%
            if(facilities!=null && facilities.size()>0)
		{
   		   for(int j=1;j<facilities.size()+1;j++)
		   {
			arryColLiqAsset=(ArrayList)facilities.get(j-1);
			String esidet=Helper.correctNull((String)arryColLiqAsset.get(2));
		        String esidetils="";
			 if(esidet.equalsIgnoreCase("F"))
			 {
			  esidetils="Funded"; 
			 
			 }
			 else if(esidet.equalsIgnoreCase("NF"))
			 {
			  esidetils="NonFunded"; 
			 }
			 %> <tr> <td>&nbsp;<%=esidetils%></td>
			 <td>&nbsp;<%=arryColLiqAsset.get(3)%></td>
			 <td>&nbsp;</td>
			 <td>&nbsp;</td>
			 <td>&nbsp;</td>
			 <td>&nbsp;</td>
			 </tr> 
<%
		 }
	      }
      	     %> <tr>
			 <td>&nbsp;</td>
			 <td>&nbsp;</td>
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
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
</table>
</td>
</tr> 
<tr>
<td><em>If devolvement of LC / invocation of gtee., give details such as 
name of drawee / beneficiary, margin held and whether credited or not. </em>
</td>
</tr> 
</table>
</td>
</tr>
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="3"> 
<tr> 
<td><strong><U>PRESENT POSITION OF SEVURITIES:</U> <div align="right">( Rs. 
in Crores )</div></strong>
</td>
</tr>
<tr>
<td>
<table width="100%" border="1" cellspacing="0" cellpadding="3"> 
<tr> 
<td width="18%" rowspan="2" align="center"><strong>Particulars of Securities 
</strong>
</td>
<td width="14%" colspan="2" align="center"><strong>Value of Securities 
</strong></td>
<td width="12%" rowspan="2" align="center"><strong>Last date of 
inspection </strong></td>
<td width="24%" rowspan="2" align="center"><strong>Name 
of the Official who inspected &amp; adverse comments if any </strong>
</td>
</tr> 
<tr>
<td align="center"><strong>Market</strong>
</td>
<td align="center"><strong>Realisable</strong>
</td>
</tr> 
<tr>
<td><u>Primary security</u>: *<br /> i)<br /> ii)<br /> iii) </td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr> 
<tr>
<td>Collateral Security <br />( Please specify ) * </td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr> 
</table>
</td>
</tr>
<tr> 
<td><em>*&nbsp;In case of stock / book - debt, specify 
realisable value<br /> * &nbsp;Land / bldg., P & m, house property, size, Plot 
No., constructed area, age of bld., location, owenership, marketability & realisable 
value, valuation & date.</em>
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="3"> 
<tr>
<td>
<strong><U>BRIEF HISTORY:</U> </strong>
</td>
</tr>
<tr>
<td>
<table width="100%" border="1" cellspacing="0" cellpadding="3"> 
<tr>
<td colspan="6" align="center">&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_his"))%></td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr> 
<tr> 
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="3">
<tr> 
<td><strong><U>REASON FOR ACCOUNT TURNING IRREGULAR:</U></strong>
</td>
</tr>
<tr> 
<td>( The Reason should be business related like diversion of funds, non - viability 
of venture, lack of demand, conpetition, fraudulent activities etc and not merely 
interest bot servicedm installments not paid etc.) </td>
</tr> 
<tr> 
<td>
<table width="100%" border="1" cellspacing="0" cellpadding="3"> 
<tr> 
<td colspan="6" align="center">&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_irr"))%></td>
</tr> 
</table>
</td>
</tr>
</table>
</td>
</tr>
<tr> 
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="3"> 
<tr>
<td><strong><U>STAFF ACCOUNTABILITY:</U></strong></td>
</tr> 
<tr> 
<td>( Specify 
date examined and sent to Reviewing Authority also. If no accountability is fixed, 
the basis on which the decision was arrived at to be reported..) </td>
</tr>
<tr> 
<td><table width="100%" border="1" cellspacing="0" cellpadding="3"> 
<tr> 
<td colspan="6" align="center">&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_staff"))%><br> 
</td>
</tr> 
</table>
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="3"> 
<tr>
<td>
<strong><U>AUDIT OBSERVATINS:</U></strong> ( in brief )</td>
</tr> 
<tr> 
<td>
<u><strong>Internal Audit ( Date of Report :&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_datei"))%>)</strong></u> 
</td>
</tr>
<tr>
<td>
<table width="100%" border="1" cellspacing="0" cellpadding="3"> 
<tr>
<td colspan="5" align="center"><strong>OBSERVATINS</strong>
</td>
<td align="center"><strong>COMPLIANCE</strong></td>
</tr> 
<tr> 
<td colspan="5" align="center">&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_observ"))%></td>
<td width="50%" align="center">&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_compl"))%></td>
</tr> 
</table>
</td>
</tr>
</table>
</td>
</tr>
<tr> 
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="3"> 
<tr>
<td>
<u><strong>Concurrent Audit ( Date of Report :&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_datec"))%>)</strong></u>
</td>
</tr> 
<tr>
<td>
<table width="100%" border="1" cellspacing="0" cellpadding="3"> 
<tr> 
<td colspan="5" align="center"><strong>OBSERVATINS</strong>
</td>
<td align="center"><strong>COMPLIANCE</strong>
</td>
</tr> 
<tr>
<td colspan="5" align="center">&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_observ1"))%></td>
<td width="50%" align="center">&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_compl1"))%></td>
</tr> 
</table>
</td>
</tr>
</table>
</td>
</tr>
<tr> 
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="3"> 
<tr> 
<td>
<u><strong>Statutory / RBI Audit/ ( Date of Report :&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_dates"))%>)</strong></u>
</td>
</tr> 
<tr> 
<td><table width="100%" border="1" cellspacing="0" cellpadding="3">
<tr> 
<td colspan="5" align="center"><strong>OBSERVATINS</strong>
</td>
<td align="center"><strong>COMPLIANCE</strong></td>
</tr> 
<tr>
<td colspan="5" align="center">&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_observ2"))%></td>
<td width="50%" align="center">&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_compl2"))%></td>
</tr> 
</table>
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="3"> 
<tr>
<td><strong><U>ACTION PLAN / PRESENT POSITION / REMARKS :</U></strong>
</td>
</tr> 
<tr>
<td><em>Please ensure that the progress with respect to following points 
viz. (a) Suit at DRT against the Co. (b) BIFR hearing (c) Action under 'SARFAEST' 
Act. (d) Whether recovery / enforcement agents etc are appointed (e) Consortium 
meeting details (f) Recovery prospects and action planned. etc are included. </em></td>
</tr> 
<tr> 
<td><table width="100%" border="1" cellspacing="0" cellpadding="3">
<tr> 
<td colspan="6" align="center">&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_action"))%></td>
</tr> 
</table>
</td>
</tr>
</table>

</td>
</tr> 
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="3"> 
<tr> 
<td colspan="2">&nbsp;</td>
</tr> 
<tr>
<td colspan="2">&nbsp;</td>
</tr> 
<tr> 
<td colspan="2">&nbsp;</td>
</tr> 
<tr> 
<td width="50%" align="center"><strong>BRANCH MANAGER </strong></td>
<td width="50%" align="center"><strong>REGIONAL 
HEAD </strong></td>
</tr>
</table>
</td>
</tr>
</table>
<input type=hidden name="app_no" value="<%=strAppno%>"> 
<input type=hidden name="comapp_id" value="<%=strAppID%>"> 
 <input type="hidden" name="comapp_compname" value="<%=Helper.correctNull((String)request.getParameter("comapp_compname"))%>">
</body>
</html>
