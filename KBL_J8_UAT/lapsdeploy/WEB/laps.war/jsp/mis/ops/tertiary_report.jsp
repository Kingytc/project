<%@include file="../../share/directives.jsp"%><%
String strlinktype="";
if(Helper.correctNull((String)session.getAttribute("linktype")).equalsIgnoreCase("T")||Helper.correctNull((String)session.getAttribute("linktype")).equalsIgnoreCase("HC"))
{
	strlinktype="Tertiary";
}
else
{
	strlinktype="Retail";
}
%>
<html>
<head>
<title>LAPS-Setup Reports Navigation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript">
<!--
//-->
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function callFunction(pagename,param)
{
 	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename+"?report="+param;
  	document.forms[0].submit();
}
function callFunction1(pagename)
{
var orgCode="<%=(String)session.getAttribute("strOrgCode")%>";
  var purl ="<%=ApplicationParams.getAppUrl()%>action/"+pagename+"?&orgcode="+orgCode+"&hidBeanId=repappproductwise&hidBeanGetMethod=getMonthlyStatement";
		var prop = 'scrollbars=yes,menubar=yes,width=775,height=520';	
		var xpos = (screen.width - 775) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);
}

function calldate()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/MonStmt.jsp";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}
function closeWindow()
{
	if (ConfirmMsg("100"))
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/repnav.jsp";
		document.forms[0].submit();
	}	
}
function menuOptionDivMouseDown (url) 
{
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			document.forms[0].action=url;
			document.forms[0].submit();
}
function doClose()
{
	if (ConfirmMsg("100"))
	{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/repnav.jsp";
	document.forms[0].submit();
	}	
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style_tab.css" type="text/css">
</head>
<body>
<form class="normal" method=post name="appReports">
<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="page_flow">Home-&gt; Tertiary>-&gt;Reports</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
	<tr>
		<td valign="top">
		<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="4" align="center">
			<tr>
				<td align="center" valign="top" colspan="2">Tertiary Application Form Reports</td>
			</tr>
			<tr>
				<td align="center" valign="top" width="49%">
				<table class="outertable" width="40%" border="0" cellspacing="0" cellpadding="0" align="center">
					<tr class="dataheader">
						<td valign="top">Application</td>
						</tr>
						<tr><td>
						<table class="outertable" width="94%" border="0" cellspacing="0" cellpadding="8" align="center">
							<tr>
								<td class="menubackflow"><a href="JavaScript:callFunction('opsrepappstatus.jsp','')">
                              Application Status Pending/Approved/Rejected
                              </a>
								</td>
							</tr>
							<tr>
								<td class="menubackflow"><a href="javaScript:callFunction('opsrepuserstatus.jsp','')">
									Userwise Status of Pending/Approved/Rejected</a>
								</td>
							</tr>
							
							<tr>
								<td class="menubackflow">
								<a href="JavaScript:callFunction('opsrepapptrack.jsp','')">Application Tracking</a>
								</td>
							</tr>
							<tr>
								<td class="menubackflow">
								<a href="JavaScript:callFunction('opsrepappstillopen.jsp','')">Turnaround time Report</a>
								</td>
							</tr>
							<tr> 
                              
                            <td class="menubackflow"><a href="JavaScript:callFunction('opsrepappstatus.jsp','C')">State 
                              / City Wise Application Status Pending / Approved / Rejected</a></td>
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
<lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>  
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidPage"> 
<input type="hidden" name="hidusr_id">
<input type="hidden" name="hidlinktype" value=<%=Helper.correctNull((String)session.getAttribute("linktype"))%>>
</form>
</body>
</html>
