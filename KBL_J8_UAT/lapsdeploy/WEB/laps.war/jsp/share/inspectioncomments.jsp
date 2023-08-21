<%@include file="../share/directives.jsp"%>

<%ArrayList arryCol = null;
%>
<html>
<head>
<title>Proposal Terms </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript">

var currentDate = "<%=Helper.getCurrentDateTime()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";

function callOnload(){

	document.forms[0].txt_comment1.value ='<%=Helper.correctNull((String)hshValues.get("INS_INTERNALCOMMENT"))%>';
	document.forms[0].txt_action1.value ='<%=Helper.correctNull((String)hshValues.get("INS_INTERNALACTION"))%>';
	document.forms[0].txt_comment2.value ='<%=Helper.correctNull((String)hshValues.get("INS_RBICOMMENT"))%>';
	document.forms[0].txt_action2.value ='<%=Helper.correctNull((String)hshValues.get("INS_RBIACTION"))%>';
	document.forms[0].txt_comment3.value ='<%=Helper.correctNull((String)hshValues.get("INS_UNITCOMMENT"))%>';
	document.forms[0].txt_action3.value ='<%=Helper.correctNull((String)hshValues.get("INS_UNITACTION"))%>';
	document.forms[0].txt_comment4.value ='<%=Helper.correctNull((String)hshValues.get("INS_RMDCOMMENT"))%>';
	document.forms[0].txt_action4.value ='<%=Helper.correctNull((String)hshValues.get("INS_RMDACTION"))%>';
	document.forms[0].txt_comment5.value ='<%=Helper.correctNull((String)hshValues.get("INS_AUDITCOMMENT"))%>';
	document.forms[0].txt_action5.value ='<%=Helper.correctNull((String)hshValues.get("INS_AUDITACTION"))%>';
	document.forms[0].txt_comment6.value ='<%=Helper.correctNull((String)hshValues.get("INS_OFFSITECOMMENT"))%>';
	document.forms[0].txt_action6.value ='<%=Helper.correctNull((String)hshValues.get("INS_OFFSITEACTION"))%>';
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

function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
	}
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
		document.forms[0].hidBeanGetMethod.value="getInspection";
		document.forms[0].hidBeanId.value="proposalterms";
		document.forms[0].action=appURL+"action/inspectioncomments.jsp";	
		document.forms[0].submit();
	}
}

function doSave()
{		
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanMethod.value="updateInspection";
	document.forms[0].hidBeanGetMethod.value="getInspection";
	document.forms[0].hidBeanId.value="proposalterms";
	document.forms[0].hidSourceUrl.value="/action/inspectioncomments.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{		
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanMethod.value="updateInspection";
	    document.forms[0].hidBeanGetMethod.value="getInspection";
		document.forms[0].hidBeanId.value="proposalterms";
		document.forms[0].hidSourceUrl.value="/action/inspectioncomments.jsp";
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
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Proposal Terms -&gt; Inspection Comments</td>
	</tr>
</table>
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="bottom">
		<table width="80%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr>			
				<td align="center" class="sub_tab_inactive" width="15%"><b><a href="JavaScript:callConduct()" >Conduct of operations</b></a></td>
				<td align="center" class="sub_tab_inactive" width="15%"><b><a href="JavaScript:callRBI()" >RBI Guidelines</a></b></td>
				<td align="center" class="sub_tab_active" width="15%"><b>Inspection Comments</b></td>
				<td align="center" class="sub_tab_inactive" width="15%"><b><a href="JavaScript:callCersai()" >CERSAI Details</a></b></td>
				<td align="center" class="sub_tab_inactive" width="15%" ><b><a href="JavaScript:callNpa()" >NPA/Ratification/Concession</b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br/>

<table width="98%" border="0" cellpadding="3" cellspacing="0" class="outertable" align="center">
	<tr>
		<td><b>Inspection Comments(Internal/RBI) and rectification thereof</b></td>
	</tr>
</table>
<table width="98%" border="0" cellpadding="3" cellspacing="0" class="outertable border1" align="center">
	<tr><td>
	<table width="95%" border="0" align="center" cellpadding="3" cellspacing="0" class="outertable">
		<tr>
				<td colspan="2">&nbsp;</td>
				<td><b>Comments</b></td>
				<td><b>Compliance/Action taken/<br/> time frame for rectification</b></td>
		</tr>
		<tr>
			<td>Internal as on </td>
			<td><input type="text"
						name="txt_innternaldate" size="12" 
						value="<%=Helper.correctNull((String)hshValues.get("INS_INTERNALDATE"))%>"
						onBlur="checkDate(this);checkmaxdate(this,currentDate)" readOnly> <a
						alt="Select date from calender" href="#"
						onClick="callCalender('txt_innternaldate')"
						onMouseOver="window.status='Date Picker';return true;"
						onMouseOut="window.status='';return true;"><img
						src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
						border=0 alt="Select date from calender"></a></td>
				<td><textarea name="txt_comment1" cols="40" rows="4" onKeyPress="textlimit(this,1999)" wrap="VIRTUAL" onkeyup="textlimit(this,1999)"></textarea></td>
				<td><textarea name="txt_action1" cols="40" rows="4" onKeyPress="textlimit(this,1999)" wrap="VIRTUAL" onkeyup="textlimit(this,1999)"></textarea></td>
		</tr>
		<tr>
			<td>RBI as on</td>
			<td><input type="text"
						name="txt_rbiasondate" size="12" 
						value="<%=Helper.correctNull((String)hshValues.get("INS_RBIASONDATE"))%>"
						onBlur="checkDate(this);checkmaxdate(this,currentDate)" readOnly> <a
						alt="Select date from calender" href="#"
						onClick="callCalender('txt_rbiasondate')"
						onMouseOver="window.status='Date Picker';return true;"
						onMouseOut="window.status='';return true;"><img
						src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
						border=0 alt="Select date from calender"></a></td>
			<td><textarea name="txt_comment2" cols="40" rows="4" onKeyPress="textlimit(this,1999)" wrap="VIRTUAL" onkeyup="textlimit(this,1999)"></textarea></td>
			<td><textarea name="txt_action2" cols="40" rows="4" onKeyPress="textlimit(this,1999)" wrap="VIRTUAL" onkeyup="textlimit(this,1999)"></textarea></td>		
		</tr>
		<tr>
			<td colspan="2">Unit Inspection Reports</td>
			<td><textarea name="txt_comment3" cols="40" rows="4" onKeyPress="textlimit(this,1999)" wrap="VIRTUAL" onkeyup="textlimit(this,1999)"></textarea></td>
			<td><textarea name="txt_action3" cols="40" rows="4" onKeyPress="textlimit(this,1999)" wrap="VIRTUAL" onkeyup="textlimit(this,1999)"></textarea></td>
		</tr>
		<tr>
			<td colspan="2">RMD's Observations</td>
			<td><textarea name="txt_comment4" cols="40" rows="4" onKeyPress="textlimit(this,1999)" wrap="VIRTUAL" onkeyup="textlimit(this,1999)"></textarea></td>
			<td><textarea name="txt_action4" cols="40" rows="4" onKeyPress="textlimit(this,1999)" wrap="VIRTUAL" onkeyup="textlimit(this,1999)"></textarea></td>
		</tr>
		<tr>
			<td colspan="2">Concurrent Audit Report</td>
			<td><textarea name="txt_comment5" cols="40" rows="4" onKeyPress="textlimit(this,1999)" wrap="VIRTUAL" onkeyup="textlimit(this,1999)"></textarea></td>
			<td><textarea name="txt_action5" cols="40" rows="4" onKeyPress="textlimit(this,1999)" wrap="VIRTUAL" onkeyup="textlimit(this,1999)"></textarea></td>
		</tr>
		<tr>
			<td colspan="2">Offsite Observation</td>
			<td><textarea name="txt_comment6" cols="40" rows="4" onKeyPress="textlimit(this,1999)" wrap="VIRTUAL" onkeyup="textlimit(this,1999)"></textarea></td>
			<td><textarea name="txt_action6" cols="40" rows="4" onKeyPress="textlimit(this,1999)" wrap="VIRTUAL" onkeyup="textlimit(this,1999)"></textarea></td>
		</tr>
	</table>
</td></tr>
</table>
<br/>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
<INPUT TYPE="hidden" name="hidsno"> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
