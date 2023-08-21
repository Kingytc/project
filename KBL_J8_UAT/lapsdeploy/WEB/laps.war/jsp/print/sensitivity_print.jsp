<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<% request.setAttribute("_cache_refresh", "true"); 

if(objValues instanceof java.util.Hashtable)
{
	   hshValues=(HashMap)objValues;
}

String pagevalType = Helper.correctNull((String) request.getParameter("pageVal"));
HashMap	 hshFin	= new HashMap();
hshFin	= (HashMap)hshValues.get(pagevalType+"hshFinValues"); 

ArrayList TableValues=new ArrayList();
ArrayList labeldetails=new ArrayList();
ArrayList vecRec=new ArrayList();
TableValues=(ArrayList)hshFin.get("TableValues");
labeldetails=(ArrayList)hshFin.get("labeldetails");
ArrayList v1=new ArrayList();
ArrayList DSCRYear=new ArrayList();
ArrayList DSCRType=new ArrayList();
ArrayList DSCRValues =new ArrayList();
int i=0;
%>
<html>
	<body>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
		<%if(TableValues!=null&&TableValues.size()>0)
		{%>
		<%for( i=0;i<2;i++)
			{ %>
			<tr>
				<td colspan="2">	&nbsp;
				</td>
					<%for(int j=0;j<TableValues.size();j++)
					{
					vecRec=(ArrayList)TableValues.get(j);
					%>
				<td align="center">
					<%=vecRec.get(i)%>
				</td>
				<%} %>
			</tr>
			<%} %>
			<%for(i=0;i<labeldetails.size();i++)
			{ 
				ArrayList v=(ArrayList)labeldetails.get(i);
			%>
			<tr>
				<td width="3%" style="text-align: center;">
					<%=v.get(3) %>.
				</td>
				<td width="27%">
					<%=v.get(1) %>
				</td>
				<%for(int j=0;j<TableValues.size();j++)
					{
					vecRec=(ArrayList)TableValues.get(j);
					DSCRValues=(ArrayList)vecRec.get(2);
					%>
				<td style="text-align: right;" width="10%">
					<%=DSCRValues.get(i)%>
				</td>
				<%} %>
			</tr>	
			<%} %>
			<tr>
				<td>
				&nbsp;
				</td>
				<td>
					Average DSCR
				</td>
				
				<td style="text-align: right;" colspan="<%=TableValues.size()%>">
				<%=Helper.correctDouble((String)hshFin.get("DscrAvg")) %>
				</td>
			</tr>
			<%}else{ %>
			<tr><td style="border: none;">Nil</td></tr>
			<%} %>
		</table>
	</body>
</html>