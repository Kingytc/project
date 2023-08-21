<%@include file="../share/directives.jsp"%>
<%String grpRights = (String) session.getAttribute("strGroupRights");%>
<HTML>
<HEAD>
<TITLE>Laps Tertiary Navigation</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<script language="JavaScript">
var grpRights = "<%=session.getAttribute("strGroupRights")%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function callFunction(pagename,pagetype)
{
	document.forms[0].hidPageType.value = pagetype;
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}
function doClose()
{
	document.forms[0].action = appURL+"action/mainnav.jsp";
	document.forms[0].submit();
}
</script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style_tab.css" type="text/css">
</HEAD>
<BODY>
<jsp:include page="../share/sessionmaintaince.jsp" flush="true"/>
<form name="navigation" class="normal">
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td class="lightbandcolor">&nbsp;</td>
	</tr>
	<tr>
		<td class="darkbandcolor">&nbsp;</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" height="150">
			<tr>
				<td valign="middle">
				<TABLE WIDTH="20%" BORDER="0" CELLSPACING="0" CELLPADDING="4" class="outertable">
					<%if (grpRights.charAt(7) == '1'
					&& grpRights.charAt(18) == 'w'
					&& (strOrgLevel.equals("A") || (strOrgLevel.equals("D") && strIsSaral
							.equals("Y")))) {%>
					<TR align="center">
						<TD class="menubackflow">
						<B> <a href="javascript:callFunction('agrappmastersearch.jsp','CR')">Customer Profile </a> </B>
						</TD>
					</TR>
					<%}%>
					<%if (grpRights.charAt(8) == '1')
					 {%>
					<TR>
						<TD class="menubackflow">
						<B> <A HREF="javascript:callFunction('agrborrowersearch.jsp','')">Application</A> </B>
						</TD>
					</TR>
					<%}%>			
				</TABLE>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td class="darkbandcolor">&nbsp;</td>
	</tr>
	<tr>
		<td class="lightbandcolor">&nbsp;</td>
	</tr>
</table><br>
<lapschoice:combuttonnew btnenable=''/> 
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>"> 
<input type="hidden" name="hidPageType">
</form>
</BODY>
</HTML>
