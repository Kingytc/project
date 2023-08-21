<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	String nfiles = "";
	String type = "";
	String goodfile = "";
	String badfile = "";
	String badrow = "";
	String ramdetails = "N";
	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		String appno = Helper.correctNull((String) session
			.getAttribute("strappno"));
	String prdcode = Helper.correctNull((String) session
			.getAttribute("prdcode"));
	String strSessionModuleType = Helper.correctNull(
			(String) session.getAttribute("sessionModuleType")).trim();
	String strreason="";
	
	if(strSessionModuleType.equals("RET"))
	{
		strreason="ret";
	}
	else if(strSessionModuleType.equals("CORP"))
	{
		strreason="corp";
	}
	else if(strSessionModuleType.equals("AGR"))
	{
		strreason="agr";
	}
	
		
	String strappreason="";
	String StrDigiLoanType=Helper.correctNull((String)session.getAttribute("StrDigiLoanType"));
	String stractiveflag=Helper.correctNull((String)hshValues.get("stractiveflag"));
	if(stractiveflag.equalsIgnoreCase("N")){
	 strappreason=Helper.correctNull((String)hshValues.get("APP_REASON"));
	}
	String strUsrClass = Helper.correctNull((String) strUserClass);
	if (strUsrClass.trim().equals("")) {
		strUsrClass = "0";
	}
	//out.println(strUsrClass);
%>
<html>
<head>
<title>Appraisal - Reason For Manual Processing</title>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>	
<script language="JavaScript">
var curdate = "<%=Helper.getCurrentDateTime()%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var varelgdigi="<%=Helper.correctNull((String)hshValues.get("APP_ELIGCRITERIA"))%>";
var varelgreason="<%=Helper.correctNull((String)hshValues.get("APP_REASON"))%>";
var userclass=<%=strUsrClass%>;

function allowWholeNumber1(obj)
{
	
	var key = window.event.keyCode;
	var val=obj.value;
	if(key==46 && val.indexOf(".")!=-1)
	{
		window.event.returnValue = false;
	}
	if( key==45 && val.indexOf("-")!=-1 ) 
	{
		window.event.returnValue = false;
	}
	if( key==45 && val != "" ) 
	{
		window.event.returnValue = false;
	}
	if( ! (key>44 && key<58)  )
	{
		window.event.returnValue = false;
	}
}
function callonLoad()
{
	if(varelgdigi!="")
	{
		document.forms[0].sel_eligdigi.value=varelgdigi;
	}
	else
	{
		document.forms[0].sel_eligdigi.value="0";
	}
	if(varelgdigi=="Y")
	{
		if(varelgreason!="")
		{
			document.forms[0].sel_reason.value=varelgreason;
		}
		else
		{
			document.forms[0].sel_reason.value="0";
		}
	}
	if(varelgdigi=="N")
	{
		if(varelgreason!="")
		{
			document.forms[0].sel_reason1.value=varelgreason;
		}
		else
		{
			document.forms[0].sel_reason1.value="0";
		}
	}
	leglOthryes();
	if(userclass!="")
	{
		if(parseInt(userclass)>=50)
		{
			disablefields(true);
		}
		else
		{
			disablefields(true);
			enableButtons(true,true,true,true,true);
		}
	}
	
	if (document.forms[0].sel_eligdigi.value == "Y") 
	{
		document.all.id1.style.visibility = "visible";
		document.all.id1.style.position = "relative";
		document.all.id2.style.visibility = "hidden";
		document.all.id2.style.position = "absolute";
	}
	else if (document.forms[0].sel_eligdigi.value == "N")
	{
		document.all.id1.style.visibility = "hidden";
		document.all.id1.style.position = "absolute";
		document.all.id2.style.visibility = "visible";
		document.all.id2.style.position = "relative";
	}
	else 
	{
		document.all.id1.style.visibility = "hidden";
		document.all.id1.style.position = "absolute";
		document.all.id2.style.visibility = "hidden";
		document.all.id2.style.position = "absolute";
	}
}
function onchgval()
 {
	if (document.forms[0].sel_eligdigi.value == "Y") {
		document.all.id1.style.visibility = "visible";
		document.all.id1.style.position = "relative";
		document.all.id2.style.visibility = "hidden";
		document.all.id2.style.position = "absolute";
		if(document.forms[0].sel_reason.value=="0")
		{
			ShowAlert(121,"Reason");
			document.forms[0].sel_reason.focus();
			return;
		}
	}
	else if (document.forms[0].sel_eligdigi.value == "N")
	{
		document.all.id1.style.visibility = "hidden";
		document.all.id1.style.position = "absolute";
		document.all.id2.style.visibility = "visible";
		document.all.id2.style.position = "relative";
		if(document.forms[0].sel_reason1.value=="0")
		{
			ShowAlert(121,"Reason");
			document.forms[0].sel_reason1.focus();
			return;
		}
	}
	else 
	{
		document.all.id1.style.visibility = "hidden";
		document.all.id1.style.position = "absolute";
		document.all.id2.style.visibility = "hidden";
		document.all.id2.style.position = "absolute";
	}
}

function onchgval1(){
	if (document.forms[0].sel_eligdigi.value == "Y") {
		document.all.id1.style.visibility = "visible";
		document.all.id1.style.position = "relative";
		document.all.id2.style.visibility = "hidden";
		document.all.id2.style.position = "absolute";
		
	}
	else if (document.forms[0].sel_eligdigi.value == "N"){
		document.all.id1.style.visibility = "hidden";
		document.all.id1.style.position = "absolute";
		document.all.id2.style.visibility = "visible";
		document.all.id2.style.position = "relative";
	}
	else {
		document.all.id1.style.visibility = "hidden";
		document.all.id1.style.position = "absolute";
		document.all.id2.style.visibility = "hidden";
		document.all.id2.style.position = "absolute";
	}
}

function leglOthryes() 
{
	if (document.forms[0].sel_eligdigi.value == "Y")
	{
		if(document.forms[0].sel_reason.value!="")
		{
			if(document.forms[0].sel_reason.options[document.forms[0].sel_reason.selectedIndex].text == "OTHERS")
			{
				document.all.othrID.style.visibility = "visible";
				document.all.othrID.style.position = "relative";
				document.all.idcomments.style.visibility = "hidden";
				document.all.idcomments.style.position = "absolute";
			}
			else
			{
				document.all.othrID.style.visibility = "hidden";
				document.all.othrID.style.position = "absolute";
				document.all.idcomments.style.visibility = "hidden";
				document.all.idcomments.style.position = "absolute";
			}
		}
		else
		{
			document.all.othrID.style.visibility = "hidden";
			document.all.othrID.style.position = "absolute";
			document.all.idcomments.style.visibility = "hidden";
			document.all.idcomments.style.position = "absolute";
		}
	}
	else if(document.forms[0].sel_eligdigi.value == "N")
	{
		if(document.forms[0].sel_reason1.value!="")
		{
			if(document.forms[0].sel_reason1.options[document.forms[0].sel_reason1.selectedIndex].text == "OTHERS")
			{
				document.all.idcomments.style.visibility = "visible";
				document.all.idcomments.style.position = "relative";
				document.all.othrID.style.visibility = "hidden";
				document.all.othrID.style.position = "absolute";
			}
			else
			{
				document.all.othrID.style.visibility = "hidden";
				document.all.othrID.style.position = "absolute";
				document.all.idcomments.style.visibility = "hidden";
				document.all.idcomments.style.position = "absolute";
			}
		}
		else
		{
			document.all.othrID.style.visibility = "hidden";
			document.all.othrID.style.position = "absolute";
			document.all.idcomments.style.visibility = "hidden";
			document.all.idcomments.style.position = "absolute";
		}
	}
	else {	
		document.all.idcomments.style.visibility = "hidden";
		document.all.idcomments.style.position = "absolute";
		document.all.othrID.style.visibility = "hidden";
		document.all.othrID.style.position = "absolute";
	}	
}

function doEdit()
{
	disablefields(false);
	enableButtons(true,false,false,false,true);
}
function doDelete()
{
	document.forms[0].hidAction.value="delete";
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanMethod.value="updateCreditSalesData";
	document.forms[0].hidBeanGetMethod.value="getCreditSalesData";
	document.forms[0].hidSourceUrl.value="/action/com_creditsales.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doClose()
{	
   var con = ConfirmMsg('100');
	if(con)
	{	
		document.forms[0].action=appURL+"action/retailpge";
		document.forms[0].submit();
	}
}
function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanGetMethod.value="getCreditSalesData";
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].action=appURL+"action/com_creditsales.jsp";
		document.forms[0].submit();
	}
}
function disablefields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
		document.forms[0].elements[i].readOnly=val;
		}	
		if(document.forms[0].elements[i].type=='textarea')
		{
		document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
		document.forms[0].elements[i].disabled=val;
		}
	}
}
function enableButtons(bool2, bool3, bool4, bool5,bool6)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}
function doSave()
{

	if(document.forms[0].txt_digiappno.value=="")
	{
		ShowAlert(121,"Digi Application Number");
		document.forms[0].txt_digiappno.focus();
		return;
	}
	if(document.forms[0].sel_eligdigi.value=="0")
	{
		ShowAlert(111,"Eligible Under Digi");
		document.forms[0].sel_eligdigi.focus();
		return;
	}
	if(document.forms[0].sel_eligdigi.value=="Y")
	{
		if(document.forms[0].sel_reason.value=="0"||document.forms[0].sel_reason.value=="s"||document.forms[0].sel_reason.value=="S")
		{
			ShowAlert(111,"Reason");
			document.forms[0].sel_reason.focus();
			return;
		}
	}

	if(document.forms[0].sel_eligdigi.value=="N")
	{
		if(document.forms[0].sel_reason1.value=="0" || document.forms[0].sel_reason1.value=="s" || document.forms[0].sel_reason1.value=="S")
		{
			ShowAlert(111,"Reason");
			document.forms[0].sel_reason1.focus();
			return;
		}
	}
	
	if (document.forms[0].sel_eligdigi.value == "Y" && document.forms[0].sel_reason.options[document.forms[0].sel_reason.selectedIndex].text == "OTHERS")
	{
		var varcomments=checktrim(document.forms[0].Otherreason.value);
		if(varcomments== "")
		{
			ShowAlert(121,"Comments");
			document.forms[0].Otherreason.focus();
			return;
		}
	}
	
 	if (document.forms[0].sel_eligdigi.value == "N" && document.forms[0].sel_reason1.options[document.forms[0].sel_reason1.selectedIndex].text == "OTHERS")
 	{
		var varcomments=checktrim(document.forms[0].txt_techcommets.value);
		if(varcomments== "")
		{
			ShowAlert(121,"Comments");
			document.forms[0].txt_techcommets.focus();
			return;
		}
 	}

	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanMethod.value="updateCreditSalesData";
	document.forms[0].hidBeanGetMethod.value="getCreditSalesData";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_creditsales.jsp";
	document.forms[0].submit();
}
function allowInteger1()
{
	var key = window.event.keyCode;
	if(!(key>47 && key<58))
	{
		window.event.returnValue = false;
	}
}

function callclear(){
	
	if (document.forms[0].sel_eligdigi.value == "Y" && document.forms[0].sel_reason.options[document.forms[0].sel_reason.selectedIndex].text == "OTHERS") {
		document.all.othrID.style.visibility = "visible";
		document.all.othrID.style.position = "relative";
		document.forms[0].Otherreason.value="";
		document.forms[0].txt_techcommets.value="";
	}
	else
	{
		document.forms[0].Otherreason.value="";
		document.forms[0].txt_techcommets.value="";
	}
	if(document.forms[0].sel_eligdigi.value == "N" && document.forms[0].sel_reason1.options[document.forms[0].sel_reason1.selectedIndex].text == "OTHERS"){
		document.all.idcomments.style.visibility = "visible";
		document.all.idcomments.style.position = "relative";
		document.forms[0].txt_techcommets.value="";
		document.forms[0].Otherreason.value="";
	}
	else
	{
		document.forms[0].Otherreason.value="";
		document.forms[0].txt_techcommets.value="";
	}
}
function allowAlphaNumericForPage()
{
	var key = window.event.keyCode;	
	if(!((key>64 && key<91) || (key>96 && key<123) || (key>47 && key<58)) )
	{
		window.event.returnValue = false;
	}
		
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad();leglOthryes();onchgval1()">
<form name="appform" method="post" class="normal">
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="28" />
			<jsp:param name="subpageid" value="109" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%}else{ %>
<jsp:include
	page="../com/proposallinks.jsp" flush="true">
	<jsp:param name="pageid" value="28" />
	<jsp:param name="cattype" value="<%=strCategoryType%>" />
	<jsp:param name="ssitype" value="<%=strSSIType%>" />

</jsp:include>


<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<%
			if (strSessionModuleType.equalsIgnoreCase("AGR")) {
		%>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Proposal
		-&gt;Repayment Schedule -&gt; Repayment Schedule for Non-EMI</td>
		<%
			} else {
		%>
		<td class="page_flow">Home -&gt; Corporate &amp; SME-&gt;Proposal
		-&gt;Repayment Schedule -&gt; Repayment Schedule for Non-EMI</td>
		<%
			}
		%>
	</tr>
</table>


<span style="display: none;"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="50%" border="0" cellspacing="1" cellpadding="3"
	class="outertable">
	<tr>
		<td class="sub_tab_inactive" align="center"><a
			href="javascript:gotoTab(appURL,'comrepayschedule','getTermFinanceFac','com_fac_repayment.jsp')"><b>Repayment
		Schedule for EMI</b></a></td>
		<td class="sub_tab_inactive" align="center"><a
					href="javascript:gotoTab(appUrl,'comrepayschedule','getFacNonEMIRepayment','com_fac_repaymentnonemi.jsp')"><b>Repayment Schedule for Non-EMI</b></a></td>
		<%if(StrDigiLoanType.equals("")){%>
		<td class="sub_tab_active" align="center"><b>Reason for Manual Processing</b></td>
		<%} %>	
		<td class="sub_tab_inactive" align="center"><a
			href="javascript:gotoTab(appURL,'comproposal','getDataComments','com_repaycomment.jsp')"><b>Terms of Repayment</b></a></td>
	</tr>
</table>
<%} %>
<br>
<table width="60%" border="1" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="60%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td nowrap="nowrap">DIGI Application Number<span
					class="mantatory">*&nbsp;</span></td>
				<td><input type="text" name="txt_digiappno" size="18"
					onKeyPress="allowAlphaNumericForPage()"
					value="<%=Helper.correctNull((String) hshValues.get("APP_DIGIAPPNO"))%>"
					maxlength="18"></td>
				<td nowrap="nowrap">Eligible Under DIGI<span class="mantatory">*&nbsp;</span></td>
				<td>&nbsp;</td>
				<td><select name="sel_eligdigi" onchange="onchgval();leglOthryes();callclear();">
					<option value="0" selected>---Select---</option>
					<option value="Y">Yes</option>
					<option value="N">No</option>

				</select></td>
			</tr>
			<tr id="id1">
				<td nowrap="nowrap">Reason<span class="mantatory">*&nbsp;</span></td>
				<td><select name="sel_reason" onchange="leglOthryes();callclear();">
					<option value="0" selected>---Select---</option>
					<lapschoice:StaticDataTag apptype="245" tagType="<%=strreason%>" />
					
				</select></td>
			</tr>
			<tr id="id2">
				<td nowrap="nowrap">Reason<span class="mantatory">*&nbsp;</span></td>
				<td><select name="sel_reason1" onchange="leglOthryes();callclear();">
				<option value="0" selected>---Select---</option>
				
					<lapschoice:StaticDataTag apptype="246" tagType="<%=strreason%>" />
					

				</select></td>
			</tr>
			<tr id="othrID">
				<td nowrap="nowrap">(Other Reason) Please specify<span
					class="mantatory">*&nbsp;</span></td>
					
					<td colspan="2"><textarea name="Otherreason" cols="40"
					rows="3" onKeyPress="notAllowSplChar(this);textlimit(this,999)"
					onKeyUp="textlimit(this,999)"><%=Helper.correctNull((String) hshValues
									.get("APP_OTHERREASON"))%></textarea></td>
			</tr>

			<tr id="idcomments">

				<td nowrap="nowrap">Comments<b><span class="mantatory">*&nbsp;</span></b></td>
				<td><textarea name="txt_techcommets" cols="75" rows="3"
					tabindex="21"><%=Helper.correctNull((String) hshValues
							.get("APP_COMMENTS"))%></textarea></td>
			</tr>
			<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			</tr>
			
		</table>
		</td>
	</tr>


</table>

<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete'
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' /> <iframe height="0"
	width="0" name="ifrmsancauthority" frameborder="0" style="border: 0"></iframe>
<iframe height="0" width="0" name="ifrmsancbranch" frameborder="0"
	style="border: 0"></iframe> <input type="hidden" name="radLoan"
	value="Y"> <input type="hidden" name="prdcode"
	value="<%=Helper.correctNull((String) hshValues.get("prdcode"))%>">
<input type="hidden" name="hidValid" value="Y"> <input
	type="hidden" name="hidInterestType"
	value="<%=Helper.correctNull((String) hshValues
									.get("loan_inttype"))%>">
<iframe name="ifrm" width="0" height="0" border="0"></iframe> <iframe
	name="ifrminterest" width="0" height="0" border="0"></iframe></form>
</body>
</html>