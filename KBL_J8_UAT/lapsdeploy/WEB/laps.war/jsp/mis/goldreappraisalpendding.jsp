<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>

<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
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
#top td {border: 0.5pt solid #000000; FONT-SIZE: 20px; COLOR: #000000; LINE-HEIGHT: 20px; FONT-FAMILY: "Book Antiqua"}

.title
{
FONT-SIZE: 20px !important; COLOR: #000000 !important; FONT-FAMILY: "Book Antiqua" !important;font-weight: bold !important;
}
</style>

<script>

function doClose()
{
	//zwindow.opener.docalReload1();
	window.close();
}
function doPrintPreview()
{
win = window.open("","","scrollbars=yes,toolbars=Yes,menubar=Yes,width=800,height=450,left=60,top=40");
	
	win.document.write("<head>");
	win.document.write("<title>LAPS</title>");
	win.document.write("<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>");
	win.document.write("<link rel='stylesheet'	href='<%=ApplicationParams.getAppUrl()%>css/report.css'	type='text/css'>");
	win.document.write("</head>");
	
	win.document.write("<body bgcolor='#FFFFFF' text='#000000'>");
	
	win.document.write("<table align='center' width='50%' border='0' cellspacing='0' cellpadding='3'>");
	win.document.write("<tr>");
	win.document.write("<td align='center'><img src='"+'<%=ApplicationParams.getAppUrl()%>'+"img/kbl_newlogo.jpg'></td>");          		
	win.document.write("</tr>");
	win.document.write("<tr>");
	win.document.write("<td>");
	win.document.write("<h3 align='center'>GOLD LOAN REAPPRAISAL PENDING FOR VERIFICATION</h3>");
	win.document.write("</td>");
	win.document.write("</tr>");
	win.document.write("<tr>");
	win.document.write("<td>");
	win.document.write("<table align='center' border='1' style='border-collapse:collapse'>");
	win.document.write("<tr>");
	win.document.write("<th width='20%'>Proposal Number</th>");
	win.document.write("<th  width='20%'>Borrower name</th>");
	win.document.write("<th  width='20%'>Account Number</th>");
	win.document.write("<th  width='20%'>Date of Reappraisal</th>");
	win.document.write("<th  width='20%'>Entered User ID</th>");
	win.document.write("</tr>");
	<%
	if (arrRow != null && arrRow.size() > 0) {
		if (arrRow.size() > 0) {
			for (int i = 0; i < arrRow.size(); i++) {
				arrCol = (ArrayList) arrRow.get(i);
				%>
    win.document.write("<tr class='datagrid'>");
    win.document.write("<td width='20%' align='center'> <%=Helper.correctNull((String)arrCol.get(0))%></td>");
    win.document.write("<td width='20%' align='center'> <%=Helper.correctNull((String)arrCol.get(1))%></td>");
    win.document.write("<td width='20%' align='center'> <%=Helper.correctNull((String)arrCol.get(2))%></td>");
    win.document.write("<td width='20%' align='center'> <%=Helper.correctNull((String)arrCol.get(3))%></td>");
    win.document.write("<td width='20%' align='center'> <%=Helper.correctNull((String)arrCol.get(4))%></td>");
    <%}
		}%>	
		win.document.write("</tr>");
		<%}%>
		win.document.write("</table>");
		win.document.write("</td>");
		win.document.write("</tr>");
		win.document.write("</table>");
		win.document.write("</body>");
				
}
</script>
<style>

</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/style.css"	type="text/css">
</head>
<style>
</style>
<body>
<table align="center" width='50%' border='0' cellspacing='0' cellpadding='3'>
<tr >
<td align="center">
<img  src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg">
<td>
</tr>
<tr>
<td>
<h3 align="center">GOLD LOAN REAPPRAISAL PENDING FOR VERIFICATION</h3>
</td>
</tr>

<tr>
<td>
<table border='1' style='border-collapse:collapse'>

	<tr >
	    <th width="20%">Proposal Number</th>
		<th  width="20%">Borrower name</th>
		<th width="20%">Account Number</th>
		<th  width="20%">Date of Reappraisal</th>
		<th  width="20%">Entered User ID</th>
	</tr>
	
	<%
			if (arrRow != null && arrRow.size() > 0) {
				if (arrRow.size() > 0) {
					for (int i = 0; i < arrRow.size(); i++) {
						arrCol = (ArrayList) arrRow.get(i);
						%>
			<tr class="datagrid">
			
				<td width="20%" align="center"><%=Helper.correctNull((String)arrCol.get(0))%></td>
				<td width="20%" align="center"><%=Helper.correctNull((String)arrCol.get(1))%></td>
				<td width="20%" align="center"><%=Helper.correctNull((String)arrCol.get(2))%></td>
				<td width="20%" align="center"><%=Helper.correctNull((String)arrCol.get(3))%></td> 
				<td width="20%" align="center"><%=Helper.correctNull((String)arrCol.get(4))%></td> 

			<%}
				}%>
			</tr>
			<%}%>
</table>
</td>
</tr>
</table>
<br>
 <table width="0%" border="0" cellspacing="0" cellpadding="2" align="center">
          <tr valign="top"> 			
            <td> 
              <div align="center"> 
             
                <lapschoice:combuttonnew btnnames="Print Preview"btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
              </div>
            </td>
          </tr>
        </table>
<input type="hidden" name="hidAction" >
 <input type="hidden" name="hidBeanId">
 <input type="hidden" name="hidBeanMethod" value="">
 <input type="hidden" name="hidBeanGetMethod" value="" >
 <input type="hidden" name="hidSourceUrl" value="">
 <input type="hidden" name="hidflag" value="">
 <input type="hidden" name="hideditflag">
 <input type="hidden" name="hidsno">
 <input type="hidden" name="strStatId1" value="">
 <input type="hidden" name="hidApplicantId">
 <input type="hidden" name="hidApplicantType">
 <input type="hidden" name="hidAppType">
</body>
</html>