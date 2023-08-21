<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="strOrgLevel" class="java.lang.String" scope="session" />
<jsp:useBean id="strIsSaral" class="java.lang.String" scope="session" />
<laps:handleerror />
<%
ArrayList g1 = new ArrayList();
int noofrows = Integer.parseInt(request.getParameter("noofrows"));
String strright = Helper.correctNull((String)session.getAttribute("strGroupRights"));
if(strright.length()>0)
{
	int len = strright.length();
	strright = strright.substring(len-1);
}

	String strCBSIDflag=Helper.correctNull((String)hshValues.get("strCBSIDflag")); 
%>
<html>
<head>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var grpRights = "<%=strright%>";
	
function callPage(id)
{
	if(("<%=strIsSaral%>" != "Y") && status == "P" && grpRights=="w")
	{
		alert("Inward Number is pending with "+username);
	}
	else
	{
		var app_no=id;
	 	document.forms[0].hidBeanId.value="BureauLink";
		document.forms[0].hidBeanGetMethod.value="getBureauData";
		document.forms[0].action = appURL + "action/Bureau_link.jsp?hidinwardno="+app_no;
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	
}

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
</script>
</div></div>
<form name="srchform" method="post" class="normal">
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<%ArrayList v = (ArrayList) hshValues.get("arrval");
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
		<td width="15%" ><a class="navigationLinks"
			href="javascript:callPage('<%=Helper.correctNull((String)g1.get(0))%>',
			'<%=Helper.correctNull((String) g1.get(1))%>','<%=Helper.correctNull((String) g1.get(2))%>',
			'<%=Helper.correctNull((String) g1.get(6))%>','<%=Helper.correctNull((String) g1.get(7))%>',
			'<%=Helper.correctNull((String) g1.get(8))%>','<%=Helper.correctNull((String) g1.get(9))%>',
			'<%=Helper.correctNull((String) g1.get(11))%>','<%=Helper.correctNull((String) g1.get(12))%>',
			'<%=Helper.correctNull((String) g1.get(13))%>','<%=Helper.correctNull((String) g1.get(14))%>',
			'<%=Helper.correctNull((String) g1.get(15))%>',
			'<%=Helper.correctNull((String) g1.get(16))%>','<%=Helper.correctNull((String) g1.get(17))%>',
			'<%=Helper.correctNull((String) g1.get(18))%>','<%=Helper.correctNull((String) g1.get(19))%>',
			'<%=Helper.correctNull((String) g1.get(20))%>','<%=Helper.correctNull((String) g1.get(21))%>')"
			><b>&nbsp;&nbsp;<%=Helper.correctNull((String)g1.get(0))%></b></a></td>
		<td width="31%">&nbsp;&nbsp;<%=Helper.correctNull((String) g1.get(6))%>&nbsp;&nbsp;</td>
		<td width="8%">&nbsp;&nbsp;<%=Helper.correctNull((String) g1.get(1))%></td>
		<td width="25%">&nbsp;&nbsp;<%=Helper.correctNull((String) g1.get(3))%></td>
		
		<td width="21%">&nbsp;&nbsp;<%=Helper.correctNull((String) g1.get(4))%></td>
	</tr>
	<%}} else{%>
	<tr class="datagrid">
		<td width="15%" >&nbsp;</td>
		<td width="31%" align="center"></td>
		<td width="8%" align="left"></td>
		<td width="25%" align="center"></td>
		<td width="21%" align="center"></td>
	</tr>
	<tr class="datagrid">
		<td width="15%" >&nbsp;</td>
		<td width="31%" align="center"></td>
		<td width="8%" align="left"></td>
		<td width="25%" align="center"></td>
		<td width="21%" align="center"></td>
	</tr>
	<tr class="">
		<td width="15%" >&nbsp;</td>
		<td width="31%" align="center"></td>
		<td width="8%" align="left"><b>No Data Found</b></td>
		<td width="25%" align="center"></td>
		<td width="21%" align="center"></td>
	</tr>
	<%}

			}

			%>

</table>
<input type="hidden" name="hidCBSIDflag" value="<%=strCBSIDflag%>">
<input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidBeanId" value="">
</form>
</body>
</html>
