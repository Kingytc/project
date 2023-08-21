<%@include file="../share/directives.jsp"%>
<%
String proposalfrmt=Helper.correctNull((String)hshValues.get("com_format"));
String strMCLRFlag=Helper.correctNull((String)hshValues.get("strMCLRFlag"));
String strECFlag="N";
String strCreatedDate=Helper.correctNull((String)hshValues.get("strCreatedDate"));
if(strCreatedDate.equalsIgnoreCase(""))
	strCreatedDate=Helper.getCurrentDateTime();
long lngDatediff=Helper.dateDiff("06/06/2020",strCreatedDate);
if(lngDatediff>=0 && (proposalfrmt.equalsIgnoreCase("1")||proposalfrmt.equalsIgnoreCase(""))){
	strECFlag="Y";
}
%>
<html>
<head>
<title>Executive Summary </title>
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
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var varDDRAppFlag="<%=Helper.correctNull((String)hshValues.get("strDDRAppFlag"))%>";
var varDDRGeneralInfo="<%=Helper.correctInt((String) hshValues.get("strDDRGeneralInfo"))%>";
var varAmtFrom="<%=Helper.correctInt((String) hshValues.get("com_amountvalue"))%>";
var varTermflag="<%=Helper.correctInt((String) hshValues.get("app_termflag"))%>";
var strgeclavailable="<%=Helper.correctInt((String) hshValues.get("strgeclavailable"))%>";
var strDPN2020="<%=Helper.correctInt((String) hshValues.get("strDPN2020"))%>";
var varMMithra="<%=Helper.correctInt((String) hshValues.get("strMMithra"))%>";
var varSvanidh="<%=Helper.correctInt((String) hshValues.get("strSvanidh"))%>";
var varcgssd="<%=Helper.correctInt((String) hshValues.get("strCgssd"))%>";
var varECBoardFlag="<%=strECFlag%>";
var varProposalFormat="<%=proposalfrmt%>";
function placevalues()
{
	enableButtons(true,true,true,true,true,true);
	
}

function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;	
}
function callProcessNote()
{
	var com_appno = document.forms[0].hidAppNo.value;
	var com_appid = document.forms[0].hidDemoId.value;
	var pgname="PN";
	if(varECBoardFlag=="Y")
	{
		var purl 	= "<%=ApplicationParams.getAppUrl()%>action/com_ProcessnoteNew.jsp?hidBeanGetMethod=getProcessNote&hidBeanId=lapsReport&appno="+com_appno+"&appid="+com_appid+"&pgname=ECNew";
	}
	else
	{
		var purl 	= "<%=ApplicationParams.getAppUrl()%>action/com_Processnote.jsp?hidBeanGetMethod=getProcessNote&hidBeanId=lapsReport&appno="+com_appno+"&appid="+com_appid+"&pgname="+pgname;	
	}
	var title 	= "ProcessNote";
	var prop 	= "scrollbars=yes,width=1200,height=550,menubar=yes";
	var xpos 	= 5;
	var ypos 	= 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}
function callProposalLC()
{
	var com_appno = document.forms[0].hidAppNo.value;
	var com_appid = document.forms[0].hidDemoId.value;
	var pgname="PN";
	var purl 	= "<%=ApplicationParams.getAppUrl()%>action/com_proposalLC.jsp?hidBeanGetMethod=getProposalLC&hidBeanId=lapsReport&appno="+com_appno+"&appid="+com_appid;
	var title 	= "ProposalForLC";
	var prop 	= "scrollbars=yes,width=1200,height=550,menubar=yes";
	var xpos 	= 5;
	var ypos 	= 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}
function callRenewalProcessNote()
{
	var com_appno = document.forms[0].hidAppNo.value;
	var com_appid = document.forms[0].hidDemoId.value;
	var pgType = "RPN";
	var pgname = "RPN";
	var purl 	= "<%=ApplicationParams.getAppUrl()%>action/com_RenewalProcessNote.jsp?hidBeanGetMethod=getRenewalProcessNote&hidBeanId=compro&appno="+com_appno+"&appid="+com_appid+"&pgType="+pgType+"&pgname="+pgname;
	var title 	= "ProposalForLC";
	var prop 	= "scrollbars=yes,width=1200,height=550,menubar=yes";
	var xpos 	= 5;
	var ypos 	= 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}
function callProposalMCFD()
{
	var com_appno = document.forms[0].hidAppNo.value;
	var com_appid = document.forms[0].hidDemoId.value;
	var pgType = "MCFD";
	var pgname="PN";
	var purl 	= "<%=ApplicationParams.getAppUrl()%>action/com_proposalMCFD.jsp?hidBeanGetMethod=getProcessNote&hidBeanId=lapsReport&appno="+com_appno+"&appid="+com_appid+"&pgType="+pgType+"&pgname="+pgname;
	var title 	= "ProposalForMCFD";
	var prop 	= "scrollbars=yes,width=1200,height=550,menubar=yes";
	var xpos 	= 5;
	var ypos 	= 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}
function callAnnexure(val)
{
	var com_appno = document.forms[0].hidAppNo.value;
	var com_appid = document.forms[0].hidDemoId.value;
	var purl	= "";var title	= ""; var Flag = "Y";

	if(val=="1")
	{
		purl	= "<%=ApplicationParams.getAppUrl()%>action/com_AnnexureI.jsp?hidBeanGetMethod=getAnnexureI&hidBeanId=commdocument&appno="+com_appno+"&appid="+com_appid+"&strFormat="+varECBoardFlag;
		title	= "AnnexureI";
	}
	else if(val=="2")
	{
		purl	= "<%=ApplicationParams.getAppUrl()%>action/com_AnnexureII.jsp?hidBeanGetMethod=getAnnexureII&hidBeanId=commdocument&appno="+com_appno+"&appid="+com_appid;
		title	= "AnnexureII";
	}
	else if(val=="3")
	{
		purl	= "<%=ApplicationParams.getAppUrl()%>action/com_AnnexureIII.jsp?hidBeanGetMethod=getAnnexureIII&hidBeanId=commdocument&appno="+com_appno+"&appid="+com_appid+"&strFormat="+varECBoardFlag;
		title	= "AnnexureIII";
	}
	else if(val=="4")
	{
		purl	= "<%=ApplicationParams.getAppUrl()%>action/com_AnnexureIV.jsp?hidBeanGetMethod=getAnnexureIV&hidBeanId=commdocument&appno="+com_appno+"&appid="+com_appid;
		title	= "AnnexureIV";
	}
	else if(val=="5")
	{
		purl	= "<%=ApplicationParams.getAppUrl()%>action/com_AnnexureV.jsp?hidBeanGetMethod=getAnnexureV&hidBeanId=commdocument&appno="+com_appno+"&appid="+com_appid+"&strFormat="+Flag;
		title	= "AnnexureV";
	}
	else if(val=="6")
	{
		purl	= "<%=ApplicationParams.getAppUrl()%>action/com_AnnexureVI.jsp?hidBeanGetMethod=getAnnexureVI&hidBeanId=commdocument&appno="+com_appno+"&appid="+com_appid;
		title	= "AnnexureVI";
	}
	else if(val=="7")
	{
		purl	= "<%=ApplicationParams.getAppUrl()%>action/com_AnnexureVII.jsp?hidBeanGetMethod=getAnnexureVII&hidBeanId=commdocument&appno="+com_appno+"&appid="+com_appid;
		title	= "AnnexureVII";
	}

	else if(val=="9")
	{
		purl	= "<%=ApplicationParams.getAppUrl()%>action/com_AnnexureIX.jsp?hidBeanGetMethod=getAnnexureIX_Print&hidBeanId=commdocument&appno="+com_appno+"&appid="+com_appid+"&strFormat=AN9";
		title	= "AnnexureIX";
	}

	else if(val=="10")
	{
		purl	= "<%=ApplicationParams.getAppUrl()%>action/com_Annexure.jsp?hidBeanGetMethod=getAnnexure&hidBeanId=commdocument&appno="+com_appno+"&appid="+com_appid;
		title	= "Annexure";
	}
	else if(val=="11")
	{
		purl	= "<%=ApplicationParams.getAppUrl()%>action/com_AnnexureVII.jsp?hidBeanGetMethod=getAnnexureVII&hidBeanId=commdocument&appno="+com_appno+"&appid="+com_appid+"&annxFlag="+Flag;
		title	= "AnnexureIII";
	}
	else if(val=="12")
	{
		purl	= "<%=ApplicationParams.getAppUrl()%>action/com_AnnexureVI.jsp?hidBeanGetMethod=getAnnexureVI&hidBeanId=commdocument&appno="+com_appno+"&appid="+com_appid+"&annxFlag="+Flag;
		title	= "AnnexureII";
	}
	else if(val=="13")
	{
		purl	= "<%=ApplicationParams.getAppUrl()%>action/com_AnnexureIX.jsp?hidBeanGetMethod=getAnnexureIX_Print&hidBeanId=commdocument&appno="+com_appno+"&appid="+com_appid+"&strFormat=EAN9&annxFlag="+Flag;
		title	= "AnnexureIV";
	}
	else if(val=="14")
	{
		purl	= "<%=ApplicationParams.getAppUrl()%>action/com_AnnexureIV.jsp?pagefrom=annx&hidBeanGetMethod=getAnnexureIV&hidBeanId=commdocument&appno="+com_appno+"&appid="+com_appid;
		title	= "AnnexureIV";
	}
	else if(val=="15")
	{
		purl	= "<%=ApplicationParams.getAppUrl()%>action/com_MCLRAnnexure.jsp?pagefrom=annx&hidBeanGetMethod=getMCLRAnnexure&hidBeanId=commdocument&appno="+com_appno+"&appid="+com_appid;
		title	= "AnnexureIV";
	}
	else if(val=="16")
	{
		purl	= "<%=ApplicationParams.getAppUrl()%>action/com_roiannexure.jsp?pagefrom=ecannx8&hidBeanGetMethod=getECBoardAnnexureVIII&hidBeanId=executive&appno="+com_appno+"&strFormat=EAN8";
		title	= "AnnexureIV";
	}
	else if(val=="17")
	{
		purl	= "<%=ApplicationParams.getAppUrl()%>action/com_roiannexure.jsp?pagefrom=ecannx6&hidBeanGetMethod=getECBoardAnnexureVIII&hidBeanId=executive&appno="+com_appno+"&strFormat=EAN6";
		title	= "AnnexureIV";
	}
	else if(val=="18")
	{
		purl	= "<%=ApplicationParams.getAppUrl()%>action/com_AnnexureIX.jsp?hidBeanGetMethod=getAnnexureIX_Print&hidBeanId=commdocument&appno="+com_appno+"&appid="+com_appid+"&strFormat=EAN9";
		title	= "AnnexureIX";
	}
	else if(val=="19")
	{
		purl	= "<%=ApplicationParams.getAppUrl()%>action/com_Annexure.jsp?hidBeanGetMethod=getAnnexureIX_Print&hidBeanId=commdocument&appno="+com_appno+"&appid="+com_appid+"&strFormat=EAN4";
		title	= "AnnexureIX";
	}
	else if(val=="20")
	{
		purl	= "<%=ApplicationParams.getAppUrl()%>action/com_ECAnnexureII.jsp?pagefrom=ecannx2&hidBeanGetMethod=getECBoardAnnexureVIII&hidBeanId=executive&appno="+com_appno+"&strFormat=EAN2";
		title	= "AnnexureIX";
	}
	else if(val=="25")
	{
		purl	= "<%=ApplicationParams.getAppUrl()%>action/com_resturctur_annexure.jsp?hidBeanGetMethod=getRestruceAnnexure&hidBeanId=appraisal&appno="+com_appno+"&appid="+com_appid;
		title	= "AnnexureIX";
	}
	
	var prop 	= "scrollbars=yes,width=1200,height=550,menubar=yes";
	var xpos 	= 5;
	var ypos 	= 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}
function showpage1(url,method)
{
	document.forms[0].hidBeanId.value="executive" ;
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
	document.forms[0].submit();
}
function callProposalShort()
{
	var com_appno = document.forms[0].hidAppNo.value;
	var com_appid = document.forms[0].hidDemoId.value;
	var pgType = "Shortnte";
	if(varProposalFormat=="7")
	{
		var purl 	= "<%=ApplicationParams.getAppUrl()%>action/com_ECLGS_processnote.jsp?hidBeanGetMethod=getProposalLC&hidBeanId=lapsReport&appno="+com_appno+"&appid="+com_appid+"&pgType="+pgType;
	}
	else if(varProposalFormat=="8")
	{
		var purl 	= "<%=ApplicationParams.getAppUrl()%>action/com_DPNProcessnote.jsp?hidBeanGetMethod=getProposalLC&hidBeanId=lapsReport&appno="+com_appno+"&appid="+com_appid+"&pgType="+pgType;
	}
	else
	{
		var purl 	= "<%=ApplicationParams.getAppUrl()%>action/com_Shortnotes.jsp?hidBeanGetMethod=getProposalLC&hidBeanId=lapsReport&appno="+com_appno+"&appid="+com_appid+"&pgType="+pgType;
	}
	var title 	= "ProposalShort";
	var prop 	= "scrollbars=yes,width=1200,height=550,menubar=yes";
	var xpos 	= 5;
	var ypos 	= 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}

function showKFS(url,method)
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
	document.forms[0].submit();
}

function callOnload()
{
	if(varTermflag=="Y")
	{
		alert("Changes made in Terms & Conditions. \n Kindly revisit and select appropriate conditions for the proposal.");
		document.forms[0].hidBeanId.value="apptermscond" ;
		document.forms[0].hidBeanGetMethod.value="getComFacilityTermData" ;
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comtermsandcond.jsp";
		document.forms[0].submit();
	}
	if(varProposalFormat=="7" || varProposalFormat=="8")
	{
		if((strgeclavailable!="Y" && varProposalFormat=="7")||(strDPN2020!="Y" && varProposalFormat=="8"))
		{
			alert("Kindly modify the proposal format in Basic information tab");
			document.forms[0].hidBeanId.value="comproposal";
			document.forms[0].hidBeanGetMethod.value="getData";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/com_companydet.jsp";
			document.forms[0].submit();
		}
	}
	if(varMMithra=="Y" && varProposalFormat!="5")
	{
		alert("Kindly modify the proposal format in Basic information tab");
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/com_companydet.jsp";
		document.forms[0].submit();
	}
	if(varSvanidh=="Y" && varProposalFormat!="5")
	{
		alert("Kindly modify the proposal format in Basic information tab");
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/com_companydet.jsp";
		document.forms[0].submit();
	}
	if(varcgssd=="Y" && varProposalFormat!="5")
	{
		alert("Kindly modify the proposal format in Basic information tab");
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/com_companydet.jsp";
		document.forms[0].submit();
	}

	if(document.forms[0].hidapplicationType.value == "Restructure")
	{
		document.all.FVCtab.style.display="table-cell";
	}
	else
	{
		document.all.FVCtab.style.display="none";
	}


	if(varECBoardFlag=="Y")
	{
		document.all.idEcBoardformat.style.display="table";
		document.all.idBoardformat.style.display="none";
	}	
	else
	{
		document.all.idBoardformat.style.display="table";
		document.all.idEcBoardformat.style.display="none";
	}
}
function callDDR()
{ 	
	if(varDDRAppFlag=="N")
	{
		alert("Enter all Applicant's Details in  Due Diligence Report -> Due Diligence - Applicant Info tab ");
		return;
	}
	if(varDDRGeneralInfo=="N")
	{
		alert("Enter Details in  Due Diligence Report -> Due Diligence - Security Info tab ");
		return;
	}
	var com_appno = document.forms[0].hidAppNo.value;
	var title = "Due_Diligence_ReportPrint";
	var purl=appURL+"action/Due_Diligence_Report.jsp?hidBeanGetMethod=getdueReportprint&hidBeanId=documentsupport&appno="+com_appno+"&strAmountVal="+varAmtFrom;
	prop='scrollbars=yes,menubar=yes,width=1050,height=620';
	xpos=300;
	ypos=150;
	prop=prop+",xpos="+xpos+",ypos="+ypos;
	window.open(purl,title,prop);
}
</script>

<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
</head>
<body onload="callOnload();">
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
<form name="exec_page1" method ="post" class="normal">

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />

		</jsp:include></td>
	</tr>
	<tr>
	    <%
	    String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	    if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">
			Home -&gt; Agriculture -&gt; Proposal -&gt; Executive Summary</td>
	<%}else{%>
		<td class="page_flow">
			Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Executive Summary 
		</td>
		<%} %>
	</tr>
</table>

 <span style="display:none;"><lapschoice:borrowertype /></span>
  <lapschoice:application/>
 <table width="60%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<tr>
	<td class="sub_tab_inactive" align="center"><a href="JavaScript:showpage1('com_delegation.jsp','getDelegationData')"
			onMouseOut="window.status='';return true;"
			onMouseOver="window.status='Cash Flow';return true;"><b>Proposal Flow</b></a></td>
	<td class="sub_tab_inactive" align="center"><a href="JavaScript:showpage1('com_mdsanctiontoec.jsp','getMDSanctiontoEC')"
			onMouseOut="window.status='Cash Flow';return true;"
			onMouseOver="window.status='Cash Flow';return true;"><b>MD Sanction to EC</b></a></td>
	<td class="sub_tab_active" align="center">Executive Summary</td>
	<%if(Helper.correctNull((String) request.getParameter("appstatus")).equalsIgnoreCase("Processed/Approved")){ %>
	<td class="sub_tab_inactive" align="center"><a href="JavaScript:showKFS('com_keyfactstatement.jsp','getKeyFactStatementData')"
			onMouseOut="window.status='Key Fact Statement';return true;"
			onMouseOver="window.status='Key Fact Statement';return true;"><b>Key Fact Statement</b></a></td>
		<%} %>
		<td id="FVCtab" class="sub_tab_inactive" align="center"><a
			href="JavaScript:showpage1('com_fairvalue_proposal.jsp','')"
			onMouseOut="window.status='';return true;"
			onMouseOver="window.status='FVC';return true;"><b>Fair value Calculation</b></a></td>
	</tr>
</table>

  <lapschoice:hiddentag pageid='<%=PageId%>'/>
  <tr>
  <td><br>
  <table width="30%" border="0" cellspacing="3" cellpadding="3" class="outertable" align="center" id="idBoardformat">
  <%if (proposalfrmt.equalsIgnoreCase("3")){ %>
  <tr><td align="center"><input type="button" name="btn_ProposalForLC" value="Process Note" onclick="callProposalLC();" class="buttonStyle" style="width: 120px"></td></tr>
  <tr><td align="center"><input type="button" name="btn_Annexure" value="Annexure" onclick="callAnnexure('10');" class="buttonStyle" style="width: 120px"></td></tr>
  <%} else if (proposalfrmt.equalsIgnoreCase("4")){ %>
  <tr><td align="center"><input type="button" name="btn_ProposalForMCFD" value="Process Note" onclick="callProposalMCFD();" class="buttonStyle" style="width: 120px"></td></tr>
   <tr><td align="center"><input type="button" name="btn_AnnexureI" value="Annexure I" onclick="callAnnexure('1');" class="buttonStyle" style="width: 120px"></td></tr>
   <tr><td align="center"><input type="button" name="btn_AnnexureVI" value="Annexure II" onclick="callAnnexure('12');" class="buttonStyle" style="width: 120px"></td></tr>
   <tr><td align="center"><input type="button" name="btn_AnnexureVII" value="Annexure III" onclick="callAnnexure('11');" class="buttonStyle" style="width: 120px"></td></tr>
    <tr><td align="center"><input type="button" name="btn_AnnexureVIII" value="Annexure IV" onclick="callAnnexure('13');" class="buttonStyle" style="width: 120px"></td></tr>
  <%}else if (proposalfrmt.equalsIgnoreCase("5")||proposalfrmt.equalsIgnoreCase("7")||proposalfrmt.equalsIgnoreCase("8")){ %>
  <tr><td align="center"><input type="button" name="btn_shortnotes" value="Process Note" onclick="callProposalShort();" class="buttonStyle" style="width: 120px"></td></tr>
  <tr><td align="center"><input type="button" name="btn_Annexure" value="Annexure" onclick="callAnnexure('14');" class="buttonStyle" style="width: 120px"></td></tr>
 <%}else if (proposalfrmt.equalsIgnoreCase("12")){ %>
  <tr><td align="center"><input type="button" name="btn_renewalnote" value="Process note" onclick="callRenewalProcessNote();" class="buttonStyle" style="width: 120px"></td></tr>
  <%}else { %>
  <tr><td align="center"><input type="button" name="btn_AppraisalNote" value="Process Note" onclick="callProcessNote();" class="buttonStyle" style="width:120px"></td></tr>
  <tr><td align="center"><input type="button" name="btn_AnnexureI" value="Annexure I" onclick="callAnnexure('1');" class="buttonStyle" style="width: 120px"></td></tr>
  <tr><td align="center"><input type="button" name="btn_AnnexureII" value="Annexure II" onclick="callAnnexure('2');" class="buttonStyle" style="width: 120px"></td></tr>
  <tr><td align="center"><input type="button" name="btn_AnnexureIII" value="Annexure III" onclick="callAnnexure('3');" class="buttonStyle" style="width: 120px"></td></tr>
  <tr><td align="center"><input type="button" name="btn_AnnexureIV" value="Annexure IV" onclick="callAnnexure('4');" class="buttonStyle" style="width: 120px"></td></tr>
  <tr><td align="center"><input type="button" name="btn_AnnexureV" value="Annexure V" onclick="callAnnexure('5');" class="buttonStyle" style="width: 120px"></td></tr>
  <tr><td align="center"><input type="button" name="btn_AnnexureVI" value="Annexure VI" onclick="callAnnexure('6');" class="buttonStyle" style="width: 120px"></td></tr>
  <tr><td align="center"><input type="button" name="btn_AnnexureVII" value="Annexure VII" onclick="callAnnexure('7');" class="buttonStyle" style="width: 120px"></td></tr>
  
   <tr><td align="center"><input type="button" name="btn_AnnexureVIII" value="Annexure VIII" onclick="callAnnexure('9');" class="buttonStyle" style="width: 120px"></td></tr>
  <%} %>
 
   <%if(strMCLRFlag.equalsIgnoreCase("Y")){ %>
    <tr><td align="center"><input type="button" name="btn_MCLRSM" value="Interest Annexure" onclick="callAnnexure('15');" class="buttonStyle" style="width: 120px"></td></tr>
    <%} %>
    <tr><td align="center"><input type="button" name="btn_DDR" value="Due Diligence Report" onclick="callDDR();" class="buttonStyle" style="width: 120px"></td></tr>
   <!-- <%//if(Helper.correctNull((String)hshValues.get("corprestructureval")).equalsIgnoreCase("Y")) {%>
        <tr><td align="center"><input type="button" name="rest_ann" value="Restructure Annexure" onclick="callAnnexure('25');" class="buttonStyle" style="width: 121px"></td></tr>
  <%//} %> -->
  
  </table>
  <table width="30%" border="0" cellspacing="3" cellpadding="3" class="outertable" align="center" id="idEcBoardformat">
   	<tr><td align="center"><input type="button" name="btn_ecprocessnote" value="Process Note" onclick="callProcessNote();" class="buttonStyle" style="width: 120px"></td></tr>
   	<tr><td align="center"><input type="button" name="btn_ecAnnexureI" value="Annexure I" onclick="callAnnexure('1');" class="buttonStyle" style="width: 120px"></td></tr>
   	<tr><td align="center"><input type="button" name="btn_ecAnnexureII" value="Annexure II" onclick="callAnnexure('20');" class="buttonStyle" style="width: 120px"></td></tr>
   	<tr><td align="center"><input type="button" name="btn_ecAnnexureIII" value="Annexure III" onclick="callAnnexure('3');" class="buttonStyle" style="width: 120px"></td></tr>
  	<tr><td align="center"><input type="button" name="btn_ecAnnexure4" value="Annexure IV" onclick="callAnnexure('19');" class="buttonStyle" style="width: 120px"></td></tr>
  	<tr><td align="center"><input type="button" name="btn_ecAnnexureV" value="Annexure V" onclick="callAnnexure('5');" class="buttonStyle" style="width: 120px"></td></tr>
  	<tr><td align="center"><input type="button" name="btn_ecMCLR" value="Annexure VI" onclick="callAnnexure('17');" class="buttonStyle" style="width: 120px"></td></tr>
  	<tr><td align="center"><input type="button" name="btn_ecAnnexureVII" value="Annexure VII" onclick="callAnnexure('7');" class="buttonStyle" style="width: 120px"></td></tr>
  	<tr><td align="center"><input type="button" name="btn_ecannexure8" value="Annexure VIII" onclick="callAnnexure('16');" class="buttonStyle" style="width: 120px"></td></tr>
  	<tr><td align="center"><input type="button" name="btn_ecAnnexure9" value="Annexure IX" onclick="callAnnexure('18');" class="buttonStyle" style="width: 120px"></td></tr>
  	<%if(strMCLRFlag.equalsIgnoreCase("Y")){ %>
    <tr><td align="center"><input type="button" name="btn_MCLRSM" value="Interest Annexure" onclick="callAnnexure('15');" class="buttonStyle" style="width: 120px"></td></tr>
    <%} %>
    <tr><td align="center"><input type="button" name="btn_DDR" value="Due Diligence Report" onclick="callDDR();" class="buttonStyle" style="width: 120px"></td></tr>
  	 <!--  <%//if(Helper.correctNull((String)hshValues.get("corprestructureval")).equalsIgnoreCase("Y")) {%>
        <tr><td align="center"><input type="button" name="rest_ann" value="Restructure Annexure" onclick="callAnnexure('25');" class="buttonStyle" style="width: 121px"></td></tr>
  <%//} %> -->
  
  </table>
  </td>
  </tr>
  
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String) hshValues.get("hidapplicantid"))%>">
<INPUT TYPE="hidden" name="hidAppNo" VALUE=<%=Helper.correctNull((String) request.getParameter("appno"))%>>
<input type="hidden" name="cmdsave" disabled>
</form>
</body>

</html>