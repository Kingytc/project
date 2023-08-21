<%@include file="../share/directives.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Share Value Master History</title>
<%
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
arrRow=(ArrayList)hshValues.get("arrRow"); %>
<script>
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
		<table width="100%" border="1" cellpadding="3" cellspacing="0" class="outertable" align="center">
		<tr>
			<td>
				<table width="100%" border="0" cellpadding="3" cellspacing="2" class="outertable" align="center">
					<tr class="dataheader" align="center" >
						<td colspan="13">History</td>
					</tr>
					<tr class="dataheader"  align="center"> 
                      <td width="10%"nowrap="nowrap">CIN Number</td>
                      <td width="15%"nowrap="nowrap">Company Name</td>
                       <td width="8%"nowrap="nowrap">Face Value <br>(Rs.)</td>
                        <td width="8%"nowrap="nowrap">Networth<br> (Rs.)</td>
                         <td width="8%" nowrap="nowrap">Average Market <br/> Value (Rs.)</td>
                      <td width="8%"nowrap="nowrap">Marktet Value <br>(Rs.)</td>
                       <td width="8%"nowrap="nowrap">Padi up Capital<br/> (Rs.)</td>
                      <td width="10%"nowrap="nowrap">Type</td>
                      <td width="8%"nowrap="nowrap">Approval <br/> Status</td>
                     
                      <td width="8%" nowrap="nowrap">Reserves <br/> Capital<br/> (Rs.)</td>
                      <td width="8%"nowrap="nowrap">Active</td>
                      <td width="8%"nowrap="nowrap">Modified By</td>
                     </tr>
                     <%if(arrRow!=null && arrRow.size()>0)
                     {
                    		for(int i=0;i<arrRow.size();i++)
                    		{
                    			arrCol=(ArrayList)arrRow.get(i);
                    			%>
                     <tr class="datagrid">
                     <td><%=Helper.correctNull((String)arrCol.get(1))%>&nbsp;</td>
                     <td><%=Helper.correctNull((String)arrCol.get(2))%>&nbsp;</td>
                     <td align="right"><%=Helper.correctNull((String)arrCol.get(3))%>&nbsp;</td>
                     <td nowrap="nowrap"><%=Helper.correctNull((String)arrCol.get(4))%>&nbsp;- (<%=Helper.correctNull((String)arrCol.get(5))%>)</td>
                     <td align="right"><%=Helper.correctNull((String)arrCol.get(6))%>&nbsp;</td>
                     <td nowrap="nowrap"><%=Helper.correctNull((String)arrCol.get(7))%>&nbsp;- (<%=Helper.correctNull((String)arrCol.get(8))%>)</td>
                     <td nowrap="nowrap"><%=Helper.correctNull((String)arrCol.get(9))%>&nbsp;- (<%=Helper.correctNull((String)arrCol.get(10))%>)</td>
                       <td><%=Helper.correctNull((String)arrCol.get(11))%>&nbsp;</td>
                       <td><%if(Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("U")){%>Unapproved<%}
                       else if(Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("A")){ %>Approved<%} %>&nbsp;</td>
                       <td align="right"><%=Helper.correctNull((String)arrCol.get(13))%>&nbsp;</td>
                       <td><%if(Helper.correctNull((String)arrCol.get(14)).equalsIgnoreCase("y")){%>Yes<%}
                       else if(Helper.correctNull((String)arrCol.get(14)).equalsIgnoreCase("n")){ %>No<%} %>&nbsp;</td>
                       <td nowrap="nowrap"><%=Helper.correctNull((String)arrCol.get(15))%>&nbsp;- (<%=Helper.correctNull((String)arrCol.get(16))%>)</td>
                     </tr>
                     <%		}
                    	}else{%>
                    	<tr class="datagrid"><td colspan="13" >&nbsp;</td></tr>
                    	<tr class="datagrid"><td colspan="13" align="center">No History Found</td></tr>
                    	<tr class="datagrid"><td colspan="13" >&nbsp;</td></tr>
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