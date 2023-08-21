<%@include file="../share/directives.jsp"%>
<%

java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);

String strcbsid = "";
String cbsname = "";
String reviewYear = "";
String appstatus = "";
String strAppholder = "";
String strApporgname = "";


strcbsid = Helper.correctNull( (String) request.getParameter("cbsid"));
cbsname = Helper.correctNull((String) request.getParameter("cbsname"));
reviewYear =Helper.correctNull((String) request.getParameter("reviewYear"));
appstatus =Helper.correctNull((String) request.getParameter("appstatus"));


String strAppStatus ="";
if(appstatus.equalsIgnoreCase("op"))
{
	strAppStatus="PENDING";
}
else if(appstatus.equalsIgnoreCase("pa"))
{
	strAppStatus="APPROVED";
}
else if(appstatus.equalsIgnoreCase("ca"))
{
	strAppStatus="CLOSED";
}
else
{
	strAppStatus="PENDING";
	appstatus="op";
}

String StrTLReviewno = Helper.correctNull((String)request.getParameter("hidtlrno"));

if(StrTLReviewno.equals("") || StrTLReviewno.equals("New"))
	StrTLReviewno = Helper.correctNull((String)hshValues.get("tlreviewno"));

String strBtnenable = Helper.correctNull((String) hshValues.get("btnenable"));

strAppholder = Helper.correctNull((String)hshValues.get("tlr_holder"));
strApporgname = Helper.correctNull((String)hshValues.get("apporgname"));

%>

<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style>
</style>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css" />
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varProposalType = "<%=Helper.correctNull((String)hshValues.get("reviewOf"))%>";
var varAssetClassify = "<%=Helper.correctNull((String)hshValues.get("tlr_assetclassify"))%>";
var valuesin = "<%=Helper.correctNull((String)hshValues.get("valuesin"))%>";

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		if(document.forms[0].hidtlrno.value=="")
		{
			disableFields(false);
			document.forms[0].cmdedit.disabled=true;
			//document.forms[0].cmddelete.disabled=true;
			document.forms[0].cmdsave.disabled=false;
			document.forms[0].cmdcancel.disabled=true;
			document.forms[0].cmdclose.disabled=false;	
		}
		else if(document.forms[0].btnenable.value=="N")
	    {
	        disableFields(false);
			document.forms[0].cmdedit.disabled=true;
			//document.forms[0].cmddelete.disabled=true;
			document.forms[0].cmdsave.disabled=true;
			document.forms[0].cmdcancel.disabled=true;
			document.forms[0].cmdclose.disabled=false;	
	    }
		else{
		    disableFields(true);
			document.forms[0].cmdedit.disabled=false;
			//document.forms[0].cmddelete.disabled=true;
			document.forms[0].cmdsave.disabled=true;
			document.forms[0].cmdcancel.disabled=true;
			document.forms[0].cmdclose.disabled=false;	
		}	
		
	}
	
	if(val=="edit")
	{	 
		
		 document.forms[0].cmdedit.disabled=true;
		// document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	
}
function callCalender(fname)
 {
	if(document.forms[0].cmdsave.disabled==false)
	 {  
	  showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	 } 
 }

function onLoading()
{
	
	disableCommandButtons("load");
	if(varProposalType != "")
	{
		document.forms[0].reviewOf.value=varProposalType;
	}
	else
	{
		document.forms[0].reviewOf.value="S";
	}
	if(varAssetClassify != "")
	{
		document.forms[0].sel_assetclasification.value=varAssetClassify;
	}
	else
	{
		document.forms[0].sel_assetclasification.value="0";
	}
	if(valuesin != "")
	{
		document.forms[0].sel_valuesin.value=valuesin;
	}
	else
	{
		document.forms[0].sel_valuesin.value="S";
	}
}
function doDelete()
{
	   if(ConfirmMsg(101))
		{	
			document.forms[0].hidAction.value ="delete";
			document.forms[0].action=appURL+"action/ControllerServlet";		
			document.forms[0].hidBeanMethod.value="updateTypeReviewTermLoan";
			document.forms[0].hidBeanGetMethod.value="getTypeReviewTermLoan";
			document.forms[0].hidBeanId.value="reviewtermloantwo";
			document.forms[0].hidSourceUrl.value="action/reviewnotetypeofreview.jsp";	
			document.forms[0].method="post";			
			document.forms[0].submit();	
		}
}
function doEdit()
{ 	
	if(document.forms[0].reviewOf.value=="")
	{
		alert("Select Proposal Type");
		return;
	}	
    document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
}
function callDescHelp(page)
{	
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = appURL+"action/comindustrymasterhelp.jsp?page="+page;
		var title = "IndustryHelp";
		var prop = "scrollbars=no,width=650,height=400";	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);	
	}
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="reviewnotetypeofreview.jsp";
		document.forms[0].hidBeanId.value="reviewtermloantwo";
		document.forms[0].hidBeanGetMethod.value="getTypeReviewTermLoan";
		document.forms[0].action=appURL +"action/reviewnotetypeofreview.jsp";
	    document.forms[0].submit();	
	}	
}
function doSave()
{
		if(document.forms[0].reviewOf.value=="S")
		{
		ShowAlert(111,'Proposal Type');
		document.forms[0].reviewOf.focus();
		return;
		}
		if(document.forms[0].sel_valuesin.value=="S")
		{
		ShowAlert(111,'Proposal in');
		document.forms[0].sel_valuesin.focus();
		return;
		}
		document.forms[0].hidAssetClass.value = document.forms[0].sel_assetclasification[document.forms[0].sel_assetclasification.selectedIndex].text;
	    document.forms[0].hidBeanId.value="reviewtermloantwo";
		document.forms[0].hidBeanGetMethod.value="updateTypeReviewTermLoan";
		document.forms[0].action=appURL+"action/reviewnotetypeofreview.jsp";
		//document.forms[0].hidSourceUrl.value="/action/reviewnotetypeofreview.jsp";
		document.forms[0].submit();
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}		  
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].disabled=val;
		}
		 
	}
	document.forms[0].txt_nextreviewdate.readOnly=true;
	document.forms[0].comapp_companyid.readOnly=true;
	
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mon_borrowersearch.jsp?hidmontype=MONITREVIEW";
		document.forms[0].submit();
	}
}
function callOtherLink(page,bean,method)
{
	
	 if (document.forms[0].cmdsave.disabled)
		{
			document.forms[0].hidSourceUrl.value=page;
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

function checkId()
{
	var varcompId = new Array();
	var bool = true;
  	<lapschoice:commapplicantidlist /> 
	var comval = document.forms[0].comapp_companyid.value;
		for(var i=0;i<varcompId.length;i++)
		{
			if(varcompId[i].toUpperCase()== comval.toUpperCase())
			{
				alert("Already Exist,Try again");
				document.forms[0].comapp_companyid.value="";
				document.forms[0].comapp_companyid.focus();
				bool = false;
				
			}
		}
	
	return bool;
}
function callOtherLink(page,bean,method)
{
	if(!document.forms[0].reviewYear.value=="")
	{
		document.forms[0].reviewOf.disabled=false;
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		alert("Select Review Year");
	}
}


</script>

</head>

<body onload="onLoading()">
<form name="safaeri3" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<lapschoice:tlrtag pageid="1" reviewof='<%=Helper.correctNull((String)hshValues.get("reviewOf"))%>' valuesin='<%=Helper.correctNull((String) hshValues.get("valuesin"))%>' />
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>

		<td valign="top" colspan=5 class="page_flow">Home -&gt; Term Loan - Review -&gt; General Details</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable linebor">
			<tr class="applicationheader">
				<td width="10%"><b>Application No</b></td>
				<td width="12%"><%=StrTLReviewno%></td>
				<td width="10%"><b>Borrower Name</b></td>
				<td width="20%"> <%=Helper.decodeAmpersand(cbsname)%>
				<input type="hidden" name="cbsname"	value="<%=cbsname%>">
				<input type="hidden" name="appname"	value="<%=cbsname%>"> </td>
				<td width="6%"><b>CBS ID</b></td>
				<td width="7%"><%=strcbsid%> <input
					type="hidden" name="cbsid" value="<%=strcbsid%>"> </td>
				<td width="8%"><b>Review Year</b></td>
				<td width="4%"><%=reviewYear%> <input
					type="hidden" name="reviewYear" value="<%=reviewYear%>"> </td>	
				<td width="6%"><b>Status</b></td>
				<td width="6%"> <%=strAppStatus%> <input
					type="hidden" name="appstatus" value="<%=appstatus%>">  <input type="hidden"
					name="readFlag"
					value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
				<input type="hidden" name="hidtlrno" value="<%=StrTLReviewno%>"></td>
		</tr>
			<tr class="applicationheader">
				<td><b>Application Holder</b></td>
				<td><%=strAppholder%><input
					type="hidden" name="appholder" value="<%//=reviewYear%>"> </td>
			<td><b>App. Recd. from</b></td>
				<td><%=strApporgname%><input
					type="hidden" name="apporgname" value="<%=strApporgname%>"> </td>	
			<td colspan="6">&nbsp;</td>			
					
			</tr>
	</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td width="60%">&nbsp;</td>
	</tr>
</table>
<br>
<table border="0" cellspacing="1" cellpadding="3" align="center" class="outertable border1">
<tr>
 <td width="78%">
<table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
	<tr>
		<td width="17%" nowrap>Proposal
		Type <span class="mantatory">*&nbsp;</span></td>
		<td width="33%" nowrap><select name="reviewOf">
			<option value="S" selected>&lt;---Select---&gt;</option>
			<option value="0">Retail / Tertiary</option>
			<option value="1">SME</option>
			<option value="2">Corporate</option>
		</select></td>
		<td width="19%" nowrap>Activity</td>
		<td width="31%" nowrap><input type="hidden" name="comapp_indcode"
			size="20" maxlength="23" style=text-align:left;border-style=groove
			value="<%=Helper.correctNull((String)hshValues.get("tlr_indcode"))%>"> <input type="text" name="comapp_companyid" size="30"
			maxlength="15" style=text-align:left;border-style=groove 
			onKeyPress="notAllowedDouble();notAllowSpace()" onBlur="checkId()"
			tabindex="7" value="<%=Helper.correctNull((String)hshValues.get("tlr_activity"))%>"> <b><span
			onClick="callDescHelp('applicantmaster')" style="cursor:hand"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
			border="0" tabindex="7"></span></b></td>
	</tr>
	<tr>
		<td width="17%" nowrap>Dealing
		with Bank since</td>
		<td width="33%" nowrap><b><%=Helper.correctNull((String)hshValues.get("personal_bankingsince"))%>
		<input type="hidden" name="hidBankSince"
			value="<%=Helper.correctNull((String)hshValues.get("personal_bankingsince"))%>"></b>
		</td>
		<td width="19%" nowrap>Asset
		Classification</td>
		<td width="31%" nowrap><select name="sel_assetclasification">
			<option value="0">&lt;---Select---&gt;</option>
			<lapschoice:StaticDataNewTag apptype="31" />
		</select></td>
	</tr>
	<tr>
		<td width="17%" nowrap>Renewal Due</td>
		<td width="33%" nowrap>
		<table class="outertable">
			<tr>
				<td><input type="text" name="txt_renewaldate" size="11"
					maxlength="20"
					value="<%=Helper.correctNull((String)hshValues.get("tlr_renewal"))%>">
				</td>
				<td><a alt="Select date from calender" href="#"
					onClick="callCalender('txt_renewaldate')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
					alt="Select date from calender" tabindex="29"></a></td>
			</tr>
		</table>
		</td>
	<td width="19%" nowrap>Credit
		facilities since</td>
		<td width="31%" nowrap><input type="text" name="txt_creditfacsince"
			size="20" maxlength="20"
			value="<%=Helper.correctNull((String)hshValues.get("tlr_facilitysince"))%>">
		</td>
	</tr>
	<tr>
		<td width="17%" nowrap>Next Review
		Date</td>
		<td width="33%" nowrap>
		<table class="outertable">
			<tr>
				<td><input type="text" name="txt_nextreviewdate" size="11"
					maxlength="20"
					value="<%=Helper.correctNull((String)hshValues.get("tlr_nextreview"))%>">
				</td>
				<td><a alt="Select date from calender" href="#"
					onClick="callCalender('txt_nextreviewdate')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
					alt="Select date from calender" tabindex="29"></a></td>
			</tr>
		</table>
		</td>
		<td width="19%" nowrap>Proposal in <span class="mantatory">*&nbsp;</span></td>
		<td width="31%" nowrap><select name="sel_valuesin">
			<option value="S" selected>&lt;---Select---&gt;</option>
			<option value="A">Amount in Rs</option>
			<option value="L">Rs. In Lacs</option>
			<option value="C">Rs. In Crores</option>
		</select>&nbsp;</td>
	</tr>
</table>
</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br> 	
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="remarksFlag" value="false"> 
<input type="hidden" name="hideditoption" value="N"> 
<input type="hidden" name="txt_usrid" value="<%=session.getAttribute("strUserId") %>"> 
<input type="hidden" name="Stateflag">
<input type="hidden" name="btnenable" value="<%=strBtnenable%>">
<input type="hidden" name="valuesin" value="<%=Helper.correctNull((String) hshValues.get("valuesin"))%>">
<input type="hidden" name="hidAssetClass">
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("AuditFlag"))%>">
</form>
</body>
</html>

