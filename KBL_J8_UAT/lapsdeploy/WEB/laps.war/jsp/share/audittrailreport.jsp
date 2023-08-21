<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%ArrayList arrRow = new ArrayList();
arrRow=(ArrayList)hshValues.get("arrRow");
String strhidPageid="";
strhidPageid=Helper.correctNull((String)request.getParameter("hidPageId"));
%>
<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
</head>
<body>
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<h3>
<center>Audit Trail Report</center>
</h3>
<form name="frmaudittrail" method="post">
<table width="95%" border="0" cellspacing="0" cellpadding="0"
	align="center">
	<tr>
		<td>
		<div id="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="2">
			<tr>
				<td class="tblhead" nowrap>Customer Name</td>
				<td nowrap><%=Helper.correctNull((String)hshValues.get("strCustomername")) %></td>
			</tr>
			<tr>
				<td class="tblhead" nowrap>Page Name</td>
				<td nowrap><%=Helper.correctNull((String)hshValues.get("PageName")) %></td>
			</tr>
			<%if(!strhidPageid.equalsIgnoreCase("perdemo") && !strhidPageid.equalsIgnoreCase("comcskyc") && !strhidPageid.equalsIgnoreCase("pempdet") && !strhidPageid.equalsIgnoreCase("pincexp")){%>
			<tr>
				<td class="tblhead">Proposal No:</td>
				<td><%=Helper.correctNull((String)hshValues.get("KeyId")) %></td>
			</tr>
			<%} %>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>

		<td height="3">
		<div id="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="2"
			align="left">



			<%
          String fontcolor="";
ArrayList arrData=null;
	if(arrRow!=null && arrRow.size()>0)
	{
		int colSize=0;
		
			for(int k=0;k<arrRow.size();k++)
			{
				arrData=(ArrayList)arrRow.get(k);
				 colSize=arrData.size();
				if( colSize>0)
				{%>
			<tr align="left" class="tblhead">
				<td nowrap="nowrap" valign="top">Date</td>
				<td nowrap="nowrap" valign="top">&nbsp;<%=Helper.correctNull((String)arrData.get(0))%></td>
				<td nowrap="nowrap" valign="top">Action Type</td>
				<td valign="top" nowrap="nowrap">&nbsp;<%=Helper.correctNull((String)arrData.get(5))%></td>
			</tr>
			<tr class="tblhead">
				<td nowrap="nowrap" valign="top">User Name</td>
				<td valign="top" colspan="3">&nbsp;<%=Helper.correctNull((String)arrData.get(1))%>
				(<%=Helper.correctNull((String)arrData.get(2))%>)</td>
			</tr>
			<tr class="tblhead">
				<td nowrap="nowrap" valign="top" colspan="2">Old Value</td>
				<td nowrap="nowrap" valign="top" colspan="2">New Value</td>
			</tr>
			<tr align="left">
				<td valign="top" colspan="2">&nbsp;<%=Helper.correctNull((String)arrData.get(3))%></td>
				<td valign="top" colspan="2">&nbsp;<%=Helper.correctNull((String)arrData.get(4))%></td>

			</tr>

			<%}
			}
		}%>
		</table>
		</div>
		</td>

	</tr>
</table>
</form>
</body>
</html>