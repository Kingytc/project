<%@include file="../share/directives.jsp"%>

<html>
<head>
<title>Proposal Terms </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript">

var appURL="<%=ApplicationParams.getAppUrl()%>";

function callOnload(){
	document.forms[0].txt_rbiguidelines.value='<%= Helper.correctNull((String)hshValues.get("creditproposal"))%>';
	disableFields(true);
}

function callConduct(){

	if(document.forms[0].cmdsave.disabled)
	{	
		document.forms[0].hidBeanId.value="proposalterms";	
		document.forms[0].hidBeanGetMethod.value="getConduct";
		document.forms[0].action=appURL+"action/proposalterms.jsp";
		document.forms[0].target="mainFrame";
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
		document.forms[0].hidBeanGetMethod.value="getRBIGuidelines";
		document.forms[0].hidBeanId.value="proposalterms";
		document.forms[0].action=appURL+"action/rbiguidelines.jsp";	
		document.forms[0].submit();
	}
}

function doSave()
{	
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanMethod.value="updateRBIGuidelines";
	document.forms[0].hidBeanGetMethod.value="getRBIGuidelines";
	document.forms[0].hidBeanId.value="proposalterms";
	document.forms[0].hidSourceUrl.value="/action/rbiguidelines.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{		
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanMethod.value="updateRBIGuidelines";
	    document.forms[0].hidBeanGetMethod.value="getRBIGuidelines";
		document.forms[0].hidBeanId.value="proposalterms";
		document.forms[0].hidSourceUrl.value="/action/rbiguidelines.jsp";
	    document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].method="post";	
		document.forms[0].submit();
	}
}
function callNpa(){
	if(document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidBeanId.value="proposalterms";	
		document.forms[0].hidBeanGetMethod.value="getNpaScheme";
		document.forms[0].action=appURL+"action/npascheme.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
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
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Proposal Terms -&gt; RBI Guidelines</td>
	</tr>
</table>
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="bottom">
		<table width="80%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr>			
				<td align="center" class="sub_tab_inactive" width="15%"><a href="JavaScript:callConduct()" ><b>Conduct of operations</b></a></td>
				<td align="center" class="sub_tab_active" width="15%"><b>RBI Guidelines</b></td>
				<td align="center" class="sub_tab_inactive" width="15%"><b><a href="JavaScript:callInspection()" >Inspection Comments</a></b></td>
				<td align="center" class="sub_tab_inactive" width="15%"><b><a href="JavaScript:callCersai()" >CERSAI Details</a></b></td>
				<td align="center" class="sub_tab_inactive" width="15%" ><b><a href="JavaScript:callNpa()" >NPA/Ratification/Concession</b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br/>
<table width="98%" border="0" cellpadding="3" cellspacing="0" class="outertable border1" align="center">
<tr><td>
<table width="100%" border="0" cellpadding="3" cellspacing="0" class="outertable">
	<tr>
		<td width="13%">RBI Guidelines, if any, Regarding the Credit Proposal</td>
		<td width="19%"><textarea name="txt_rbiguidelines" cols="50"
						rows="5" onKeyPress="textlimit(this,1999)" wrap="VIRTUAL" onkeyup="textlimit(this,1999)"></textarea></td>												
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
