<%@ page import="com.sai.laps.helper.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<html>
<head>
<title>com_duediligencereportprint</title>
<%
String strsaral= Helper.correctNull((String) request.getParameter("hidsaral"));
String strappname=Helper.correctNull((String)request.getParameter("appname"));
%>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>

</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0" font-family="arial" font-size="11px">

<form name="frminspection" method="post">

  <table width="90%" border="0" cellspacing="1" cellpadding="3" align="center">
    <tr> 
      <td colspan="3"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg"></td>
          </tr>
         <tr> 
    		<td align="center"><b>Branch - <%=Helper.correctNull((String)hshValues.get("orgname"))%></b></td>
  		</tr>
  		<tr> 
    		<td align="center"><%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp; 
      		<%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp; <%=Helper.correctNull((String)hshValues.get("orgcity"))%>,&nbsp; 
      		<%=Helper.correctNull((String)hshValues.get("orgstate"))%>-&nbsp; <%=Helper.correctNull((String)hshValues.get("orgzip"))%>&nbsp; 
      		<hr/>
    		</td>
  		</tr>
          <tr> 
            <td align="center">&nbsp;</td>
          </tr>
          <tr> 
            <td align="center"><b>Due Diligence Report</b></td>
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
            <td align="center">&nbsp;</td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td width="53%">Name of the Account / Applicant</td>
      <td width="1%"><b>:</b></td>
        <%if(strsaral.equalsIgnoreCase("saral"))
		{%>
		<td width="46%"><%=strappname%></td>
      
      <%}else
    	  {%>
    	    <td width="46%"><%=Helper.correctNull((String)hshValues.get("appname"))%></td>
    	    <%} %>
    </tr>
    <tr> 
      <td colspan="4"> 
        <table width="100%" border="0" cellspacing="3" cellpadding="3">
          <tr> 
            <td valign="top"> <b>Observations of inspecting official 
              </b> </td>
          </tr>
          <tr> 
            <td valign="top"> 
              <p> <%=Helper.formatTextAreaData((String)hshValues.get("duecertificate_comments"))%> 
                &nbsp; </p>
            </td>
          </tr>
          <tr> 
            <td>&nbsp; 
              
            </td>
          </tr>
          <tr> 
            <td> <b>Certificate</b> </td>
          </tr>
          <tr> 
            <td><B> "I have made enquiries from <%=Helper.correctNull((String)hshValues.get("duecertificate_enquriedby"))%> 
              about
              <%if(strsaral.equalsIgnoreCase("saral"))
		{%>
		<%=strappname%>
		<%}else
    	  {%>
               <%=Helper.correctNull((String)hshValues.get("appname"))%>  <%} %>
              / their partners /Directors. <%=Helper.correctNull((String)hshValues.get("duecertificate_enquried"))%> 
              have given a good report on the dealings and conduct of the aforesaid 
              parties." </B></td>
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
    <tr> 
    	
      <td valign="bottom" width="53%">Date :&nbsp; <%=Helper.correctNull((String)hshValues.get("duedate"))%></td>
    	
      <td width="1%">&nbsp;</td>
        
      <td align="center" width="46%" ><b>(<%=Helper.correctNull((String)hshValues.get("dueofficername"))%>)<br/>
        <%=Helper.correctNull((String)hshValues.get("duedesignation"))%></b></td>
    </tr>
  </table>
</form>
</body>
</html>

