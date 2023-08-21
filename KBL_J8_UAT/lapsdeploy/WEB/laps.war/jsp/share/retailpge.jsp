<%@include file="../share/directives.jsp"%>
<%String grpRights = (String) session.getAttribute("strGroupRights");
String strhidcategory = Helper.correctNull((String)request.getParameter("hidCategoryType"));
String strExcelUploadFlag = Helper.correctNull((String)request.getParameter("strExcelUploadFlag"));
%>
<HTML>
<HEAD>
<TITLE>Laps Retail Navigation</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<script language="JavaScript">
var grpRights = "<%=session.getAttribute("strGroupRights")%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function callFunction(pagename)
{
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}
function doClose()
{
	document.forms[0].action = appURL+"action/mainnav.jsp";
	document.forms[0].submit();
}

function dohlp()     
{
  var hlpvar = appURL+"phlp/loan_appretail.htm";
  var title = "Retail";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style_tab.css" type="text/css">
</HEAD>

<BODY>
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
<jsp:include page="../share/sessionmaintaince.jsp" flush="true"></jsp:include>
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
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center" height="150">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" height="150">
			<tr>
				<td width="33%" valign="middle">
				<TABLE WIDTH="20%" BORDER="0" CELLSPACING="0" CELLPADDING="4" class="outertable">
				<%if(strhidcategory.equalsIgnoreCase("RET")){ %>
				<!--  	<%if (grpRights.charAt(4) == '1' && grpRights.charAt(18) == 'w' && (strOrgLevel.equals("A") || (strOrgLevel.equals("D") && strIsSaral.equals("Y")))) {%>
					<TR>
						<TD class="menubackflow"><B> <A HREF="javascript:callFunction('mastersearchper.jsp')">Customer Profile </A> </B></TD>
					</TR>
					<%}%>	-->				
					<%if (grpRights.charAt(5) == '1' || grpRights.charAt(6) == '1') { %>
					<TR>
						<TD class="menubackflow"><B><A HREF="javascript:callFunction('perborrowersearch.jsp')">Proposal</A> </B></TD>
					</TR>
					<TR>
						<td class="menubackflow"><b><a href="javascript:callFunction('querySearch_dev.jsp')">Query / Reply </a> </b></td>					
					</TR>
					<TR>
						<td class="menubackflow"><b><a href="javascript:callFunction('digi_fieldinvestigation_inbox.jsp')">Digi-Retail FI/KYC Pending </a> </b></td>					
					</TR>
					<%}
				}else if(strhidcategory.equalsIgnoreCase("AGR")){%>
				<!--  	<%if (grpRights.charAt(19) == '1' && grpRights.charAt(18) == 'w' && (strOrgLevel.equals("A") || (strOrgLevel.equals("D") && strIsSaral.equals("Y")))) {%>
					<TR>
						<TD class="menubackflow"><B> <A HREF="javascript:callFunction('mastersearchper.jsp')">Customer Profile </A> </B></TD>
					</TR>
					<%}%>	-->				
					<%if (grpRights.charAt(20) == '1' || grpRights.charAt(21) == '1') { %>
					<TR>
						<TD class="menubackflow"><B><A HREF="javascript:callFunction('perborrowersearch.jsp')">Proposal</A> </B></TD>
					</TR>
					<%}}else {%>
				<!--  	<%if (grpRights.charAt(18) == 'w' && (strOrgLevel.equals("A") || (strOrgLevel.equals("D") && strIsSaral.equals("Y")))) {%>
					<TR>
						<TD class="menubackflow"><B> <A HREF="javascript:callFunction('mastersearchper.jsp')">Customer Profile </A> </B></TD>
					</TR>
					<%}%>-->					
					<%if (grpRights.charAt(20) == '1' || grpRights.charAt(5) == '1'
							||grpRights.charAt(24) == '1' || grpRights.charAt(25) == '1') { %>
					<TR>
						<TD class="menubackflow"><B><A HREF="javascript:callFunction('perborrowersearch.jsp')">Proposal</A> </B></TD>
					</TR>
					<TR>
						<td class="menubackflow"><b><a href="javascript:callFunction('querySearch_dev.jsp')">Query / Reply </a> </b></td>					
					</TR>
					<%if(strExcelUploadFlag.equalsIgnoreCase("y")){ %>
					<TR>
						<TD class="menubackflow"><B><A HREF="javascript:callFunction('exceluploader.jsp')">Excel Upload</A> </B></TD>
					</TR>
					<%} %>
					<%}}%>	
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
