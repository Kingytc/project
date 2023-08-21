<%@include file="../share/directives.jsp"%>

<%
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String strPagefrom = Helper.correctNull((String) request.getParameter("pagefrom"));	
String pageid = Helper.correctNull((String) request.getParameter("pageid"));

ArrayList arrCol = new ArrayList();
ArrayList arrRow = (ArrayList) hshValues.get("arrRows");
%>
<html>
<head>
<title>Live - Stock Security Details</title>
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

var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varLiveStrockFlag="<%=Helper.correctNull((String)hshValues.get("strLiveStrockFlag"))%>";

var varVerificationFlag="<%=Helper.correctNull((String)hshValues.get("hid_VerificationFlag"))%>";

function doSave()
{
	if(document.forms[0].txt_sec_sno.length==undefined)
	{
		if(document.forms[0].txt_sec_age.value=="")
		{
			ShowAlert(121,'Age');
			document.forms[0].txt_sec_age.focus();
			return;
		}
	}
	else
	{
		for(var i=0;i<document.forms[0].txt_sec_sno.length;i++)
		{
			if((document.forms[0].txt_sec_breed[i].value!="" || document.forms[0].txt_sec_identmark[i].value!="") && document.forms[0].txt_sec_age[i].value=="")
			{
				ShowAlert(121,'Age');
				document.forms[0].txt_sec_age[i].focus();
				return;
			}
	
		}
	}

	if(document.forms[0].txt_sec_sno.length==undefined)
	{
		if(document.forms[0].txt_sec_breed.value=="")
		{
			ShowAlert(111,'Breed');
			document.forms[0].txt_sec_breed.focus();
			return;
		}
	}
	else
	{
		for(var i=0;i<document.forms[0].txt_sec_sno.length;i++)
		{
			if(document.forms[0].txt_sec_breed[i].value=="" && (document.forms[0].txt_sec_age[i].value!="" || document.forms[0].txt_sec_identmark[i].value!=""))
			{
				ShowAlert(111,'Breed');
				document.forms[0].txt_sec_breed[i].focus();
				return;
			}
	
		}
	}
	if(document.forms[0].txt_sec_sno.length==undefined)
	{
		if(document.forms[0].txt_sec_identmark.value=="")
		{
			ShowAlert(121,'Identification Mark');
			document.forms[0].txt_sec_identmark.focus();
			return;
		}
	}
	else
	{
		for(var i=0;i<document.forms[0].txt_sec_sno.length;i++)
		{
			if(document.forms[0].txt_sec_identmark[i].value=="" && (document.forms[0].txt_sec_age[i].value!="" || document.forms[0].txt_sec_breed[i].value!=""))
			{
				ShowAlert(121,'Identification Mark');
				document.forms[0].txt_sec_identmark[i].focus();
				return;
			}
	
		}
	}
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanMethod.value="updateLiveStock_det";
	document.forms[0].hidBeanGetMethod.value="getLiveStockDet";
	document.forms[0].hidSourceUrl.value="/action/securitiesLiveStock_det.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();	

}	

function doEdit()
{
	callDisableControls(true,false,false,false);
	disablefields(false);
}

function doDelete()
{		
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{
	document.forms[0].hidAction.value="delete"; 
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanMethod.value="updateLiveStock_det";
	document.forms[0].hidBeanGetMethod.value="getLiveStockDet";
	document.forms[0].hidSourceUrl.value="/action/securitiesLiveStock_det.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
	}
} 
function callDisableControls(cmdEdit,cmdSave,cmdCancel,cmdClose)
{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdSave;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
}

function disablefields(bool)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].disabled=bool;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=bool;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].disabled=bool;		  
		}		
		
	}
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanGetMethod.value="getLiveStockDet";
		document.forms[0].hidBeanId.value="getLiveStock";
		document.forms[0].hidSourceUrl.value="/action/securitiesLiveStock_det.jsp";
		document.forms[0].submit();
	}
}

function doClose()
{
	var varconfirm=ConfirmMsg('100');
	if(varconfirm)
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
		document.forms[0].submit();
	}
}

function onload()
{
	
	if(varLiveStrockFlag!="Y")
	{
		alert("Please Enter Details in Live Stock tab");
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].hidBeanGetMethod.value="getLiveStock";
		document.forms[0].action=appUrl+"action/securitiesLiveStock.jsp";
		document.forms[0].submit();	
	}
	
	if(varVerificationFlag=="V")
	{
		document.forms[0].cmdedit.disabled=true;
	}
	
	<%if (arrRow != null && arrRow.size() > 0) 
	{
		if (arrRow.size() == 1) 
		{
			arrCol = (ArrayList) arrRow.get(0);%>

			document.forms[0].txt_sec_breed.value="<%=Helper.correctNull((String) arrCol.get(1))%>";
			
		<%}
		else 
		{
			for (int i = 0; i < arrRow.size(); i++) 
			{
				arrCol = (ArrayList) arrRow.get(i);%>
				document.forms[0].txt_sec_breed[<%=i%>].value="<%=Helper.correctNull((String) arrCol.get(1))%>";
				
			<%}
		}
	}%>
	disablefields(true);
	

	
}
function disableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled = bool1;
	document.forms[0].cmdsave.disabled = bool2;
	document.forms[0].cmdcancel.disabled = bool3;
	document.forms[0].cmddelete.disabled = bool4;
	document.forms[0].cmdclose.disabled = bool5;
}
/*
function checkage()
{
	if(document.forms[0].txt_sec_sno.length==undefined)
	{
		if(eval(document.forms[0].txt_sec_age.value)>100)
		{
			alert("Particulars Age should not higher than 100");
			document.forms[0].txt_sec_age.value="";
		//	document.forms[0].txt_sec_age.focus();
			return;
		}
	}
	else
	{
		for(var i=0;i<document.forms[0].txt_sec_sno.length;i++)
		{
			if(eval(document.forms[0].txt_sec_age[i].value)>100)
			{
				alert("Particulars Age should not higher than 100");
				document.forms[0].txt_sec_age[i].value="";
			//	document.forms[0].txt_sec_age[i].focus();
				return;
			}
	
		}
	}

}*/
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onload()">
<form method="post" class="normal">
<%if(strPagefrom.equalsIgnoreCase("appl")){ 
if(!(strSessionModuleType.equalsIgnoreCase("RET"))){
if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
	 <table width="100%" border="0" cellspacing="0" cellpadding="0"
		class="outertable">
		<tr>
			<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
				<jsp:param name="pageid" value="33" />
				<jsp:param name="subpageid" value="209" />
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
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt; Details of Particulars</td>
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../set/appurlsectabs.jsp" flush="true">
			<jsp:param name="pageid" value="19" />
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
<td class="page_flow" colspan="2">Home -&gt; Retail -&gt; Application -&gt; Security Master -&gt; Details of Particulars</td>
</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%} else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="4" />
			<jsp:param name="subpageid" value="209" />
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
	<jsp:param name="pageid" value="19" />
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
		<jsp:param name="pageid" value="19" />
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
		<td class="page_flow">Home -&gt; Securities -&gt; Details of Particulars</td>
	</tr>
</table>
<table width="50%" border="0" cellspacing="1" cellpadding="0" class="outertable" align="center">
	<tr>
		<td class="sub_tab_inactive_new" WIDTH="50%" align="center">
			<b><a href="JavaScript:gototab('securitymaster','getSecurities','customer_securities.jsp')">
			Security Details</a></b>
		</td>
		<td class="sub_tab_inactive_new" WIDTH="15%" align="center">
			<b><a href="JavaScript:gototab('securitymaster','getLiveStock','securitiesLiveStock.jsp')">
			Live Stock Details</a></b>
		</td>
		<td class="sub_tab_active_new" align="center"><b>Details of Particulars</b></td>
	</tr>
</table>
<%} %>
<table width="97%" border="1" cellspacing="0" cellpadding="5" class="outertable" align="center">
	<tr>
			<td> Security ID :  <span style="color:#750b6a"> <%=Helper.correctNull((String)hshValues.get("SEC_SECURITYID"))%> </span>  </td>	
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable" align="center">
				<tr class="dataheader" align="center">
					<td align="center" width="10%">S.No</td>	
					<td align="center" width="20%">Age</td>	
					<td align="center" width="20%">Breed</td>	
					<td align="center" width="50%">Identification Mark</td>	
			    </tr>
			    <%
							
								int j=0;
								if (arrRow != null && arrRow.size() > 0) {
									for (int i = 0; i < arrRow.size(); i++) {
										j=j+1;
										arrCol = (ArrayList) arrRow.get(i);
						%>
			   <tr class="datagrid" align="center">
				    <td width="10%"><input type="text" name="txt_sec_sno" size="10" style="text-align:center" readOnly=readOnly value="<%=j%>"></td>
				    <td width="20%"><input type="text" name="txt_sec_age" size="20" maxlength="3" onkeypress="allowInteger()"  style="text-align:center" value="<%=Helper.correctNull((String) arrCol.get(0))%>"></td>
 					<td width="20%">
					    <select name="txt_sec_breed" style="width:85%">
							<option value="">---Select-----</option>
							<lapschoice:StaticDataTag apptype="212" />
							</select></td>
					<td width="50%"><textarea name="txt_sec_identmark" rows="3" cols="75" onkeyup="textlimitcorp1(this,50);" onkeydown="textlimitcorp1(this,50);"><%=Helper.correctNull((String) arrCol.get(2))%></textarea></td>
				</tr>
				<%
							}
								} else {
						%>
				 <tr class="datagrid" align="center">
				    <td width="10%"><input type="text" name="txt_sec_sno" size="10" style="text-align:center" readOnly=readOnly value=""></td>
				    <td width="20%"><input type="text" name="txt_sec_age" size="20" onkeypress="allowInteger()"  style="text-align:center" value=""></td>
 					<td width="20%">
					    <select name="txt_sec_breed" style="width:85%">
							<option value="">---Select-----</option>
							<lapschoice:StaticDataTag apptype="212" />
							</select></td>
					<td width="50%"><textarea name="txt_sec_identmark" rows="3" cols="75" onkeyup="textlimitcorp1(this,50);" onkeydown="textlimitcorp1(this,50);"></textarea></td>
				</tr>
				<%
							}
						%>
									
			</table>
		</td>
	</tr>
</table>

     <br/>   	

<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />

<br>
<lapschoice:hiddentag pageid='<%=pageid%>' />

<input type="hidden" name="hid_VerificationFlag" value="<%=Helper.correctNull((String) hshValues.get("hid_VerificationFlag"))%>" />
<input type="hidden" name="txtperapp_appid"
			value="<%=Helper.correctNull((String) hshValues.get("applicantId"))%>">
		<input type="hidden" name="hidDemoId"
			value="<%=Helper.correctNull((String) request.getParameter("hidDemoId"))%>">
		<input type="hidden" name="hidSecurityId"
			value="<%=Helper.correctNull((String)request.getParameter("hidSecurityId"))%>">

</form>
</body>
</html>


