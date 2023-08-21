<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="strOrgLevel" class="java.lang.String" scope="session" />
<jsp:useBean id="strIsSaral" class="java.lang.String" scope="session" />
<laps:handleerror />
<%
ArrayList g1 = new ArrayList();
int noofrows = Integer.parseInt(request.getParameter("noofrows"));
 
%>
<html>
<head>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
	
</script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body >
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
function callPage(uniqoldid,name,cbsid)
{	
	document.forms[0].hidappid.value=uniqoldid;
	document.forms[0].hidname.value=name;
	document.forms[0].hidcbsid.value=cbsid;
	//var hidvalue = document.forms[0].hidvalue.value;
	//var txt_search =  document.forms[0].txt_value.value;
	document.forms[0].hidBeanId.value="inwardRegister";
	document.forms[0].hidBeanGetMethod.value="getmsmeproposalresult";
	document.forms[0].action=appURL + "action/msme_proposalsearch.jsp?";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
	
}

function callLink(uniqoldid,name,cbsid)
{
	document.forms[0].hidappid.value=uniqoldid;
	document.forms[0].hidname.value=name;
	document.forms[0].hidcbsid.value=cbsid;
	document.forms[0].hidBeanId.value="inwardRegister";
	document.forms[0].hidBeanGetMethod.value="getmsmeproposalresult";
	document.forms[0].action = appURL + "action/msmeproposallink.jsp?";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}
</script>
</div></div>
<form name="srchform" method="post" class="normal">
<table width="100%" border="0" cellspacing="1" cellpadding="5"
									 class="outertable">
<tr>
								<td colspan="8">
								<table width="100%" border="0" cellspacing="1" cellpadding="5"
									 class="outertable">
	<%ArrayList v = (ArrayList) hshValues.get("arrRow");
			if (v != null) {
				int vecsize = v.size();

				if (vecsize != 0) {
					if (noofrows > vecsize) {
						noofrows = vecsize;
					}
					for (int l = 0; l < noofrows; l++) {

						g1 = (ArrayList) v.get(l);
						%>
	<tr class="datagrid">
		<td width="33%"><a href="#" onClick="javascript:callLink('<%=Helper.correctNull((String) g1.get(3))%>','<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(1))%>')"><b><%=Helper.correctNull((String) g1.get(0))%></b></a></td>
		<td width="33%"><%=Helper.correctNull((String) g1.get(1))%></td>
		<td width="33%"><%=Helper.correctNull((String) g1.get(2))%> </td>
		
	</tr>
	<%}
				} else {

				%>
	<tr>
		<td colspan="8" align="center">No Data Found</td>

	</tr>
	
	<%}

			}

			%>
</table>
</td>
</tr>
<input type="hidden" name="hid_rowcount" value="" /> 
<input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidBeanId" value=""> 
<input type="hidden" name="hidsearchtype" value="<%=Helper.correctNull((String) hshValues.get("val"))%>">
<input type="hidden" name="hidappid" value="">
<input type="hidden" name="hidname" value="">
<input type="hidden" name="hidcbsid" value="">
<input type="hidden" name="hidsearchval" value="<%=Helper.correctNull((String) hshValues.get("search"))%>">

</form>
</body>
</html>
