<%@include file="../share/directives.jsp"%>

<%ArrayList arrRowsta = null;
			ArrayList arrColsta = new ArrayList();
			ArrayList arrstatusRow = null;
			arrstatusRow = (ArrayList) hshValues.get("arrRow");
			ArrayList arrstatusCol = new ArrayList();

			String status_note = Helper.correctNull((String) hshValues
					.get("status_note"));

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
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";

var ACCOUNT_CLASSIFIED ="<%=Helper.correctNull((String)hshValues.get("ACCOUNT_CLASSIFIED"))%>";
var ACCOUNT_PLACEDUNDER="<%=Helper.correctNull((String)hshValues.get("ACCOUNT_PLACEDUNDER"))%>";
//var OTS="<%=Helper.correctNull((String)hshValues.get("OTS"))%>";
var BIFR_ACCOUNT="<%=Helper.correctNull((String)hshValues.get("BIFR_ACCOUNT"))%>";
var TAKEOVER_ACCOUNT="<%=Helper.correctNull((String)hshValues.get("TAKEOVER_ACCOUNT"))%>";
var GUARANTEE="<%=Helper.correctNull((String)hshValues.get("GUARANTEE"))%>";
var FRAUD_ACCOUNT="<%=Helper.correctNull((String)hshValues.get("FRAUD_ACCOUNT"))%>";
var TERMS_SANCTION="<%=Helper.correctNull((String)hshValues.get("TERMS_SANCTION"))%>";
var VETTED_BY_ADVOCATES="<%=Helper.correctNull((String)hshValues.get("VETTED_BY_ADVOCATES"))%>";
var VETTING_AUTHORITY="<%=Helper.correctNull((String)hshValues.get("VETTING_AUTHORITY"))%>";
var SUIT="<%=Helper.correctNull((String)hshValues.get("SUIT"))%>";
var ACTION_UNDER_SARFAESIA="<%=Helper.correctNull((String)hshValues.get("ACTION_UNDER_SARFAESIA"))%>";
var AGENT_APPOINTED="<%=Helper.correctNull((String)hshValues.get("AGENT_APPOINTED"))%>";
var POSSESSION_NOTICE="<%=Helper.correctNull((String)hshValues.get("POSSESSION_NOTICE"))%>";
var POSSESSION_TAKEN="<%=Helper.correctNull((String)hshValues.get("POSSESSION_TAKEN"))%>";
var ASSET_SOLD="<%=Helper.correctNull((String)hshValues.get("ASSET_SOLD"))%>";
var PWO_VALUE="<%=Helper.correctNull((String)hshValues.get("status_note"))%>";

function showpwo()
{
	if(PWO_VALUE=="2")
	{
		document.all.pwo.style.visibility="visible";
	}
	else
	{
		document.all.pwo.style.visibility="hidden";
	}

}

function showsuit()
{

	

}





function show1()
{

	if(document.forms[0].txt_eas.value=="4" || document.forms[0].txt_eas.value=="0")
	{
		document.all.ta1.style.visibility="hidden";
		document.forms[0].txt_easreason.value="";
	}
	else
	{
		document.all.ta1.style.visibility="visible";
		
		
	}

}
function showOTSreason()
{
	
}
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appUrl,name);
		
	}
}
function callbifr()
{   
    
	if(document.forms[0].txt_bifr.value=="1")
	{
		document.all.ref1.style.visibility="visible";
		document.all.ref1.style.position="relative";
		for(var i=0;i<5;i++)
		{
		document.all.ref2[i].style.visibility="visible";
		document.all.ref2[i].style.position="relative";
		}
		document.all.star1.style.visibility="visible";
		document.all.star2.style.visibility="visible";
		document.all.star3.style.visibility="visible";
		document.all.star1.style.position="relative";
		document.all.star2.style.position="relative";
		document.all.star3.style.position="relative";	
	}
	else
	{
		document.all.ref1.style.visibility="hidden";
		document.all.ref1.style.position="absolute";
		for(var i=0;i<5;i++)
		{
		document.all.ref2[i].style.visibility="hidden";
		document.all.ref2[i].style.position="absolute";
		document.forms[0].txt_refno[i].value="";
		document.forms[0].txt_refdate[i].value="";
		document.forms[0].txt_hearing_status[i].value="";
		
		}
		document.all.star1.style.visibility="hidden";
		document.all.star2.style.visibility="hidden";
		document.all.star3.style.visibility="hidden";
		document.all.star1.style.position="absolute";
		document.all.star2.style.position="absolute";
		document.all.star3.style.position="absolute";			
	}

}
function callbank()
{
	if(document.forms[0].txt_takeover.value=="1")
	{
		document.all.txt_bank.style.visibility="visible";
		document.all.bank1.style.visibility="visible";
	}
	else
	{
		document.all.txt_bank.style.visibility="hidden";
		document.all.bank1.style.visibility="hidden";
		document.forms[0].txt_bank.value="";
	}
}
function callgovern()
{
	if(document.forms[0].txt_govern.value=="1")
	{
		document.all.gov.style.visibility="visible";
		document.all.gov1.style.visibility="visible";
	}
	else
	{
		document.all.gov.style.visibility="hidden";
		document.all.gov1.style.visibility="hidden";
		document.forms[0].txt_governreason.value="";
	}
}


function callreprtdate()
{
	if(document.forms[0].txt_fraud.value=="1")
	{
		document.all.fraudate.style.visibility="visible";
		document.all.fraudate1.style.visibility="visible";
	}
	else
	{
		document.all.fraudate.style.visibility="hidden";
		document.all.fraudate1.style.visibility="hidden";
		document.forms[0].txt_frauddate.value="";
	}
}

function callterms()
{
	if(document.forms[0].txt_terms.value=="2")
	{
		document.all.term1.style.visibility="visible";
		document.all.term2.style.visibility="visible";
	}
	else
	{
		document.all.term1.style.visibility="hidden";
		document.all.term2.style.visibility="hidden";
		document.forms[0].txt_termscomplied.value="";
	}
}

function calldocs()
{
	
	if(document.forms[0].txt_docs.value=="1")
	{
		document.all.docs1.style.visibility="visible";
		document.all.docs2.style.visibility="visible";
	}
	else
	{
		document.all.docs1.style.visibility="hidden";
		document.all.docs2.style.visibility="hidden";
		document.forms[0].txt_latestdate.value="";
		document.forms[0].txt_vetting.value="0";
		document.forms[0].txt_vettingname.value="";
		document.forms[0].txt_Discrepancies.value="";
	}
}


function showposs()
{
	
}

function showposs1()
{
	
}

function showposs2()
{
	
}

function showposs3()
{
	
}



function showagent()
{
	if(document.forms[0].txt_agent.value=="1")
	{
		document.all.ragent.style.visibility="visible";
		document.all.ragent.style.position="relative";
		
	}
	else
	{
		document.all.ragent.style.visibility="hidden";
		document.all.ragent.style.position="absolute";
		document.forms[0].txt_agentreason.value="";
	}
}
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;
		 disableFields(false);
	}
}

function onLoading()
{ 

	if(ACCOUNT_CLASSIFIED !="")
	{
		document.forms[0].txt_eas.value=ACCOUNT_CLASSIFIED ;
	}
	else
	{
		document.forms[0].txt_eas.value="0";
	}
	if(ACCOUNT_PLACEDUNDER !="")
	{
		document.forms[0].txt_placedunders.value=ACCOUNT_PLACEDUNDER ;
	}
	else
	{
		document.forms[0].txt_placedunders.value="0";
	}
	
	if(BIFR_ACCOUNT !="")
	{
		document.forms[0].txt_bifr.value=BIFR_ACCOUNT ;
	}
	else
	{
		document.forms[0].txt_bifr.value="0";
	}
	if(TAKEOVER_ACCOUNT !="")
	{
		document.forms[0].txt_takeover.value=TAKEOVER_ACCOUNT ;
	}
	else
	{
		document.forms[0].txt_takeover.value="0";
	}
	if(GUARANTEE !="")
	{
		document.forms[0].txt_govern.value=GUARANTEE ;
	}
	else
	{
		document.forms[0].txt_govern.value="0";
	}
	if(FRAUD_ACCOUNT !="")
	{
		document.forms[0].txt_fraud.value=FRAUD_ACCOUNT ;
	}
	else
	{
		document.forms[0].txt_fraud.value="0";
	}
	if(TERMS_SANCTION !="")
	{
		document.forms[0].txt_terms.value=TERMS_SANCTION ;
	}
	else
	{
		document.forms[0].txt_terms.value="0";
	}
	if(VETTED_BY_ADVOCATES !="")
	{
		document.forms[0].txt_docs.value=VETTED_BY_ADVOCATES ;
	}
	else
	{
		document.forms[0].txt_docs.value="0";
	}
	if(VETTING_AUTHORITY !="")
	{
		document.forms[0].txt_vetting.value=VETTING_AUTHORITY ;
	}
	else
	{
		document.forms[0].txt_vetting.value="0";
	}
	
	if(AGENT_APPOINTED !="")
	{
		document.forms[0].txt_agent.value=AGENT_APPOINTED ;
	}
	else
	{
		document.forms[0].txt_agent.value="0";
	}
	
	<%
	 arrRowsta=new ArrayList();
	arrRowsta=(ArrayList)hshValues.get("arrRow");
	for (int i = 0; i <5; i++)
	{
	
		if(arrRowsta!=null && arrRowsta.size()>0)
		{
				arrColsta=(ArrayList)arrRowsta.get(i);
				if(arrColsta!=null && arrColsta.size()>0)
				{
					String con1=Helper.correctNull((String)arrColsta.get(1));
					String pat1=Helper.correctNull((String)arrColsta.get(2));
					String limit1=Helper.correctNull((String)arrColsta.get(3));%>
					
					var con1="<%=con1%>";
					var pat1="<%=pat1%>";
					var limit1="<%=limit1%>";
					var j="<%=i%>";
					document.forms[0].txt_refno[j].value=con1;
					document.forms[0].txt_refdate[j].value=pat1;
					document.forms[0].txt_hearing_status[j].value=limit1;
				<%}
		}
	}%>
	 disableFields(true);
	 show1();
	
	 calldocs();
	 callterms();
	 callreprtdate();
	 callgovern();
	 callbank();
	 callbifr();
	 showagent();
	 showpwo();
	 
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");	
	document.forms[0].txt_eas.focus();
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidmoduletype.value="STAT";
		document.forms[0].hidSourceUrl.value="/action/StatusNote_page2.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanGetMethod.value="getstatusnotepage2Data";
		document.forms[0].hidBeanMethod.value="getstatusnotepage2Data";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 		
	}	
	
	disableCommandButtons("load");
}

function doSave()
	{
		if(document.forms[0].txt_ecgc.value="")
		{
			alert("Enter the Position of ECGC claim/ROD lodged");
			document.forms[0].txt_ecgc.focus();
			return;
		}
		if(document.forms[0].txt_bifr.value=="0")				
		{
			alert("Whether account is referred to BIFR");
			document.forms[0].txt_bifr.focus();
			return;
		}
		for(i=0;i<5;i++)
		{
			if(document.forms[0].txt_bifr.value=="1" && document.forms[0].txt_refno[i].value=="")
			{
				alert("Enter the Reference No.");
				document.forms[0].txt_refno[i].focus();
				return;
			}
			if(document.forms[0].txt_bifr.value=="1" && document.forms[0].txt_refdate[i].value=="")
			{
				alert("Enter the Reference Date.");
				document.forms[0].txt_refdate[i].focus();
				return;
			}
			if(document.forms[0].txt_bifr.value=="1" && document.forms[0].txt_hearing_status[i].value=="")
			{
				alert("Enter the Hearing Status");
				document.forms[0].txt_hearing_status[i].focus();
				return;
			}
		}
		if(document.forms[0].txt_govern.value=="0")
		{
			alert("Enter Whether State/Central Government Guarantee is available");
			document.forms[0].txt_govern.focus();
			return;
		}
		if(document.forms[0].txt_govern.value=="1" && document.forms[0].txt_governreason.value=="")
		{
			alert("Enter Particulars of Guarantee");
			document.forms[0].txt_governreason.focus();
			return;
		}
		if(document.forms[0].txt_placedunders.value=="")
		{
			alert("Enter Whether account is reported as Fraud");
			document.form[0].txt_placedunders.focus();
			return;
		}
		if(document.forms[0].txt_placedunders.value=="1" && document.forms[0].txt_placedundersreason.value=="")
		{
			alert("Enter the Date Reported");
			document.forms[0].txt_placedundersreason.focus();
			return;
		}
		if(document.forms[0].txt_docs.value=="0")
		{
			alert("Whether documents are vetted by Advocates");
			document.forms[0].txt_docs.focus();
			return;
		}
		if(document.forms[0].txt_docs.value=="1" && document.forms[0].txt_latestdate.value=="")
		{
			alert("Enter the Date");
			document.forms[0].txt_latestdate.focus();
			return;
		}
		if(document.forms[0].txt_docs.value=="1" && document.forms[0].txt_vettingname.value=="")
		{
			alert("Enter the Vetting Authority Name");
			document.forms[0].txt_vettingname.focus();
			return;
		}
		document.forms[0].hidmoduletype.value="STAT";	
		document.forms[0].hidSourceUrl.value="/action/StatusNote_page2.jsp";
		document.forms[0].hidAction.value ="insert";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanMethod.value="updatestatusnotepage2Data";
		document.forms[0].hidBeanGetMethod.value="getstatusnotepage2Data";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}
	}
	document.forms[0].txt_frauddate.readOnly=true;
	document.forms[0].txt_latestdoc.readOnly=true;
	document.forms[0].txt_dbcdoc.readOnly=true;
	document.forms[0].txt_latestdate.readOnly=true;
	
	for(var i=0;i<5;i++)
	{
		document.forms[0].txt_refdate[i].readOnly=true;	
	}
	
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/npa_mainlinknav.jsp";
		document.forms[0].submit();
		
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
		{	
		document.forms[0].hidmoduletype.value="STAT";	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updatestatusnotepage2Data";
		document.forms[0].hidBeanGetMethod.value="getstatusnotepage2Data";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidSourceUrl.value="action/StatusNote_page2.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
		}


}

function callLink(page,bean,method)
{
		if (document.forms[0].cmdsave.disabled)
			{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].hidmoduletype.value="STAT";
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
		}
		else
		{
			ShowAlert(103);
		}
}

</script>
</head>
<body onload="onLoading()">

<form name="statusnotepage2" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapstab:staturltag pageid="3"/>
					</td>
				</tr>
				 <tr> 
           <td valign="top" class="page_flow">Home 
				-&gt; NPA-&gt; Status Note -&gt;Comments  
 </td>
          </tr>
			</table>
		</td>
	</tr>
</table>
<lapschoice:npaapplication />
		<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("appno")%>" />
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td>

				<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
					<tr>
						<td width="2%" valign="top" rowspan="2">11.</td>
						<td width="25%" valign="top" rowspan="2">Whether the account was
						classified as 'EAS / SMA' category<br>
						<br>
						Reasons for classifiying A/c. as 'EAS/ SMA' category, such as
						overdues, turnover below projected sales, non- submission of
						statements / dbc, sanction stipulation not complied / audit
						irregularites not rectified, continuous losses etc. and efforts
						made to upgrade the same.</td>
						
                  <td colspan="6">
                    <select name="txt_eas" onChange="show1()" tabindex="1">
                      <option value="0" selected>----Select----</option>
                      <option value="1">EAS1</option>
                      <option value="2">EAS2</option>
                      <option value="3">SMA</option>
                      <option value="4">NO</option>
                    </select>
                  </td>
					</tr>
					<tr>
						
                  <td id="ta1" colspan="6">&nbsp;
                    <textarea name="txt_easreason" tabindex="2"
							onKeyPress="textlimit(this,1499)" onKeyUp="textlimit(this,1499)"cols=55 rows=6><%=Helper.correctNull((String)hshValues.get("ACCOUNT_CLASSIFIED_REASON"))%>
							</textarea>
                  </td>
					</tr>
					<tr>
						<td rowspan="4" valign="top" width="2%">12.</td>
						<td width="25%" height="52" valign="top" rowspan="2">a) Whether
						account placed under nursing/rehabilitation. if not, whether
						rehabilitation likely to improve status of account. It yes,
						whether the account suffers from any previous history of serious
						material irregularity, diversion of funds, non-viability or fraud.</td>
						
                  <td height="26" colspan="6">
                    <select name="txt_placedunders" tabindex="3">
                      <option value="0" selected>----Select----</option>
                      <option value="1">YES</option>
                      <option value="2">NO</option>
                    </select>
                  </td>
					</tr>
					<tr>
						<td height="26" colspan="6">&nbsp;<textarea
							onKeyPress="textlimit(this,1499)" onKeyUp="textlimit(this,1499)" name="txt_placedundersreason"
							cols=55 rows=6 tabindex="4"><%=Helper.correctNull((String) hshValues
							.get("ACCOUNT_PLACEDUNDER_REASON"))%></textarea></td>
					</tr>
					<tr>
						<td width="25%" height="25" rowspan="2" valign="top"><!--b) Whether
						OTS possible?--></td>
						<td height="12" colspan="6"><!-- <select name="txt_ots"
							onchange="showOTSreason()">
							<option value="0" selected>----Select----</option>
							<option value="1">YES</option>
							<option value="2">NO</option>
						</select> --></td>
					</tr>
					<tr>
						<td id="ots1" height="13" colspan="6"><!-- <textarea
							name="txt_ots_reason" cols=55 rows=6
							onKeyPress="textlimit(this,1400)"><%//=Helper.correctNull((String) hshValues.get("OTS_REASON"))%></textarea>
						 --></td>
					</tr>
					<tr>
						<td width="2%" valign="top">13.</td>
						<td width="25%" valign="top">Position of ECGC claim / ROD lodged <span class="mantatory">*&nbsp;</span></td>
						<td colspan="6"><textarea name="txt_ecgc" cols=55 rows=6 tabindex="5"
							onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("ECGC_POSITION"))%></textarea></td>
					</tr>
					<tr>
						<td width="2%" valign="top" rowspan="7">14.</td>
						<td width="25%" rowspan="7" valign="top">Whether account is
						referred to BIFR. if yes reference nos. &amp; date <span class="mantatory">*&nbsp;</span></td>
						<td colspan="6"><select name="txt_bifr" onChange="callbifr()" tabindex="6">
							<option value="0" selected>----Select----</option>
							<option value="1">YES</option>
							<option value="2">NO</option>
						</select></td>
					</tr>
					<tr id="ref1" style="visibility:hidden;position:absolute;">
						<td width="14%" align="center">Reference No. <span class="mantatory" id="star1">*&nbsp;</span></td>
						<td colspan="2" align="center">Reference Date <span class="mantatory" id="star2">*&nbsp;</span></td>
						<td width="27%" align="center">Hearing Status <span class="mantatory" id="star3">*&nbsp;</span></td>
						<td colspan="2">&nbsp;</td>
					</tr>


					<%arrRowsta = new ArrayList();
			arrRowsta = (ArrayList) hshValues.get("arrRow");
			for (int i = 0; i < 5; i++) {

				if (arrRowsta != null && arrRowsta.size() > 0) {
					arrColsta = (ArrayList) arrRowsta.get(i);
					if (arrColsta != null && arrColsta.size() > 0) {%>

					<tr id="ref2">
						<td width="14%"><input type="text" name="txt_refno" size="25" tabindex="7"
							value="" maxlength="14" onKeyPress="allowInteger()"></td>
						<td colspan="2" align="center"><input type="text" onBlur="checkDate(this);checkmaxdate(this,currentDate)"
							name="txt_refdate" size="13" maxlength="10" tabindex="8" value="">
						<a href="#" onClick="callCalender('txt_refdate[<%=i%>]')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0" tabindex="8"></a></td>
						<td width="27%"><textarea name="txt_hearing_status" tabindex="9"
							onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" cols=35 rows=3></textarea></td>
							<td colspan="2">&nbsp;</td>
					</tr>
					<%}

				}

				else {%>

					<tr id="ref2">
						<td width="14%"><input type="text" name="txt_refno" size="25" tabindex="10"
							value="" maxlength="14"></td>
						
                  <td colspan="2" align="center">
                    <input type="text" 
							name="txt_refdate" size="13" maxlength="10" onBlur="checkDate(this);checkmaxdate(this,currentDate)" tabindex="11" value="">
                    <a href="#" onClick="callCalender('txt_refdate[<%=i%>]')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0" tabindex="11"></a></td>
						<td width="27%"><textarea name="txt_hearing_status" tabindex="12"
							onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" cols=35 rows=3></textarea></td>
							<td colspan="2">&nbsp;</td>
					</tr>
					<%}
			}%>
					<tr>
						<td width="2%" valign="top">15.</td>
						<td width="25%">Whether account is a take-over account. if yes,
						give bank from whom taken over.</td>
						<td width="14%"><select name="txt_takeover" onchange="callbank()" tabindex="13">
							<option value="0" selected>----Select----</option>
							<option value="1">YES</option>
							<option value="2">NO</option>
						</select></td>
						<td id="bank1" width="10%">&nbsp;Bank Name:</td>
						<td id="bank" width="22%">&nbsp;<input type="text" name="txt_bank" tabindex="14"
							size="25" maxlength="100"
							value="<%=Helper.correctNull((String)hshValues.get("TAKEOVER_BANK"))%>">
						</td>
						<td width="27%">&nbsp;</td>
					</tr>
					<tr>
						<td width="2%" valign="top">16.</td>
						
                  <td width="25%">Whether State/Central government guarantee is 
                    available. if yes brief particulars of guarantee.<span class="mantatory">*&nbsp;</span></td>
						<td width="14%"><select name="txt_govern" onchange="callgovern()" tabindex="15">
							<option value="0" selected>----Select----</option>
							<option value="1">YES</option>
							<option value="2">NO</option>
						</select></td>
						<td id="gov1" width="10%">Particulars of Guarantee <span class="mantatory">*&nbsp;</span></td>
						<td id="gov" width="22%"><textarea name="txt_governreason" cols=35 tabindex="16"
							onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" rows=6><%=Helper.correctNull((String) hshValues
							.get("PARTICULAR_GUARANTEE"))%></textarea></td>
						<td width="27%">&nbsp;</td>
					</tr>
					<tr>
						<td width="2%" valign="top">17.</td>
						<td width="25%">Whether account is reported as Fraud, If yes date
						when 1st reported.<span class="mantatory">*&nbsp;</span></td>
						<td width="14%"><select name="txt_fraud"
							onchange="callreprtdate()" tabindex="17">
							<option value="0" selected>----Select----</option>
							<option value="1">YES</option>
							<option value="2">NO</option>
						</select></td>
						<td id="fraudate1" width="10%">Date Reported</td>
						<td id="fraudate" width="22%"><input type="text" 
							name="txt_frauddate" size="13" maxlength="10" tabindex="18" onBlur="checkDate(this);checkmaxdate(this,currentDate)"
							value="<%=Helper.correctNull((String)hshValues.get("FRAUD_ACCOUNTDATE"))%>">
						<a href="#" onClick="callCalender('txt_frauddate')"
							title="Click to view calender" border=0> <img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0" tabindex="18"></a></td>
						<td width="27%">&nbsp;</td>
					</tr>
					<tr>
						<td rowspan="6" valign="top" width="2%">18.<br>
						<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
						&nbsp;&nbsp; <br>
						</td>
						<td width="25%">(a) Whether all terms of sanction complied with.
						if not, specify those not complied with.</td>
						<td width="14%"><select name="txt_terms" onchange="callterms()" tabindex="19">
							<option value="0" selected>----Select----</option>
							<option value="1">YES</option>
							<option value="2">NO</option>
						</select></td>
						<td width="10%" id="term2">Not Complied with</td>
						<td width="22%" id="term1"><textarea name="txt_termscomplied" tabindex="20"
							cols=35 onKeyPress="textlimit(this,1499)" onKeyUp="textlimit(this,1499)" rows=6><%=Helper.correctNull((String) hshValues
							.get("TERMS_SANCTION_NOT_COMPLIED"))%></textarea></td>
						<td colspan="3" width="27%">&nbsp;</td>
					</tr>
					<tr>
						<td width="25%" height="49">(b) Date of latest doc</td>
						<td colspan="6" height="49"><input type="text"
							name="txt_latestdoc" size="13" maxlength="10" tabindex="21" onBlur="checkDate(this);checkmaxdate(this,currentDate)"
							value="<%=Helper.correctNull((String)hshValues.get("LATEST_DOCDATE"))%>">
						<a href="#" onClick="callCalender('txt_latestdoc')"
							title="Click to view calender" border=0> <img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0" tabindex="21"></a></td>
					</tr>
					<tr>
						<td width="25%" height="37">(c) Date of DBC</td>
						<td colspan="6" height="37"><input type="text" name="txt_dbcdoc"
							size="13" maxlength="10" tabindex="22" onBlur="checkDate(this);checkmaxdate(this,currentDate)"
							value="<%=Helper.correctNull((String)hshValues.get("DBC_DATE"))%>">
						<a href="#" onClick="callCalender('txt_dbcdoc')"
							title="Click to view calender" border=0> <img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0" tabindex="22"></a></td>
					</tr>
					<tr>
						
                  <td valign="top" width="25%" rowspan="3">(d) Whether documents 
                    are vetted by Advocates , date of certificate and name of 
                    Advocates Discrepancies mentioned if any, specify<span class="mantatory">*&nbsp;</span></td>
						<td colspan="6"><select name="txt_docs" onchange="calldocs()" tabindex="23">
							<option value="0" selected>----Select----</option>
							<option value="1">YES</option>
							<option value="2">NO</option>
						</select></td>
					</tr>
					<tr id="docs1">
						<td align="center" width="14%">&nbsp;Date<span class="mantatory">*&nbsp;</span></td>
						<td align="center" colspan="2">&nbsp;Vetting Authority<span class="mantatory">*&nbsp;</span></td>
						<td align="center" width="27%">&nbsp;Discrepancies</td>
						
                  <td colspan="2">&nbsp;</td>
					</tr>
					<tr id="docs2">
						<td width="14%" height="66">&nbsp;<input type="text"
							name="txt_latestdate" size="15" maxlength="10" tabindex="24" onBlur="checkDate(this);checkmaxdate(this,currentDate)"
							value="<%=Helper.correctNull((String)hshValues.get("VETTEDDATE"))%>">
						<a href="#" onClick="callCalender('txt_latestdate')"
							title="Click to view calender" border=0> <img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0" tabindex="24"></a></td>
						<td width="10%" height="66" align="center">&nbsp;<select
							name="txt_vetting" onchange="calldocs()" tabindex="25">
							<option value="0" selected>----Select----</option>
							<option value="1">Advocate</option>
							<option value="2">Bank Official</option>
						</select></td>
						<td width="22%" height="66" align="center">&nbsp;<input type="text"
							name="txt_vettingname" maxlength="30" tabindex="26"
							value="<%=Helper.correctNull((String) hshValues.get("ADVOCATES_NAME"))%>">
						</td>
						<td width="27%" height="66">&nbsp;<textarea name="txt_Discrepancies" tabindex="27"
							onKeyPress="textlimit(this,1499)" onKeyUp="textlimit(this,1499)" cols=35 rows=3><%=Helper.correctNull((String) hshValues
							.get("DISCREPANCIES"))%></textarea></td>
							<td colspan="2">&nbsp;</td>
					</tr>
					
					<tr>
						<td width="2%" valign="top" rowspan="2">21.</td>
						<td width="25%" valign="top" rowspan="2">
						<p>Whether any agent appointed.</p>
						<p>If yes, give details of appointment and present status</p>
						</td>
						<td colspan="3"><select name="txt_agent" onchange="showagent()" tabindex="28">
							<option value="0" selected>----Select----</option>
							<option value="1">Yes</option>
							<option value="2">No</option>
						</select></td>
						<td width="27%" rowspan="2">&nbsp;</td>
						<td colspan="2">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="3" id="ragent"><textarea name="txt_agentreason" tabindex="29"
							onKeyPress="textlimit(this,1499)" onKeyUp="textlimit(this,1499)" cols=55 rows=5><%=Helper.correctNull((String) hshValues
									.get("AGENT_REASON"))%></textarea></td>
									<td colspan="2">&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>

				<table id="pwo" width="100%" border="0" cellspacing="0"
					cellpadding="3" class="outertable">
					<tr>
						<td width="3%">22.</td>
						<td width="18%">a) Amount Written Off</td>
						<td><input type="text" name="txt_amtwrittenoff" maxlength="20"
							onKeyPress="allowInteger()" tabindex="30"
							value="<%=Helper.correctNull((String) hshValues.get("pwo_amt"))%>"></td>
					</tr>
					<tr>
						<td width="3%">&nbsp;</td>
						<td width="18%">b) Date of Written Off</td>
						<td><input type="text" name="txt_writtenoffdate" size="15"
							maxlength="10" tabindex="31" onBlur="checkDate(this);checkmaxdate(this,currentDate)"
							value="<%=Helper.correctNull((String)hshValues.get("pwo_date"))%>">
						<a href="#" onClick="callCalender('txt_writtenoffdate')"
							title="Click to view calender" border=0> <img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0" tabindex="31"></a></td>
					</tr>
					<tr>
						<td width="3%">&nbsp;</td>
						<td width="18%">c) Recovery after Write Off</td>
						<td><input type="text" name="txt_recoverywrittenoff"
							maxlength="25" onKeyPress="allowInteger()" tabindex="32"
							value="<%=Helper.correctNull((String) hshValues.get("pwo_recovery"))%>"></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
   <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<input type="hidden" name="hidappno"
	value="<%=(String)request.getParameter("npa_appno")%>">

<input type="hidden" name="status_note" value="<%=status_note %>" /> 
 <lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
