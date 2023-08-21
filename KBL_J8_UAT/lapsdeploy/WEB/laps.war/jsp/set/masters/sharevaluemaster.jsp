<%@ include file="../../share/directives.jsp"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%
ArrayList arrRow = new ArrayList();
ArrayList arrCol = new ArrayList();
int intsize=0;
if (hshValues != null) {
	arrRow = (ArrayList) hshValues.get("arrRow");
}
String strAction=Helper.correctNull((String)hshValues.get("strAction"));
String hidtype=Helper.correctNull((String)hshValues.get("hidtype"));

%>
<html>
<head>
<title>Share Value Master</title>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var varshareType="<%=Helper.correctNull((String)hshValues.get("svm_sharetype"))%>";
var varApproveFlag="<%=Helper.correctNull((String)hshValues.get("svm_companyapproveflag"))%>";
var varActiveFlag="<%=Helper.correctNull((String)hshValues.get("svm_companyactiveflag"))%>";
function onload()
{
	disablefields(true);
	document.forms[0].cmdhistory.disabled=false;
	if(varshareType!="")
	{
		var str_type_temp =varshareType.split("@");	
		for(var i=1;i<str_type_temp.length-1;i++)
		{
			var selValue=str_type_temp[i];
			for(var j=0;j<document.forms[0].sel_type.options.length;j++)
			{
				if(document.forms[0].sel_type.options[j].value==selValue)
				{
					document.forms[0].sel_type.options[j].selected=true
				}
				
			}		
			
		}
	}
	if(varApproveFlag!="")
	{
		document.forms[0].sel_approve.value=varApproveFlag;
	}
	if(varActiveFlag!="")
	{
		document.forms[0].sel_active.value=varActiveFlag;
	}


	if(document.forms[0].hidcompanycode.value!="")
	{
		enableButtons(true,false,true,false,false,false);
	}
}

function doNew()
{
	document.forms[0].hidAction.value="insert";
	enableButtons(true,true,false,true,false,true);
	disablefields(false);
}
function doEdit()
{
	document.forms[0].hidAction.value="update";
	enableButtons(true,true,false,true,false,true);
	disablefields(false);
}
function doSave()
{
	
	if(document.forms[0].txt_CIN_no.value=="")
	{
		alert("Enter CIN Number");
		document.forms[0].txt_CIN_no.focus();
		return;
	}
	if(document.forms[0].txt_Companyname.value=="")
	{
		alert("Enter Company Name");
		document.forms[0].txt_Companyname.focus();
		return;
	}

	var str_type ="";
	for(var i=0;i<document.forms[0].sel_type.options.length;i++)
	{
		if(document.forms[0].sel_type.options[i].selected)
		{	
			if(str_type=="")
				str_type="@"+document.forms[0].sel_type.options[i].value+"@";
			else
				str_type=str_type+document.forms[0].sel_type.options[i].value+"@";
		}		
	}
	
	if(str_type=="")
	{
		alert("Select Type");
		return false;
	}
	document.forms[0].hidtype.value=str_type;

	if(document.forms[0].sel_approve.value=="")
	{
		alert("Select Company Approval Status");
		document.forms[0].sel_approve.focus();
		return;
	}
	if(document.forms[0].sel_approve.value=="A")
	{	
			if(document.forms[0].txt_avgmarketval.value=="0.00" || document.forms[0].txt_avgmarketval.value=="" || document.forms[0].txt_avgmarketval.value=="0")
			{
				alert("Enter Average Market Value");
				document.forms[0].txt_avgmarketval.focus();
				return;
			}
			if(document.forms[0].txt_paidupcapital.value=="0.00" || document.forms[0].txt_paidupcapital.value=="" || document.forms[0].txt_paidupcapital.value=="0")
			{
				alert("Enter Paid up Capital of the Company");
				document.forms[0].txt_paidupcapital.focus();
				return;
			}
			if(document.forms[0].txt_paidupcapitalasondate.value=="")
			{
				alert("Select Paid up Capital as on Date");
				document.forms[0].txt_paidupcapitalasondate.focus();
				return;
			}
			if(document.forms[0].sel_active.value=="y"){
				if(document.forms[0].txt_marketval.value=="0.00" || document.forms[0].txt_marketval.value=="" || document.forms[0].txt_marketval.value=="0")
				{
					alert("Enter Market Value");
					document.forms[0].txt_marketval.focus();
					return;
				}
			}
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanGetMethod.value="updateShareValueMasterData";
	//document.forms[0].hidBeanGetMethod.value="getShareValueMasterData";
	//document.forms[0].hidSourceUrl.value="/action/sharevaluemaster.jsp";
	document.forms[0].action=appURL+"action/sharevaluemaster.jsp";
	document.forms[0].submit();
}
function doDelete()
{
	document.forms[0].hidAction.value="delete";
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanMethod.value="updateShareValueMasterData";
	document.forms[0].hidBeanGetMethod.value="getShareValueMasterData";
	document.forms[0].hidSourceUrl.value="/action/sharevaluemaster.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doCancel()
{
	if (ConfirmMsg(102))
	{
		document.forms[0].hidAction.value="";
		document.forms[0].hidBeanId.value = "staticdata";
		document.forms[0].hidBeanGetMethod.value = "getShareValueMasterData";
		document.forms[0].action = appURL + "action/sharevaluemaster.jsp";
		document.forms[0].submit();
	}
}
function doClose()
{
	    if(ConfirmMsg(100))
		{
			document.forms[0].action=appURL+"action/mainnav.jsp";
		 	document.forms[0].submit();
	 	}
}
function disablefields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}	  
		if(document.forms[0].elements[i].type=='select-multiple')
		{
			document.forms[0].elements[i].disabled=one;
		}	  
	}
	document.forms[0].txt_networthasondate.readOnly=true;
	document.forms[0].txt_marketvalasondate.readOnly=true;
	document.forms[0].txt_paidupcapitalasondate.readOnly=true;
}

function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	//document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdcancel.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;	
	document.forms[0].cmdhistory.disabled=false;	
}
function getcompanyList()
{
	if(document.forms[0].cmdsave.disabled==true)
	{
		var varQryString = appURL+"action/setShareValueMasterSearch.jsp?hidBeanId=staticdata&hidBeanGetMethod=getShareValueMasterData&pagefrom=sharemaster&hidAction=search&hidparam=allValues";
		var title = "Users";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
}
function callCalender(cmdname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,cmdname);
	}
}
function callHistory()
{
	if(document.forms[0].hidcompanycode.value=="")
	{
		alert("Select Company");
		return;
	}
	var prop = "scrollbars=yes,width=1200,height=550,menubar=yes";
	var title = "History";
	var xpos = 100;
	var ypos = 55;
	prop = prop + ",left="+xpos+",top="+ypos;
	var url=appURL+"action/shareMasterHistory.jsp?hidBeanId=staticdata&hidBeanGetMethod=getShareMasterHistory&strCompanyNo="+document.forms[0].hidcompanycode.value;
	window.open(url,title,prop);
}
</script>
</head>
<body onload=" onload();">
<form method="post" class="normal">
<div align="center">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Master -&gt; Share Value Master</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../../set/mastertab.jsp" flush="true">
			<jsp:param name="tabid" value="14" />
		</jsp:include></td>
	</tr>
</table>
<br/>
<br/>
<table width="60%" border="0" cellspacing="1" cellpadding="5"
	class="outertable border1 tableBg" align="center">
	<tr class="dataheader">
	<td colspan="4" align="center">COMPANY INFORMATION</td>
	</tr>
	
	<tr>
		<td width="25%">CIN Number <span class="mantatory">*&nbsp;</span></td>
		<td width="20%"><input type="text" name="txt_CIN_no" size="25" maxlength="21" onkeypress="allowAlphaNumeric();"
		value="<%=Helper.correctNull((String)hshValues.get("svm_companycinno")) %>">&nbsp;<a alt="Select date from calender"  href="javascript:getcompanyList()">
									 <img src="<%=ApplicationParams.getAppUrl()%>img/search_corp.gif"  border="0"></a></td>
		<td width="20%">Company Name <span class="mantatory">*&nbsp;</span></td>
		<td width="30%"><input type="text" name="txt_Companyname" size="50" onkeypress="allowAlphabetsForName();" value="<%=Helper.correctNull((String)hshValues.get("svm_companyname")) %>"></td>
	</tr>
	<tr>
		<td width="25%">Type <span class="mantatory">*&nbsp;</span></td>
		<td width="20%">
		<select multiple="multiple" name="sel_type" id="sel_type1" size="5" style="width:95%">
                    <lapschoice:staticdatasecuritiestag parenttype="6"/>
						</select>
		</td>
		<td>Whether Company Approval Status? <span class="mantatory">*&nbsp;</span></td>
		<td>
		<select name="sel_approve">
		<option value=""><--select--></option>
		<option value="A">Approved</option>
		<option value="U">Unapproved</option>
		</select>
		</td>
	</tr>
	<tr>
	<td>Face Value</td>
	<td><input type="text" name="txt_facevalue" style="text-align: right;" onkeypress="allowNumber(this);" onblur="roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("svm_facevalue")) %>">&nbsp;[Rs.]</td>
	<td>Average Market Value <span class="mantatory">*&nbsp;</span></td>
	<td><input type="text" name="txt_avgmarketval" style="text-align: right;" onkeypress="allowNumber(this);" onblur="roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("svm_companyavgmarketval")) %>">&nbsp;[Rs.]
	<input type="hidden" name="hid_avgmarketval" ></td>
	</tr>
	<tr>
	<td>Networth </td>
	<td><input type="text" name="txt_networth" style="text-align: right;" onkeypress="allowNumber(this);" onblur="roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("svm_companynetworth")) %>">&nbsp;[Rs.]</td>
	<td>As on Date </td>
	<td><input type="text" name="txt_networthasondate"	size="12" maxlength="10" 
							value="<%=Helper.correctNull((String)hshValues.get("svm_companynetworthason")) %>" onBlur="checkDate(this);checkmaxdate(this,currdate);">
							<a alt="Select date from calender"  href="javascript:callCalender('txt_networthasondate')">
									 <img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
	</tr>
	<tr>
	<td>Market value </td>
	<td><input type="text" name="txt_marketval" style="text-align: right;" onkeypress="allowNumber(this);" onblur="roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("svm_companymarketval")) %>">&nbsp;[Rs.]</td>
	<td>As on Date </td>
	<td><input type="text" name="txt_marketvalasondate"	size="12" maxlength="10" 
							value="<%=Helper.correctNull((String)hshValues.get("SVM_COMPANYMARKETVALASON")) %>" onBlur="checkDate(this);checkmaxdate(this,currdate);">
							<a alt="Select date from calender"  href="javascript:callCalender('txt_marketvalasondate')">
									 <img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
	</tr>
	<tr>
	<td>Paid up Capital of the Company  <span class="mantatory">*&nbsp;</span></td>
	<td><input type="text" name="txt_paidupcapital" style="text-align: right;" onkeypress="allowNumber(this);" onblur="roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("svm_companypaidup")) %>">&nbsp;[Rs.]</td>
	<td>As on Date <span class="mantatory">*&nbsp;</span></td>
	<td><input type="text" name="txt_paidupcapitalasondate"	size="12" maxlength="10" 
							value="<%=Helper.correctNull((String)hshValues.get("svm_companypaidupason")) %>" onBlur="checkDate(this);checkmaxdate(this,currdate);">
							<a alt="Select date from calender"  href="javascript:callCalender('txt_paidupcapitalasondate')">
									 <img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
	</tr>
	<tr>
	<td>Reserves Capital of the Company</td>
	<td><input type="text" name="txt_reservescapital" style="text-align: right;" onkeypress="allowNumber(this);" onblur="roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("svm_companyreservescapital")) %>">&nbsp;[Rs.]</td>
	<td>Active Flag </td>
	<td>
	<select name="sel_active">
	<option value="y">Yes</option>
	<option value="n">No</option>
	</select>
	</td>
	</tr>
	
</table>
</div>
<lapschoice:hiddentag
	pageid="<%=PageId%>" /> 
<table width="12%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr>
		<td>
		<br/><br/><lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_History"
			btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
		</td>
	</tr>
</table>
<input type="hidden" name="hidcompanycode" value="<%=Helper.correctNull((String)hshValues.get("svm_companycode")) %>">
<input type="hidden" name="hidtype" value="<%=Helper.correctNull((String)hshValues.get("svm_sharetype")) %>">
</form>
</body>
</html>