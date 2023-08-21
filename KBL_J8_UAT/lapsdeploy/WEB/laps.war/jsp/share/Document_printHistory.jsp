<%@include file="../share/directives.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Document Print History</title>
<%
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
arrRow=(ArrayList)hshValues.get("arrRow"); %>
<script >
function doClose()
{
	if( ConfirmMsg(100) )
	{
		window.close();
	}
}
</script>
</head>
<body>
 <table width="98%" border="0" cellpadding="3" cellspacing="3" class="outertable" align="center">
<tr>
	<td>
		<table width="100%" border="0" cellpadding="3" cellspacing="0" class="outertable border1" align="center">
		<tr>
			<td>
				<table width="100%" border="0" cellpadding="3" cellspacing="2" class="outertable" align="center">
					<tr class="dataheader" align="center" >
						<td colspan="4">Document Print History</td>
					</tr>
					<tr align="center" >
						<td colspan="4">&nbsp;</td>
					</tr>
					<tr class="dataheader"> 
                      <td width="40%" align="center">Document Name</td>
                      <td width="20%" align="center">User Name</td>
                      <td width="20%" align="center">Branch</td>
                      <td width="20%" align="center">Print Date</td>
                     </tr>
                     <%if(arrRow!=null && arrRow.size()>0)
                     {
                    		for(int i=0;i<arrRow.size();i++)
                    		{
                    			arrCol=(ArrayList)arrRow.get(i);
                    			%>
                     <tr class="datagrid">
                     <td width="40%"><%=Helper.correctNull((String)arrCol.get(1))%>&nbsp;</td>
                     <td width="20%"><%=Helper.correctNull((String)arrCol.get(3))%>&nbsp;(<%=Helper.correctNull((String)arrCol.get(2))%>)&nbsp;</td>
                     <td width="20%"><%=Helper.correctNull((String)arrCol.get(6))%>&nbsp;</td>
                     <td width="20%"><%=Helper.correctNull((String)arrCol.get(7))%>&nbsp;</td>
                     </tr>
                     <%		}
                    	}else{%>
                    	<tr class="datagrid"><td colspan="4" >&nbsp;</td></tr>
                    	<tr class="datagrid"><td colspan="4" align="center">No History Found</td></tr>
                    	<tr class="datagrid"><td colspan="4" >&nbsp;</td></tr>
                    	<%} %>
					<tr><td>&nbsp;</td></tr>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<lapschoice:combuttonnew btnnames='' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
</body>
</html>