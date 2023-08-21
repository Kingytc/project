<%@ page import="com.sai.laps.helper.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Duediligence Report</title>
<%
String strsaral= Helper.correctNull((String) request.getParameter("hidsaral"));
%>
<style type="text/css">
<!--
body,td,th {
	font-family: verdana;
	font-size: 11px;
	color: #000000;
}
body {
	margin-left: 50px;
	margin-top: 20px;
	margin-right: 50px;
	margin-bottom: 20px;
}
-->
</style>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>

</head>

<body>
<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()"> 
  <div class="menuitems" url="">
   <script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div>
  </div>
<table width="100%" border="0" cellspacing="0" cellpadding="3">
<tr> 
	<td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg" /></td>
</tr>
<tr> 
    			<td align="center"><b>Branch - <%=Helper.correctNull((String)hshValues.get("orgname"))%></b></td>
			</tr>
<tr> 
  			
    <td align="center"><%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp; 
      <%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp; <%=Helper.correctNull((String)hshValues.get("orgcity"))%>,&nbsp; 
      <%=Helper.correctNull((String)hshValues.get("orgstate"))%>-&nbsp; <%=Helper.correctNull((String)hshValues.get("orgzip"))%>&nbsp; 
      . Tel No : <%=Helper.correctNull((String)hshValues.get("orgphone"))%>
      <hr/>
		</td>
</tr>
  <tr>
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
    <td align="center"><strong>RETAIL BANKING DEPARTMENT</strong><br />
     </td>
  </tr>
    <%if(strsaral.equalsIgnoreCase("saral"))
		{%>
  <tr> 
    <td valign="bottom" align="center" colspan="3"><laps:inward/></td>
  </tr>
  <%}else
	{%>
  <tr> 
    <td valign="bottom" align="center" colspan="3"> <laps:application/></td>
  </tr>
  <%}%>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><b>SALARIED PERSONS:</b></td>
  </tr>
  <tr>
    <td><table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolor="#CCCCCC">
      <tr>
        <td width="2%">1.</td>
        <td width="21%">Name of the Applicant </td>          
          <td width="68%" colspan="2">&nbsp;<%=Helper.correctNull((String)hshValues.get("strName"))%> </td>
      </tr>
      <tr>
        <td>&nbsp;</td>        
        <td align="right"><%=Helper.correctNull((String)hshValues.get("strTitle"))%></td>
          <td colspan="2">&nbsp;<%=Helper.correctNull((String)hshValues.get("strFatHusName"))%></td>
      </tr>
      <tr>
        <td height="22">&nbsp;</td>        
        <td align="right">Age</td>
          <td colspan="2">&nbsp;<%=Helper.correctNull((String)hshValues.get("strAge"))%></td>
      </tr>
      <tr>        
        <td colspan="4">&nbsp;</td>
      </tr>
      <tr>
        <td>2.</td>
        <td>Present Occupation/Employment</td>
          <td colspan="2">&nbsp;<%=Helper.correctNull((String)hshValues.get("strOccupation"))%></td>
      </tr>
      <tr>
        <td colspan="4">&nbsp;</td>
      </tr>
      <tr>
        <td valign="top">3.</td>
        <td>No. of  years in present employment/Organisation<br />
          Years:</td>
          <td colspan="2">&nbsp;<%=Helper.correctNull((String)hshValues.get("strYrsemploy"))%></td>
      </tr>
      <tr>
        <td colspan="4">&nbsp;</td>
      </tr>
      <%
      String service=Helper.correctNull((String)hshValues.get("strService"));
      if(service.equalsIgnoreCase("u"))
      {
    	  service="Unconfirmed";
      }
      else if(service.equalsIgnoreCase("c"))
      {
    	  service="confirmed";
      }
      
      %>
      
      <tr>
        <td>4.</td>
        <td>Whether applicant&rsquo;s services are </td>
          <td colspan="2">&nbsp;<%=service%></td>
      </tr>
      <tr>
        <td colspan="4">&nbsp;</td>
      </tr>
      <tr>
        <td valign="top">5.</td>
        <td valign="top">Address of Residence (including Telephone Numbers/Mobile Number and e-mail address</td>
        <td colspan="2">&nbsp;<%=Helper.correctNull((String)hshValues.get("strResiAddr"))%></td>
        </tr>
      <tr>
        <td valign="top">5.a)</td>
        <td valign="top">Address of Office(including Telephone Numbers/Mobile Number and e-mail address</td>
          <td colspan="2">&nbsp;<%=Helper.correctNull((String)hshValues.get("strOfficeAddr"))%></td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td>Before answering the following questions, mention the sources of information and name of person (s) contacted.</td>
  </tr>
  <tr>
    <td><%=Helper.correctNull((String)hshValues.get("strPersonContact"))%></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolor="#CCCCCC">
      <tr>
        <td width="2%" valign="top">1.</td>
        <td width="33%" valign="top">Whether the residential address given by applicant is visited ?  if so when ? Whether address matches with that given in the application? Give land mark for identifying the address and enclose rough sketch of location.</td>
        <td width="65%">&nbsp;<%=Helper.correctNull((String)hshValues.get("strResiaddrVisited"))%></td>
      </tr>
      <tr>
        <td colspan="3">&nbsp;</td>
      </tr>
      <tr>
        <td valign="top">2.</td>
        <td valign="top">Since how many years the applicant is residing at the given address of residence?</td>
          <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strYrsofResidence"))%></td>
      </tr>
      <tr>
        <td colspan="3">&nbsp;</td>
      </tr>
      <tr>
        <td valign="top">3.</td>
        <td valign="top">Whether the residence is owned/rented/leased/company provided. </td>
        <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strTypeofResidence"))%></td>
      </tr>
      <tr>
        <td colspan="3">&nbsp;</td>
      </tr>
      <tr>
        <td valign="top">4.</td>
        <td valign="top">Whether address of  Office/Business Place is visited ? If so when? Whether the address on physical inspection matches with that of address given in the application? Give land mark for identifying location.</td>
        <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strOfficeaddrVisited"))%></td>
      </tr>
      <tr>
        <td colspan="3">&nbsp;</td>
      </tr>
      <tr>
        <td valign="top">5.</td>
        <td valign="top">Whether identity of the applicant (s) is/are established through telephonic enquiry? If the date, time and the telephone numbers.</td>
        <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strIdentity"))%></td>
      </tr>
      <tr>
        <td colspan="3">&nbsp;</td>
      </tr>
      <tr>
        <td valign="top">5.</td>
        <td valign="top">Whether genuineness of salary certificate ( in the case of employees ) submitted by the applicant is verified with the employer ( say Yes or No) </td>
        <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strGenuineSC"))%></td>
      </tr>
      <tr>
        <td colspan="3">&nbsp;</td>
      </tr>
      <tr>
        <td valign="top">6.</td>
        <td valign="top">Whether the undertaking given by the employer for deduction of loan installment is verified and found genuine?</td>
        <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strUndertakingVerified"))%></td>
      </tr>
      <tr>
        <td colspan="3">&nbsp;</td>
      </tr>
      <tr>
        <td valign="top">7.</td>
        <td valign="top">(a)Whether the Authority who issued such letter of undertaking for deduction of loan installment is competent to issue such undertaking?<br />
          <br />
          (b)Whether the Organization normally issues such letters of undertaking ? <br />
          (Essentially this fact is to be enquired with the employer and if needed discretely as some of the Organizations do not issue such letters of undertaking, but applicants manage to get such undertaking from unauthorized Officials )<br /></td>
        <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strUndertakingAuthority"))%></td>
      </tr>
      <tr>
       <td colspan="3">&nbsp;</td>
      </tr>
      <tr>
        <td valign="top">8.</td>
        <td  valign="top">(a) Whether copies of IT Returns submitted by the applicant (s) are verified with the Originals?<br />
            <br />
          (b) Whether genuineness of IT returns is verified with I.T. Department? If so when ( mention the date ) and who has verified the same.<br /></td>
        <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strITReturns"))%></td>
      </tr>
      <tr>
        <td colspan="3">&nbsp;</td>
      </tr>
      <tr>
        <td valign="top">9.</td>
        <td valign="top">Whether identity of the applicant is verified based on PAN Number <br />
          ( wherever  applicable )</td>
        <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strPANIdentity"))%></td>
      </tr>
      <tr>
        <td colspan="3">&nbsp;</td>
      </tr>
      <tr>
        <td valign="top">10.</td>
        <td valign="top">Whether any of the following documents like Electricity Bill, LIC receipts, Voters ID, Telephone Bill , Society Rent Agreement, Credit Card Billing  etc. are verified? </td>
        <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strDocumentVerified"))%></td>
      </tr>
      <tr>
        <td colspan="3">&nbsp;</td>
      </tr>
      <tr>
        <td valign="top">11</td>
        <td valign="top"><p>Whether Bank Statement /extract Pass book (SB account or CD account )  is verified ( including first page of pass book )? If yes, given comment on the following:</p>
          <p>a.Whether the account is active or  Dormant?<br />
            b.Nature of Debits/Credits<br />
            c.Abnormal Value Transactions<br />
            d.Average Balance<br />
            e.Repayments to other Institutions<br />
            f.Cheque Returns<br />
            g.ECS transactions<br />
          h.Incidence of OD</p></td>
        <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strBnkstmtVerified"))%></td>
      </tr>
      
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td width="26%">Place: &nbsp;<%=Helper.correctNull((String)hshValues.get("dueplace"))%></td>
          <td width="41%">&nbsp;</td>
          <td width="33%"> Signature of Officer</td>
		  <!--<td width="33%"> <%//=Helper.correctNull((String)hshValues.get("dueinspectorname"))%></td>-->
		 </tr>
        <tr> 
          <td>Date: &nbsp;<%=Helper.correctNull((String)hshValues.get("duedatevisit"))%></td>
          <td>&nbsp;</td>
          <td>Designation:</td>
		  <!-- <td> <%//=Helper.correctNull((String)hshValues.get("dueinspectordesign"))%></td>-->
        </tr>
        <tr> 
          <td colspan="3">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr></tr>
</table>
</body>
</html>
