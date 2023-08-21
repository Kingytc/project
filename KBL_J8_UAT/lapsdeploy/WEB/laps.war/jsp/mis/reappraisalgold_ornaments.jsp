<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>

<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
    <%
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
	if(hshValues!=null)
	{
		arrRow = (ArrayList)hshValues.get("arrRow");
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
body, table,td,th,h3
{
FONT-SIZE: 20px !important; COLOR: #000000 !important; FONT-FAMILY: "Book Antiqua" !important;
}
#top{background-color: #ffffff;}
#top table{ border-collapse: collapse;}
#top td {border: 0.5pt solid #000000; FONT-SIZE: 20px; COLOR: #000000; LINE-HEIGHT: 26px; FONT-FAMILY: "Book Antiqua"}

.title
{
FONT-SIZE: 20px !important; COLOR: #000000 !important; FONT-FAMILY: "Book Antiqua" !important;font-weight: bold !important;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script>

</script>
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/style.css"	type="text/css">
<title>Insert title here</title>
</head>
<body>
<table align="center" width='50%' border='0' cellspacing='0' cellpadding='3'>
<tr >
<td align="center">
<img  src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg">
<td>
</tr>
<tr>
<td>
<h2 align="center"> REAPPRAISAL OF GOLD ORNAMENTS</h2>
</td>
</tr>
<br>
<br>
<tr>
<td>
<h3 align="left">Branch: <%=Helper.correctNull((String) hshValues.get("strOrgName"))%></h3>
</td>
</tr>
<br>
<tr>
<td>
<h3>Date:</h3>
</td>
</tr>
<tr>
<td>
<table border='1' style='border-collapse:collapse'>
<tr>
<th width="14%">
Sl NO.
</th>
<th width="14%">
Party Name
</th>
<th width="14%">
A/C No.
</th>
<th width="14%">
Total Gross Weight
</th>
<th width="14%">
Total Net Weight
</th>
<th width="14%">
Date of Re-appraisal
</th>
<th width="14%">
Remarks
</th>
</tr>
<%
			if (arrRow != null && arrRow.size() > 0) {
				if (arrRow.size() > 0) {
					for (int i = 0; i < arrRow.size(); i++) {
						arrCol = (ArrayList) arrRow.get(i);
						%>
			<tr>
			
				<td width="14%" align="center"><font size="3" face="MS Sans Serif" ><%=Helper.correctNull((String)arrCol.get(0))%></font></td>
				<td width="14%" align="center"><font size="3" face="MS Sans Serif" ><%=Helper.correctNull((String)arrCol.get(1))%></font></td>
				<td width="14%" align="center"><font size="3" face="MS Sans Serif" ><%=Helper.correctNull((String)arrCol.get(2))%></font></td>
				<td width="14%" align="center"><font size="3" face="MS Sans Serif" ><%=Helper.correctNull((String)arrCol.get(3))%></font></td> 
				<td width="14%" align="center"><font size="3" face="MS Sans Serif" ><%=Helper.correctNull((String)arrCol.get(4))%></font></td>
				<td width="14%" align="center"><font size="3" face="MS Sans Serif" ><%=Helper.correctNull((String)arrCol.get(5))%></font></td>
				<td width="14%" align="center"><font size="3" face="MS Sans Serif" ><%=Helper.correctNull((String)arrCol.get(6))%></font></td>

			<%}
				}%>
			</tr>
			<%}%>
</table>
</td>
</tr>
<tr>
<td>
<p>I have appraised all the above mentioned gold ornaments and found that the 
ornaments are genuine, except............................................</p>
<br>
<br>
</td>
</tr>
<tr>
<td>
<%=Helper.correctNull((String) hshValues.get("appraisername"))%>
<p><b>Name and Signature of Jewel Appraiser:</b></p>
<br>
</td>
</tr>
<tr>
<td>
<p><b><u>Certificate by the Branch Head:</u></b></p>
</td>
</tr>
<br>
<tr>
<td>
<p>The above mentioned gold ornaments are re-appraised by the Jewel Appraiser and 
found that all the gold ornaments are found genuine, except..................</p>
</td>
</tr>
<br>
<br>
<tr>
<td>
<table width="100%" >
<tr>
<td width="35%">
<p><b>Joint Custodian I</b></p>
</td>
<td width ="35%">
<p><b>Joint Custodian II</b></p>
</td>
<td width="35%">
<p><b>Branch Head</b></p>
</td>
</tr>

</table>
</td>
</tr>
</table>
</body>
</html>