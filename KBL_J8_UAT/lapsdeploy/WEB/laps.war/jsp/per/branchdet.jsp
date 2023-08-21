<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
ArrayList v= new ArrayList();
String strFromLink =Helper.correctNull((String)request.getParameter("strfrom"));
%>
<html>
<head>
<title>Branch Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript" type="text/javascript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var path      ="<%=ApplicationParams.getAppUrl()%>";
var strAppUrl="/laps/";
var from_link = "<%=strFromLink%>";

function showLink(val1, val2)
{
    if (from_link == "Branch")
	{
		window.opener.document.forms[0].txtperapp_branchcode.value = val1;
		window.opener.document.forms[0].txtperapp_branch.value =val2;
		window.close();
	}
}
function doClose()
{
	window.close();
}
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<body>
<FORM name="" method="post" class="normal">
<table border="0" width="98.3%" cellspacing="0" cellpadding="3"
	align="center" class="outertable">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="3" width="100%"
			class="outertable linebor">
			<tr class="dataHeader">
				<td width="3%">&nbsp;</td>
				<td width="33%"><b>Branch Name</b></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<%ArrayList vecRow = (ArrayList)hshValues.get("vecData");     
     if(vecRow.size()>6){ %>
		<div class="cellContainer">
		<%} %><table width="100%" border="0" cellspacing="1" cellpadding="3">
			<%
           
		if(vecRow!=null && vecRow.size()>0)
		 {
			v = (ArrayList) hshValues.get("vecData");
			for(int i=0;i<vecRow.size();i++)
			{
				v = (ArrayList)vecRow.get(i);
				if(v.size() >0)
				{ 	
				   %>
			<tr class="datagrid">
				<td width="3%"><%=i+1%></td>
				<td width="30%"><a
					href="javascript:showLink('<%=Helper.correctNull((String)v.get(0))%>','<%=Helper.correctNull((String)v.get(1))%>')"><b><%=Helper.correctNull((String)v.get(1))%></b></a></td>
				<%
				}
			}
		}
         %>
			
		</table>
		<%if(vecRow.size()>6){ %>
		</div>
		<%} %>
		</td>
	</tr>
</table>
<br>
<table width="" border="0" cellspacing="0" cellpadding="3"
	align="center" class="outertable">
	<tr>
		<td><lapschoice:combuttonnew
			btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
		</td>
	</tr>
</table>
</FORM>
</body>
</html>
