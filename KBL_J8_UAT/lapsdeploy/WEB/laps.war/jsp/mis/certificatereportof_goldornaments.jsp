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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script>

		
function doClose()
{
	window.close();
}
function doPrintPreview()
{
	win = window.open("","","scrollbars=yes,toolbars=Yes,menubar=Yes,width=1000,height=500,left=60,top=40");
	win.document.write("<head>");
	win.document.write("<title>LAPS</title>");
	win.document.write("<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>");
	win.document.write("<link rel='stylesheet'	href='<%=ApplicationParams.getAppUrl()%>css/report.css'	type='text/css'>");
	win.document.write("</head>");
	win.document.write("<body bgcolor='#FFFFFF' text='#000000'>");
	win.document.write("<table width='100%' border='0' cellspacing='0' cellpadding='3'>");
	win.document.write("<tr>");
	win.document.write("<td align='center'><img src='"+<%=ApplicationParams.getAppUrl()%>+"img/kbl_newlogo.jpg'></td>");           		
	win.document.write("</tr>");
	win.document.write("<tr>");
	win.document.write("<td align='center'><strong>Karnataka Bank Ltd.</strong></td>");
	win.document.write("</tr>");
	win.document.write("<tr>");
	win.document.write("<td align='center'><strong>REAPPRAISAL OF GOLD ORNAMENTS</strong></td>");
	win.document.write("</tr>");
	win.document.write("<tr>");
	win.document.write("<table width='75%'>");
	win.document.write("<tr>");
	win.document.write("<td width='4%' align='center'><strong>Branch:</strong></td>");
	win.document.write("</tr>");
	win.document.write("<tr>");
	win.document.write("<br>");
	win.document.write("<td align='right'><strong>Date:</strong></td>");
	win.document.write("</tr>");
	win.document.write("</table>");
	
}
</script>
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/style.css"	type="text/css">
<title>Insert title here</title>
<style type="text/css">
body,table,td,th,h2,p
{
FONT-SIZE: 20px !important; COLOR: #000000 !important; FONT-FAMILY: "Book Antiqua" !important;
}
#top{background-color: #ffffff;}
#top table{ border-collapse: collapse;}
#top td {border: 0.5pt solid #000000; FONT-SIZE: 16px; COLOR: #000000; LINE-HEIGHT: 20px; FONT-FAMILY: "Book Antiqua"}

.title
{
FONT-SIZE: 20px !important; COLOR: #000000 !important; FONT-FAMILY: "Book Antiqua" !important;font-weight: bold !important;
}
</style>
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
<h2 align="center">Certificate of Reappraisal of Gold Ornaments</h2>
</td>
</tr>
<br>
<br>
<tr>
<td>
<h2 align="left">Branch: <%=Helper.correctNull((String) hshValues.get("BRANCH"))%></h2>
</td>
</tr>
<br>
<tr>
<td>
<h2>Date: <%=Helper.correctNull((String) hshValues.get("DATE_OF_REAPPRAISAL"))%></h2>
</td>
</tr>
<tr>
<td>
<h2> Name of the Borrower & Account No: <%=Helper.correctNull((String) hshValues.get("PARTY_NAME"))%> and <%=Helper.correctNull((String) hshValues.get("ACCOUNT_NUMBER"))%></h2>
</td>
</tr>
<tr>
<td>
<table border='1' style='border-collapse:collapse'>
<tr>
<th width="16%">
Sl NO.
</th>
<th width="16%">
Description of gold Ornaments
</th>
<th width="16%">
No's
</th>
<th width="16%">
Gross Weight
</th>
<th width="16%">
Net Weight
</th>
<th width="16%">
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
			
				<td width="16%" align="center"><%=Helper.correctNull((String)arrCol.get(0))%></td>
				<td width="16%" align="center"><%=Helper.correctNull((String)arrCol.get(1))%></td>
				<td width="16%" align="center"><%=Helper.correctNull((String)arrCol.get(2))%></td>
				<td width="16%" align="center"><%=Helper.correctNull((String)arrCol.get(3))%></td> 
				<td width="16%" align="center"><%=Helper.correctNull((String)arrCol.get(4))%></td>
				<td width="16%" align="center"><%=Helper.correctNull((String)arrCol.get(5))%></td>

			<%}
				}%>
			</tr>
			<%}%>
			<tr>
			<td>
			</td>
			<td>
			Total:
			</td>
			<td align="center">
			<%=Helper.correctNull((String) hshValues.get("TOTAL_QTY"))%>
			</td>
			<td align="center">
			<%=Helper.correctNull((String) hshValues.get("TOTAL_GROSS_WEIGHT"))%>
			</td>
			<td align="center">
			<%=Helper.correctNull((String) hshValues.get("TOTAL_NET_WEIGHT"))%>
			</td>
			<td>
			</td>
			</tr>
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
<p  align="center"><b><u>Certificate by the Branch Head:</u></b></p>
</td>
</tr>
<br>
<tr>
<td>
<p>The above mentioned gold ornaments are re-appraised by the Jewel Appraiser and 
found that all the gold ornaments are found genuine, except..................</p>
<br>
<br>
</td>
</tr>

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
<tr>
</tr>
<tr>
<td width="35%">
(Name,PA No.)
</td>
<td width="35%">
(Name,PA No.)
</td>
<td width="35%">
(Name,PA No.)
</td>
</tr>
</table>
</td>
</tr>
</table>
</body>
</html>