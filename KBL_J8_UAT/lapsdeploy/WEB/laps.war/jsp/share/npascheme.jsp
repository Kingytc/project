<%@include file="../share/directives.jsp"%>

<html>
<head>
<title>Proposal Terms </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript">

var currentDate = "<%=Helper.getCurrentDateTime()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";

function callOnload(){

	document.forms[0].txt_amtwise.value ='<%=Helper.correctNull((String)hshValues.get("npa_amtwise"))%>';
	document.forms[0].txt_accwise.value ='<%=Helper.correctNull((String)hshValues.get("npa_accwise"))%>';
	//document.forms[0].txt_ratification.value ='<%//=Helper.replaceForJavaScriptString((String)hshValues.get("npa_ratification"))%>';
	//document.forms[0].txt_concession.value ='<%//=Helper.replaceForJavaScriptString((String)hshValues.get("npa_concession"))%>';
	disableFields(true);
}

function callConduct(){
	if(document.forms[0].cmdsave.disabled)
	{
	document.forms[0].hidBeanId.value="proposalterms";	
	document.forms[0].hidBeanGetMethod.value="getConduct";
	document.forms[0].action=appURL+"action/proposalterms.jsp";
	document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function callRBI(){
	if(document.forms[0].cmdsave.disabled)
	{
	document.forms[0].hidBeanId.value="proposalterms";	
	document.forms[0].hidBeanGetMethod.value="getRBIGuidelines";
	document.forms[0].action=appURL+"action/rbiguidelines.jsp";
	document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function callInspection(){
	if(document.forms[0].cmdsave.disabled)
	{
	document.forms[0].hidBeanId.value="proposalterms";	
	document.forms[0].hidBeanGetMethod.value="getInspection";
	document.forms[0].action=appURL+"action/inspectioncomments.jsp";
	document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
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
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=(!val);
		}	
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		} 
	}
}

function disableCommandButtons(cmdEdit,cmdSave,cmdCancel,cmdDelete,cmdClose)
{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdSave;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmddelete.disabled=cmdDelete;
	document.forms[0].cmdclose.disabled=cmdClose;
}  

function doEdit(){
	
	disableFields(false);
	disableCommandButtons(true,false,false,false,true); 
	document.forms[0].hidAction.value="update";
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanGetMethod.value="getNpaScheme";
		document.forms[0].hidBeanId.value="proposalterms";
		document.forms[0].action=appURL+"action/npascheme.jsp";	
		document.forms[0].submit();
	}
}

function doSave()
{	
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanMethod.value="updateNpaScheme";
	document.forms[0].hidBeanGetMethod.value="getNpaScheme";
	document.forms[0].hidBeanId.value="proposalterms";
	document.forms[0].hidSourceUrl.value="/action/npascheme.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{		
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanMethod.value="updateNpaScheme";
	    document.forms[0].hidBeanGetMethod.value="getNpaScheme";
		document.forms[0].hidBeanId.value="proposalterms";
		document.forms[0].hidSourceUrl.value="/action/npascheme.jsp";
	    document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].method="post";	
		document.forms[0].submit();
	}
}
function disab()
{
	var c = window.event.keyCode;
	if(c == 13)
	{
	return;
	}
}
function callCersai(){
	if(document.forms[0].cmdsave.disabled)
	{
	document.forms[0].hidBeanId.value="proposalterms";	
	document.forms[0].hidBeanGetMethod.value="getCersaiCibil";
	document.forms[0].action=appURL+"action/cersaicibildetails.jsp";
	document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
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
<body onload="callOnload()">
<form name="proposal" action="" method="post" class="normal">
<jsp:include page="../share/Applurllinkper.jsp" flush="true">
<jsp:param name="pageid" value="51" />
</jsp:include>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Proposal Terms -&gt; Cersai&Cibil Details</td>
	</tr>
</table>
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="bottom">
		<table width="80%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr>			
				<td align="center" class="sub_tab_inactive" width="15%"><b><a href="JavaScript:callConduct()" >Conduct of operations</a></b></td>
				<td align="center" class="sub_tab_inactive" width="15%"><b><a href="JavaScript:callRBI()" >RBI Guidelines</a></b></td>
				<td align="center" class="sub_tab_inactive" width="15%"><b><a href="JavaScript:callInspection()" >Inspection Comments</a></b></td>
				<td align="center" class="sub_tab_inactive" width="15%"><b><a href="JavaScript:callCersai()" >CERSAI Details</b></td>
				<td align="center" class="sub_tab_active" width="15%"><b>NPA/Ratification/Concession</b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
  <table width="93%" border="0" cellpadding="3" cellspacing="0" class="outertable border1" align="center">
    <tr><td>
        <table width="80%" border="0" cellpadding="3" cellspacing="0" class="outertable">
          <tr>
           <td align="right">Amount wise&nbsp;</td>
	      	<td>  <lapschoice:CurrencyTag name="txt_amtwise" maxlength="6" size="12" tabindex="11" style="text-align:right" onKeyPress="allowDecimals(this)"
											onBlur="roundtxt(this);checkPercentage(this);" /></td> 
            <td align="right">Account wise</td>
           <td><lapschoice:CurrencyTag name="txt_accwise" maxlength="6" size="12" tabindex="11" style="text-align:right" onKeyPress="allowDecimals(this)"
											onBlur="roundtxt(this);checkPercentage(this);" /></td> 
            <td width="10%" align="right">As on</td>
			<td><input type="text" name="txt_npadate" size="12" value="<%=Helper.correctNull((String)hshValues.get("npa_date"))%>" onBlur="checkDate(this);checkmaxdate(this,currentDate)" readOnly> <a
						alt="Select date from calender" href="#" onClick="callCalender('txt_npadate')" onMouseOver="window.status='Date Picker';return true;"
						onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0 alt="Select date from calender"></a></td>
		</tr>
		</table>
	<table width="97%" border="0" cellpadding="3" cellspacing="0" class="outertable">
	<tr>
	    <td width="10%" align="right">Ratification</td>
	    <td width="33%"> 
             <textarea name="txt_ratification" cols="50" rows="5" onKeyPress="textlimit(this,'3999');if(event.keyCode==13){return false;}"  onKeyUp="textlimit(this,3999)"wrap="VIRTUAL"><%=Helper.correctNull((String)hshValues.get("npa_ratification"))%></textarea></td>												
	    <td width="17%" align="left">Any Other Concession</td>
	    <td width="40%"> 
             <textarea name="txt_concession" cols="50" rows="5" onKeyPress="textlimit(this,'3999');if(event.keyCode==13){return false;}" onKeyUp="textlimit(this,3999)" wrap="VIRTUAL"><%=Helper.correctNull((String)hshValues.get("npa_concession"))%></textarea></td>												
	</tr>
</table>
</td></tr>
</table>										
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
<INPUT TYPE="hidden" name="hidsno"> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
