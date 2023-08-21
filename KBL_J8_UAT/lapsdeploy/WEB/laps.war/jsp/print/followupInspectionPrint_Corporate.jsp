<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<laps:handleerror />
<%
ArrayList arrCol = new ArrayList();
ArrayList arrRow = new ArrayList();
%>

<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/link.css" type="text/css" />
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css"
	type="text/css" />
</head>
<body bgcolor="#ffffff">
<form name="frminspection" method="post">
  <table width="80%" border="0" cellspacing="0" cellpadding="3"
	align="center">
    <tr> 
      <td colspan="4"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr> 
            <td align="center"><img
					src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg"></td>
          </tr>
          <tr> 
            <td align="center"><b>Branch - <%=Helper.correctNull((String)hshValues.get("orgname"))%></b></td>
          </tr>
          <tr> 
            <td align="center"><%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp; 
              <%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp; 
              <%=Helper.correctNull((String)hshValues.get("orgcity"))%>,&nbsp; 
              <%=Helper.correctNull((String)hshValues.get("orgstate"))%>-&nbsp; 
              <%=Helper.correctNull((String)hshValues.get("orgzip"))%>&nbsp; 
              <hr/>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td colspan="4" align="center"><b>POST DISBURSEMENT / FOLLOW-UP INSPECTION 
        REPORT</b></td>
    </tr>
    <tr> 
      <td width="3%" valign="top"><b>1.</b></td>
      <td width="43%" valign="top"><b>Date of Visit</b></td>
      <td width="4%" valign="top"><b>:</b></td>
      <td width="50%"><%=Helper.correctNull((String)hshValues.get("inspec_date")) %></td>
    </tr>
    <%--    <tr> 
      <td width="3%">&nbsp;</td>
      <td width="43%">Date of last visit, if any</td>
      <td width="4%">:</td>
      <td width="50%"><%=Helper.correctNull((String)hshValues.get("ADDRESS")) %></td>
    </tr> --%>
    <tr> 
      <td width="3%" valign="top"><b>2.</b></td>
      <td width="43%" valign="top"><b>Name of the Borrower</b></td>
      <td width="4%" valign="top"><b>:</b></td>
      <td width="50%"><%=Helper.correctNull((String)hshValues.get("personal_custname")) %></td>
    </tr>
    <tr> 
      <td width="3%" valign="top"><b>3.</b></td>
      <td width="43%" valign="top"><b>Residential &amp; / or Business Address</b></td>
      <td width="4%" valign="top"><b>:</b></td>
      <td width="50%"><%=Helper.correctNull((String)hshValues.get("personal_address")) %> 
        <%=Helper.correctNull((String)hshValues.get("personal_address1")) %> <%=Helper.correctNull((String)hshValues.get("city_name")) %> 
        <%=Helper.correctNull((String)hshValues.get("state_name")) %> <%=Helper.correctNull((String)hshValues.get("personal_pincode")) %> 
      </td>
    </tr>
    <%--    <tr> 
      <td width="3%">4.</td>
      <td width="43%">Distance from branch</td>
      <td width="4%">:</td>
      <td width="50%"><%=Helper.correctNull((String)hshValues.get("PREVIOUS_INS_DATE")) %></td>
    </tr> --%>
    <tr valign="top"> 
      <td width="3%" valign="top"><b>4.</b></td>
      <td width="43%" valign="top"><b>Facility / ies availed from our Bank</b></td>
      <td width="4%" valign="top"><b></b></td>
      <td width="50%">&nbsp;</td>
    </tr>
    <tr valign="top"> 
      <td width="3%">&nbsp;</td>
      <td colspan="3"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr valign="top" class="tblhead"> 
              <td width="7%" height="19"><b>S.No.</b></td>
              <td width="26%" height="19"><b>Nature of Facility</b></td>
              <td width="17%" height="19"><b>Purpose of loan</b></td>
              <td width="18%" height="19"><b>Limit (Rs.)</b></td>
              <td width="19%" height="19"><b>O/S. (Rs.)</b></td>
              <td width="13%" height="19"><b>Overdue, if any (Rs.)</b></td>
            </tr>
            <%
										arrCol=new ArrayList();
         
										arrRow=(ArrayList)hshValues.get("arrRow");
										if(arrRow!=null && arrRow.size()>0)
										{
 							    			for(int i=0;i<arrRow.size();i++)
											{
 							    				arrCol=(ArrayList)arrRow.get(i);
									%>
            <tr valign="top"> 
              <td width="7%">&nbsp;<%=i+1%></td>
              <td width="26%">&nbsp;<%=Helper.correctNull((String)arrCol.get(1))%></td>
              <td width="17%">&nbsp;<%=Helper.correctNull((String)arrCol.get(2))%></td>
              <td width="18%">&nbsp;<%=Helper.checkDecimal(Helper.correctDouble((String)arrCol.get(3)))%></td>
              <td width="19%">&nbsp;<%=Helper.checkDecimal(Helper.correctDouble((String)arrCol.get(4)))%></td>
              <td width="13%">&nbsp;<%=Helper.checkDecimal(Helper.correctDouble((String)arrCol.get(5)))%></td>
            </tr>
            <%
									}
									}
									%>
          </table>
        </div>
      </td>
    </tr>
    <%--   <tr> 
      <td width="3%">6.</td>
      <td width="43%">Details and present status of credit facilities, if any, 
        availed from other banks / financial institutions</td>
      <td width="4%">:</td>
      <td width="50%"><%=Helper.correctNull((String)hshValues.get("DEVIATION")) %></td>
    </tr>
    <tr> 
      <td width="3%">7.</td>
      <td width="43%">Present Credit Rating if applicable</td>
      <td width="4%">:</td>
      <td width="50%"><%=Helper.correctNull((String)hshValues.get("DEVELOPMENT_PURPOSE")) %></td>
    </tr>--%>
    <tr valign="top"> 
      <td width="3%"><b>5.</b></td>
      <td width="43%"><b>Due for review</b></td>
      <td width="4%"><b>:</b></td>
      <td width="50%"><%=Helper.correctNull((String)hshValues.get("reviewdue")) %></td>
    </tr>
    <%--   <tr> 
      <td width="3%">9.</td>
      <td width="43%">Business premises</td>
      <td width="4%">:</td>
      <td width="50%"><%=Helper.correctNull((String)hshValues.get("PURCHASE_OF_MACHINERY")) %></td>
    </tr>--%>
    <tr valign="top"> 
      <td width="3%"><b>6.</b></td>
      <td width="43%"><b>Nearby Landmarks for Identification</b></td>
      <td width="4%"><b></b></td>
      <td width="50%">&nbsp;</td>
    </tr>
    <tr valign="top"> 
      <td width="3%">&nbsp;</td>
      <td colspan="3"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="2">
          <tr valign="top"> 
            <td><b>East :</b></td>
            <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("landmarkeast")) %></td>
            <td><b>West :</b></td>
            <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("landmarkwest")) %></td>
          </tr>
          <tr valign="top"> 
            <td><b>North :</b></td>
            <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("landmarknorth")) %></td>
            <td><b>South :</b></td>
            <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("landmarksouth")) %></td>
          </tr>
        </table>
      </td>
    </tr>
    <%--  <tr> 
      <td width="3%">7.</td>
      <td width="43%" colspan="3">Security</td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td colspan="3"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="2">
          <tr> 
            <td rowspan="2" height="5" align="center"><b>S.No.</b></td>
            <td rowspan="2" height="32" align="center"><b>Type of Security</b></td>
            <td rowspan="2" height="37" align="center"><b>Details of security 
              / ies incl. value</b></td>
            <td colspan="2" height="19" align="center"><b>Insurance cover</b></td>
          </tr>
          <tr> 
            <td width="18%" height="18" align="center"><b>Amount</b></td>
            <td width="20%" height="18" align="center"><b>Valid upto</b></td>
          </tr>
          <%
										arrCol=new ArrayList();
           								arrRow=new ArrayList();
										arrRow=(ArrayList)hshValues.get("arrSecurity");
										
										if(arrRow!=null && arrRow.size()>0)
										{
 							    			for(int i=0;i<arrRow.size();i++)
											{
 							    				arrCol=(ArrayList)arrRow.get(i);
									%>
          <tr> 
            <td>&nbsp;<%=i+1%></td>
            <td><b>&nbsp;<%=Helper.correctNull((String)arrCol.get(0)) %></b></td>
            <td ><%=Helper.correctNull((String)arrCol.get(4)) %> / &nbsp;<%=Helper.correctNull((String)arrCol.get(1)) %> 
              / <%=Helper.correctNull((String)arrCol.get(5)) %></td>
            <td>&nbsp;<%=Helper.checkDecimal(Helper.correctDouble((String)arrCol.get(2))) %></td>
            <td>&nbsp;<%=Helper.correctNull((String)arrCol.get(3)) %></td>
          </tr>
          <%
									}
									}
									%>
        </table>
      </td>
    </tr>--%>
    <tr valign="top"> 
      <td width="3%"><b>7.</b></td>
      <td width="43%"><b>Observations / Comments of Inspection officer</b></td>
      <td width="4%">&nbsp;</td>
      <td width="50%">&nbsp;</td>
    </tr>
    <tr valign="top"> 
      <td width="3%"><b></b></td>
      <td width="43%"><b>Primary Security</b></td>
      <td width="4%">:</td>
      <td width="50%">&nbsp;</td>
    </tr>
    <tr valign="top"> 
      <td width="3%">&nbsp;</td>
      <td colspan="3"><%=Helper.formatTextAreaData((String)hshValues.get("primesecurity")) %></td>
    </tr>
    <tr valign="top"> 
      <td width="3%"><b></b></td>
      <td width="43%"><b>Collateral Security</b></td>
      <td width="4%">:</td>
      <td width="50%">&nbsp;</td>
    </tr>
    <tr valign="top"> 
      <td width="3%">&nbsp;</td>
      <td colspan="3"><%=Helper.formatTextAreaData((String)hshValues.get("collateralsecurity")) %></td>
    </tr>
    <tr valign="top"> 
      <td width="3%"><b></b></td>
      <td width="43%"><b>Present status of business activity of borrower</b></td>
      <td width="4%">:</td>
      <td width="50%">&nbsp;</td>
    </tr>
     <tr valign="top"> 
      <td width="3%">&nbsp;</td>
      <td colspan="3"><%=Helper.formatTextAreaData((String)hshValues.get("presentstatus")) %></td>
    </tr>
    <tr valign="top"> 
      <td width="3%"><b></b></td>
      <td width="43%"><b>Comments of operations in the account</b></td>
      <td width="4%">:</td>
      <td width="50%">&nbsp;</td>
    </tr>
     <tr valign="top"> 
      <td width="3%">&nbsp;</td>
      <td colspan="3"><%=Helper.formatTextAreaData((String)hshValues.get("operations")) %></td>
    </tr>
    <tr valign="top"> 
      <td width="3%"><b></b></td>
      <td width="43%"><b>Whether Bank's name board is displayed</b></td>
      <td width="4%">:</td>
      <td width="50%"><%=Helper.correctNull((String)hshValues.get("banknameboard")) %></td>
    </tr>
    <tr valign="top"> 
      <td width="3%"><b></b></td>
      <td width="43%"><b>Whether borrower's name board is displayed</b></td>
      <td width="4%">:</td>
      <td width="50%"><%=Helper.correctNull((String)hshValues.get("borrnameboard")) %></td>
    </tr>
    <tr valign="top"> 
      <td width="3%"><b></b></td>
      <td width="43%"><b>Proper maintenance of books of accounts</b></td>
      <td width="4%">:</td>
      <td width="50%"><%=Helper.correctNull((String)hshValues.get("bookmaintanance")) %></td>
    </tr>
    <tr valign="top"> 
      <td width="3%"><b></b></td>
      <td width="43%"><b>Documentation and its validity</b></td>
      <td width="4%">:</td>
      <td width="50%">&nbsp;</td>
    </tr>
    <tr valign="top"> 
      <td width="3%">&nbsp;</td>
      <td colspan="3"><%=Helper.formatTextAreaData((String)hshValues.get("documentvalidity")) %></td>
    </tr>
    <tr valign="top"> 
      <td width="3%"><b>8.</b></td>
      <td width="43%"><b>Any other features observed during visit:</b></td>
      <td width="4%">:</td>
      <td width="50%">&nbsp;</td>
    </tr>
    <tr valign="top">
      <td width="3%">&nbsp;</td>
      <td colspan="3"><%=Helper.formatTextAreaData((String)hshValues.get("shortfall")) %></td>
    </tr>
    <tr valign="top"> 
      <td width="3%">&nbsp;</td>
      <td colspan="3">I confirm that I have conducted inspection of securities, 
        documents etc. and my findings are as above.</td>
    </tr>
    <tr> 
      <td colspan="4">&nbsp;</td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td colspan="3"> 
        <table width="100%" border="0" cellspacing="1" cellpadding="2">
         <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
          <tr> 
            <td width="7%"><b>Place :</b></td>
            <td width="50%"><%=Helper.correctNull((String)hshValues.get("from_place")) %></td>
             <td width="18%" nowrap>&nbsp;</td>
            <td width="24%" align="center"><%=Helper.correctNull((String)hshValues.get("user_name"))%></td>
          </tr>
          <tr> 
            <td width="7%" nowrap><b>Date : </b></td>
            <td width="50%"><%=Helper.correctNull((String)hshValues.get("filled_date")) %></td>
             <td width="18%">&nbsp;</td>
            <td width="24%" align="center">(<%=Helper.correctNull((String)hshValues.get("user_desig"))%>)</td>
          </tr>
         
        </table>
      </td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td width="43%"><b>Comments / observations of the Approving Authority:</b></td>
      <td width="4%">&nbsp;</td>
      <td width="50%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td colspan="3"><%=Helper.formatTextAreaData((String)hshValues.get("sanccomments")) %></td>
    </tr>
    <tr> 
      <td colspan="4">&nbsp;</td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td width="43%"><b>Date : <%=Helper.correctNull((String)hshValues.get("approvedate")) %> </b></td>
      <td width="4%">&nbsp;</td>
      <td width="50%" align="center"> <b>Signature of Approving Authority</b></td>
    </tr>
  </table>
</form>
</body>
</html>

