<%@ page import="com.sai.laps.helper.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="strOrgLevel" class="java.lang.String" scope="session" />
<jsp:useBean id="strGroupRights" class="java.lang.String" scope="session" />
<laps:handleerror />
<%
%>
<html>
<head>
<title>Commercial-Existing Application form</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function showBlank()
{
	document.all.result.src=appURL+'action/blank.jsp';
}
function resetme()
{
	document.forms[0].reset();
	document.all.result.src=<%=ApplicationParams.getAppUrl()%>+'action/blank.jsp';
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/combstpge.jsp";
		document.forms[0].submit();
	}
}
function doSearch()
{
	if(document.forms[0].srchoption.checked==true)
	{
		alert('Enter Application Number');
		return;
	}
	document.all.result.src="<%=ApplicationParams.getAppUrl()%>action/combst_appresult?hidBeanGetMethod=getBSTAppnoData&hidBeanId=broadsancterms&id=<%=Helper.correctNull((String)request.getParameter("id"))%>&appno="+appno+"&comapp_compname=<%=Helper.correctNull((String)request.getParameter("comapp_compname"))%>";
}
function doNew()
{
	var id="<%=Helper.correctNull((String)request.getParameter("id"))%>";
	var appname="<%=Helper.correctNull((String)request.getParameter("appname"))%>";
	document.forms[0].hid_comappid.value=id;
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/combst_facility.jsp?hidBeanId=broadsancterms&hidBeanGetMethod=getBSTfacility&hidcatory=bst&appname="+appname+"&com_id="+id+"&appno=NEW&hidcatory=bst&valuesin=L";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="exist" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td valign="top" class="page_flow">
				Home&nbsp;-&gt;&nbsp;Corporate &amp; SME&nbsp;-&gt;&nbsp;Broad Terms of Proposal&nbsp;Application Search</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable border1">
					<tr>
						<td height="70" valign="top"><br>
						<table width="80%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
							<tr>
								<td height="0" valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
									<tr>
										<td>
										<table width="30%" border="0" cellspacing="0" align="center" cellpadding="0" class="outertable linebor">
										<tr align="center">
											<%if(strGroupRights.charAt(18) =='w' && (strOrgLevel.equals("A"))){%>
												<td align="center"><input type="button" name="cmdNew"
													value="New Broad Terms Proposal" class="buttonStyle" style="width:100%" onClick="doNew()">
												</td>
												<% }%>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						<br>
						<table width="80%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
							<tr>
								<td valign="top" id="searchheading">
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
									<tr align="center" class="dataheader">
										<td width="24%">Application No.</td>
										<td width="51%" >Borrower Name </td>
										<td width="25%" >Process Status</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td valign="top"><iframe id="result"
									src="<%=ApplicationParams.getAppUrl()%>action/combst_appresult.jsp?hidBeanGetMethod=getBSTAppnoData&hidBeanId=broadsancterms&id=<%=Helper.correctNull((String)request.getParameter("id"))%>&appname=<%=Helper.correctNull((String)request.getParameter("appname"))%>&com_id=<%=Helper.correctNull((String)request.getParameter("com_id"))%>"
									width="100%" height=220> </iframe></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<table border="1" cellspacing="0" cellpadding="0"
	bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
	<tr>
		<td>
		<table width="0%" border="0" cellspacing="0" cellpadding="2">
			<tr valign="middle">
				<td></td>
				<td>
				<div align="center"><input type="button" name="cmdclose"
					value="Close" class="buttonClose" onClick="doClose()"></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
 <input type="hidden" name="comapp_id"
	value="<%=request.getParameter("comapp_id")%>"> <input type="hidden"
	name="comapp_compname"
	value="<%=request.getParameter("comapp_compname")%>"> <input
	type="hidden" name="comapp_compid"
	value="<%=request.getParameter("comapp_compid")%>">
	<input type="hidden" name="hid_comappid">
	</form>
</body>
</html>
