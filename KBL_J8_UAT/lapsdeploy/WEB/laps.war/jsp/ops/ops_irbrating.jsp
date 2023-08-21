<%@ page import="com.sai.laps.helper.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%String strSSIType = Helper.correctNull((String) request
					.getParameter("hidSSIType"));
			String strCategoryType = Helper.correctNull((String) request
					.getParameter("hidCategoryType"));
			String strPage = Helper.correctNull((String) hshValues.get("page"));
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"	type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript">

var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";

function callload() 
{
}

function calclose()
{
	var varconfirm=ConfirmMsg('100');
	if(varconfirm)
	{
		document.forms[0].action=appUrl+"action/agrborrowersearch.jsp";
		document.forms[0].submit();
	}
}


function callLink(page,bean,method)
{
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit();
}


function doramdetails()
{
 	var varQryString = appURL+"action/ramparameters.jsp?controllerservlet&hidBeanGetMethod=getRAMParameters&hidBeanId=LapsToRam&comapp_appno="+document.forms[0].appno.value+"&type="+document.forms[0].cattype.value;
	var title = "Ramdetails";
	var prop = "scrollbars=no,menubar=no,width=600,height=350";
	prop = prop + ",left=200,top=150";
    window.open(varQryString,title,prop);	
}

function callAssess(page,flowtype)
{		
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].pageval.value=flowtype;
	document.forms[0].hidBeanId.value="ADV1151";
	document.forms[0].hidBeanGetMethod.value="getDataFinancials";	
	document.forms[0].submit();	 
}

</SCRIPT>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" margin onload="callload()">
<!--<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
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
-->
<form name="finForm" action="" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td valign="top" colSpan=5><jsp:include page="../share/menus.jsp" flush="true"/>
	 <jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="13" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<b><i>Home-&gt;
Tertiary-&gt; Proposal-&gt; IRB Details</i></b> <br>
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="1" cellspacing="0" cellpadding="5"
	bgcolor="#DEDACF" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
	align="center">
	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="5"
			bgcolor="#DEDACF" bordercolorlight="#8F8369"
			bordercolordark="#FFFFFB" align="center">
			<tr>
				<td align="center">
				<table width="100%" border="0" cellspacing="3" cellpadding="2">
					<tr>
						<%if (strPage.trim().equals("FI")) {

			%>
						<td width="15%" height="20" bgcolor="#71694F">
						<div align="center"><font face="Arial, Helvetica, sans-serif"
							size="2"><b>Financials</b></div>
						</td>
						<%} else {

			%>
						<td width="15%" height="20">
						<div align="center"><font face="Arial, Helvetica, sans-serif"
							size="2"><b><a
							href="javascript:callAssess('adv_financials.jsp','FI')"
							class="blackfont">Financials</a></b></div>
						</td>
						<%}

			%>
						<%if (strPage.trim().equals("RA")) {

			%>
						<td width="15%" height="20" bgcolor="#71694F">
						<div align="center"><font face="Arial, Helvetica, sans-serif"
							size="2"><b>Ratios</b></div>
						</td>
						<%} else {

			%>
						<td width="15%" height="20">
						<div align="center"><font face="Arial, Helvetica, sans-serif"
							size="2"><b><a
							href="javascript:callAssess('adv_financials.jsp','RA')"
							class="blackfont">Ratios</a></b></div>
						</td>
						<%}

			%>
						<%--
				if(strPage.trim().equals("CAA"))
				{
			%>
            <td width="15%" height="20" bgcolor="#71694F"> 
              <div align="center"b>ASSETS</b></div>
            </td>
            <% }
				else
				{
			%>
            <td width="15%" height="20"> 
              <div align="center"b><a href="javascript:callAssess('adv_financials.jsp','CAA')" class="blackfont">ASSETS</a></b></div>
            </td>
            <%
				}
			--%>
						<%if (strPage.trim().equals("MPBF1")) {

			%>
						<td width="15%" height="20" bgcolor="#71694F">
						<div align="center"><font face="Arial, Helvetica, sans-serif"
							size="2"><b>WORKING
						CAPITAL</b></div>
						</td>
						<%} else {

			%>
						<td width="15%" height="20">
						<div align="center"><font face="Arial, Helvetica, sans-serif"
							size="2"><b><a
							href="javascript:callAssess('adv_financials.jsp','MPBF1')"
							class="blackfont">WORKING CAPITAL</a></b></div>
						</td>
						<%}

			%>
						<%if (strPage.trim().equals("FU")) {

			%>
						<td width="15%" height="20" bgcolor="#71694F">
						<div align="center"><font face="Arial, Helvetica, sans-serif"
							size="2"><b>Fund
						Flow</b></div>
						</td>
						<%} else {

			%>
						<td width="15%" height="20">
						<div align="center"><font face="Arial, Helvetica, sans-serif"
							size="2"><b><a
							href="javascript:callAssess('adv_fundflow.jsp','FU')"
							class="blackfont">Fund Flow</a></b></div>
						</td>
						<%}

			%>
						<%if (strPage.trim().equals("RATING")) {

			%>
						<td width="15%" height="20" bgcolor="#71694F">
						<div align="center"><font face="Arial, Helvetica, sans-serif"
							size="2"><b>IRB
						Details</b></div>
						</td>
						<%} else {

			%>
						<td width="15%" height="20">
						<div align="center"><font face="Arial, Helvetica, sans-serif"
							size="2"><b><a
							href="javascript:callRating('ops_irbrating.jsp','RATING')"
							class="blackfont">IRB Details</a></b></div>
						</td>
						<%}

			%>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<table width="100%" border="1" cellspacing="0" cellpadding="3"
			bgcolor="#DEDACF" bordercolorlight="#8F8369"
			bordercolordark="#FFFFFB" align="center" HEIGHT="249">
			<tr align="center">
				<td><INPUT TYPE="button" NAME="ramdetails" VALUE="IRB Details"
					STYLE="width:250" CLASS="buttoncolor" ONCLICK="doramdetails()"> <INPUT
					TYPE="button" NAME="cmdapply" VALUE="Save"
					STYLE="visibility:hidden;" disabled="disabled"></td>
			</tr>
			<tr align="center">
				<td><input type="button" name="cmdClose" value="Close"
					class="buttonClose"
					onClick="calclose()"></td>
			</tr>
		</table>
	<tr>
		<td>
</table>

<input type="hidden" name="hidAction"> 
<input type="hidden" name="hidBeanId" value=""> 
<input type="hidden" name="hidBeanMethod" value=""> 
<input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidSourceUrl" value=""> 
<input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
<input type="hidden" name="pageval" value="<%=Helper.correctNull((String)hshValues.get("pageval"))%>">
</form>
</body>
</html>


