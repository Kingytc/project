<%@ page import="com.sai.laps.helper.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<html>
<head>
<TITLE>Laps Navigation</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<script language="JavaScript">
var grpRights = "<%=session.getAttribute("strGroupRights")%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function callFunction(pagename)
{
	document.forms[0].method="post";
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}

function callWorkflow(pagename)
{
    document.forms[0].method="post";
	document.forms[0].hidBeanGetMethod.value="getWorkflowData";
	document.forms[0].hidBeanId.value="setproducts";
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
	
}

function callPage(pagename)
{	
	document.forms[0].method="post";	
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].hidBeanId.value="formula";
	document.forms[0].hidBeanGetMethod.value="getCMA";
	document.forms[0].submit();
}
function callPage1(pname)
{
    document.forms[0].method="post";
	document.forms[0].action=appURL+"action/"+pname;
	document.forms[0].submit();
}

//Help function added by vino
function dohlp()     
{
  var hlpvar = appURL+"phlp/setup_corpprod.htm";
  var title = "CorporateProductSearch";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}
</script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>

</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" margin onLoad="">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url=""><script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>
<form name="frmltrnav">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	bgcolor="#DEDACF">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" colspan=5><font face="Times New Roman" size="3"><b><i>Home
				-&gt; Setup -&gt; Tertiary Products</i></b></font></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<BR>
<BR>
<table width="50%" border="0" cellspacing="0" cellpadding="5"
	class="outertable border1"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="center">
			<tr>
				<td width="100%" valign="top" align="center">
				<fieldset style="width:475;background-color:#DEDACF"><legend><font
					size="1" face="MS Sans Serif"><b><font color="#CC3300">Tertiary
				Products</font></b></font></legend>
				<table width="100%" cellpadding="1" cellspacing="1" border="0">
					<tr>

						<td valign="top" align="center" width="51%">
						<fieldset style="width:230;background-color:#DEDACF">
						<table width="100%" border="0" cellspacing="2" cellpadding="5"
							align="center">

							<tr>
								<td width="65%"><b> <a
									href="javascript:callFunction('ops_limitmaster.jsp')"
									class="blackfont"><font size="1" face="MS Sans Serif">Limit
								Master</font></a></b></td>
							</tr>
							<tr>
								<td width="65%"><b> <a
									href="javascript:callWorkflow('setprdworkflowcom.jsp')"
									class="blackfont"><font size="1" face="MS Sans Serif">Flow
								points</font></a></b></td>
							</tr>
							<tr>
								<td width="65%"><b> <a
									href="javascript:callFunction('ops_processcharge.jsp')"
									class="blackfont"><font size="1" face="MS Sans Serif">Charges</font></a></b></td>
							</tr>
							<tr>
								<td width="35%"><b><a
									href="javascript:callFunction('facilitiesdoc.jsp')"
									class="blackfont"><font size="1" face="MS Sans Serif">Documents</font></a></b></td>
							</tr>

						</table>
						</fieldset>
						</td>

						<td valign="top" width="50%">
						<fieldset style="width:230;background-color:#DEDACF">
						<table width="100%" border="0" cellspacing="2" cellpadding="5"
							align="center">
							<tr>
								<td width="35%"><b><a
									href="javascript:callFunction('setcomtermscondition.jsp')"
									class="blackfont"><font size="1" face="MS Sans Serif">Terms and
								Conditions</font></a></b></td>
							</tr>
							<tr>
								<td width="35%"><b><a
									href="javascript:callFunction('ops_interest.jsp')"
									class="blackfont"><font size="1" face="MS Sans Serif">Interest</font></a></b></td>
							</tr>
							<tr>
								<td width="35%"><b><a
									href="javascript:callFunction('ops_margin.jsp')"
									class="blackfont"><font size="1" face="MS Sans Serif">Margin</font></a></b></td>
							</tr>

							<tr>
								<td width="35%" no wrap><b><a
									href="javascript:callFunction('set_govtspons_parameters.jsp')"
									class="blackfont"><font size="1" face="MS Sans Serif">Govt.
								Sponsor Schemes Parameter</font></a></b></td>
							</tr>


						</table>

						</fieldset>
						</td>
					</tr>
				</table>
				</fieldset>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<div align="center"><BR>
<table border="0" cellspacing="0" cellpadding="4"
	bordercolorlight="#EBEBF8" bordercolordark="#82829F">
	<tr>
		<td>
		<fieldset>
		<table border="0" cellspacing="0" cellpadding="3" align="center">
			<tr>
				<td width="46%" bordercolor="#993300">
				<div align="center"><font size="1" face="MS Sans Serif"> <input
					type="button" name="cmdexit" value="Close"
					style="background-color:#CC3300;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold"
					onclick="callFunction('setupnav.jsp','','')"> </font></div>
				</td>
			</tr>
		</table>
		</fieldset>
		</td>
	</tr>
</table>
<INPUT TYPE="hidden" NAME="hidPage"> <INPUT TYPE="hidden"
	NAME="hidusr_id"> <INPUT
	TYPE="hidden" NAME="hidBeanGetMethod" VALUE=""> <INPUT TYPE="hidden"
	NAME="hidBeanId" VALUE=""> <input type="hidden" name="newmode"
	value="Y"> <input type="hidden" name="prdtype" value="T"></div>
</form>
</body>
</html>
