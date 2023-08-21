<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<lapschoice:handleerror />
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
HashMap hshValues1=new HashMap();
	if(hshValues!=null)
	{
		hshValues1=(HashMap)hshValues.get("hshSHGCorpus");	
	}
	
	String strapptype = "";
	String apptype = "";
	String app_status = Helper.correctNull((String) hshValues
			.get("app_status"));

	String prd_type = Helper.correctNull((String) session
			.getAttribute("strProductType"));
	java.text.NumberFormat nf = java.text.NumberFormat
			.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);

	String strDosevalue = Helper.correctNull((String) session
			.getAttribute("strDose"));
	String strbalanceamt="0.00", stramtlent="0.00", strinterest="0.00", strfundgovt="0.00", strtotal="0.00", strmonthlysave="0.00",
	strloanoutstand="0.00", strrecoverperf="0.00", strlevelofsavg="0.00", strvelofsavg="0.00";
	if(hshValues1!=null)
	{
	if(!Helper.correctNull((String) hshValues1.get("balanceamt")).equals("")){
		strbalanceamt=nf.format(FwHelper.parseDouble(Helper.correctDouble((String) hshValues1.get("balanceamt"))));
	}
	if(!Helper.correctNull((String) hshValues1.get("amtlent")).equals("")){
		stramtlent=nf.format(FwHelper.parseDouble(Helper.correctDouble((String) hshValues1.get("amtlent"))));
	}
	if(!Helper.correctNull((String) hshValues1.get("interest")).equals("")){
		strinterest=nf.format(FwHelper.parseDouble(Helper.correctDouble((String) hshValues1.get("interest"))));
	}
	if(!Helper.correctNull((String) hshValues1.get("fundgovt")).equals("")){
		strfundgovt=nf.format(FwHelper.parseDouble(Helper.correctDouble((String) hshValues1.get("fundgovt"))));
	}
	if(!Helper.correctNull((String) hshValues1.get("total")).equals("")){
		strtotal=nf.format(FwHelper.parseDouble(Helper.correctDouble((String) hshValues1.get("total"))));
	}
	if(!Helper.correctNull((String) hshValues1.get("monthlysave")).equals("")){
		strmonthlysave=nf.format(FwHelper.parseDouble(Helper.correctDouble((String) hshValues1.get("monthlysave"))));
	}
	if(!Helper.correctNull((String) hshValues1.get("loanoutstand")).equals("")){
		strloanoutstand=nf.format(FwHelper.parseDouble(Helper.correctDouble((String) hshValues1.get("loanoutstand"))));
	}
	if(!Helper.correctNull((String) hshValues1.get("recoverperf")).equals("")){
		strrecoverperf=nf.format(FwHelper.parseDouble(Helper.correctDouble((String) hshValues1.get("recoverperf"))));
	}
	if(!Helper.correctNull((String) hshValues1.get("levelofsavg")).equals(""))
	{
		strlevelofsavg=nf.format(FwHelper.parseDouble(Helper.correctDouble((String) hshValues1.get("levelofsavg"))));
	}
	if(!Helper.correctNull((String) hshValues1.get("velofsavg")).equals("")){
		strvelofsavg=nf.format(FwHelper.parseDouble(Helper.correctDouble((String) hshValues1.get("velofsavg"))));
	}
	}
	
	String schemetype="";
	schemetype = Helper.correctNull((String) request.getParameter("schemetype"));

	String cattype = Helper.correctNull((String) request.getParameter("cattype"));
	String applevel = Helper.correctNull((String) request.getParameter("applevel"));
	//System.out.println("applevel==="+applevel);			
	cattype = Helper.correctNull((String) request.getParameter("cattype1"));
	if (cattype.equals(""))
	{
		cattype = Helper.correctNull((String) session.getAttribute("cattype"));
	}
	String ssitype = (String) request.getParameter("ssitype");
	if (ssitype.equalsIgnoreCase("")) {
		ssitype = Helper.correctNull((String) hshValues	.get("hidSSIType"));
	}
	String strType = Helper.correctNull((String) session.getAttribute("link"));
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	
%><%@page import="com.sai.fw.management.utils.FwHelper"%>
<html>
<head>
<title>Corpus of the Group</title>
<style>
.divCellContainer {
	width: 100%;
	height: 100px;
	overflow: auto;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>

<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var txt_totalcumulative="<%=Helper.correctDouble((String) hshValues.get("totalcumulative"))%>";
var varschemetype="<%=schemetype%>";
function doSave()
{ 
	calculateTotal();
	calculateLevelOfsavings();
	calcVelocityOfLending();
	document.forms[0].txt_levelofsavg.readOnly =false;
	document.forms[0].txt_total.readOnly =false;
	document.forms[0].txt_veloflending.readOnly =false;
	disableCommonButtons(true, true, true, true, false);	
	document.forms[0].hidBeanId.value="agrSHGloan";
	document.forms[0].hidSourceUrl.value="/action/agrSHGcorpusofgroup.jsp";
	document.forms[0].hidBeanMethod.value="updateSHGCorpusDetails";
	document.forms[0].hidBeanGetMethod.value="getSHGCorpusDetails";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{
	disabledFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommonButtons(true, false, false, true, false);	
	document.forms[0].txt_levelofsavg.readOnly =true;
	document.forms[0].txt_total.readOnly =true;
	document.forms[0].txt_veloflending.readOnly =true;	
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getSHGCorpusDetails";
		document.forms[0].hidBeanId.value="agrSHGloan";
		document.forms[0].action=appUrl+"action/agrSHGcorpusofgroup.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].txt_levelofsavg.readOnly =false;
		document.forms[0].txt_total.readOnly =false;
		document.forms[0].txt_veloflending.readOnly =false;
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanId.value="agrSHGloan";
		document.forms[0].hidSourceUrl.value="action/agrSHGcorpusofgroup.jsp";	
		document.forms[0].hidBeanMethod.value="updateSHGCorpusDetails";
		document.forms[0].hidBeanGetMethod.value="getSHGCorpusDetails";
		document.forms[0].submit();		
	}
}	

function disableCommonButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function onloading()
{	  
	disableCommonButtons(false, true, true, false, false);
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=varschemetype;
}	

function callOtherTab()
{
	if(document.forms[0].cmdEdit.disabled == true && document.forms[0].cmdApply.disabled != true)
	{
		ShowAlert(103);
	}
	else
	{
    	document.forms[0].hidBeanId.value="agrSHGloan"; 
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_shgfinanceposition.jsp?hidBeanGetMethod=getSHGFinancePositionDetails";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}

function callLink(page)
{	
	//document.forms[0].hidAction.value="";
	document.forms[0].hidBeanGetMethod.value="getSHGFinancePositionDetails";
	document.forms[0].hidBeanId.value="agrSHGloan";
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit();
}

function calculateTotal()
{
	document.forms[0].txt_total.value = parseFloat(document.forms[0].txt_balamt.value)+
    										 parseFloat(document.forms[0].txt_amtlent.value)+
											 parseFloat(document.forms[0].txt_interest.value)+
											 parseFloat(document.forms[0].txt_fundgovt.value);
	document.forms[0].txt_total.value=NanNumber(document.forms[0].txt_total.value);
	roundtxt(document.forms[0].txt_total);
}

function calculateLevelOfsavings()
{
	var noofmonths="<%=Helper.correctNull((String) hshValues.get("noofmonths"))%>";
	var totalmembers="<%=Helper.correctNull((String) hshValues.get("totmembers"))%>";

	document.forms[0].txt_levelofsavg.value = parseFloat(txt_totalcumulative)/
												(parseFloat(noofmonths) * parseFloat(totalmembers) * parseFloat(document.forms[0].txt_monthlysavg.value));

	if(parseFloat(noofmonths)==0 || parseFloat(totalmembers)==0 ||  parseFloat(document.forms[0].txt_monthlysavg.value)==0)
	{
		document.forms[0].txt_levelofsavg.value=0.00;
	}
	else
	{
		document.forms[0].txt_levelofsavg.value=NanNumber(document.forms[0].txt_levelofsavg.value);
	}
	roundtxt(document.forms[0].txt_levelofsavg); 
}

function calcVelocityOfLending()
{
	if(txt_totalcumulative!="0.00")
	{
		document.forms[0].txt_veloflending.value  = parseFloat(document.forms[0].txt_loanoutstdg.value) / parseFloat(txt_totalcumulative);
		document.forms[0].txt_veloflending.value=NanNumber(document.forms[0].txt_veloflending.value);
		roundtxt(document.forms[0].txt_veloflending);
	}
}
function disabledFields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  

	}
	
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
DIV.cellContainer {
	width: 100%;
	height: 250;
	overflow: auto;
}
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading()">
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
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="999" />
			<jsp:param name="cattype" value="<%=cattype%>" />
			<jsp:param name="ssitype" value="<%=ssitype%>" />
		</jsp:include></td>
	</tr>
</table>
<table>
	
	<tr>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Group Finance - &gt; Corpus Of The Group</td>
	</tr>
	
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="64" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
	
			
		</jsp:include></td>
	</tr>
</table>

<table width="50%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable border1">
	<tr>
		<td>Balance amount in SB account</td>
		<td WIDTH="41%"><lapschoice:CurrencyTag name="txt_balamt"
			maxlength="15" tabindex="1" size="15"
			onKeyPress="allowDecimals(this)" style="text-align:right"
			value="<%=strbalanceamt%>"
			onBlur="roundtxt(this);calculateTotal();" other="readOnly" /></td>
	</tr>
	<tr>
		<td WIDTH="59%">Amount internally lent</td>
		<TD WIDTH="41%"><lapschoice:CurrencyTag name="txt_amtlent"
			maxlength="15" tabindex="2" size="15"
			onKeyPress="allowDecimals(this)" style="text-align:right"
			value="<%=stramtlent%>"
			onBlur="roundtxt(this);calculateTotal();" other="readOnly" /></TD>
	</tr>
	<tr>
		<td WIDTH="59%">Interest from members</td>
		<TD WIDTH="41%"><lapschoice:CurrencyTag name="txt_interest"
			maxlength="15" tabindex="3" size="15"
			onKeyPress="allowDecimals(this)" style="text-align:right"
			value="<%=strinterest%>"
			onBlur="roundtxt(this);calculateTotal();" other="readOnly" /></TD>
	</tr>
	<tr>
		<td WIDTH="59%">Grants/ donations/ funds from Govt.</td>
		<TD WIDTH="41%"><lapschoice:CurrencyTag name="txt_fundgovt"
			maxlength="15" tabindex="4" size="15"
			onKeyPress="allowDecimals(this)" style="text-align:right"
			value="<%=strfundgovt%>"
			onBlur="roundtxt(this);calculateTotal();" other="readOnly" /></TD>
	</tr>
	<tr>
		<td WIDTH="59%">TOTAL</td>
		<TD WIDTH="41%"><lapschoice:CurrencyTag name="txt_total"
			maxlength="15" size="15" onKeyPress="allowDecimals(this)"
			style="text-align:right"
			value="<%=strtotal%>"
			onBlur="roundtxt(this)" other="readOnly" /></TD>
	</tr>
	<tr>
		<td WIDTH="59%">Monthly Savings</td>
		<TD WIDTH="41%"><lapschoice:CurrencyTag name="txt_monthlysavg"
			maxlength="15" tabindex="5" size="15"
			onKeyPress="allowDecimals(this)" style="text-align:right"
			value="<%=strmonthlysave%>"
			onBlur="roundtxt(this);calculateLevelOfsavings();" other="readOnly" /></TD>
	</tr>
	<tr>
		<td WIDTH="59%">Total Loans Outstanding</td>
		<TD WIDTH="41%"><lapschoice:CurrencyTag name="txt_loanoutstdg"
			maxlength="15" tabindex="6" size="15"
			onKeyPress="allowDecimals(this)" style="text-align:right"
			value="<%=strloanoutstand%>"
			onBlur="roundtxt(this);calculateLevelOfsavings();calcVelocityOfLending();"
			other="readOnly" /></TD>
	</tr>

	<tr>
		<td WIDTH="59%">Recovery Performance within the Group</td>
		<TD WIDTH="41%"><lapschoice:CurrencyTag name="txt_recoveryperf"
			maxlength="15" tabindex="7" size="15"
			onKeyPress="allowDecimals(this)" style="text-align:right"
			value="<%=strrecoverperf%>"
			onBlur="roundtxt(this);checkPercentage(this);" other="readOnly" /> %</TD>
	</tr>
	<tr>
		<td WIDTH="59%">Level of Savings</td>
		<TD WIDTH="41%"><lapschoice:CurrencyTag name="txt_levelofsavg"
			maxlength="15" tabindex="8" size="15"
			onKeyPress="allowDecimals(this)" style="text-align:right"
			value="<%=strlevelofsavg%>"
			onBlur="roundtxt(this)" other="readOnly" /></TD>
	</tr>
	<tr>
		<td WIDTH="59%">Velocity of Lending</td>
		<TD WIDTH="41%"><lapschoice:CurrencyTag name="txt_veloflending"
			maxlength="15" tabindex="9" size="15"
			onKeyPress="allowDecimals(this)" style="text-align:right"
			value="<%=strvelofsavg%>"
			onBlur="roundtxt(this)" other="readOnly" /></TD>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
 <input
	type="hidden" name="hidAction" value=""> <input type="hidden"
	name="hidBeanId" value=""> <input type="hidden"
	name="hidBeanMethod" value=""> <input type="hidden"
	name="hidBeanGetMethod" value=""> <input type="hidden"
	name="hidSourceUrl" value=""> <input type="hidden"
	name="hidApp_type" value="A"> <input type="hidden" name="page"
	value=""> <INPUT TYPE="hidden" name="trapEdit"
	value="<%=Helper.correctNull((String) hshValues.get("trapEdit"))%>">
<INPUT TYPE="hidden" name="hidEditMode"
	value="<%=Helper.correctNull((String) hshValues.get("hidEditMode"))%>">
<input type="hidden" name="hidDemoId"
	value="<%=request.getParameter("hidDemoId")%>"> <input
	type="hidden" name="hidAppType"
	value="<%=Helper.correctNull((String) hshValues.get("hidAppType"))%>">
	<!--<input type="hidden" name="appno" value="<%=Helper.correctNull((String)request.getParameter("appno"))%>">
--></form>
</body>
</html>