<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@include file="../share/directives.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String strhidcategory = Helper.correctNull((String)request.getParameter("hidCategoryType"));
if(strhidcategory.equals(""))
{
	strhidcategory="PERM";
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Permission Page</title>

<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style_tab.css" type="text/css">
<script type="text/javascript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var strOrgLevel = "<%=Helper.correctNull((String)session.getAttribute("strOrgLevel"))%>";
var varhidcategory = "<%=strhidcategory%>";


function callFunction1(pagename)
{
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}
function doClose()
{
	document.forms[0].action = appURL+"action/mainnav.jsp";
	document.forms[0].submit();
}
</script>
</head>
<body>
<form name="permission" class="normal">
<br>
<!-- <table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td class="lightbandcolor">&nbsp;</td>
	</tr>
	<tr>
		<td class="darkbandcolor">&nbsp;</td>
	</tr>
</table> -->
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable border1 tableBg" align="center">
	<tr>
		<td>
		<TABLE width="25%" BORDER="0" CELLSPACING="0" CELLPADDING="4" class="outertable">
			<tr>
		<td>&nbsp;</td>
	</tr>
	<%if((strOrgLevel.equals("A")||strOrgLevel.equals("C")|| (strOrgLevel.equals("D") && Helper.correctNull((String)session.getAttribute("strRLPFUser")).equalsIgnoreCase("012"))) &&
			 strGroupRights.charAt(18)=='w')
	{%>
	<tr>
						<td class="menubackflow"><b><a
							href="javascript:callFunction1('app_permission_param.jsp')">
						New Permission </a> </b></td>
					</tr>
					<%} %>
	<tr>
						<td class="menubackflow"><b><a
							href="javascript:callFunction1('permissionSearch.jsp')">
						Existing Permission </a> </b></td>
					</tr>					
			<tr>
					<td class="menubackflow"><b><a
						href="javascript:callFunction1('querySearch_dev.jsp')">
					Query / Reply </a> </b></td>
				</tr>											
</TABLE>
</td>
</tr>
</table>
<br>
<!-- <table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td class="lightbandcolor">&nbsp;</td>
	</tr>
	<tr>
		<td class="darkbandcolor">&nbsp;</td>
	</tr>
</table> -->
<br> 
<lapschoice:combuttonnew btnenable=''/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidCategoryType" value="<%=strhidcategory%>">
</form>
</body>
</html>