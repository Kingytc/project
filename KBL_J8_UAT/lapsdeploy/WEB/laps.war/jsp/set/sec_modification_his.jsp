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
<title>Securities Modified</title>
</head>
<body>
<form name="appform" method="post" class="normal">
<br>
<table width="95%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr align="center">
		<td class="page_flow">Securities Modified </td>
	</tr>
	<tr>
		<td> Security ID :  <span style="color:#750b6a"> <%=strSecId %> </span>  </td>	
	</tr>
</table>
<br>
	<table width="95%" border="0" cellspacing="1" cellpadding="2" align="center" >
			<tr class="dataheader" align="center" >
				<td width="20%">Parameter Modified </td>
				<td width="20%">Existing Value </td>
				<td width="20%">Modified Value </td>
				<td width="20%">Verified by</td>
				<td width="20%">Verification Date </td>
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
				<tr class="datagrid">
					<td width="20%"><%=Helper.correctNull((String)arrData.get(0)) %>&nbsp;</td>
					<%if(Helper.correctNull((String)arrData.get(0)).equalsIgnoreCase("Search /flow of title on property conducted /obtained")){ %>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(1)).replaceAll("@","<br>") %>&nbsp;</td>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(2)).replaceAll("@","<br>") %>&nbsp;</td>
					<%}else if(Helper.correctNull((String)arrData.get(0)).equalsIgnoreCase("Period of EC")){ %>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(1)).replaceAll("@","<br>") %>&nbsp;</td>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(2)).replaceAll("@","<br>") %>&nbsp;</td>
					<%}else if(Helper.correctNull((String)arrData.get(0)).equalsIgnoreCase("CERSAI ID Creation Date")){ %>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(1)).replaceAll("@","<br>") %>&nbsp;</td>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(2)).replaceAll("@","<br>") %>&nbsp;</td>
					<%}else if(Helper.correctNull((String)arrData.get(0)).equalsIgnoreCase("Survey No")){ %>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(1)).replaceAll("@","<br>") %>&nbsp;</td>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(2)).replaceAll("@","<br>") %>&nbsp;</td>
					<%}else if(Helper.correctNull((String)arrData.get(0)).equalsIgnoreCase("CERSAI ID")){ %>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(1)).replaceAll("@","<br>") %>&nbsp;</td>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(2)).replaceAll("@","<br>") %>&nbsp;</td>
					<%}else if(Helper.correctNull((String)arrData.get(0)).equalsIgnoreCase("CERSAI search Date")){ %>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(1)).replaceAll("@","<br>") %>&nbsp;</td>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(2)).replaceAll("@","<br>") %>&nbsp;</td>
					<%}else if(Helper.correctNull((String)arrData.get(0)).equalsIgnoreCase("CERSAI Search Ref. No")){ %>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(1)).replaceAll("@","<br>") %>&nbsp;</td>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(2)).replaceAll("@","<br>") %>&nbsp;</td>
					<%}else if(Helper.correctNull((String)arrData.get(0)).equalsIgnoreCase("Any charge on the property observed")){ %>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(1)).replaceAll("@","<br>") %>&nbsp;</td>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(2)).replaceAll("@","<br>") %>&nbsp;</td>
					<%}else if(Helper.correctNull((String)arrData.get(0)).equalsIgnoreCase("Reason for our bank charge not reflecting")){ %>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(1)).replaceAll("@","<br>") %>&nbsp;</td>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(2)).replaceAll("@","<br>") %>&nbsp;</td>
					<%}else if(Helper.correctNull((String)arrData.get(0)).equalsIgnoreCase("Reason for other bank charge being reflected")){ %>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(1)).replaceAll("@","<br>") %>&nbsp;</td>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(2)).replaceAll("@","<br>") %>&nbsp;</td>
					<%}else if(Helper.correctNull((String)arrData.get(0)).equalsIgnoreCase("Whether our bank charge reflected")){ %>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(1)).replaceAll("@","<br>") %>&nbsp;</td>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(2)).replaceAll("@","<br>") %>&nbsp;</td>
					<%}else if(Helper.correctNull((String)arrData.get(0)).equalsIgnoreCase("Whether property offered is already mortgaged to our Bank")){ %>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(1)).replaceAll("@","<br>") %>&nbsp;</td>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(2)).replaceAll("@","<br>") %>&nbsp;</td>
					<%}else if(Helper.correctNull((String)arrData.get(0)).equalsIgnoreCase("Reason/Remarks For Any charge on the property observed")){ %>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(1)).replaceAll("@","<br>") %>&nbsp;</td>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(2)).replaceAll("@","<br>") %>&nbsp;</td>
					<%}else{ %>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(1)) %>&nbsp;</td>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(2)) %>&nbsp;</td>
					<%} %>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(3)) %>&nbsp;</td>
					<td width="20%" align="center"><%=Helper.correctNull((String)arrData.get(4)) %>&nbsp;</td>
				
				</tr>
				<% 	  }  } 
                          else
                           {  %>
		 		<tr  class="datagrid" align="center">
					<td colspan="5">No records found&nbsp; </td>
				</tr> 
				<% } %>
	 </table>
	<br>
	<br>
</form>
</body>
</html>