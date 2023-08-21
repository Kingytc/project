<%@include file="../share/directives.jsp"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<%String strCons_Owner = Helper.correctNull((String) request.getParameter("hidCostitution"));%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

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
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var bank_charges="<%=Helper.correctNull((String)hshValues.get("bank_charges"))%>";
var terms_condts="<%=Helper.correctNull((String)hshValues.get("terms_condts"))%>";
var business_cont="<%=Helper.correctNull((String)hshValues.get("business_cont"))%>";

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
		showReason();
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
	if(terms_condts=="1")
	{
	  document.forms[0].sel_rbutton.value=terms_condts;	
	  document.all.a1.style.visibility="visible";
	  document.all.a1.style.position="relative";
		 
	}
	
	else
	{
		document.forms[0].sel_rbutton.value='0';	
	}
	if(business_cont=="1")
	{
	  document.forms[0].sel_business_cont.value=business_cont;	
	  document.all.a2.style.visibility="visible";
	  document.all.a2.style.position="relative";
	}
	
	else
	{
		document.forms[0].sel_business_cont.value='0';
	}
	
	showReason();
	showBusiness();
	clearValues();
	disableFields(true);
}
function doEdit()
{ 	
	disableFields(false);
	
	disableCommandButtons("edit");	
	document.forms[0].hidAction.value ="insert";
	document.forms[0].sel_rbutton.focus();
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
	    document.forms[0].hidSourceUrl.value="/action/34PointsFormat_page6.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanGetMethod.value="get34pointspage6Data";
		document.forms[0].hidBeanMethod.value="get34pointspage6Data";
		document.forms[0].action=appUrl +"controllerservlet"; 
		document.forms[0].submit(); 		
	}		
	disableCommandButtons("load");
}

function doSave()
{
	if(document.forms[0].txt_claim.value=="")
	{
		alert("Enter the Details of DICGC/ECGC claim");
		document.forms[0].txt_claim.focus();
		return;
	}
	document.forms[0].hidSourceUrl.value="/action/34PointsFormat_page6.jsp";
	document.forms[0].hidBeanId.value="npa";
	document.forms[0].hidBeanMethod.value="update34pointspage6Data";
	document.forms[0].hidBeanGetMethod.value="get34pointspage6Data";
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
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}		 
	}
}
function doClose()
	{
	if(ConfirmMsg('100'))
		{
		document.forms[0].method="post";	
		document.forms[0].action=appUrl+"action/"+"npa_mainlinknav.jsp";
		document.forms[0].submit();
		}
	}
	
function doDelete()
{
if(ConfirmMsg(101))
		{	
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidSourceUrl.value="/action/34PointsFormat_page6.jsp";
			document.forms[0].hidBeanId.value="npa";
			document.forms[0].hidBeanMethod.value="update34pointspage6Data";
			document.forms[0].hidBeanGetMethod.value="get34pointspage6Data";
			document.forms[0].action=appUrl +"controllerservlet";
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
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}
		
function showReason()
{
		if(document.forms[0].sel_rbutton.value=='1')
		{
			document.all.a1.style.visibility="visible";
			document.all.a1.style.position="relative";
			
		}
		else 
		{		
			document.all.a1.style.visibility="hidden";
			document.all.a1.style.position="absolute";
		}
	
}
function showBusiness()
{
		if(document.forms[0].sel_business_cont.value=='1')
		{
			document.all.a2.style.visibility="visible";
			document.all.a2.style.position="relative";
			
		}
		else 
		{		
			document.all.a2.style.visibility="hidden";
			document.all.a2.style.position="absolute";
		}	
}		
function clearValues()
{	
	if(bank_charges=="n")
	for( i=0;i<=4;i++)		
	{	
		    document.forms[0].txt_location[i].value="";
			document.forms[0].txt_descript[i].value="";
			document.forms[0].txt_owner[i].value="";
			document.forms[0].txt_date[i].value="";		
	}
	if(terms_condts=="0")
	document.forms[0].txt_reason.value="";	
	if(business_cont=="0")	
	document.forms[0].txt_present_act.value="";	
}
</script>
</head>
<body onload="onLoading()">
<form name="34pointsFormatpage6" method="post" class="normal">

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left" class="outertable">
			<tr>
				<td><lapstab:suiturltag pageid="10" /></td>
			</tr>
			<tr>
				<td valign="top" class="page_flow">Home -&gt; NPA-&gt; Filing Of Suit -&gt;Comments</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:npaapplication /> <INPUT type="hidden" name="npa_appno"
	value="<%=(String)request.getParameter("npa_appno")%>" />
<table width="100%" border="0" cellspacing="0" cellpadding="2" 	class="outertable border1">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" 	class="outertable"
			align="center">
			<tr>
				<td WIDTH="47%">Whether the terms and conditions are stipulated in
				the Sanction Advice and/or as required for while granting credit
				facility(ies) to the borrower(s) originally and subsequently were
				fulfilled or not: - <br>
				<br>
				</td>
				<td WIDTH="30%"><select name="sel_rbutton" onChange="showReason();">
					<option value="0">Yes</option>
					<option value="1">No</option>
				</select></td>
			</tr>
			<tr id="a1">
				<td>if no, brief reasons:-<br>
				<br>
				<textarea rows="4" name="txt_reason" cols="55"
					onKeyPress="textlimit(this,300)"><%=Helper.correctNull((String) hshValues.get("reasons"))%></textarea>
				<br>
				<br>
				</td>
				<td>&nbsp;</td>			
			<tr>
				<td>Please elaborate the future course of action. towards the
				recovery of the advances:-</td>
			</tr>
			<tr>
				<td><textarea rows="8" name="txt_elaborate" cols="70"
					onkeypress="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues
							.get("fil_elaborate"))%></textarea>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>Any further comments you wish to incorporate therein:-</td>
			</tr>
			<tr>
				<td><textarea rows="8" name="txt_further" cols="70"
					onkeypress="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues
									.get("fil_further"))%></textarea>
				</td>
			</tr>

			<tr>
				<td></td>
			</tr>
			<tr>

				<td WIDTH="47%">Whether Business is continued ?<br>
				<br>
				</td>

				<td WIDTH="30%"><select name="sel_business_cont"
					onChange="showBusiness();">
					<option value="0">Yes</option>
					<option value="1">No</option>
				</select></td>
			</tr>
			<tr id="a2">

				<td>If not, present activity of borrower<br>
				<br>
				<textarea rows="4" name="txt_present_act" cols="55" onKeyPress="textlimit(this,300)">
					<%=Helper.correctNull((String) hshValues.get("present_act"))%></textarea>
				<br>
				<br>

				</td>
				<td>&nbsp;</td>
			<tr>
			<tr>
				<td>Are the assets possessed by the borrower/guarantor presently
				free of any charge ?</td>
			</tr>
			<tr>
				<td><textarea rows="8" name="txt_assets" cols="70"
					onkeypress="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues.get("fil_assets"))%></textarea>
				</td>
			</tr>

			<tr>
				<td>Details of DICGC/ECGC claim <span class="mantatory">*&nbsp;</span>
				</td>
			</tr>
			<tr>
				<td><textarea rows="8" name="txt_claim" cols="70"
					onkeypress="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues.get("fil_claim"))%></textarea>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete"
btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />  
<lapschoice:hiddentag pageid='<%=PageId%>'/> <input type="hidden" name="hidCostitution"
	value="<%=strCons_Owner%>" /> </form>
</body>
</html>
