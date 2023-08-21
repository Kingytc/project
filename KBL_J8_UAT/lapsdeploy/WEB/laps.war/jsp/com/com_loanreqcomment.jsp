<%@include file="../share/directives.jsp"%>
<%
			String strDesc = Helper.correctNull((String) request.getParameter("pageval"));
			ArrayList arrRow = new ArrayList();%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "<%=ApplicationParams.getAppUrl()%>";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;
}

function placevalues()
{
	if(document.forms[0].btnenable.value=="N")	 
	{	 	
	 	enableButtons(true,true,true,true,false);
	}
	else
	{
		enableButtons(false,true,true,true,false);
	}
}

function doCancel()
{
	if (ConfirmMsg(102))
	{
		document.forms[0].hidBeanGetMethod.value="getDataComment";
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].action=appURL+"action/com_loanreqcomment.jsp?type=1";
		document.forms[0].submit();
	}
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	 }
}

function doEdit()
{
	enableButtons(true,false,false,false,true);
	document.forms[0].hidAction.value ="insert";
}

function doSave()
{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateGeneralComment";
	document.forms[0].hidBeanGetMethod.value="getDataComment";
	document.forms[0].hidSourceUrl.value="/action/com_loanreqcomment.jsp"
	document.forms[0].action=appURL+"controllerservlet?type=1";
	document.forms[0].submit();
}

function doDelete()
{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateGeneralComment";
	document.forms[0].hidBeanGetMethod.value="getDataComment";
	document.forms[0].hidSourceUrl.value="/action/com_loanreqcomment.jsp"
	document.forms[0].action=appURL+"controllerservlet?type=1";
	document.forms[0].submit();
}

function gototab(beanid,methodname,pagename,type)
{
	document.forms[0].hidBeanId.value=beanid;
	document.forms[0].hidBeanGetMethod.value=methodname;
	document.forms[0].action=appURL+"action/"+pagename;
	document.forms[0].hidtype.value=type;
	document.forms[0].submit();
}   
</script>
</head>

<body onload="placevalues()">
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
<form name="frmpri" method=post class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>

		<td valign="top" colSpan=5 height="16">
		<jsp:include page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="8" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<span class="page_flow">Home-&gt;
Corporate-&gt; Proposal-&gt; Risk Analysis -&gt;Assessment</span><br>
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application />
<lapschoice:FinAnalysisTag tabid="5" />
<jsp:include page="../com/com_commentstab.jsp" flush="true">
							<jsp:param name="tabid" value="1" />
						</jsp:include>
						<lapschoice:ComAssessmentTab  subtabid="2" assessmenttype="<%=strDesc%>"/>
	<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td>
								<table width="90%" border="0" cellspacing="0" cellpadding="5" class="outertable linebor" align="center">
									<%arrRow = (ArrayList) hshValues.get("arrRow");
			if (arrRow != null && arrRow.size() > 0) {%>
									<tr class="dataheader">
										<td align="center" width="35%"><b>Particulars&nbsp;</b></td>
										<td colspan="2" align="center"><b>Previous Year&nbsp;</b></td>
										<td align="center"><b>Current Year&nbsp;</b></td>
										<td colspan="2" align="center"><b>Next Year&nbsp;</b></td>
									</tr>
									<%for (int i = 0; i < arrRow.size(); i++) {
					ArrayList arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);
					String strBgcolor = "";
					String strAlign = "";
					if (i < 2) {
						strBgcolor = "dataheader";
						strAlign = "center";
					} else {
						strBgcolor = "datagrid";
						strAlign = "right";
					}

					%>
									<tr class="<%=strBgcolor%>">
										<td><%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
										<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(1))%>&nbsp;</td>
										<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(2))%>&nbsp;</td>
										<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(3))%>&nbsp;</td>
										<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(4))%>&nbsp;</td>
										<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(5))%>&nbsp;</td>
									</tr>
									<%}}%>
								</table>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td width="50%" valign="top"><textarea
											name="txt_assessmentoflimit" cols="110" wrap="VIRTUAL"
											rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("com_limitassessmnent_comments"))%></textarea></td>
										<%if (strDesc.equals("TO")) {%>
										<td valign="top" align="left" width="50%"><font size="2"
											color="red" face="Tahoma">Note:
										<ul>

											<li>The &quot;Eligible Working Capital Finance Limit&quot;
											(Col. No. 7) is the value under Col. 5. or Col. 6. whichever
											is lower.</li>

											<li>However in case the &quot;Actual/ Projected NWC&quot;
											(Col. No. 4) is negative, the eligible working capital
											finance limit can be sanctioned only if the borrower inducts
											the sufficient margin in the business.</li>

											<li>Please make a note of it before sanctioning the credit
											limits to the customer in such cases.</li>
										</ul>
										</font></td>
										<%}%>
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
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidtype" /> 
<input type="hidden" name="pageval" value="<%=strDesc%>">
</form>
<script language="javascript1.2">editor_generate('txt_assessmentoflimit');</script>
</body>
</html>
