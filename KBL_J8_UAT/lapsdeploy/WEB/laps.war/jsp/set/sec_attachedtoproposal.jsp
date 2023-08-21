<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="../share/directives.jsp"%>
<%
ArrayList arrValues=new ArrayList();
String strSecId="";
if (hshValues instanceof java.util.HashMap) 
{
	if(hshValues!=null)
	{
		arrValues=(ArrayList)hshValues.get("arrRows");
		strSecId=Helper.correctNull((String) hshValues.get("strSecId"));
	}
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Securities Attached to Proposal</title>
</head>
<body>
<form name="appform" method="post" class="normal">
<br>
<table width="95%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr align="center">
		<td class="page_flow">Securities Attached to Proposal </td>
	</tr>
	<tr>
		<td> Security ID :  <span style="color:#750b6a"> <%=strSecId %> </span>  </td>	
	</tr>
</table>
<br>
	<table width="95%" border="0" cellspacing="1" cellpadding="2" align="center" >
			<tr class="dataheader" align="center" >
				<td width="10%">Proposal Number </td>
				<td width="10%">Proposal Type </td>
				<td width="5%">Facility Serial no. </td>
				<td width="10%">Applicant Name </td>
				<td width="10%">Facility Desc/Product Desc</td>
				<td width="5%">Module </td>
				<td width="10%">Loan Amount(in Rs.) </td>
				<td width="10%">Status</td>
				<td width="10%">CBS Account no. </td>
				<td width="10%">Type of Security </td>
				<td width="10%">Security Value at the time of sanction(in Rs.) </td>
			</tr>
				<%
                            if(arrValues!=null && arrValues.size()>0)
                            {
                          	  int arrSize=arrValues.size();
                                ArrayList arrData=null;
                          	  for(int i=0;i<arrSize;i++)
                          	  {
                          		  arrData=new ArrayList();
                          		  arrData=(ArrayList)arrValues.get(i);
                         %>
				<tr class="datagrid" align="center">
					<td width="10%"><%=Helper.correctNull((String)arrData.get(0)) %>&nbsp;</td>
					<td width="10%"><%=Helper.correctNull((String)arrData.get(1)) %>&nbsp;</td>
					<td width="5%"><%=Helper.correctNull((String)arrData.get(2)) %>&nbsp;</td>
					<td width="10%"><%=Helper.correctNull((String)arrData.get(3)) %>&nbsp;</td>
					<td width="10%"><%=Helper.correctNull((String)arrData.get(4)) %>&nbsp;</td>
					<td width="5%"><%=Helper.correctNull((String)arrData.get(5)) %>&nbsp;</td>
					<td width="10%"><%=Helper.correctNull((String)arrData.get(6)) %>&nbsp;</td>
					<td width="10%"><%=Helper.correctNull((String)arrData.get(7)) %>&nbsp;</td>
					<td width="10%"><%=Helper.correctNull((String)arrData.get(8)) %>&nbsp;</td>
					<td width="10%"><%=Helper.correctNull((String)arrData.get(9)) %>&nbsp;</td>
					<td width="10%"><%=Helper.correctNull((String)arrData.get(10)) %>&nbsp;</td>
					
				</tr>
				<% 	  }  } 
                          else
                           {  %>
		 		<tr  class="datagrid" align="center">
					<td colspan="11">No records found&nbsp; </td>
				</tr> 
				<% } %>
	 </table>
	<br>
	<br>
</form>
</body>
</html>