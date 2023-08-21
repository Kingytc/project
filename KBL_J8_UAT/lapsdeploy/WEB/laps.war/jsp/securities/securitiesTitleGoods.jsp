<%@include file="../share/directives.jsp"%>
<%
String sectype = Helper.correctNull((String) request.getParameter("hidsectype"));
String strsecID = Helper.correctNull((String) request.getParameter("hidsecid"));
String strPagefrom = Helper.correctNull((String) request.getParameter("pagefrom"));
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
	document.forms[0].hidAction.value="update";
}

function doSave()
{	
	if(document.forms[0].txt_dateissue.value == "")
	{
		ShowAlert('121','Date of Issue');
		document.forms[0].txt_dateissue.focus();
		return;
	}
	if(trim(document.forms[0].txt_issuer.value) == "")
	{
		document.forms[0].txt_issuer.value="";
		ShowAlert('121','Name of the issuer');
		document.forms[0].txt_issuer.focus();
		return;
	}
	if(document.forms[0].txt_value.value == "" ||
			document.forms[0].txt_value.value == "0.00")
	{
		document.forms[0].txt_value.value="";
		ShowAlert('121','Value');
		document.forms[0].txt_value.focus();
		return;
	}

	modifyCheck();
	
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidSourceUrl.value="/action/securitiesTitleGoods.jsp";
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanMethod.value="updateTitleGoods";
	document.forms[0].hidBeanGetMethod.value="getTitleGoods";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function modifyCheck()
{
	var temp="";
	var tempname="";
	if(document.forms[0].txt_receiptno.value!=document.forms[0].old_txt_receiptno.value)
	{
		temp=temp+"old_txt_receiptno"+"@"; 
		tempname=tempname+"Receipt No."+"@";
	}
	if(document.forms[0].txt_dateissue.value!=document.forms[0].old_txt_dateissue.value)
	{
		temp=temp+"old_txt_dateissue"+"@"; 
		tempname=tempname+"Date of Issue"+"@";
	}
	if(document.forms[0].txt_issuer.value!=document.forms[0].old_txt_issuer.value)
	{
		temp=temp+"old_txt_issuer"+"@"; 
		tempname=tempname+"Name of the issuer"+"@";
	}
	if(document.forms[0].txt_goodsheld.value!=document.forms[0].old_txt_goodsheld.value)
	{
		temp=temp+"old_txt_goodsheld"+"@"; 
		tempname=tempname+"Place where goods held"+"@";
	}
	if(document.forms[0].txt_quantity.value!=document.forms[0].old_txt_quantity.value)
	{
		temp=temp+"old_txt_quantity"+"@"; 
		tempname=tempname+"Quantity"+"@";
	}
	if(document.forms[0].txt_value.value!=document.forms[0].old_txt_value.value)
	{
		temp=temp+"old_txt_value"+"@"; 
		tempname=tempname+"Value"+"@";
	}
	
	  document.forms[0].hidmodifiedvalue.value = temp;
	  document.forms[0].hidmodifiedField.value = tempname;
}

function doClose()
{
	if (ConfirmMsg(100)) 
	{
		document.forms[0].action = appURL + "action/mainnav.jsp";
		document.forms[0].submit();
	}
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

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].hidBeanGetMethod.value="getTitleGoods";
		document.forms[0].action=appURL+"action/securitiesTitleGoods.jsp";
		document.forms[0].submit();
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/securitiesTitleGoods.jsp";
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].hidBeanMethod.value="updateTitleGoods";
		document.forms[0].hidBeanGetMethod.value="getTitleGoods";
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
function callCalender(name)
{
if(document.forms[0].cmdsave.disabled==false)
	{
	showCal(appURL,name);
	}
}
function callCalender1(name)
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
<form method="post" class="normal">
<%if(strPagefrom.equalsIgnoreCase("appl")){ 
if(!(strSessionModuleType.equalsIgnoreCase("RET"))){
if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
	 <table width="100%" border="0" cellspacing="0" cellpadding="0"
		class="outertable">
		<tr>
			<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
				<jsp:param name="pageid" value="33" />
				<jsp:param name="subpageid" value="206" />
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
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt; Title to Goods</td>
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../set/appurlsectabs.jsp" flush="true">
			<jsp:param name="pageid" value="9" />
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
<td class="page_flow" colspan="2">Home -&gt; Retail -&gt; Application -&gt; Security Master -&gt; Title to Goods</td>
</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%} else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="4" />
			<jsp:param name="subpageid" value="206" />
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
	<jsp:param name="pageid" value="9" />
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
		<jsp:param name="pageid" value="9" />
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
		<td class="page_flow">Home -&gt; Securities -&gt; Title to Goods</td>
	</tr>
</table>
<table width="50%" border="0" cellspacing="1" cellpadding="0" align="center"
			class="outertable">
			<tr>
		<td class="sub_tab_inactive_new" WIDTH="50%" align="center">
			<b><a href="JavaScript:gototab('securitymaster','getSecurities','customer_securities.jsp')">
			Security Details</a></b>
		</td>
		<td class="sub_tab_active_new" align="center"><b>Title to Goods</b></td>
	</tr>
</table>
<%} %>

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
						<td width="20%">Receipt No. </td>
						<td nowrap width="25%"><input type="text" name="txt_receiptno" size="30" maxlength="50"
							value="<%=Helper.correctNull((String)hshValues.get("txt_receiptno"))%>">
						</td>

						
                  <td width="20%">Date of Issue<b><span class="mantatory">*&nbsp;</span></b></td>
				  <td width="3%">&nbsp;</td>
                  <td nowrap width="32%">
                    <input type="text" name="txt_dateissue" size="15" maxlength="10" onBlur="checkDate(this);checkmaxdate(this,curdate)"
							value="<%=Helper.correctNull((String) hshValues.get("txt_dateissue"))%>">&nbsp; <a href="#"
							onClick="callCalender('txt_dateissue')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a></td>
					</tr>
					
					<tr>	
						<td>Name of the issuer<b><span class="mantatory">*&nbsp;</span></b></td>
						<td><input type="text" name="txt_issuer"
							size="30" value="<%=Helper.correctNull((String)hshValues.get("txt_issuer"))%>" maxlength="50" >
						</td>
						
						
						
                  <td>Place where goods held </td>
					<td width="3%">&nbsp;</td>	
                  <td>
                    <input type="text" name="txt_goodsheld" maxlength="50"  style="text-align: left" 
							size="30" value="<%=Helper.correctNull((String)hshValues.get("txt_goodsheld"))%>">
						</td>
					</tr>
					<tr>
						<td>Quantity</td>
						<td><input type="text" name="txt_quantity" maxlength="10"  style="text-align: right" onKeyPress="allowNumber(this)" 
							size="15" value="<%=Helper.correctNull((String)hshValues.get("txt_quantity"))%>">	</td>
						
                  <td nowrap>Value <b><span class="mantatory">*&nbsp;</span></b></td>
						
                  <td>Rs.</td>
                  <td nowrap="nowrap">
                    <input type="text" name="txt_value"
							size="15" maxlength="10" style="text-align: right" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"
							value="<%=Helper.correctNull((String)hshValues.get("txt_value"))%>">
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

<input type="hidden" name="hidmodifiedvalue">  
<input type="hidden" name="hidmodifiedField">  

<input type="hidden" name="old_txt_receiptno" value="<%=Helper.correctNull((String) hshValues.get("txt_receiptno"))%>">
<input type="hidden" name="old_txt_dateissue" value="<%=Helper.correctNull((String) hshValues.get("txt_dateissue"))%>">
<input type="hidden" name="old_txt_issuer" value="<%=Helper.correctNull((String) hshValues.get("txt_issuer"))%>">
<input type="hidden" name="old_txt_goodsheld" value="<%=Helper.correctNull((String) hshValues.get("txt_goodsheld"))%>">
<input type="hidden" name="old_txt_quantity" value="<%=Helper.correctNull((String) hshValues.get("txt_quantity"))%>">
<input type="hidden" name="old_txt_value" value="<%=Helper.correctNull((String) hshValues.get("txt_value"))%>">

</form>
</body>
</html>


