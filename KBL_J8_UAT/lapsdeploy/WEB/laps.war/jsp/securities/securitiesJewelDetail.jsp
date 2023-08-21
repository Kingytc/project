<%@include file="../share/directives.jsp"%>
<%
String sectype = Helper.correctNull((String) request.getParameter("hidsectype"));
String strsecID = Helper.correctNull((String) request.getParameter("hidsecid"));
String strPagefrom = Helper.correctNull((String) request.getParameter("pagefrom"));
java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);
			String strProfilestatus = Helper.correctNull((String) hshValues
					.get("strProfilestatus"));
			String tempProfile = "";
			if (strProfilestatus.equalsIgnoreCase("Y")) {
				tempProfile = "Completed";
			} else {
				tempProfile = " Not Completed";
			}
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
		//	out.println(strProfilestatus);
		String pageid = Helper.correctNull((String) request.getParameter("pageid"));
		String strEmployment=(String)session.getAttribute("strEmployment");
		String strAppid = Helper.correctNull((String) hshValues
				.get("strAppid"));
		String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
		String grpRights = Helper.correctNull((String) session.getAttribute("strGroupRights"));
%>
<html>
<head>
<title>Personal - Applicant Securities</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
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
var varVerificationFlag="<%=Helper.correctNull((String)hshValues.get("hid_VerificationFlag"))%>";

function callLoad()
{
	callDisable(true);
	
	//if(document.forms[0].hidappstatus.value=="true" || document.forms[0].hidappexist.value=="true")
	//{
	//	disableControls(false,true,true,true,false);
	//}
	//else
	//{
	//	disableControls(false,true,true,true,false);
	//}
	
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

	<%if(grpRights.charAt(18)=='r'){%>
	document.forms[0].cmdedit.disabled=true;
<%}%>

	if(varVerificationFlag=="V")
	{
		document.forms[0].cmdedit.disabled=true;
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
	if(document.forms[0].cmdedit.disabled)
	{
		var varQryString = appURL+"action/ops_sanctionhelp.jsp?id="+id+"&pagename=kycnorms&hidBeanId=additionalParameter&hidBeanGetMethod=getSearch";
		var title = "CBS_DATAS_HELP";
		var prop = "scrollbars=no,width=650,height=400";	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);	
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
	
	
}

function disableControls(bcmdEdit,bcmdSave,bcmdDelete,bcmdCancel,bcmdClose)
{
	document.forms[0].cmdedit.disabled=bcmdEdit;
	document.forms[0].cmdsave.disabled=bcmdSave;
	document.forms[0].cmddelete.disabled=bcmdDelete;
	document.forms[0].cmdcancel.disabled=bcmdCancel;
	document.forms[0].cmdclose.disabled=bcmdClose;
}

function doEdit() 
{
	callDisable(false);
	disableControls(true,false,false,false,true);
	document.forms[0].txt_amount.readOnly=true;
	//document.forms[0].sel_CustType.focus();
}

function dobtnClose()
{
	if (ConfirmMsg(100)) 
	{
		<%if(strPagefrom.equalsIgnoreCase("appl")&&(strSessionModuleType.equalsIgnoreCase("RET"))){%>
		document.forms[0].hidBeanId.value="bankappfi"
		document.forms[0].hidBeanGetMethod.value="getSecurityRetailDetails";
		document.forms[0].action=appURL+"action/securitymaster_retail.jsp";
		document.forms[0].submit();
	<%}else if(strPagefrom.equalsIgnoreCase("secmailbox")){%>
		window.close();
	<%}else{%>
		document.forms[0].hidBeanId.value="securitymaster"
		document.forms[0].hidBeanGetMethod.value="getSecurityValuesDetails";
		document.forms[0].action=appURL+"action/securitiesMasterPage.jsp";
		document.forms[0].submit();
		<%}%>
	}
}

function doSave()
{
	if(trim(document.forms[0].txt_descjewel.value) == "")
	{
		document.forms[0].txt_descjewel.value="";
		ShowAlert('121','Description of Jewels');
		document.forms[0].txt_descjewel.focus();
		return;
	}
	if(document.forms[0].txt_netweight.value == "0" ||
			document.forms[0].txt_netweight.value == "")
	{
		document.forms[0].txt_netweight.value="";
		ShowAlert('121','Net weight in grams');
		document.forms[0].txt_netweight.focus();
		return;
	}
	if(document.forms[0].txt_marketrate.value == "" ||
			document.forms[0].txt_marketrate.value == "0.00")
	{
		document.forms[0].txt_marketrate.value = "";
		ShowAlert('121','Market rate per gram');
		document.forms[0].txt_marketrate.focus();
		return;
	}

	modidyCheck();
	
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value="update"
	document.forms[0].hidSourceUrl.value="/action/securitiesJewelDetail.jsp";
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanMethod.value="updateJewelDetail";
	document.forms[0].hidBeanGetMethod.value="getJewelDetail";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function modidyCheck()
{
	var temp="";
	var tempname="";
	if(document.forms[0].txt_descjewel.value!=document.forms[0].old_txt_descjewel.value)
	{
		temp=temp+"old_txt_descjewel"+"@"; 
		tempname=tempname+"Description of Jewels"+"@";
	}
	if(document.forms[0].txt_netweight.value!=document.forms[0].old_txt_netweight.value)
	{
		temp=temp+"old_txt_netweight"+"@"; 
		tempname=tempname+"Net weight in grams"+"@";
	}
	if(document.forms[0].txt_quality.value!=document.forms[0].old_txt_quality.value)
	{
		temp=temp+"old_txt_quality"+"@"; 
		tempname=tempname+"Quality  "+"@";
	}
	if(document.forms[0].txt_marketrate.value!=document.forms[0].old_txt_marketrate.value)
	{
		temp=temp+"old_txt_marketrate"+"@"; 
		tempname=tempname+"Market rate per gram"+"@";
	}
	if(document.forms[0].txt_amount.value!=document.forms[0].old_txt_amount.value)
	{
		temp=temp+"old_txt_amount"+"@"; 
		tempname=tempname+"Amount"+"@";
	}
	
	  document.forms[0].hidmodifiedvalue.value = temp;
	  document.forms[0].hidmodifiedField.value = tempname;
}
function doClose()
{
	if (ConfirmMsg(100)) {
		document.forms[0].action = appURL + "action/mainnav.jsp";
		document.forms[0].submit();
	}
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="securitymaster"
		document.forms[0].hidBeanGetMethod.value="getJewelDetail";
		document.forms[0].action=appURL+"action/securitiesJewelDetail.jsp";
		document.forms[0].submit();
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/securitiesJewelDetail.jsp";
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].hidBeanMethod.value="updateJewelDetail";
		document.forms[0].hidBeanGetMethod.value="getJewelDetail";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
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

function caculatetot()
{
	var costprice=document.forms[0].txtauto_valuation.value;
	var accessoriesprice=document.forms[0].txtauto_accessories.value;
    var txtauto_tax=document.forms[0].txtauto_tax.value;
	var txtauto_insurance=document.forms[0].txtauto_insurance.value;
	var txtauto_charges=document.forms[0].txtauto_charges.value;	
	if (costprice=="")
		{
		costprice = "0";
		}
	
	var str_dtotal1= parseFloat(costprice) + parseFloat(accessoriesprice)+parseFloat(txtauto_tax)+parseFloat(txtauto_insurance) + parseFloat(txtauto_charges);
	str_dtotal=Math.ceil(str_dtotal1);
	document.forms[0].txtauto_totcost.value=str_dtotal1;
	roundtxt(document.forms[0].txtauto_totcost)	        
}
function amounttot()
{
	var varnetweight =NanNumber(document.forms[0].txt_netweight.value);
	var varmarketrate=NanNumber(document.forms[0].txt_marketrate.value);
	if(trim(varnetweight)=="") 
	{
		document.forms[0].txt_netweight.value="0";
	}
	document.forms[0].txt_amount.value=NanNumber(varnetweight*varmarketrate);
	roundNumber(document.forms[0].txt_amount,'2');
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="callLoad()">
<form name="frmjewel" method="post" class="normal">
<jsp:include
	page="../share/help.jsp" flush="true"/>

<%if(strPagefrom.equalsIgnoreCase("appl")){ 
if(!(strSessionModuleType.equalsIgnoreCase("RET"))){
if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
	 <table width="100%" border="0" cellspacing="0" cellpadding="0"
		class="outertable">
		<tr>
			<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
				<jsp:param name="pageid" value="33" />
				<jsp:param name="subpageid" value="205" />
				<jsp:param name="cattype" value="<%=strCategoryType%>" />
				<jsp:param name="ssitype" value="<%=strSSIType%>" />
			</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
			</td>
		</tr>
	</table>
	<%}else{%>
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="33" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt; Jewel Details</td>
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../set/appurlsectabs.jsp" flush="true">
			<jsp:param name="pageid" value="8" />
		</jsp:include>
		</td>
	</tr>
</table>
<%}else if(strSessionModuleType.equalsIgnoreCase("RET")){
if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
<jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
<jsp:param name="pageid" value="<%=pageid%>" />
</jsp:include>
<table width="98%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
<tr>
<td class="page_flow" colspan="2">Home -&gt; Retail -&gt; Application -&gt; Security Master -&gt; Jewel Details</td>
</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%} else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="4" />
			<jsp:param name="subpageid" value="205" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
<td valign="top">
<jsp:include page="../set/appurlsectabs.jsp" flush="true">
	<jsp:param name="pageid" value="8" />
</jsp:include>
</td>
</tr>
</table>
<%
}}else if(strPagefrom.equals("secmailbox")) { %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td valign="top">
	<jsp:include page="../set/appurlsectabs.jsp" flush="true">
		<jsp:param name="pageid" value="8" />
	</jsp:include>
	</td>
</tr>
</table>		
<%}else{%>
<table width="98%" border="0" cellspacing="1" cellpadding="3"	class="outertable" align="center">
	<tr class="dataheader">
		<td align="left" width="10%"><b>Customer Name</b></td>
		<td align="left" width="30%"><b><%=Helper.correctNull((String)hshValues.get("perapp_fname"))%>&nbsp;</b></td>
		<td align="left" width="10%"><b>Customer CBSID</b></td>
		<td align="left" width="20%"><b><%=Helper.correctNull((String)hshValues.get("perapp_cbsid"))%>&nbsp;</b></td>
		<td align="left" width="10%"><b>Customer LAPS ID</b></td>
		<td align="left" width="20%"><b><%=Helper.correctNull((String)hshValues.get("perapp_oldid"))%>&nbsp;</b></td>
	</tr>
</table> 
<table width="98%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
	<tr>
		<td class="page_flow">Home -&gt; Securities -&gt; Jewel Details</td>
	</tr>
	
</table>
<table width="50%" border="0" cellspacing="1" cellpadding="0"
			class="outertable">
			<tr>
		<td class="sub_tab_inactive" WIDTH="50%" align="center">
			<b><a href="JavaScript:gototab('securitymaster','getSecurities','customer_securities.jsp')">
			Security Details</a></b>
		</td>
		<td  WIDTH="15%" class="sub_tab_active" align="center"><b>Jewel Details</b></td>
	</tr>
</table>
<%}%>
<table width="98%" border="0" cellpadding="3" cellspacing="0"
			align="center" class="outertable" style="border: 2px solid #dccada;">
	<tr>
		<td>
		<table width="90%" border="0" cellspacing="0" cellpadding="0"
			class="outertable" align="center">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="3" cellpadding="3"
					align="center" class="outertable">
				
					<tr>
						<td> Security ID :  <span style="color:#750b6a"> <%=Helper.correctNull((String)hshValues.get("strSecID"))%> </span>  </td>	
					</tr>
				
					<tr>
						<td width="22%">Description of Jewels<b><span class="mantatory">*&nbsp;</span></b></td>
						<td nowrap width="28%"><input type="text" tabindex="1"
							name="txt_descjewel" size="30" maxlength="50"
							value="<%=Helper.correctNull((String)hshValues.get("txt_descjewel"))%>">
						</td>

						<td width="25%">Net weight in grams<b><span class="mantatory">*&nbsp;</span></b></td>
						<td width="3%">&nbsp;</td>
						<td nowrap width="22%">
						<input type="text" name="txt_netweight" size="8" maxlength="10" 
						onKeyPress="allowNumber(document.forms[0].txt_netweight)" onBlur="amounttot();" tabindex="2"
							value="<%=Helper.correctNull((String) hshValues.get("txt_netweight"))%>"></td>
					</tr>
					
					<tr>	
						<td>Quality	</td>
						<td><input type="text" name="txt_quality" tabindex="3"
							size="30" value="<%=Helper.correctNull((String)hshValues.get("txt_quality"))%>" maxlength="50" >
						</td>
						
						
						<td>Market rate per gram<b><span class="mantatory">*&nbsp;</span></b> </td>
						<td>Rs.</td>
						<td><lapschoice:CurrencyTag
						  		name="txt_marketrate" tabindex="4" size="12" maxlength="10" 
						  		value='<%=Helper.correctNull((String)hshValues.get("txt_marketrate"))%>'
						  		onBlur="amounttot()"/>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;	</td>
						<td nowrap>Amount</td>
						<td>Rs.</td>
						<td><lapschoice:CurrencyTag 
						  		name="txt_amount" tabindex="5" size="12" maxlength="10" 
						  		value='<%=Helper.correctNull((String)hshValues.get("txt_amount"))%>'
						  		onBlur="amounttot()"/>
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
<%if(strPagefrom.equalsIgnoreCase("appl")||strPagefrom.equalsIgnoreCase("secmailbox")){%>
 <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable" align="center">
  <tr><td align="center"> 
    <input type="button" name="cmdclose" value="Close" onClick="dobtnClose()"  class="buttonClose"> 
  </td></tr>
 </table>
<%}else{ %>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<%} %>
<br>

<lapschoice:hiddentag pageid='<%=pageid%>' />
		<input type="hidden" name="txtperapp_appid"
			value="<%=Helper.correctNull((String) hshValues.get("applicantId"))%>">
		<input type="hidden" name="hidDemoId"
			value="<%=Helper.correctNull((String) request.getParameter("hidDemoId"))%>">
		<input type="hidden" name="hidSecurityId"
			value="<%=Helper.correctNull((String)request.getParameter("hidSecurityId"))%>">
<input type="hidden" name="hidsectype" value="<%=sectype%>">
<input type="hidden" name="hidsecid" value="<%=strsecID%>">

<input type="hidden" name="old_txt_descjewel"  value="<%=Helper.correctNull((String) hshValues.get("txt_descjewel"))%>">
<input type="hidden" name="old_txt_netweight" value="<%=Helper.correctNull((String) hshValues.get("txt_netweight"))%>">
<input type="hidden" name="old_txt_quality" value="<%=Helper.correctNull((String) hshValues.get("txt_quality"))%>"> 
<input type="hidden" name="old_txt_marketrate" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("txt_marketrate"))))%>">
<input type="hidden" name="old_txt_amount" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("txt_amount"))))%>">

<input type="hidden" name="hidmodifiedvalue">  
<input type="hidden" name="hidmodifiedField">  

</form>
</body>
</html>


