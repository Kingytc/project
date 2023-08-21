<%@include file="../share/directives.jsp"%>
<%String strProfilestatus = Helper.correctNull((String) hshValues
					.get("strProfilestatus"));
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
			String strCattype=Helper.correctNull(request.getParameter("hidCategoryType"));
			String strappname=Helper.correctNull((String)request.getParameter("txtperapp_fname"));
			if(strappname.equals(""))
			{
				strappname=Helper.correctNull((String)request.getParameter("hidapp_name"));
			}
		String pageid = Helper.correctNull((String) request.getParameter("pageid"));
		String strEmployment=(String)session.getAttribute("strEmployment");
		String hidfacname=Helper.correctNull(request.getParameter("hidfacname"));
		String strPageName=Helper.correctNull((String)hshValues.get("strIncompletepage"));
		String perapp_const=Helper.correctNull((String)hshValues.get("PERAPP_CONSTITUTIONNEW"));
		
		String strapptype = Helper.correctNull((String)request.getParameter("corp"));
		String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
			if(hshValues!=null)
			{
				arrRow = (ArrayList)hshValues.get("arrRow");
			}
			
%>
<html>
<head>
<title>Personal - Applicant KYC NORMS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<SCRIPT LANGUAGE="JavaScript">

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var curdate = "<%=Helper.getCurrentDateTime()%>";
var value1="<%=Helper.correctNull((String)hshValues.get("perinc_id"))%>";
var varcusttype="<%=Helper.correctNull((String)hshValues.get("custtype"))%>";
var varform="<%=Helper.correctNull((String)hshValues.get("form"))%>";
var varaccount="<%=Helper.correctNull((String)hshValues.get("account"))%>";
var varofac="<%=Helper.correctNull((String)hshValues.get("ofac"))%>";
var varremittance="<%=Helper.correctNull((String)hshValues.get("remittance"))%>";
var varsleeppartner="<%=Helper.correctNull((String)hshValues.get("kyc_sleeppartner"))%>";
var varpoliticalexpose="<%=Helper.correctNull((String)hshValues.get("kyc_politicalexposed"))%>";
var varfamilyshare="<%=Helper.correctNull((String)hshValues.get("kyc_familyshare"))%>";
var varcons="<%=Helper.correctNull((String)hshValues.get("perapp_constitution"))%>";
var varstatus="<%=Helper.correctNull((String)hshValues.get("perapp_status"))%>";
var ownership="<%=Helper.correctNull((String)hshValues.get("comapp_ownership"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var appstatus="<%=Helper.correctNull((String) hshValues.get("appstatus"))%>";
var cbs_id="<%=Helper.correctNull((String) hshValues.get("strCBSID"))%>";
var varactivitycode="<%=Helper.correctNull((String)hshValues.get("activitycode"))%>";
var perapp_const="<%=perapp_const %>";
function callLoad()
{
	callDisable(true);

	if(document.forms[0].readFlag.value=="r")
	{
		disableControls(true,true,true,true,false);
	}
	else
	{
	    if(appstatus=="true")
	    {
		  disableControls(true,true,true,true,false);
	    }
	     else
	    {
	    disableControls(false,true,true,true,false);
        }
	}    
	
	/*if(varcusttype!="")
	{
	document.forms[0].sel_CustType.value=varcusttype;
	}
	else
	{
	document.forms[0].sel_CustType.value="";
	}
	
	if(varform!="")
	{
	document.forms[0].sel_Form.value=varform;
	}
	else
	{
	document.forms[0].sel_Form.value="";
	}
	
	if(varaccount!="")
	{
	document.forms[0].sel_Account.value=varaccount;
	}
	else
	{
	document.forms[0].sel_Account.value="";
	}
	
	if(varofac!="")
	{
	document.forms[0].sel_OFAC.value=varofac;
	}
	else
	{
	document.forms[0].sel_OFAC.value="";
	}
	
	if(varremittance!="")
	{
	document.forms[0].sel_Remittance.value=varremittance;
	}
	else
	{
	document.forms[0].sel_Remittance.value="";
	}
	if(varsleeppartner != "")
	{
	 document.forms[0].sel_sleeppartner.value=varsleeppartner
	}
	else
	{
	 document.forms[0].sel_sleeppartner.value="";
	}
	if(varpoliticalexpose != "")
	{
	 document.forms[0].sel_politicalexposed.value=varpoliticalexpose
	}
	else
	{
	 document.forms[0].sel_politicalexposed.value="";
	}
	if(varfamilyshare != "")
	{
	 document.forms[0].sel_familyshare.value=varfamilyshare
	}
	else
	{
	 document.forms[0].sel_familyshare.value="";
	}
	callRemitCountry();

	fnCallMandatory();*/

	if(varactivitycode!="")
	{
		
		document.forms[0].hid_Activity.value=varactivitycode;
	}
	
	
}

function callIncomeExpenses()
{
	if(document.forms[0].cmdsave.disabled==true)
	{
		if(isNaN(value1))
		{
			ShowAlert('103');
		}
		else
		{	
			if(document.forms[0].hidModuleName.value == 'T'){
				
				document.forms[0].hidBeanGetMethod.value="getIncome";
				document.forms[0].action=appURL+"action/perincexpenses.jsp?applnt=T";
				document.forms[0].submit();
				
			}else{
				
				document.forms[0].hidBeanGetMethod.value="getIncome";
				document.forms[0].action=appURL+"action/perincexpenses.jsp?applnt=P";
				document.forms[0].submit();
			}
		}
	}
	else
	{
		ShowAlert('103');
	}
}

function callDemographics()
{
	if(document.forms[0].cmdsave.disabled==true)
	{
		if(isNaN(value1))
		{
			ShowAlert('103');
		}
		else
		{
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getDemographics";
			if(document.forms[0].hidModuleName.value=="T")
				document.forms[0].action=appURL+"action/ops_applicant.jsp?applnt=T";
			else
				document.forms[0].action=appURL+"action/perapplicant.jsp?applnt=P";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
}

function callEmployer()
{
	if(document.forms[0].cmdsave.disabled==true)
	{
		if(isNaN(value1))
		{
			ShowAlert('103');
		}
		else
		{
			document.forms[0].hidBeanGetMethod.value="getEmployer";
			document.forms[0].action=appURL+"action/peremployer.jsp?applnt=P";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
}

function callDescHelp(id)
{	
	if(document.forms[0].cmdsave.disabled==false)
	{
		if(cbs_id=="")
		{
			var varQryString = appURL+"action/ops_sanctionhelp.jsp?id="+id+"&pagename=kycnorms&hidBeanId=additionalParameter&hidBeanGetMethod=getSearch";
			var title = "CBS_DATAS_HELP";
			var prop = "scrollbars=no,width=650,height=400";	
			prop = prop + ",left=200,top=200";
			window.open(varQryString,title,prop);
		}	
		else
		{
			if(!(id=="70" || id=="54" || id=="61"))
			{
				var varQryString = appURL+"action/ops_sanctionhelp.jsp?id="+id+"&pagename=kycnorms&hidBeanId=additionalParameter&hidBeanGetMethod=getSearch";
				var title = "CBS_DATAS_HELP";
				var prop = "scrollbars=no,width=650,height=400";	
				prop = prop + ",left=200,top=200";
				window.open(varQryString,title,prop);
			}
			else
			{
				//No Function;
			}
		}
	}
}
function callDisable(one)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].readOnly=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
		  document.forms[0].elements[i].readOnly=one;
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=one;
		}
	}
	document.forms[0].hid_custoccup.readOnly=true;
	document.forms[0].txt_custoccup.readOnly=true;
	//document.forms[0].txt_AnnualIncome.readOnly=true;
	//document.forms[0].txt_CountryResi.readOnly=true;
	document.forms[0].txt_ResiProofType.readOnly=true;
	//document.forms[0].txt_SourceIncome.readOnly=true;
	document.forms[0].txt_IdProofType.readOnly=true;
	//document.forms[0].txt_Networth.readOnly=true;
	//document.forms[0].txt_TurnOver.readOnly=true;
	//document.forms[0].txt_Activity.readOnly=true;
	//document.forms[0].txt_EstiTurnOver.readOnly=true;
	//document.forms[0].txt_RemitCountry.readOnly=true;
	document.forms[0].txt_Risk.readOnly=true;
	//document.forms[0].txt_city1.readOnly=true;
	//document.forms[0].txt_cntry1.readOnly=true;
	//document.forms[0].txt_city2.readOnly=true;
	//document.forms[0].txt_cntry2.readOnly=true;
	//document.forms[0].txt_city3.readOnly=true;
	//document.forms[0].txt_cntry3.readOnly=true;
	
	//document.forms[0].hid_AnnualIncome.readOnly=true;
	document.forms[0].hid_ResiProofType.readOnly=true;
	//document.forms[0].hid_SourceIncome.readOnly=true;
	document.forms[0].hid_IdProofType.readOnly=true;
	//document.forms[0].hid_Networth.readOnly=true;
	//document.forms[0].hid_TurnOver.readOnly=true;
	document.forms[0].hid_Activity.readOnly=true;
	//document.forms[0].hid_EstiTurnOver.readOnly=true;
	document.forms[0].hid_Risk.readOnly=true; 
	document.forms[0].txt_id_valid.readOnly=true;
	document.forms[0].txt_residence_valid.readOnly=true;
}

function disableControls(bcmdEdit,bcmdSave,bcmdDelete,bcmdCancel,bcmdClose)
{
	document.forms[0].cmdedit.disabled=bcmdEdit;
	document.forms[0].cmdsave.disabled=bcmdSave;
	document.forms[0].cmddelete.disabled=true;
	document.forms[0].cmdcancel.disabled=bcmdCancel;
	document.forms[0].cmdclose.disabled=bcmdClose;
}

function doEdit() 
{
	callDisable(false);
	disableControls(true,false,false,false,true);
	//document.forms[0].sel_CustType.focus();
	document.forms[0].hideditflag.value="Y";	
	if(cbs_id=="")
	{
		disableCBSFields(false);
	}
	else
	{
		disableCBSFields(true);
	}
	var le = document.forms[0].bene_owner_cus.length;
	//alert("le"+le);
	if(le>1)
	{
	for(var i=0;i<le;i++)
	{
		document.forms[0].bene_owner_cus[i].readOnly = true;
		document.forms[0].identi_docu[i].readOnly = true;
		document.forms[0].identi_docu_num[i].readOnly = true;
		document.forms[0].percent_of_shares_held[i].readOnly = true;
		document.forms[0].relationship_with_borrower[i].readOnly = true;
		document.forms[0].no_of_shares_held[i].readOnly = true;
		document.forms[0].gvarantee_available[i].readOnly = true;
		document.forms[0].name_of_beneficial[i].readOnly = true;
		
	}
	}
}
function disableCBSFields(boolval)
{
	document.forms[0].txt_IDProofRef.readOnly=boolval;
}
function doSave()
{
	

	/*if(document.forms[0].sel_CustType.value=="")
	{
		ShowAlert('111','Whether the Customer is Corporate');
		document.forms[0].sel_CustType.focus();
		return true;
	}
	if(document.forms[0].txt_AnnualIncome.value=="")
	{
		ShowAlert('111','Annual Income');
		document.forms[0].txt_AnnualIncome.focus();
		return true;
	}
	if(document.forms[0].txt_CountryResi.value=="")
	{
		ShowAlert('111','the Country of Residence');
		document.forms[0].txt_CountryResi.focus();
		return true;
	}*/
	if(document.forms[0].txt_custoccup.value=="")
	{
		ShowAlert('111','Customer Occupation');
		document.forms[0].txt_custoccup.focus();
		return true;
	}
	if(document.forms[0].hid_custoccup.value=="MISC")
	{
		if(document.forms[0].txt_Occupation.value=="")
		{
			ShowAlert('111','Occupation');
			document.forms[0].txt_Occupation.focus();
			return true;
		}
	}
	if(document.forms[0].txt_IdProofType.value=="")
	{
		ShowAlert('111','the ID Proof Type');
		document.forms[0].txt_IdProofType.focus();
		return true;
	}
	if(document.forms[0].txt_ResiProofType.value=="")
	{
		ShowAlert('111','the Residence Proof Type');
		document.forms[0].txt_ResiProofType.focus();
		return true;
	}
	if(document.forms[0].txt_IDProofRef.value=="")
	{
		ShowAlert('111','the ID Proof Reference');
		document.forms[0].txt_IDProofRef.focus();
		return true;
	}
	
	if(document.forms[0].txt_ResiIDRefNo.value=="")
	{
		ShowAlert('111','the Residence Proof Reference');
		document.forms[0].txt_ResiIDRefNo.focus();
		return true;
	}
	if(document.forms[0].txt_Risk.value=="")
	{
		ShowAlert('111','the Risk Categorization');
		document.forms[0].txt_Risk.focus();
		return true;
	}
	if(document.forms[0].hid_Activity.value=="0")
	{
		ShowAlert('111','the Nature of Activity');
		document.forms[0].hid_Activity.focus();
		return true;
	}
	if(document.forms[0].txt_doc_date.value=="")
	{
		ShowAlert('111','Residence ID Date');
		document.forms[0].txt_doc_date.focus();
		return true;
	}	
	if(perapp_const!="01")
	{
		if(document.forms[0].txt_Activitykyc.value=="")
		{
			ShowAlert('111','Nature of Activity(Proposal description)');
			document.forms[0].txt_Activitykyc.focus();
			return true;
		}
	}
	
	/*if(document.forms[0].txt_SourceIncome.value=="")
	{
		ShowAlert('111','the Source of Income');
		document.forms[0].txt_SourceIncome.focus();
		return true;
	}
	if(document.forms[0].txt_Networth.value=="")
	{
		ShowAlert('111','the Networth');
		document.forms[0].txt_Networth.focus();
		return true;
	}*/
/*	if(document.forms[0].sel_CustType.value=="Y")
	{*/
		/*if(document.forms[0].txt_TurnOver.value=="")
		{
			ShowAlert('111','the Annual Turn Over');
			document.forms[0].txt_TurnOver.focus();
			return true;
		}
		if(document.forms[0].txt_EstiTurnOver.value=="")
		{
			ShowAlert('111','the Annual Turn Over (Estimated)');
			document.forms[0].txt_EstiTurnOver.focus();
			return true;
		}
	//}
	if(document.forms[0].sel_Account.value=="")
	{
		ShowAlert('111','Pooled Account');
		document.forms[0].sel_Account.focus();
		return true;
	}
	if(document.forms[0].sel_OFAC.value=="")
	{
		ShowAlert('111','the OFAC/UNSCAN');
		document.forms[0].sel_OFAC.focus();
		return true;
	}*/
	

/*	if(varcons=="007")
	{
	
		if(document.forms[0].sel_sleeppartner.value=="")
		{
			ShowAlert('111','Sleeping Partners');
			document.forms[0].sel_sleeppartner.focus();
			return true;
		}

	}
	if(varcons=="005")
	{
	
		if(document.forms[0].sel_familyshare.value=="")
		{
			ShowAlert('111','Family Share');
			document.forms[0].sel_familyshare.focus();
			return true;
		}

	}
	if(ownership=="OP")
	{
		if(document.forms[0].sel_sleeppartner.value=="")
		{
			ShowAlert('111','Sleeping Partners');
			document.forms[0].sel_sleeppartner.focus();
			return true;
		}
	}
	
	if(ownership=="OLP")
	{
		if(document.forms[0].sel_familyshare.value=="")
		{
			ShowAlert('111','Family Share');
			document.forms[0].sel_familyshare.focus();
			return true;
		}
	
	}

	if(varstatus=="2")
	{
		if(document.forms[0].sel_politicalexposed.value=="")
		{
			ShowAlert('111','Political Exposed');
			document.forms[0].sel_politicalexposed.focus();
			return true;
		}
	}*/
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidRecordflag.value = varRecordFlag;
		document.forms[0].hidAction.value="insert"
		document.forms[0].hidBeanId.value="mastapplicant"
		document.forms[0].hidBeanMethod.value="updateKYCNormsdetails";
		document.forms[0].hidBeanGetMethod.value="getKYCNormsdetails";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/set_KYCNorms.jsp";
		document.forms[0].submit();
}
function fnCallMandatory()
{
	if(varcons=="007")
	{
		document.all.id_sleepingpartner.innerText = "*";
	}
	else{
		document.all.id_sleepingpartner.innerText = "";
	}
	if(varcons=="005")
	{
		document.all.id_familyshare.innerText = "*";
	}
	else{
		document.all.id_familyshare.innerText = "";
	}
	if(ownership=="OP")
	{
		document.all.id_sleepingpartner.innerText = "*";
	}
	else{
		document.all.id_sleepingpartner.innerText = "";
	}
	
	if(ownership=="OLP")
	{
		document.all.id_familyshare.innerText = "*";
	}
	else{
		document.all.id_familyshare.innerText = "";
	}

	if(varstatus=="2")
	{
		document.all.id_politicalexpos.innerText = "*";
	}
	else{
		document.all.id_politicalexpos.innerText = "";
	}
	
	/*if(document.forms[0].hid_custoccup.value=="MISC")
	{
		document.all.id_occupation.innerText = "*";
	}
	else{
		document.all.id_occupation.innerText = "";
	}*/
}

function showCitySearch(varTextControl,varTextControl1,varHidControl,varHidControl1,varTextControl2,varHidControl2)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = "<%=ApplicationParams.getAppUrl()%>action/searchCity.jsp?hidcitycontrol="+varTextControl+"&hidstatecontrol="+varTextControl1+"&hidcitycodecontrol="+varHidControl+"&hidstatecodecontrol="+varHidControl1+"&hidzipcontrol="+varTextControl2+"&hidzipvaildatorcontrol="+varHidControl2;
		var title = "City";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}	
}

function callCntrySearch(varTextControl,varHidControl)
{	
	if(document.forms[0].cmdedit.disabled)
	{
		var varQryString = appURL+"action/searchCountry.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getCountrySearchList"+"&hidcntrycontrol="+varTextControl+"&hidcntrycodecontrol="+varHidControl;
		var title = "Country";
		var prop = "scrollbars=no,width=650,height=400";	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);	
	}
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		/*if(document.forms[0].hidModuleName.value=='T')
		{
			document.forms[0].action=appURL+"action/agrappmastersearch.jsp";	
			document.forms[0].submit();
		}
		else if(document.forms[0].hidModuleName.value=='P')
		{*/
			document.forms[0].action=appURL+"action/mastersearchper.jsp";
			document.forms[0].submit();
		/*}
		else 
		{
			document.forms[0].method="post";
			document.forms[0].action=appURL+"action/comappmastersearch.jsp";
			document.forms[0].submit();
		}*/
	}
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="mastapplicant"
		document.forms[0].hidBeanGetMethod.value="getKYCNormsdetails";
		document.forms[0].action=appURL+"action/set_KYCNorms.jsp";
		document.forms[0].submit();
	}
}

function doDelete()
{
	if(varRecordFlag=="Y")
	{
	  	if(ConfirmMsg(101))
	  	{
			document.forms[0].hidAction.value="delete"
		 	document.forms[0].hidBeanId.value="mastapplicant"
			document.forms[0].hidBeanMethod.value="updateKYCNormsdetails";
			document.forms[0].hidBeanGetMethod.value="getKYCNormsdetails";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/set_KYCNorms.jsp";
	 		document.forms[0].submit();
	  	}
   	}
	else
	{
		ShowAlert(158);
	}
}

function callRemitCountry()
{
	if(document.forms[0].sel_Remittance.value=="Y")
	{
		document.all.RemitCntry1.style.visibility="visible";
		document.all.RemitCntry2.style.visibility="visible";
		document.all.RemitCntry1.style.position="relative";
		document.all.RemitCntry2.style.position="relative";
	}
	else
	{
		document.all.RemitCntry1.style.visibility="hidden";
		document.all.RemitCntry2.style.visibility="hidden";
		document.all.RemitCntry1.style.position="absolute";
		document.all.RemitCntry2.style.position="absolute";
		document.forms[0].txt_RemitCountry.value="";
	}
}

function callLink(page,bean,method)
{
	if (document.forms[0].cmdsave.disabled == true)
	{
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
function callCalender(name)
{

if(document.forms[0].cmdsave.disabled==false)
	{
	
	showCal(appURL,name);
	}
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callLoad()">
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
<form method="post" class="normal">

<%if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equals("")) { %>

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt;  Customer
		Profile -&gt; KYCNorms</td>
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
			<jsp:param name="pageid" value="3" />
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
			<jsp:param name="subsubpageid" value="23" />
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
			<jsp:param name="subsubpageid" value="23"/>
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %>
<jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value=""/>
			<jsp:param name="subsubpageid" value="23"/>
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
		<td class="page_flow">Home -&gt;Agriculture -&gt;Application -&gt; Applicant -&gt; Customer Profile -&gt; KYC Norms</td>
	</tr>
	<%}else{ %>
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Application -&gt; Applicant -&gt; Customer Profile -&gt; KYC Norms</td>
	</tr>
	
  </table>
<%}}else if(strSessionModuleType.equalsIgnoreCase("LAD") || strSessionModuleType.equalsIgnoreCase("RET")){ %>
        <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="<%=pageid%>" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; 
       Retail(including schematic) -&gt; Application -&gt; Applicant/Guarantor -&gt; KYC Norms</td>
    </tr>
  </table>
  <%} else { %>
   <jsp:include page="../share/applurllinkerdigi.jsp" flush="true"> 
        <jsp:param name="pageid" value="<%=pageid%>" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; 
       Digi Retail -&gt; Application -&gt; Applicant/Guarantor -&gt; KYC Norms</td>
    </tr>
  </table>
  <% }  %>
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
		<%}%>
		<%if(strapptype.equalsIgnoreCase("C") || strapptype.equalsIgnoreCase("R")){ %>
		<tr>
		<td><jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value="23"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
	</table>
<%} }%>

<% }  %>

<table width="100%" border="0" cellspacing="0" cellpadding="2"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable border1">
			<tr>
				<td>
				<table width="90%" border="0" cellspacing="3" cellpadding="3"
					align="center" class="outertable">
				<!--  	<tr>
						<td width="17%">Corporate Customer<span class="mantatory">*&nbsp;</span></td>
						<td width="33%"><select name="sel_CustType">
							<option value="" selected>--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
						<td width="16%">Annual Income<span class="mantatory">*&nbsp;</span></td>
						<td width="34%"><input type="text" name="hid_AnnualIncome"
							size="6"
							value="<%=Helper.correctNull((String)hshValues.get("annualincomecode"))%>">
						<input type="text" name="txt_AnnualIncome" size="40"
							maxlength="20"
							value="<%=Helper.correctNull((String)hshValues.get("annualincomedesc"))%>">
						<span onClick="callDescHelp('53')" style="cursor: hand"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span></td>
					</tr>-->
					<tr>
						<td width="17%">Customer Occupation<span class="mantatory">*&nbsp;</span></td>
						<td width="33%" nowrap><input type="text" class="finaclefieldsbgcolor"
							name="hid_custoccup" size="6"
							value="<%=Helper.correctNull((String)hshValues.get("custoccupcode"))%>">
						<input type="text" name="txt_custoccup" size="40" maxlength="20" class="finaclefieldsbgcolor"
							value="<%=Helper.correctNull((String)hshValues.get("custoccupdesc"))%>">
						<a href="#" onClick="callDescHelp('70')" style="cursor: hand"
							tabindex="8"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0" tabindex=""></a></td>

						<td width="16%">Since</td>

						<td width="34%"><input type="text" name="txt_sinceoccupation" size="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("kyc_sinceoccupation"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate)" maxlength="12">
							<a style="vertical-align: middle" alt="Select date from calender" href="#"
							onClick="callCalender('txt_sinceoccupation')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
					</tr>
					<!-- <tr>
						<td width="17%">Form 60/61</td>
						<td width="33%"><select name="sel_Form">
							<option value="" selected>Select</option>
							<option value="60">60</option>
							<option value="61">61</option>
							<option value="NR">NRI</option>
						</select></td>
						<td width="16%">Country of residence<span class="mantatory">*&nbsp;</span></td>
						<td width="34%"><input type="hidden" name="hid_CountryResi"
							size="6"
							value="<%=Helper.correctNull((String)hshValues.get("countryresicode"))%>">
						<input type="text" name="txt_CountryResi" size="40" maxlength="20"
							value="<%=Helper.correctNull((String)hshValues.get("countryresidesc"))%>">
						<a href="#"
							onClick="callCntrySearch('txt_CountryResi','hid_CountryResi')"
							style="cursor: hand" tabindex="8"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0" tabindex="21"></a></td>
					</tr>-->
					<tr>
						<!--  <td width="17%">Ref No</td>
						<td width="33%"><input type="text" name="txt_FormRefNo"
							size="40" maxlength="25"
							value="<%=Helper.correctNull((String)hshValues.get("formrefno"))%>">
						</td>-->
						
						<td width="17%">ID Proof Type<span class="mantatory">*&nbsp;</span></td>
						<td width="33%"><input type="text" name="hid_IdProofType" class="finaclefieldsbgcolor"
							size="6"
							value="<%=Helper.correctNull((String)hshValues.get("idprooftypecode"))%>">
						<input type="text" name="txt_IdProofType" size="40" maxlength="20" class="finaclefieldsbgcolor"
							value="<%=Helper.correctNull((String)hshValues.get("idprooftypedesc"))%>">
						<span onClick="callDescHelp('54')" style="cursor: hand"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span></td>
						
						
						<td width="16%" nowrap="nowrap">Residence Proof Type<span class="mantatory">*&nbsp;</span></td>
						<td width="34%"><input type="text" name="hid_ResiProofType"
							size="6"
							value="<%=Helper.correctNull((String)hshValues.get("resiprooftypecode"))%>">
						<input type="text" name="txt_ResiProofType" size="40"
							maxlength="20"
							value="<%=Helper.correctNull((String)hshValues.get("resiprooftypedesc"))%>">
						<span onClick="callDescHelp('55')" style="cursor: hand"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span></td>
					</tr>
					<tr>
						<td width="17%">ID Reference<span class="mantatory">*&nbsp;</span></td>
						<td width="33%"><input type="text" name="txt_IDProofRef" class="finaclefieldsbgcolor"
							size="40" maxlength="25"
							value="<%=Helper.correctNull((String)hshValues.get("idproofref"))%>">
						</td>
						<td width="16%" nowrap>Residence ID Reference <span class="mantatory">*&nbsp;</span></td>
						<td width="34%"><input type="text" name="txt_ResiIDRefNo"
							size="40" maxlength="25"
							value="<%=Helper.correctNull((String)hshValues.get("resiidrefno"))%>">
						</td>
					</tr>
					
					<tr>
						<td width="17%">Valid Upto</td>
						<td width="33%" nowrap><input type="text" name="txt_id_valid" size="11"
							onBlur="checkDate(document.forms[0].txt_id_valid);"
							value="<%=Helper.correctNull((String) hshValues
							.get("kyc_id_valid"))%>"
							 maxlength="12">
							<a style="vertical-align: middle" alt="Select date from calender" href="#"
							onClick="callCalender('txt_id_valid')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>

						<td width="16%">Valid Upto</td>
						<td width="34%"><input type="text" name="txt_residence_valid" size="11"
							onBlur="checkDate(document.forms[0].txt_residence_valid);"
							value="<%=Helper.correctNull((String) hshValues
							.get("kyc_residence_valid"))%>"
							 maxlength="12">
							<a style="vertical-align: middle" alt="Select date from calender" href="#"
							onClick="callCalender('txt_residence_valid')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
					</tr>
					
					
					
					
					<!--<tr>
						
						<!--<td width="16%">Source of Income <span class="mantatory">*&nbsp;</span></td>
						<td width="34%"><input type="text" name="hid_SourceIncome"
							size="6"
							value="<%=Helper.correctNull((String)hshValues.get("sourceincomecode"))%>">
						<input type="text" name="txt_SourceIncome" size="40" maxlength="5"
							value="<%=Helper.correctNull((String)hshValues.get("sourceincomedesc"))%>">
						<span onClick="callDescHelp('56')" style="cursor: hand"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span></td>
					</tr>-->
					<!--  <tr>
						<td width="17%">Networth (in Rs) <span class="mantatory">*&nbsp;</span></td>
						<td width="33%"><input type="text" name="hid_Networth"
							size="6"
							value="<%=Helper.correctNull((String)hshValues.get("networthcode"))%>">
						<input type="text" name="txt_Networth" size="40" maxlength="5"
							value="<%=Helper.correctNull((String)hshValues.get("networthdesc"))%>">
						<span onClick="callDescHelp('57')" style="cursor: hand"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span></td>
						<td width="16%">Pooled Account <span class="mantatory">*&nbsp;</span></td>
						<td width="34%"><select name="sel_Account">
							<option value="" selected>Select</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
					</tr>-->
					<tr>
						<!--<td width="17%">Annual Turn Over <span class="mantatory">*&nbsp;</span></td>
						<td width="33%"><input type="text" name="hid_TurnOver"
							size="6"
							value="<%=Helper.correctNull((String)hshValues.get("turnovercode"))%>">
						<input type="text" name="txt_TurnOver" size="40" maxlength="5"
							value="<%=Helper.correctNull((String)hshValues.get("turnoverdesc"))%>">
						<span onClick="callDescHelp('58')" style="cursor: hand"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0" tabindex="7"></span></td>-->
						<td width="17%">Risk Categorization <span class="mantatory">*&nbsp;</span></td>
						<td width="33%"><input type="text" name="hid_Risk" size="6" class="finaclefieldsbgcolor"
							value="<%=Helper.correctNull((String)hshValues.get("riskcode"))%>">
						<input type="text" name="txt_Risk" size="40" maxlength="20" class="finaclefieldsbgcolor"
							value="<%=Helper.correctNull((String)hshValues.get("riskdesc"))%>">
						<span onClick="callDescHelp('61')" style="cursor: hand"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span></td>
						
						<td width="16%">Nature of Activity <span class="mantatory">*&nbsp;</span></td>
						<!--<td width="34%"><input type="text" name="hid_Activity"
							size="6"
							value="">
						<input type="text" name="txt_Activity" size="40" maxlength="20"
							value="<%=Helper.correctNull((String)hshValues.get("activitydesc"))%>">
						<span onClick="callDescHelp('60')" style="cursor: hand"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span></td>
					-->
					
					<td width="34%"><select name="hid_Activity" style="width: 200px" >
                    <option value="0">---Select-----</option>
                    <%String apptype="60"; %>
                    <lapschoice:StaticDataNewTag apptype='<%=apptype%>'/> 
                   
                  </select>
                </td>
					
					</tr>
					
					<tr>
					<%if(!perapp_const.equals("01")) { %>
						<td>Nature of Activity(Proposal description)<span class="mantatory">*&nbsp;</span></td>
					<% } else { %>
						<td>Nature of Activity(Proposal description)</td>
					<% } %>
					<td ><input type="text" name="txt_Activitykyc" maxlength="280" size="50" onkeypress="allowAlphabetsForName()" value="<%=Helper.correctNull((String)hshValues.get("kyc_kycActivity"))%>"></td>
					<td width="16%">Residence ID Date<span class="mantatory">*&nbsp;</span></td>
						<td width="34%"><input type="text" name="txt_doc_date" size="11"
							onBlur="checkDate(document.forms[0].txt_doc_date);checkmaxdate(this,curdate);"
							value="<%=Helper.correctNull((String) hshValues
							.get("KYC_DOC_DATE"))%>"
							 maxlength="12">
							<a style="vertical-align: middle" alt="Select date from calender" href="#"
							onClick="callCalender('txt_doc_date')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
					</tr>
					<table align="center" width="15%">
					<tr style="height:30px;">
					<td width="25%" align="center" style="background-color: #8450a7; color:white"> <b>Beneficial Owner Details</b></td>
					</tr>
					</table>
					<tr>
					<table width="100%" border='1' style='border-collapse:collapse' class="outertable" >
					<tr style="height:30px;">
					<th style="background-color: #eccbe8;" width="12%" align="center">
					Beneficial Owner Customer ID
					</th >
					<th style="background-color: #eccbe8;"  width="12%" align="center">
					Name of the Beneficial Owner
					</th>
					<th style="background-color: #eccbe8;"  width="12%" align="center">
					Identification Document
					</th>
					<th style="background-color: #eccbe8;"  width="12%" align="center">
					Identification Document Number
					</th>
					<th style="background-color: #eccbe8;"  width="12%" align="center">
					Percentage of shares held
					</th>
					<th style="background-color: #eccbe8;"  width="12%" align="center">
					Relationship with the borrower
					</th>
					<th style="background-color: #eccbe8;"  width="12%" align="center">
					No of shares held
					</th>
					<th style="background-color: #eccbe8;"  width="12%" align="center">
					Gvarantee available
					</th>
					</tr>
					<%
			if (arrRow != null && arrRow.size() > 0) {
				if (arrRow.size() > 0) {
					for (int i = 0; i < arrRow.size(); i++) {
						arrCol = (ArrayList) arrRow.get(i);
						%>
			<tr>
			
				<td width="12%" align="center"><input type="text" name="bene_owner_cus" class="finaclefieldsbgcolor"
							value="<%=Helper.correctNull((String)arrCol.get(0))%>" ></td>
				<td width="12%" align="center"><input type="text" name="name_of_beneficial" class="finaclefieldsbgcolor"
							value="<%=Helper.correctNull((String)arrCol.get(1))%>" ></td>
				<td width="12%" align="center"><input type="text" name="identi_docu"  class="finaclefieldsbgcolor"
							value="<%=Helper.correctNull((String)arrCol.get(2))%>" ></td>
				 <td width="12%" align="center"><input type="text" name="identi_docu_num"  class="finaclefieldsbgcolor"
							value="<%=Helper.correctNull((String)arrCol.get(3))%>" ></td>
				<td width="12%" align="center"><input type="text" name="percent_of_shares_held"  class="finaclefieldsbgcolor"
							value="<%=Helper.correctNull((String)arrCol.get(4))%>" ></td>
			   <td width="12%" align="center"><input type="text" name="relationship_with_borrower"  class="finaclefieldsbgcolor"
							value="<%=Helper.correctNull((String)arrCol.get(5))%>" ></td>
				<td width="12%" align="center"><input type="text" name="no_of_shares_held"  class="finaclefieldsbgcolor"
							value="<%=Helper.correctNull((String)arrCol.get(6))%>" ></td>
					<td width="12%" align="center" ><input type="text" name="gvarantee_available" class="finaclefieldsbgcolor"
							value="<%=Helper.correctNull((String)arrCol.get(7))%>" ></td>

			<%}
				}%>
			</tr>
			<%}%>
		</table>
		</tr>
				<!-- <tr>
						<td width="17%">Annual Turn Over (Estimated) <span class="mantatory">*&nbsp;</span></td>
						<td width="33%"><input type="text" name="hid_EstiTurnOver"
							size="6"
							value="<%=Helper.correctNull((String)hshValues.get("estiturnovercode"))%>">
						<input type="text" name="txt_EstiTurnOver" size="40" maxlength="5"
							value="<%=Helper.correctNull((String)hshValues.get("estiturnoverdesc"))%>">
						<span onClick="callDescHelp('59')" style="cursor: hand"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span></td>
						<td width="16%">OFAC/UNSCAN <span class="mantatory">*&nbsp;</span></td>
						<td width="34%"><select name="sel_OFAC">
							<option value="" selected>Select</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
					</tr>
					<tr>
						<td width="17%">Foreign Inward Remittance</td>
						<td width="33%"><select name="sel_Remittance"
							onchange="callRemitCountry()">
							<option value="" selected>Select</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
						<td width="16%" id="RemitCntry1">Remit Country</td>
						<td width="34%" id="RemitCntry2"><input type="hidden"
							name="hid_RemitCountry" size="6"
							value="<%=Helper.correctNull((String)hshValues.get("remitcountrycode"))%>">
						<input type="text" name="txt_RemitCountry" size="40"
							maxlength="20"
							value="<%=Helper.correctNull((String)hshValues.get("remitcountrydesc"))%>">
						<a href="#"
							onClick="callCntrySearch('txt_RemitCountry','hid_RemitCountry')"
							style="cursor: hand" tabindex="8"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0" tabindex="21"></a></td>
					</tr>
					<tr>
						
						<!--  <td width="16%">Sleeping Partners <span class="mantatory" id="id_sleepingpartner">*&nbsp;</span></td>
						<td width="34%"><select name="sel_sleeppartner" onchange="">
							<option value="" selected>Select</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
					</tr>
				<!--	<tr>
						<td width="17%">Political Exposed <span class="mantatory" id="id_politicalexpos">*&nbsp;</span></td>
						<td width="33%"><select name="sel_politicalexposed"
							onchange="">
							<option value="" selected>Select</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
						<td width="16%">Family Share <span class="mantatory" id="id_familyshare">*&nbsp;</span></td>
						<td width="34%"><select name="sel_familyshare" onchange="">
							<option value="" selected>Select</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
					</tr>
					<tr>
						<td colspan="4" height="31">Client's Client</td>
					</tr>
					<tr>
						<td colspan="4">
						<table width="100%" border="0" cellspacing="3" cellpadding="3"
							align="center" class="outertable">
							<tr>
								<td colspan="3">Client 1</td>
								<td colspan="3">Client 3</td>
							</tr>
							<tr>
								<td width="2%">&nbsp;</td>
								<td width="18%">Name</td>
								<td width="28%"><input type="text" name="txt_clientname1"
									size="40" maxlength="80"
									value="<%=Helper.correctNull((String)hshValues.get("clientname_1"))%>">
								</td>
								<td width="18%">&nbsp;&nbsp;Name</td>
								<td width="31%"><input type="text" name="txt_clientname3"
									size="40" maxlength="80"
									value="<%=Helper.correctNull((String)hshValues.get("clientname_3"))%>">
								</td>
							</tr>
							<tr>
								<td width="2%">&nbsp;</td>
								<td width="18%">Address</td>
								<td width="28%"><input type="text" name="txt_location1"
									size="40" maxlength="45"
									value="<%=Helper.correctNull((String)hshValues.get("clientlocation_1"))%>">
								</td>
								<td width="18%">&nbsp;&nbsp;Address</td>
								<td width="31%"><input type="text" name="txt_location3"
									size="40" maxlength="45"
									value="<%=Helper.correctNull((String)hshValues.get("clientlocation_3"))%>">
								</td>
							</tr>
							<tr>
								<td width="2%">&nbsp;</td>
								<td width="18%">City</td>
								<td width="28%"><input type="text" name="txt_city1"
									size="40" maxlength="20"
									value="<%=Helper.correctNull((String)hshValues.get("client1citydesc"))%>">
								<a href="#"
									onClick="showCitySearch('txt_city1','txt_state1','hid_city1','hid_state1','hid_zip1','hidres1')"
									style="cursor: hand" tabindex="8"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0" tabindex="21"></a> <input type="hidden"
									name="hid_city1" size="40" maxlength="20"
									value="<%=Helper.correctNull((String)hshValues.get("client1citycode"))%>">
								<input type="hidden" name="txt_state1" size="40" maxlength="20"
									value="<%=Helper.correctNull((String)hshValues.get("client1statedesc"))%>">
								<input type="hidden" name="hid_state1" size="40" maxlength="20"
									value="<%=Helper.correctNull((String)hshValues.get("client1statecode"))%>">
								</td>
								<td width="18%">&nbsp;&nbsp;City</td>
								<td width="31%"><input type="text" name="txt_city3"
									size="40" maxlength="20"
									value="<%=Helper.correctNull((String)hshValues.get("client3citydesc"))%>">
								<a href="#"
									onClick="showCitySearch('txt_city3','txt_state3','hid_city3','hid_state3','hid_zip2','hidres2')"
									style="cursor: hand" tabindex="8"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0" tabindex="21"></a> <input type="hidden"
									name="hid_city3" size="40" maxlength="20"
									value="<%=Helper.correctNull((String)hshValues.get("client3citycode"))%>">
								<input type="hidden" name="txt_state3" size="40" maxlength="20"
									value="<%=Helper.correctNull((String)hshValues.get("client3statedesc"))%>">
								<input type="hidden" name="hid_state3" size="40" maxlength="20"
									value="<%=Helper.correctNull((String)hshValues.get("client3statecode"))%>">
								</td>
							</tr>
							<tr>
								<td width="2%">&nbsp;</td>
								<td width="18%">Country</td>
								<td width="28%"><input type="text" name="txt_cntry1"
									size="40" maxlength="20"
									value="<%=Helper.correctNull((String)hshValues.get("client1cntrydesc"))%>">
								<a href="#" onClick="callCntrySearch('txt_cntry1','hid_cntry1')"
									style="cursor: hand" tabindex="8"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0" tabindex="21"></a> <input type="hidden"
									name="hid_cntry1" size="40" maxlength="20"
									value="<%=Helper.correctNull((String)hshValues.get("client1cntrycode"))%>">
								</td>
								<td width="18%">&nbsp;&nbsp;Country</td>
								<td width="31%"><input type="text" name="txt_cntry3"
									size="40" maxlength="20"
									value="<%=Helper.correctNull((String)hshValues.get("client3cntrydesc"))%>">
								<a href="#" onClick="callCntrySearch('txt_cntry3','hid_cntry3')"
									style="cursor: hand" tabindex="8"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0" tabindex="21"></a> <input type="hidden"
									name="hid_cntry3" size="40" maxlength="20"
									value="<%=Helper.correctNull((String)hshValues.get("client3cntrycode"))%>">
								</td>
							</tr>
							<tr>
								<td colspan="5">Client 2</td>
							</tr>
							<tr>
								<td width="2%">&nbsp;</td>
								<td width="18%">Name</td>
								<td width="28%"><input type="text" name="txt_clientname2"
									size="40" maxlength="80"
									value="<%=Helper.correctNull((String)hshValues.get("clientname_2"))%>">
								</td>
							</tr>
							<tr>
								<td width="2%">&nbsp;</td>
								<td width="18%">Address</td>
								<td width="28%"><input type="text" name="txt_location2"
									size="40" maxlength="45"
									value="<%=Helper.correctNull((String)hshValues.get("clientlocation_2"))%>">
								</td>
							</tr>
							<tr>
								<td width="2%">&nbsp;</td>
								<td width="18%">City</td>
								<td width="28%"><input type="text" name="txt_city2"
									size="40" maxlength="20"
									value="<%=Helper.correctNull((String)hshValues.get("client2citydesc"))%>">
								<a href="#"
									onClick="showCitySearch('txt_city2','txt_state2','hid_city2','hid_state2','hid_CountryResi','hid_zip')"
									style="cursor: hand" tabindex="8"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0" tabindex="21"></a> <input type="hidden"
									name="hid_city2" size="40" maxlength="20"
									value="<%=Helper.correctNull((String)hshValues.get("client2citycode"))%>">
								<input type="hidden" name="txt_state2" size="40" maxlength="20"
									value="<%=Helper.correctNull((String)hshValues.get("client2statedesc"))%>">
								<input type="hidden" name="hid_state2" size="40" maxlength="20"
									value="<%=Helper.correctNull((String)hshValues.get("client2statecode"))%>">
								</td>
							</tr>
							<tr>
								<td width="2%">&nbsp;</td>
								<td width="18%">Country</td>
								<td width="28%"><input type="text" name="txt_cntry2"
									size="40" maxlength="20"
									value="<%=Helper.correctNull((String)hshValues.get("client2cntrydesc"))%>">
								<a href="#" onClick="callCntrySearch('txt_cntry2','hid_cntry2')"
									style="cursor: hand" tabindex="8"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0" tabindex="21"></a> <input type="hidden"
									name="hid_cntry2" size="40" maxlength="20"
									value="<%=Helper.correctNull((String)hshValues.get("client2cntrycode"))%>">
								</td>
							</tr>-->
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
<br>

	<%if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equals("")) { %>	
	<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail'
		btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
   <% }  else { %>
	 <span style="display: none;"> <div>
			<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail'
			btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
		</div>	</span>		
		<lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
	<% } %>
	
<br>
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="hidModuleName" value="<%=strModuleName%>"> <input
	type="hidden" name="hidDemoId"
	value="<%=Helper.correctNull((String)hshValues.get("cust_id"))%>">
<input type="hidden" name="comapp_id"
	value="<%=Helper.correctNull((String)hshValues.get("cust_id"))%>">
<input type="hidden" name="hidappstatus" value="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>"> 
<input type="hidden" name="hidappexist"
	value="<%=Helper.correctNull((String)request.getParameter("hidappexist"))%>">
<input type="hidden" name="hidCategoryType"
	value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>">
<input type="hidden" name="txtperapp_appid" value="<%=Helper.correctNull((String)hshValues.get("cust_id"))%>"> 
<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
	
	<input type="hidden" name="hidapp_name"
	value="<%=strappname%>">
	<input type="hidden" name="hid_zip">
	<input type="hidden" name="hid_zip1">
	<input type="hidden" name="hid_zip2">
	<input type="hidden" name="hidres1">
	<input type="hidden" name="hidres2">
	 <input type="hidden" name="hidzip" value="<%=Helper.correctNull((String) hshValues.get("state_validatepin"))%>">
<input type="hidden" name="hidfacname"	value="<%=hidfacname%>">
</form>
</body>
</html>


