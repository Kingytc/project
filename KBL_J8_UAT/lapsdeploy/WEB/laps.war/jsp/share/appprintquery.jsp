
<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	if (hshValues != null) {
		arrRow = (ArrayList) hshValues.get("arrRow");
	}
	String strUserid = Helper.correctNull((String) session.getAttribute("strUserId"));
%>
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<style type="text/css">
body, table td
{
FONT-SIZE: 16px !important; COLOR: #000000 !important; FONT-FAMILY: "Book Antiqua" !important;
}
#top{background-color: #ffffff;}
#top table{ border-collapse: collapse;}
#top td {border: 0.5pt solid #000000; FONT-SIZE: 16px; COLOR: #000000; LINE-HEIGHT: 16px; FONT-FAMILY: "Book Antiqua"}

.title
{
FONT-SIZE: 16px !important; COLOR: #000000 !important; FONT-FAMILY: "Book Antiqua" !important;font-weight: bold !important;
}
</style>
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="0" cellpadding="0" class="outertable">
				<tr>
				<td align="center"><br><img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td></tr>
			  <tr><td> &nbsp;  </td> </tr>
			  <tr><td>  </td> </tr>
			 <tr>
			 	<td align="center">
			 	<div id="top">
			 		<table width="95%" border="0" cellspacing="0" cellpadding="1" class="outertable" >
				 		<tr class="tblhead">
							<td colspan="10">Proposal No : <%=Helper.correctNull((String)hshValues.get("appno")) %></td>
							</tr>
				 		<tr class="tblhead">
							<td>Query S.no</td>
							<td>Query Raised Organisation</td>
							<td>Query Raised by</td>
							<td>Date of raising Query</td>
							<td>Details of the query entered by the user</td>
							<td>Query Replied Organisation</td>
							<td>Query Replied by</td>
							<td>Date of Query Replied</td>
							<td>Comments entered by the user</td>
							<td>Query Status</td>
						</tr>
				
				 <%
				 		String parentid="",strCreatedUser="",strStatus="",strRepliedUser="";
				 		int strChildCount=0, slno=0;
						if (arrRow != null && arrRow.size()>0) {
							for (int i = 0; i < arrRow.size(); i++) {
								arrCol = new ArrayList();
								arrCol = (ArrayList) arrRow.get(i);
								parentid=Helper.correctNull((String)arrCol.get(12));
								strCreatedUser=Helper.correctNull((String)arrCol.get(2));
								strRepliedUser=Helper.correctNull((String)arrCol.get(7));
								strStatus=Helper.correctNull((String)arrCol.get(6));
								strChildCount=Integer.parseInt(Helper.correctInt((String)arrCol.get(13)))+1;
								
					%>
					
					<%if((!strUserid.equals(strCreatedUser)) && strStatus.equalsIgnoreCase("Query Entered")){ %>
					<%
						}else{%>
							
						<tr>
						<%if(parentid.equals("0")) { %>
							<td rowspan="<%=strChildCount %>"><%=slno + 1%></td>
							<td rowspan="<%=strChildCount %>"><%=arrCol.get(5)%>&nbsp;</td>
						<%slno++; } %>
						<td><%=arrCol.get(2)%>&nbsp;- &nbsp;<%=arrCol.get(3)%>&nbsp;</td>
						<td><%=arrCol.get(4)%>&nbsp;</td>
						<td><%=arrCol.get(1)%>&nbsp;</td>
						<td><%=arrCol.get(11)%>&nbsp;</td>
						<% if(strStatus.equalsIgnoreCase("Query Sent")){
							if(!strRepliedUser.equalsIgnoreCase("") && strRepliedUser.equals(strUserid)){%>
							<td><%=arrCol.get(7)%>&nbsp;-&nbsp;<%=arrCol.get(8)%>&nbsp;</td>
							<td><%=arrCol.get(9)%>&nbsp;</td>
							<td><%=arrCol.get(10)%>&nbsp;</td>
							<%}else{ %>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<%}}
							else{ %>
							<td><%=arrCol.get(7)%>&nbsp;-&nbsp;<%=arrCol.get(8)%>&nbsp;</td>
							<td><%=arrCol.get(9)%>&nbsp;</td>
							<td><%=arrCol.get(10)%>&nbsp;</td>
							<%} %>
						<td><%=arrCol.get(6)%>&nbsp;</td>
					</tr>
							
					
					<%}}} %>
					</table>
					</div>
					</td>
				</tr>
		 	</table>
	   </td>
   </tr>
</table>
		<br><br>
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="hidappno" value="">
</body>
</html>