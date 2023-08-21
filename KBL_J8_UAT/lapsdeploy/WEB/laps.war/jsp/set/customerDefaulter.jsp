<%@include file="../share/directives.jsp"%>
<%HashMap hshRecord = (HashMap) hshValues.get("hshRecord");
java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);
String pageid = Helper.correctNull((String) request.getParameter("pageid"));
String strEmployment=(String)session.getAttribute("strEmployment");
String strModuleName = Helper.correctNull(request
		.getParameter("hidModuleName"));
String strModName = "";
if (strModuleName.equalsIgnoreCase("T")) {
	strModName = "Tertiary";
} else if (strModuleName.equalsIgnoreCase("P")) {
	strModName = "Retail";
} else {
	strModName = "Corporate & SME";
}
String strProfilestatus = Helper.correctNull((String) hshValues
		.get("strProfilestatus"));
String hidfacname=Helper.correctNull(request.getParameter("hidfacname"));
String strPageName=Helper.correctNull((String)hshValues.get("strIncompletepage"));

String strapptype = Helper.correctNull((String)request.getParameter("corp"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String strAppId = Helper.correctNull((String)hshValues.get("applicantId"));

%>
<html>
<head>
<title>Rating/Defaulter</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript">
var appURL="<%=ApplicationParams.getAppUrl()%>";
var curdate = "<%=Helper.getCurrentDateTime()%>";
var selrbidefaulter="<%=Helper.correctNull((String) hshValues.get("DEF_RBIDEFIS"))%>";
var selECGCI ="<%=Helper.correctNull((String) hshValues.get("DEF_ECGSEPIS"))%>";
var selWillful ="<%=Helper.correctNull((String) hshValues.get("DEF_WILDEFIS"))%>";
var selExitPloicy ="<%=Helper.correctNull((String) hshValues.get("DEF_EXITPOLIS"))%>";
var appstatus ="<%=Helper.correctNull((String) hshValues.get("appstatus"))%>";
var selSUITFILED ="<%=Helper.correctNull((String) hshValues.get("DEF_SUITFILED"))%>";
var varSMAcategory="<%=Helper.correctNull((String)hshValues.get("cibil_SMACategory"))%>";
var varReferredCRIF="<%=Helper.correctNull((String)hshValues.get("CRIF_REFERED"))%>";
var varReferredEXPERIAN="<%=Helper.correctNull((String)hshValues.get("EXPERIAN_REFERED"))%>";
var varCIBILAutoFlag="<%=Helper.correctNull((String)hshValues.get("cibil_auto_update"))%>";
var varCRIFAutoFlag="<%=Helper.correctNull((String)hshValues.get("crif_auto_update"))%>";
var selProbe ="<%=Helper.correctNull((String) hshValues.get("DEF_PROBE"))%>";
var digiFlag ="<%=Helper.correctNull((String) hshValues.get("digiFlag"))%>";

function callOnload()
{ 
	if(varReferredCRIF!="")
	{
		document.forms[0].sel_referredCRIF.value=varReferredCRIF;
	}
	referredcrif();

	if(varReferredEXPERIAN!="")
	{
		document.forms[0].sel_referredExperian.value=varReferredEXPERIAN;
	}
	referredexperian();
	if(selrbidefaulter =="Y"){
		document.forms[0].sel_RBIDefaulter.value="Y";
	}else if(selrbidefaulter =="N"){
		document.forms[0].sel_RBIDefaulter.value="N";
	}else{
		document.forms[0].sel_RBIDefaulter.value="";
	}

	if(selECGCI =="Y"){
		document.forms[0].sel_ECGCIList.value="Y";
	}else if(selECGCI =="N"){
		document.forms[0].sel_ECGCIList.value="N";
	}else{
		document.forms[0].sel_ECGCIList.value="";
	}

	if(selWillful =="Y"){
		document.forms[0].sel_Willful.value="Y";
	}else if(selWillful =="N"){
		document.forms[0].sel_Willful.value="N";
	}else{
		document.forms[0].sel_Willful.value="";
	}

	if(selExitPloicy =="Y"){
		document.forms[0].sel_Identified.value="Y";
	}else if(selExitPloicy =="N"){
		document.forms[0].sel_Identified.value="N";
	}else{
		document.forms[0].sel_Identified.value="";
	}

	if(selSUITFILED =="Y"){
		document.forms[0].sel_Suitfiled.value="Y";
	}else if(selSUITFILED =="N"){
		document.forms[0].sel_Suitfiled.value="N";
	}else{
		document.forms[0].sel_Suitfiled.value="";
	}	
	
	if(selProbe =="Y"){
		document.forms[0].sel_probe.value="Y";
	}else if(selProbe =="N"){
		document.forms[0].sel_probe.value="N";
	}else{
		document.forms[0].sel_probe.value="";
	}
	
  	calldisable(true);

  	if(document.forms[0].readFlag.value=="r")
	{
		disablecontrols(true,true,true,true,false);
		
	}
	else
	{
  	   if(appstatus=="true")
  	   {
		disablecontrols(true,true,true,true,false);
  	   }
  	  else
  	  {
  		disablecontrols(false,true,true,true,false);
  	  }
	}
	//showRating();
	hidDate();
	var varrefcibil="<%=Helper.correctNull((String)hshValues.get("cibil_rat_status"))%>";
	document.forms[0].sel_refercibil.value=varrefcibil;
	if(varrefcibil=='Y')
	{
	cibildet();
	}
	else
	{		
		document.forms[0].txt_datecibil.value="";
		document.forms[0].txt_cibilComment.value="";
		document.forms[0].txt_cibilscore.value="";
		cibildet();
	}
	document.forms[0].sel_SMAcategory.value=varSMAcategory;
	funSMAcategory();
	

}
function disablecontrols(edit,save,cancel,cdelete,close)
{
	document.forms[0].cmdedit.disabled = edit;
	document.forms[0].cmdsave.disabled = save;
	document.forms[0].cmdcancel.disabled = cancel;
	document.forms[0].cmddelete.disabled = cdelete;
	document.forms[0].cmdclose.disabled = close;
}
function calldisable(val)
{
	for(i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type == "text" )
		{
			document.forms[0].elements[i].disabled = val;
		}
		if(document.forms[0].elements[i].type == "textarea" )
		{
			document.forms[0].elements[i].disabled = val;
		}
		if(document.forms[0].elements[i].type == "select-one" )
		{
			document.forms[0].elements[i].disabled = val;
		}
    }
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mastersearchper.jsp";	
		document.forms[0].submit();
	}
}

function doEdit()
{
	calldisable(false);
	disablecontrols(true,false,false,false,false);
	document.forms[0].hideditflag.value="Y";
	if(varCIBILAutoFlag=="Y")
	{
		document.forms[0].sel_refercibil.disabled=true;
		document.forms[0].txt_cibilscore.readOnly=true;
		document.forms[0].txt_datecibil.readOnly=true;
	}
	if(varCRIFAutoFlag=="Y")
	{
		document.forms[0].sel_referredCRIF.disabled=true;
		document.forms[0].crifscore.readOnly=true;
		document.forms[0].crif_date.readOnly=true;
	}

	if(digiFlag=="Y")
	{
		document.forms[0].txt_cibilscore.readOnly=true;
		document.forms[0].txt_datecibil.readOnly=true;
		document.forms[0].crifscore.readOnly=true;
		document.forms[0].crif_date.readOnly=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].sel_refercibil.disabled=true;
		document.forms[0].sel_referredCRIF.disabled=true;
	}		
}

function doSave()
{
	if(document.forms[0].sel_refercibil.value=="")
	{
		ShowAlert("111","Whether Refered to CIBIL");
		document.forms[0].sel_refercibil.focus();
		return false;
	}
	if(document.forms[0].sel_refercibil.value=="Y" && document.forms[0].txt_cibilscore.value=="")
	{
		ShowAlert("121","CIBIL Score");
		document.forms[0].txt_cibilscore.focus();
		return false;
	}
	if(document.forms[0].sel_refercibil.value=="Y" && document.forms[0].txt_cibilComment.value=="")
	{
		ShowAlert("121","CIBIL Details");
		document.forms[0].txt_cibilComment.focus();
		return false;
	}
	if(document.forms[0].sel_SMAcategory.value=="")
	{
		ShowAlert("111","Whether Reported to CRILC");
		document.forms[0].sel_SMAcategory.focus();
		return false;
	}
	if(document.forms[0].sel_SMAcategory.value=="Y" && document.forms[0].txt_smaComment.value=="")
	{
		ShowAlert("121","CRILC details");
		document.forms[0].txt_smaComment.focus();
		return false;
	}
	if(document.forms[0].sel_SMAcategory.value=="Y" && document.forms[0].txt_crilcdate.value=="")
	{
		ShowAlert("111","Reported to CRILC");
		document.forms[0].txt_crilcdate.focus();
		return false;
	}
	if(document.forms[0].sel_referredCRIF.value=="")
	{
		ShowAlert("111","Whether referred to CRIF");
		document.forms[0].sel_referredCRIF.focus();
		return false;
	}
	if(document.forms[0].sel_referredCRIF.value=="Y" && document.forms[0].crifscore.value=="")
	{
		ShowAlert("121","CRIF score");
		document.forms[0].crifscore.focus();
		return false;
	}
	if(document.forms[0].sel_referredCRIF.value=="Y" && document.forms[0].crifdetails.value=="")
	{
		ShowAlert("121","CRIF details");
		document.forms[0].crifdetails.focus();
		return false;
	}
	if(document.forms[0].sel_referredCRIF.value=="Y" && document.forms[0].crif_date.value=="")
	{
		ShowAlert("111","CRIF Reported date");
		document.forms[0].crif_date.focus();
		return false;
	}


	if(document.forms[0].sel_referredExperian.value=="")
	{
		ShowAlert("111","Whether referred to Experian");
		document.forms[0].sel_referredExperian.focus();
		return false;
	}
	if(document.forms[0].sel_referredExperian.value=="Y" && document.forms[0].experianscore.value=="")
	{
		ShowAlert("121","Experian score");
		document.forms[0].experianscore.focus();
		return false;
	}
	if(document.forms[0].sel_referredExperian.value=="Y" && document.forms[0].experiandetails.value=="")
	{
		ShowAlert("121","Experian details");
		document.forms[0].experiandetails.focus();
		return false;
	}
	if(document.forms[0].sel_referredExperian.value=="Y" && document.forms[0].experian_date.value=="")
	{
		ShowAlert("111","Experian Reported date");
		document.forms[0].experian_date.focus();
		return false;
	}

	

	if(document.forms[0].sel_refercibil.value!="Y")		
	{
		document.forms[0].txt_datecibil.value="";
		document.forms[0].txt_cibilComment.value="";
		document.forms[0].txt_cibilscore.value="";
	}
	if(document.forms[0].sel_SMAcategory.value!="Y")		
	{
		document.forms[0].txt_smaComment.value="";
		document.forms[0].txt_crilcdate.value="";
	}
	if(document.forms[0].sel_referredCRIF.value!="Y")		
	{
		document.forms[0].crifscore.value="";
		document.forms[0].crifdetails.value="";
		document.forms[0].crif_date.value="";
	}
	if(document.forms[0].sel_referredExperian.value!="Y")		
	{
		document.forms[0].experianscore.value="";
		document.forms[0].experiandetails.value="";
		document.forms[0].experian_date.value="";
	}
	//document.forms[0].cmdsave.disabled=true;
	//document.forms[0].cmdcancel.disabled=true;
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].sel_refercibil.disabled=false;
	document.forms[0].sel_referredCRIF.disabled=false;
	document.forms[0].hidAction.value="update";
	
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].hidBeanMethod.value="updateDefaulter";
	document.forms[0].hidBeanGetMethod.value="getDefaulter";
	document.forms[0].hidSourceUrl.value="/action/customerDefaulter.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();	
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidBeanGetMethod.value="getDefaulter";
		document.forms[0].action=appURL+"action/customerDefaulter.jsp";	
		document.forms[0].submit();
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{	
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanMethod.value="updateDefaulter";
		document.forms[0].hidBeanGetMethod.value="getDefaulter";
		document.forms[0].hidSourceUrl.value="/action/customerDefaulter.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
	else
	{
		
		ShowAlert(158);
	}			
}

function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{	
		if(varCIBILAutoFlag=="Y" && name=="txt_datecibil")
		{
			return;
		}
		if(varCRIFAutoFlag=="Y" && name=="crif_date")
		{
			return;
		}
		if(digiFlag=="Y" && name=="txt_datecibil")
		{
			return;
		}
		if(digiFlag=="Y" && name=="crif_date")
		{
			return;
		}
		showCal(appURL,name);
	}
}

function callLink(page,bean,method)
{ 
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidAction.value="";
	 	document.forms[0].hidBeanGetMethod.value=method;
	 	document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].action=appURL+"action/"+page;
	 	document.forms[0].submit();
	}
	else 
	{
		ShowAlert(103);
	}
}

function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			  document.forms[0].elements[i].value="";		  
		}		
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
}

function hidDate()
{
	
if(document.forms[0].sel_RBIDefaulter.value=="Y"){
	document.all.hid1.style.visibility="visible";
	document.all.hid1.style.position="relative";
	document.all.hid2.style.visibility="visible";
	document.all.hid2.style.position="relative";
	document.all.hid3.style.visibility="visible";
	document.all.hid3.style.position="relative";
	document.all.hid4.style.visibility="visible";
	document.all.hid4.style.position="relative";
	document.all.hid5.style.visibility="visible";
	document.all.hid5.style.position="relative";
	document.all.hid6.style.visibility="visible";
	document.all.hid6.style.position="relative";
	document.all.hid19.style.visibility="visible";
	document.all.hid19.style.position="relative";
}
else
{
		document.all.hid1.style.visibility="hidden";
		//document.all.hid1.style.position="absolute";
		document.all.hid2.style.visibility="hidden";
		//document.all.hid2.style.position="absolute";
		document.all.hid3.style.visibility="hidden";
		//document.all.hid3.style.position="absolute";
		document.all.hid4.style.visibility="hidden";
		//document.all.hid4.style.position="absolute";
		document.all.hid5.style.visibility="hidden";
		//document.all.hid5.style.position="absolute";
		document.all.hid6.style.visibility="hidden";
		//document.all.hid6.style.position="absolute";
		document.all.hid19.style.visibility="hidden";
}
if(document.forms[0].sel_ECGCIList.value=="Y"){
	document.all.hid7.style.visibility="visible";
	document.all.hid7.style.position="relative";
	document.all.hid8.style.visibility="visible";
	document.all.hid8.style.position="relative";
	document.all.hid9.style.visibility="visible";
	document.all.hid9.style.position="relative";
	document.all.hid10.style.visibility="visible";
	document.all.hid10.style.position="relative";
	document.all.hid11.style.visibility="visible";
	document.all.hid11.style.position="relative";
	document.all.hid12.style.visibility="visible";
	document.all.hid12.style.position="relative";
	document.all.hid20.style.visibility="visible";
	document.all.hid20.style.position="relative";
}
else{
	document.all.hid7.style.visibility="hidden";
	//document.all.hid7.style.position="absolute";
	document.all.hid8.style.visibility="hidden";
	//document.all.hid8.style.position="absolute";
	document.all.hid9.style.visibility="hidden";
	//document.all.hid9.style.position="absolute";
	document.all.hid10.style.visibility="hidden";
	//document.all.hid10.style.position="absolute";
	document.all.hid11.style.visibility="hidden";
	//document.all.hid11.style.position="absolute";
	document.all.hid12.style.visibility="hidden";
	//document.all.hid12.style.position="absolute";
	document.all.hid20.style.visibility="hidden";
}
if(document.forms[0].sel_Willful.value=="Y"){

	document.all.hid13.style.visibility="visible";
	document.all.hid13.style.position="relative";
	document.all.hid14.style.visibility="visible";
	document.all.hid14.style.position="relative";
	document.all.hid15.style.visibility="visible";
	document.all.hid15.style.position="relative";
	document.all.hid16.style.visibility="visible";
	document.all.hid16.style.position="relative";
	document.all.hid17.style.visibility="visible";
	document.all.hid17.style.position="relative";
	document.all.hid18.style.visibility="visible";
	document.all.hid18.style.position="relative";
	document.all.hid21.style.visibility="visible";
	document.all.hid21.style.position="relative";
}
else{

	document.all.hid13.style.visibility="hidden";
	//document.all.hid13.style.position="absolute";
	document.all.hid14.style.visibility="hidden";
	//document.all.hid14.style.position="absolute";
	document.all.hid15.style.visibility="hidden";
	//document.all.hid15.style.position="absolute";
	document.all.hid16.style.visibility="hidden";
	//document.all.hid16.style.position="absolute";
	document.all.hid17.style.visibility="hidden";
	//document.all.hid17.style.position="absolute";
	document.all.hid18.style.visibility="hidden";
	//document.all.hid18.style.position="absolute";
	document.all.hid21.style.visibility="hidden";
}

if(document.forms[0].sel_Identified.value=="Y")
{
	document.all.hid22.style.visibility="visible";
	document.all.hid22.style.position="relative";
}else{
	document.all.hid22.style.visibility="hidden";
}
if(document.forms[0].sel_Suitfiled.value=="Y")
{
	document.all.hid23.style.visibility="visible";
	document.all.hid23.style.position="relative";
}else{
	document.all.hid23.style.visibility="hidden";
}
if(document.forms[0].sel_probe.value=="Y")
{
	document.all.hid24.style.visibility="visible";
	document.all.hid24.style.position="relative";
}else{
	document.all.hid24.style.visibility="hidden";
}
}

function cibildet()
{
	
	if(document.forms[0].sel_refercibil.value=="Y")
	{
		
		document.all.hidcibil.style.visibility="visible";
		document.all.hidcibil.style.position="relative";
		document.all.hidcibil1.style.visibility="visible";
		document.all.hidcibil1.style.position="relative";

		
	}
	else
	{
		
		document.all.hidcibil.style.visibility="hidden";
		document.all.hidcibil.style.position="absolute";
		document.all.hidcibil1.style.visibility="hidden";
		document.all.hidcibil1.style.position="absolute";
		
	}
}
function funSMAcategory()
{
	if(document.forms[0].sel_SMAcategory.value=="Y")
	{
		
		document.all.hidSMA1.style.visibility="visible";
		document.all.hidSMA1.style.position="relative";
		document.all.hidSMA2.style.visibility="visible";
		document.all.hidSMA2.style.position="relative";
		document.all.hidSMA3.style.visibility="visible";
		document.all.hidSMA3.style.position="relative";

		
	}
	else
	{
		
		document.all.hidSMA1.style.visibility="hidden";
		document.all.hidSMA1.style.position="absolute";
		document.all.hidSMA2.style.visibility="hidden";
		document.all.hidSMA2.style.position="absolute";
		document.all.hidSMA3.style.visibility="hidden";
		document.all.hidSMA3.style.position="absolute";
		
	}
}
function referredcrif()
{
	if(document.forms[0].sel_referredCRIF.value=="Y")
	{
		document.all.crif_score.style.display="table-cell";
		document.all.crif_score1.style.display="table-cell";
		document.all.crif_details.style.display="table-cell";
		document.all.crif_details1.style.display="table-cell";
		document.all.report_date.style.display="table-cell";
		document.all.report_date1.style.display="table-cell";
		
		
	}
	else
	{
		document.all.crif_score.style.display="none";
		document.all.crif_score1.style.display="none";
		document.all.crif_details.style.display="none";
		document.all.crif_details1.style.display="none";
		document.all.report_date.style.display="none";
		document.all.report_date1.style.display="none";
		
	}
}

function referredexperian()
{
	if(document.forms[0].sel_referredExperian.value=="Y")
	{
		document.all.experian_score.style.display="table-cell";
		document.all.experian_score1.style.display="table-cell";
		document.all.experian_details.style.display="table-cell";
		document.all.experian_details1.style.display="table-cell";
		document.all.report_date2.style.display="table-cell";
		document.all.report_date3.style.display="table-cell";
		
		
	}
	else
	{
		document.all.experian_score.style.display="none";
		document.all.experian_score1.style.display="none";
		document.all.experian_details.style.display="none";
		document.all.experian_details1.style.display="none";
		document.all.report_date2.style.display="none";
		document.all.report_date3.style.display="none";
		
	}
}
function getscore()
{
	

}

</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="callOnload()">
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
<form name="colForm" method="post" class="normal"><jsp:include
	page="../share/help.jsp" flush="true"/>

<%if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equals("")) { %>

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Customer
		Profile -&gt; Rating/Defaulter</td>
	</tr>
	
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
<table width="98%" border="0" cellpadding="1" cellspacing="3"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/Cusurllink.jsp" flush="true">
			<jsp:param name="pageid" value="4" />
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="strProfilestatus" value="<%=strProfilestatus%>" />
			<jsp:param name="hidincompletedpagename" value="<%=strPageName%>" />
			
		</jsp:include></td>
	</tr>
</table>
</td>
</tr>
</table>

<% } else {  %>

<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ 
if(!strSessionModuleType.equalsIgnoreCase("RET")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="subpageid" value="115" />
			<jsp:param name="subsubpageid" value="24" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<% }else{%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="subsubpageid" value="24"/>
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %>
<jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value=""/>
			<jsp:param name="subsubpageid" value="24"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include>
<%}else{ %>
       <%if(strapptype.equalsIgnoreCase("C")){ %>
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="cattype" value="CORP" />
			<jsp:param name="ssitype" value="" />
			<jsp:param name="applevel" value="A" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
   <%
if(strSessionModuleType.equalsIgnoreCase("AGR")){
%>
	<tr>
		<td class="page_flow">Home -&gt;Agriculture -&gt; Application -&gt; Applicant-&gt; customer profile -&gt; Rating/Defaulter</td>
	</tr>
	<%}else{ %>
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Application -&gt; Applicant-&gt; customer profile -&gt; Rating/Defaulter</td>
	</tr>
	
  </table>
	<%}}else if(strSessionModuleType.equalsIgnoreCase("RET") || strSessionModuleType.equalsIgnoreCase("LAD")){%>
        <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="<%=pageid%>" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; 
       Retail(including schematic) -&gt; Application -&gt; Applicant/Guarantor -&gt; Rating/Defaulter</td>
    </tr>
  </table>
  <%} else { %>
         <jsp:include page="../share/applurllinkerdigi.jsp" flush="true"> 
        <jsp:param name="pageid" value="<%=pageid%>" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; 
       Digi Retail -&gt; Application -&gt; Applicant/Guarantor -&gt; Rating/Defaulter</td>
    </tr>
  </table>
  
  <% } %>
<lapschoice:application />
   
   <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
			<%if(strapptype.equalsIgnoreCase("C")){ %>
		<tr>
		<lapstab:ComfacilityTab tabid="2" />
		</tr>
		<%}if(strapptype.equalsIgnoreCase("C") || strapptype.equalsIgnoreCase("R")){%>
			<tr>
		<td><jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value="24"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
	</table>
	<%}} %>


<% }  %>

<table width="30%" border="0" cellpadding="1" cellspacing="3" class="outertable">
	<tr>
		<td class="sub_tab_inactive" align="center"><b><a href="#" 
		onclick="javascript:callLink('customerRating.jsp','mastapplicant','getRating')">
		Rating</a></b></td>
		<td class="sub_tab_active" align="center"><b>Defaulter</b></td>
	</tr>
</table>

<table width="98%" border="0" cellpadding="3" cellspacing="0" class="outertable border1" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3"	align="center" class="outertable">
		<tr valign="top" class="applicationheader"><td  ><b>Defaulter</b></td></tr>
		</table>
		<table width="100%" border="0" cellspacing="1" cellpadding="3"	align="center" class="outertable">
		<tr>
		
		<td width="30%">Whether RBI Defaulter</td>
						<td width="15%"><select name="sel_RBIDefaulter" onchange="hidDate()">
							<option value="" selected>--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
		<td nowrap="nowrap"> As on date </td>
		<td>		
		        <table>
						 <tr>
							 <td> <input type="text" name="txt_asonRBIdate"  onBlur="checkDate(this);checkmaxdate(this,curdate);" size="12" maxlength="13" value="<%=Helper.correctNull((String) hshValues.get("asonRBIdate"))%>"> </td>
							 <td><a alt="Select date from calender"  href="javascript:callCalender('txt_asonRBIdate')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
							 </td>
						</tr>
					</table>
		</td>
					
		<td id="hid19" width="20%">
		
		<textarea name="txt_RBIDefaulter" cols="25"  rows="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("DEF_RBIDEFCOMM"))%></textarea></td>
		<td id="hid1" width="10%" nowrap="nowrap">From Date </td>										
		<td id="hid2" width="10%"><input type="text" name="txt_fromdate1" size="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("DEF_RBIFRMDAT"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate)" maxlength="12"></td>
		<td id="hid3" width="10%"><a alt="Select date from calender" href="#"
							onClick="callCalender('txt_fromdate1')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
							
		<td id="hid4" width="10%" nowrap="nowrap">Deleted on Date </td>										
		<td id="hid5" width="10%"><input type="text" name="txt_deleteondate1" size="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("DEF_RBIDELDAT"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate)" maxlength="12"></td>
		<td id="hid6" width="10%"><a alt="Select date from calender" href="#"
							onClick="callCalender('txt_deleteondate1')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
							
		</tr>
		<tr>
		<td>Whether ECGCI Specific list</td>
						<td><select name="sel_ECGCIList" onchange="hidDate()">
							<option value="" selected>--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
						
		<td width="10%"> As on date </td>
		<td>		
		<table>
						 <tr>
							 <td> <input type="text" name="txt_asonECGCIdate"  onBlur="checkDate(this);checkmaxdate(this,curdate);" size="12" maxlength="13" value="<%=Helper.correctNull((String) hshValues.get("asonECGCIdate"))%>"> </td>
							 <td><a alt="Select date from calender"  href="javascript:callCalender('txt_asonECGCIdate')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
							 </td>
						</tr>
					</table>
		</td>
		
		<td id="hid20">
		<textarea name="txt_ECGCIList" cols="25"  rows="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String)hshValues.get("DEF_ECGSEPCOMM"))%></textarea></td>
					
		<td id="hid7">From Date </td>										
		<td id="hid8"><input type="text" name="txt_fromdate2" size="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("DEF_ECGFRMDAT"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate)" maxlength="12"></td>
		<td id="hid9"><a alt="Select date from calender" href="#"
							onClick="callCalender('txt_fromdate2')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
							
		<td id="hid10">Deleted on Date </td>										
		<td id="hid11"><input type="text" name="txt_deleteondate2" size="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("DEF_ECGDELDAT"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate)" maxlength="12"></td>
		<td id="hid12"><a alt="Select date from calender" href="#"
							onClick="callCalender('txt_deleteondate2')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
		</tr>
		
		<tr>
		<td>Whether Willful Defaulter</td>
						<td><select name="sel_Willful" onchange="hidDate()">
							<option value="" selected>--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
						
		<td width="10%"> As on date </td>
		<td>		
		<table>
						 <tr>
							 <td> <input type="text" name="txt_asonWillfuldate"  onBlur="checkDate(this);checkmaxdate(this,curdate);" size="12" maxlength="13" value="<%=Helper.correctNull((String) hshValues.get("asonWillfuldate"))%>"> </td>
							 <td><a alt="Select date from calender"  href="javascript:callCalender('txt_asonWillfuldate')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
							 </td>
						</tr>
					</table>
		</td>
				
		<td id="hid21">
		<textarea name="txt_Willful" cols="25"  rows="3"  onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("DEF_WILDDEFCOMM"))%></textarea></td>
							
		<td id="hid13">From Date </td>										
		<td id="hid14"><input type="text" name="txt_fromdate3" size="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("DEF_WILFRMDAT"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate)" maxlength="12"></td>
		<td id="hid15"><a alt="Select date from calender" href="#"
							onClick="callCalender('txt_fromdate3')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
							
		<td id="hid16">Deleted on Date </td>										
		<td id="hid17"><input type="text" name="txt_deleteondate3" size="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("DEF_WILDELDAT"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate)" maxlength="12"></td>
		<td id="hid18"><a alt="Select date from calender" href="#"
							onClick="callCalender('txt_deleteondate3')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
		</tr>
		<tr>
				<td>Whether Identified under EXIT policy</td>
				<td><select name="sel_Identified" onchange="hidDate()">
							<option value="" selected>--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
		<td colspan="2">&nbsp;</td>
		<td id="hid22"><textarea name="txt_Identified" cols="25"  rows="3"  onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String)hshValues.get("DEF_EXITPOLCOMM"))%></textarea></td>
		</tr>
		<tr>
		 <td>Whether Suit filed, whether action initiated<br/> by other bank/ financial institutions still pending? </td>
		 <td><select name="sel_Suitfiled" onchange="hidDate()">
							<option value="" selected>--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select>
		</td>
		<td colspan="2">&nbsp;</td>
		<td id="hid23"><textarea name="txt_Suitfiled" cols="25"  rows="3"  onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String)hshValues.get("DEF_SUITFILEDCOMM"))%></textarea></td>			
		</tr>
		<tr>
		 <td>Whether referred to Probe 42? </td>
		 <td><select name="sel_probe" onchange="hidDate()">
							<option value="" selected>--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select>
		</td>
		<td colspan="2">&nbsp;</td>
		<td id="hid24"><textarea name="txt_probecmts" cols="25"  rows="3"  onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String)hshValues.get("DEF_PROBECMT"))%></textarea></td>			
		</tr>
		</table>
		<table width="100%" border="0" cellspacing="1" cellpadding="3"	align="center" class="outertable">
		<tr valign="top" class="applicationheader">
            <td colspan="4"><b>CIBIL Details</b></td>
        </tr>
		
		<tr>
		<td width="14%" nowrap="nowrap">Whether Refered to CIBIL &nbsp; <b><span class="mantatory">*&nbsp;</span></b></td>
		<td colspan="" width="20%">
							<select name="sel_refercibil" onchange="cibildet()">
							<option value="" selected>--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
		<td></td>
		<td></td>
		</tr>
		<tr id="hidcibil">		
            <td width="14%">CIBIL Score &nbsp; <b><span class="mantatory">*&nbsp;</span></b></td>						
            <td colspan="" ><input type="text" name="txt_cibilscore" size="15" maxlength="5"
			 value='<%=Helper.correctNull((String)hshValues.get("cibil_score"))%>' onKeyPress="allowNegtiveNumber(document.forms[0].txt_cibilscore)"  tabindex="9" style="text-align:right"></td>
			
		    <td width="14%">Reported Date</td>
		    
		    
		    <td ><input type="text" name="txt_datecibil" size="10" maxlength="10" value="<%=Helper.correctNull((String)hshValues.get("cibil_reporteddate")) %>" onBlur="checkDate(this);checkmaxdate(this,curdate);">
		    
		    
		    <a alt="Select date from calender" href="#"
							onClick="callCalender('txt_datecibil')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" ></a></td>
		   
		</tr>
		<tr id="hidcibil1">		
            <td width="14%">CIBIL Details &nbsp; <b><span class="mantatory">*&nbsp;</span></b></td>						
            <td colspan="3" ><textarea name="txt_cibilComment" cols="140"  rows="5" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" tabindex="4"><%=Helper.correctNull((String)hshValues.get("cibil_details"))%></textarea>
            </td>
		</tr>
		
		
		<tr>		
            <td width="14%">Whether Reported to CRILC<b><span class="mantatory">*&nbsp;</span></b></td>
            <td><select name="sel_SMAcategory" onchange="funSMAcategory()">
            <option value="" selected>--Select--</option>
            <option value="Y">Yes</option>
            <option value="N">No</option>
            <option value="NA">Not Applicable</option>
            </select></td>						
            <td id="hidSMA1">CRILC Details &nbsp;<b><span class="mantatory">*&nbsp;</span></td>
            <td id="hidSMA3"><textarea name="txt_smaComment" cols="100"  rows="5" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" tabindex="4"><%=Helper.correctNull((String)hshValues.get("cibil_smadetails"))%></textarea>
            </td>
		</tr>
		
		
	   <tr id="hidSMA2">
	   <td>Reported to CRILC &nbsp;<b><span class="mantatory">*&nbsp;</span></td>
	   <td>	<input type="text" name="txt_crilcdate" size="10" maxlength="10" onBlur="checkDate(this);checkmaxdate(this,curdate);"  tabindex="" value="<%=Helper.correctNull((String)hshValues.get("cibil_CRILC"))%>"> <a alt="Select date from calender" href="#"
							onClick="callCalender('txt_crilcdate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" ></a></td>
	   </tr>
		 <tr>
		<td width="14%" nowrap="nowrap">Whether Referred to CRIF&nbsp; <b><span class="mantatory">*&nbsp;</span></b></td>
		<td colspan="" width="20%">
							<select name="sel_referredCRIF" onchange="referredcrif()">
							<option value="" selected>--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
							<option value="NA">Not Applicable</option>
						</select></td></tr>
						<tr><td id="crif_score">CRIF Score<b><span class="mantatory">*&nbsp;</span></b></td>
						<td id="crif_score1"><input type="text" name="crifscore" value="<%=Helper.correctNull((String) hshValues.get("CRIF_SCORE"))%>" onKeyPress="allowNegtiveNumber(document.forms[0].crifscore)" ></td>
						<td id="crif_details">CRIF Details<b><span class="mantatory">*&nbsp;</span></b></td>
						<td id="crif_details1"><textarea name="crifdetails" cols="100"  rows="5" onKeyPress="textlimit(this,19)" onKeyUp="textlimit(this,19)"><%=Helper.correctNull((String) hshValues.get("CRIF_DETAILS"))%></textarea></td>
						</tr>
						<tr>
						<td id="report_date">CRIF Reported date<b><span class="mantatory">*&nbsp;</span></b></td>
						<td id="report_date1"><input type="text" name="crif_date" size="11" value="<%=Helper.correctNull((String) hshValues.get("CRIF_DATE"))%>"
							
							onBlur="checkDate(this);checkmaxdate(this,curdate);" maxlength="12">
							&nbsp;
							<a alt="Select date from calender" href="#"
							onClick="callCalender('crif_date')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
						</tr>
			<tr style="display: none;">
			<td id="score">Score<b><span class="mantatory">*&nbsp;</span></b></td>	
			<td id="score1"><input type="text" name="cibil_score" size="11" value="" ></td>
			</tr>
			
				 <tr>
		<td width="14%" nowrap="nowrap">Whether Referred to Experian&nbsp; <b><span class="mantatory">*&nbsp;</span></b></td>
		<td colspan="" width="20%">
							<select name="sel_referredExperian" onchange="referredexperian()">
							<option value="" selected>--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
							<option value="NA">Not Applicable</option>
						</select></td></tr>
	<tr><td id="experian_score">Experian Score<b><span class="mantatory">*&nbsp;</span></b></td>
						<td id="experian_score1"><input type="text" name="experianscore" value="<%=Helper.correctNull((String) hshValues.get("EXPERIAN_SCORE"))%>" onKeyPress="allowNegtiveNumber(document.forms[0].experianscore)" ></td>
						<td id="experian_details">Experian Details<b><span class="mantatory">*&nbsp;</span></b></td>
						<td id="experian_details1"><textarea name="experiandetails" cols="100"  rows="5" onKeyPress="textlimit(this,19)" onKeyUp="textlimit(this,19)"><%=Helper.correctNull((String) hshValues.get("EXPERIAN_DETAILS"))%></textarea></td>
						</tr>
						<tr>
						<td id="report_date2">Experian Reported date<b><span class="mantatory">*&nbsp;</span></b></td>
						<td id="report_date3"><input type="text" name="experian_date" size="11" value="<%=Helper.correctNull((String) hshValues.get("EXPERIAN_DATE"))%>"
							
							onBlur="checkDate(this);checkmaxdate(this,curdate);" maxlength="12">
							&nbsp;
							<a alt="Select date from calender" href="#"
							onClick="callCalender('experian_date')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
						</tr>
		
		
						
	  </table>		
		<td>
	</tr>
</table>

<br>
	<%if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equals("")) { %>	
		<lapschoice:combuttonnew btnnames='Edit _Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
	<% } else {  %>
	<div style="display: none; ">
		<lapschoice:combuttonnew btnnames='Edit _Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
	</div>		
		<lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
	<% } %>
<table width="20%" border="0" cellspacing="1" align="center" cellpadding="3" class="outertable">
<!--<tr align="center"><td><input type="button" class="buttonPrint" name="" value="Score" onclick=""  </td></tr>-->
</table>
<br>
<%String strappno = request.getParameter("appno");
%> 
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="txtperapp_appid" value="<%=Helper.correctNull((String)hshValues.get("applicantId"))%>"> 
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)request.getParameter("hidDemoId"))%>">
<input type="hidden" name="hidappstatus" value="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>">   
<input type="hidden" name="hidFromPage" value="Defaulter">  
<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>"> 
<input type="hidden" name="hidfacname"	value="<%=hidfacname%>">
</form>
</body>
</html>
