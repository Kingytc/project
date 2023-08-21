<%@include file="../share/directives.jsp"%>
<%

//String grpRights = (String) session.getAttribute("strGroupRights");
//			session.setAttribute("pageType", "New");
//			String DigiOrgCode = Helper.correctNull((String) session.getAttribute("strOrgCode"));
//		String orglevel= Helper.correctNull((String) session.getAttribute("strOrgLevel"));
//out.println(DigiOrgCode);
//out.println(test);
%>
<HTML>
<HEAD>
<TITLE>Credit Enquiry</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<script language="JavaScript">

var appURL = "<%=ApplicationParams.getAppUrl()%>";

function callFunction(pagename,param)
{
	document.forms[0].hidreportmis.value=param;
  	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename+"?report="+param;
  	document.forms[0].submit();
}
function doClose()
{
	document.forms[0].action = appURL+"action/mainnav.jsp";
	document.forms[0].submit();
}
function callinwardoutward(pagename)
{
	//document.forms[0].action = appURL+"action/"+pagename;
	//document.forms[0].submit();
	if(pagename=="inward_reg.jsp")
	{
		//document.forms[0].action=appURL+"controllerservlet";
		//document.forms[0].hidBeanId.value="lapsReport";
		//document.forms[0].hidBeanMethod.value="updateGoldReAppraiserdet";
		//document.forms[0].hidBeanGetMethod.value="getinwarddetails";
		document.forms[0].hidSourceUrl.value="/action/inward_reg.jsp";
		document.forms[0].submit();
	}
	
}
function callinwardoutward(url, bean, method)
{
	document.forms[0].hidBeanGetMethod.value = method;
	document.forms[0].hidBeanId.value = bean;
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+ url;
	document.forms[0].submit();
}
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style_tab.css" type="text/css">
</HEAD>
<BODY>
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
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" height="150">
		<tr>
		<td>&nbsp;</td>
	</tr>
			<tr>
				<td width="33%" valign="middle">
				<TABLE WIDTH="20%" BORDER="0" CELLSPACING="0" CELLPADDING="4" class="outertable">
				
					<tr>
						<TD class="menubackflow" nowrap="nowrap"><b><a href="javascript:txtLoad('Inward');callinwardoutward('inward_reg.jsp','lapsReport','getinwarddetails')">Inward</a></b></TD>
					</tr>
					<tr>
						<TD class="menubackflow" nowrap="nowrap"><b><a href="javascript:txtLoad('Outward');callinwardoutward('outward_reg.jsp','lapsReport','getoutwarddetails')">Outward</a></b></TD>
					</tr>
					
					<tr>
						<TD class="menubackflow" nowrap="nowrap"><b><a href="javascript:txtLoad('Proposal');callinwardoutward('inwardoutwardproposal.jsp','lapsReport','getinwardoutwardproposaldetails')" >Proposal</a></b></TD>
					</tr>
					<tr>
						<TD class="menubackflow" nowrap="nowrap"><b><a  href="javascript:txtLoad('Credit Enquiry');callinwardoutward('creditEnquiry.jsp')">Credit Enquiry</a></b></TD>
					</tr>
					<tr>
						<TD class="menubackflow" nowrap="nowrap"><b><a href="javascript:txtLoad('Short Note');callinwardoutward('shortnotes.jsp','lapsReport','getinwardoutwardshortnotedetails')">Short Note</a></b></TD>
					</tr>
					<tr>
						<TD class="menubackflow" nowrap="nowrap"><b><a href="javascript:txtLoad('Lodged Proposal');callinwardoutward('lodged_proposal.jsp')">Lodged Proposal</a></b></TD>
					</tr>
					<tr>
						<TD class="menubackflow" nowrap="nowrap"><b><a href="javascript:txtLoad('Dropped Proposal');callinwardoutward('dropped_proposal.jsp')" >Dropped Proposal</a></b></TD>
					</tr>
					<tr>
						<TD class="menubackflow" nowrap="nowrap"><b><a >Report</a></b></TD>
					</tr>
					<tr>
		<td>&nbsp;</td>
	</tr>
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
<input type="hidden" name="hidreportmis"/>
<lapschoice:combuttonnew btnenable=''/> 
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</BODY>
</HTML>
