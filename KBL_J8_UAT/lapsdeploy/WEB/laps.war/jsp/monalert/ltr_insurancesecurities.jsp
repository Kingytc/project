<%@ page import="com.sai.laps.helper.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%String date = Helper.getCurrentDateTime();
%>
<html> 
<head>
<title>KARNATAKA BANK LTD.</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0"
	marginwidth="5" marginheight="0">
<table width="75%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td align="center"><img
					src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>
        </tr>
        <tr> 
          <td align="center"><b>KARNATAKA BANK LTD. </b></td>
        </tr>
        <tr> 
          <td align="center"><B><%=Helper.correctNull((String) hshValues.get("org_name"))%><br>
            <%=Helper.correctNull((String) hshValues.get("org_add1"))%>, <%=Helper.correctNull((String) hshValues.get("org_add2"))%>, 
            <%=Helper.correctNull((String) hshValues.get("org_cityname"))%>, <%=Helper.correctNull((String) hshValues.get("org_statename"))%>, 
            <%=Helper.correctNull((String) hshValues.get("org_zip"))%>. Tel No : <%=Helper.correctNull((String) hshValues.get("org_phone"))%> </B></td>
        </tr>
        <tr> 
          <td> 
            <hr>
          </td>
        </tr>
        <tr> 
          <td ALIGN="RIGHT">DATE:<%=date%></td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top">TO :<br>
            M/s.&nbsp;<%=Helper.correctNull((String) hshValues
							.get("personal_custname"))%>,<br>
            <%=Helper.correctNull((String) hshValues
							.get("personal_address"))%>,<br>
            <%=Helper.correctNull((String) hshValues
							.get("personal_address1"))%>,<br>
            <%=Helper.correctNull((String) hshValues.get("city"))%>,<br>
            <%=Helper.correctNull((String) hshValues.get("state"))%>,<br>
            <%=Helper.correctNull((String) hshValues
							.get("personal_pincode"))%></td>
        </tr>
        <tr> 
          <td>Dear Sir/Madam,</td>
        </tr>
        <tr> 
          <td align="center"><U><b>Ref: Insurance of Securities</b></U></td>
        </tr>
        <tr> 
          <td align="center"><b>A/c. No. :</b> &nbsp;<%=Helper.correctNull((String) hshValues.get("straccno"))%></td>
        </tr>
        <tr> 
          <td> 
            <p>We refer to the insurance cover available for the credit facility 
              of Working capital /Term Loan availed by you from our Bank.</p>
          </td>
        </tr>
        <tr> 
          <td>1.Insurance cover is available for Rs.<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("INS_COVERAMT"))))%></td>
        </tr>
        <tr>
          <td>
            <p>2.If location of securities is changed ,please arrange to give 
              the revised address of the location of securities in the Insurance Policy at the time of renewal.</p>
            
          </td>
        </tr>
        <tr>
          <td>3.Insurance cover is expiring on <%=Helper.correctNull((String)hshValues.get("INS_EXPIRYDATE"))%></td>
        </tr>
        <tr>
          <td>4.Please renew the same and confirm.</td>
        </tr>
        <tr> 
          <td>Thanking you,</td>
        </tr>
        <tr> 
          <td align="right">Yours faithfully,&nbsp;&nbsp;&nbsp;</td>
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
          <td align="right">BRANCH MANAGER&nbsp;&nbsp;&nbsp;</td>
        </tr>
      </table>
		</td>
	</tr>
</table>
</body>
</html>
