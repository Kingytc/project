<%@include file="../share/directives.jsp"%>
<%
	
				ArrayList arrRow	=	new ArrayList();
				ArrayList arrCol	=	new ArrayList();
				arrRow	=	(ArrayList)hshValues.get("arrRow");
				int iarrLength	=0;
				if(arrRow!=null && arrRow.size()>0)
				{
					iarrLength= arrRow.size();
				}
	
%>
<html>
<head>
<script type="text/javascript">
var appURL="<%=ApplicationParams.getAppUrl()%>";
function SelectValues(refid,sno)
{
	document.all.ifrm.src=appURL+"action/ifrmnsdllViewDocument.jsp?hidBeanId=nsdl&hidBeanGetMethod=viewAttachedDocument&strRefId="+refid+"&hidSno="+sno;
}
</script>
</head>
<body>
<form>

<table width="90%" cellspacing="0" cellpadding="3" align="center" class="outertable">
<tr>
          <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>/img/kbl_newlogo.jpg"></td>          		
        </tr>
        <tr>&nbsp;</tr>
 </table>
 
	<table width="90%" cellspacing="1" cellpadding="3" align="center" class="outertable" >
	
		<tr  class="dataheader">
					<td>&nbsp; </td>
					<td>&nbsp; Reference ID</td>
					<td>&nbsp; Document Name</td>
					
		</tr>
		<%if(iarrLength>0)
		{
				for(int i=0;i<iarrLength;i++)
				{
					arrCol	=	(ArrayList) arrRow.get(i);
		
			%>
			<tr  class="datagrid">
					<td align="center">
					<input type="radio" name="rdselect" style="border:none" onClick="SelectValues('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(2))%>')">
					</td>
					<td> <%=Helper.correctNull((String)arrCol.get(0)) %></td>
					<td> <%=Helper.correctNull((String)arrCol.get(1)) %></td>
			</tr>
			 
		<%}}
		else
		{
			%>
			<tr  class="datagrid">
					<td colspan="3" align="center">&nbsp; -- No Data Found --  </td>
			</tr>
		<%} %>
	 </table>
		<table width="90%" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr>
		<td>
		<iframe height="800px" width="100%" id="ifrm" frameborder=0 style="border:0" scrolling="auto"></iframe>
		</td>
		</tr>
		</table>
		
</form>
</body>
</html>

