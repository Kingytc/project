<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Appraiser Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var perIntroCbsId="<%=Helper.correctNull((String)hshValues.get("ja_percbsid"))%>";
var perAppfname="<%=Helper.correctNull((String)hshValues.get("ja_perfname"))%>";
function doClose()
{
 	window.close();
} 
function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled == false)
	{
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}
function doEdit()
{
	disableFields(false);	
	document.forms[0].hidAction.value ="insert";
	enableButtons(true,false,false,false,true);	

}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;	
	document.forms[0].cmddelete.disabled=bool4;  	
	document.forms[0].cmdclose.disabled=bool5;
}

function doSave()
{
	if(document.forms[0].txt_appraisername.value=="")
	{
		alert("Select Appraiser Name");
		return;
	}
	else if(document.forms[0].hidAppraiserID.value=="")
	{
		alert("Select CBS ID");
		return;
	}
	else if(document.forms[0].txt_appraisedon.value=="")
	{
		alert("Select Appraisal Date");
		return;
	}
	else if(document.forms[0].txt_comments.value=="")
	{
		alert("Enter Appraiser Comments");
		document.forms[0].txt_comments.focus();
		return;
	}
	else if (document.forms[0].hidAppraiserID.value==perIntroCbsId)
	{
		alert("The said "+perAppfname+" is introduced by Jewel appraisal  "+document.forms[0].txt_appraisername.value+" & "+document.forms[0].hidAppraiserID.value);
		
	}
	
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="agrotherassets";
	document.forms[0].hidBeanMethod.value="updateGoldAppraiserdet";
	document.forms[0].hidBeanGetMethod.value="getGoldAppraiserdet";
	document.forms[0].hidSourceUrl.value="/action/per_appraiserdetails.jsp";
	document.forms[0].submit();

}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		enableButtons(false,false,false,true,true)
		document.forms[0].hidBeanId.value="agrotherassets"
		document.forms[0].hidBeanGetMethod.value="getGoldAppraiserdet";
		document.forms[0].action=appURL+"/action/per_appraiserdetails.jsp";
		document.forms[0].submit();
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
			document.forms[0].elements[i].disabled=!val;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
	}	
	document.forms[0].txt_appraisername.readOnly=true;
	document.forms[0].hidAppraiserID.readOnly=true;
	//document.forms[0].txt_appraisedon.readOnly=true;
}
function onloading()
{
	disableFields(true);	
}

function showAppraiserName()
{	
	if(document.forms[0].cmdsave.disabled == false)
	{
		var action=document.forms[0].hidAction.value;	
		var prop = "scrollbars=yes,width=500,height=400,top=100,left=250";
		var url=appURL+"action/valuerslist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getValuerMasterList&hidAction=search&strfrom=ValuersMaster&hidAppVal="+"J&appraiser="+"appraiser";
		window.open(url,"",prop);
	}

	
}
function doDelete()
{
	if(ConfirmMsg(101))
	{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="agrotherassets";
		document.forms[0].hidBeanMethod.value="updateGoldAppraiserdet";
		document.forms[0].hidBeanGetMethod.value="getGoldAppraiserdet";
		document.forms[0].hidSourceUrl.value="/action/per_appraiserdetails.jsp";
		document.forms[0].submit();
	
	}
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading();">
<form name="appform" method="post" class="normal">
<table width="98%" border="0" cellpadding="5" cellspacing="0" class="outertable" align="center">

	<tr>
	<td>
	
<table width="90%" border="0" cellpadding="5" cellspacing="0" class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
			<tr class="dataheader">
				<td align="center"> Appraiser Details
				
				
				</td>
				</tr>
				<tr>
				<td>

				<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
			
			<tr class="datagrid">
			<td width="25%" nowrap>&nbsp;Appraiser Name </td>
			<td width="25%"><input type="text" name="txt_appraisername" value="<%=Helper.correctNull((String)hshValues.get("ja_name")) %>" size="25">	&nbsp;
			<a href="#" onClick="showAppraiserName();" style="cursor:hand" tabindex="22">
			<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" ></a>
			
			
			
			
			</td>
			<td width="15%" >Appraised on </td>
			<td width="10%"><input type="text" name="txt_appraisedon" value="<%=Helper.correctNull((String)hshValues.get("ja_appraiseon")) %>" size="12">			
			</td>
			<td width="5%" align="left">
			<a alt="Select date from calender"
									href="#" onClick="callCalender('txt_appraisedon')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
									alt="Select date from calender"></a></td>
			</tr>
			<tr class="datagrid">
			<td>CBS ID</td>
			<td colspan="4"><input type="text" name="hidAppraiserID" value="<%=Helper.correctNull((String)hshValues.get("ja_appraisercbsid")) %>"></td>
			</tr>
	
			<tr class="datagrid">
			<td ><b>&nbsp;&nbsp;Comments </b>
			</td>
			<td colspan="6"><b><textarea name="txt_comments" rows="7" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"cols="80"><%=Helper.replaceForJavaScriptString(Helper.correctNull((String)hshValues.get("ja_comments")))%></textarea></b>
			</td>
			</tr>
		
					
				</table>
				</td>
			</tr>
				</table>
			<tr>
			<td>
			<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete'	btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
			</td>
			</tr>
	

</table>
</td>
</tr>
</table>
<input type="hidden" name="hidAction">
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidBeanGetMethod">
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidSourceUrl">

</form>
</body>
</html>
