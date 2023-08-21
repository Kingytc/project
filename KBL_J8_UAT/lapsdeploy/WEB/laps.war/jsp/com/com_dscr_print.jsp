<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<% request.setAttribute("_cache_refresh", "true"); 
ArrayList TableValues=new ArrayList();
ArrayList labeldetails=new ArrayList();
ArrayList vecRec=new ArrayList();
TableValues=(ArrayList)hshValues.get("TableValues");
labeldetails=(ArrayList)hshValues.get("labeldetails");
ArrayList v1=new ArrayList();
ArrayList DSCRYear=new ArrayList();
ArrayList DSCRType=new ArrayList();
ArrayList DSCRValues =new ArrayList();
int i=0;
%>
<html>
	<head>
		<title>
		DSCR
		</title>
		<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
	</head>
	<body>
	<table width="100%">
	<tr >
	<td width="100%">
		<table width="98%" align="center">
			<tr>
				<td>
				&nbsp;
				</td>
			</tr>
				<tr>
				<td style="text-align: center;">
				DSCR
				</td>
			</tr>
			<tr>
				<td width="100%">
					 <span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/> 
				</td>
			</tr>
		</table>
		<table width="98%" align="center">
		<%for( i=0;i<2;i++)
			{%>
			<tr class="datagrid">
				<td colspan="2">	&nbsp;
				</td>
					<%
					if(TableValues.size()>0)
					{
					for(int j=0;j<TableValues.size();j++)
					{
					vecRec=(ArrayList)TableValues.get(j);
				
					%>
				<td>
					<%=vecRec.get(i)%>
				</td>
				<%} }
				else
				{%>
				<td>
					&nbsp;
				</td>
				<%} %>
			</tr>
			<%} %>
			<%for(i=0;i<labeldetails.size();i++)
			{ 
				ArrayList v=(ArrayList)labeldetails.get(i);
			%>
			<tr class="datagrid">
				<td width="5%" style="text-align: center;">
					<%=v.get(3) %>
				</td>
				<td width="25%">
					<%=v.get(1) %>
				</td>
				<%
				if(TableValues.size()>0)
				{
				for(int j=0;j<TableValues.size();j++)
					{
					vecRec=(ArrayList)TableValues.get(j);
					DSCRValues=(ArrayList)vecRec.get(2);
					%>
				<td style="text-align:right;" width="10%">
					<%=DSCRValues.get(i)%>
				</td>
				<%}}else{ %>
				<td style="text-align:right;" width="10%">
				0.00
				</td>
				<%} %>
			</tr>	
			<%} %>
			<tr class="datagrid">
				<td>
				&nbsp;
				</td>
				<td>
					Average DSCR
				</td>
				
				<td style="text-align: right;" colspan="<%=TableValues.size() %>">
				<%=Helper.correctDouble((String)hshValues.get("DscrAvg")) %>
				</td>
				
			</tr>
		</table>
		</td>
		</tr>
		</table>
	</body>
</html>