<%@ include file="../share/directives.jsp"%>
<html>
<head>
<title>Industy Master</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/navigate.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
 var appURL = "<%=ApplicationParams.getAppUrl()%>";
var isnew="false";
var activeflag ="<%=Helper.correctNull((String)hshValues.get("ind_active"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function disablecommandbuttons(cmbnew,cmbedit,cmbapply,cmbcancel,cmbdelete,cmbclose)
{
	document.forms[0].cmdnew.disabled = cmbnew;
	document.forms[0].cmdedit.disabled = cmbedit;
	document.forms[0].cmdsave.disabled = cmbapply;
	document.forms[0].cmdcancel.disabled = cmbcancel;
	document.forms[0].cmddelete.disabled = cmbdelete;
	document.forms[0].cmdclose.disabled = cmbclose;
}
function disableControls(bflag)
{ 
	document.forms[0].txt_industryname.readOnly = bflag;
	document.forms[0].txt_bsrcode.readOnly = bflag;
	document.forms[0].txt_indgrp.readOnly = true;
	document.forms[0].selactive.disabled = bflag;
}

function onloading()
{
	if(checktrim(document.forms[0].hidinudstryname.value)=="")
	{
		disablecommandbuttons(false,false,true,true,true,false);
		disableControls(true);
	}
	else
	{
		disablecommandbuttons(false,false,true,true,true,false);
		disableControls(true);
	}
	
	if(activeflag != "")
	{
	 	document.forms[0].selactive.value=activeflag;
	}
	else
	{
		document.forms[0].selactive.value="Y";
	}
	
	if((checktrim(document.forms[0].newmode.value)=="N") && (checktrim(document.forms[0].hidinudstryname.value)==""))
	{
		disablecommandbuttons(false,false,true,true,true,false);
		disableControls(true);
	}
	else if((checktrim(document.forms[0].newmode.value)=="N") && (checktrim(document.forms[0].hidinudstryname.value)!=""))
	{
		disablecommandbuttons(false,false,true,true,false,false);
		disableControls(true);
	}
}

function doNew()
{		
	isnew="true";
	disableControls(false);
	disablecommandbuttons(true,true,false,false,true,true);
	document.forms[0].txt_industryname.focus();
	document.forms[0].txt_industryname.value = "";
	document.forms[0].txt_bsrcode.value = "";
	document.forms[0].txt_indgrp.value = "";
	document.forms[0].txt_indgrpcode.value="";
	document.forms[0].hidinudstryname.value = "";
}

function doEdit()
{	
	if(document.forms[0].txt_industryname.value=="")
	{
		ShowAlert('111','Industry Name');
		document.forms[0].txt_industryname.focus();
		return false;
	}
	else
	{
		isnew="false";
		disableControls(false);
		disablecommandbuttons(true,true,false,false,true,true);
		document.forms[0].txt_industryname.focus();
	}
}

function doSave()
{
	if(checktrim(document.forms[0].txt_industryname.value)=="")
	{		
		ShowAlert('121','Industry Name');
		document.forms[0].txt_industryname.focus();
		return false;
	}
	if(checktrim(document.forms[0].txt_bsrcode.value)=="")
	{		
		ShowAlert('121','BSR Code');
		document.forms[0].txt_bsrcode.focus();
		return false;
	}
	
	if(checktrim(document.forms[0].txt_indgrp.value)=="")
	{		
		ShowAlert('111','Industry Group');
		document.forms[0].txt_indgrp.focus();
		return false;
	}	
	if(isnew=="true")
	{
		document.forms[0].hidAction.value="insert";
	}
	else
	{
		document.forms[0].hidAction.value="update";
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].newmode.value ="Y";		
	document.forms[0].hidBeanId.value="industrymaster";
	document.forms[0].hidBeanGetMethod.value="updateData";
	document.forms[0].hidSourceUrl.value=appURL+"action/com_indus_master.jsp";
	document.forms[0].submit();
}

function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101)){
			
		document.forms[0].hidAction.value="delete";
		document.forms[0].action=appURL+"controllerservlet";			
		document.forms[0].hidBeanId.value="industrymaster";
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].hidSourceUrl.value="/action/com_indus_master.jsp";
		document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert(158);
	}
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].newmode.value ="N";
		document.forms[0].hidAction.value = "";
		document.forms[0].action=appURL+"action/com_indus_master.jsp";
		document.forms[0].hidBeanId.value="industrymaster";
		document.forms[0].hidBeanGetMethod.value="getData";
		//document.forms[0].hidSourceUrl.value=appURL+"action/com_indus_master.jsp";
		document.forms[0].submit();
	}
}

function doClose()
{
	if(ConfirmMsg(100)){
	document.forms[0].action=appURL+"action/setupnav.jsp";
	document.forms[0].submit();
	}
}

function callDescHelp(page)
{	
	if(page=="industrymaster")
	{
		if(isnew!="true")
		{
			var varQryString = appURL+"action/comsetupindustrymasterhelp.jsp?page="+page;
			var title = "IndustryHelp";
			var prop = "scrollbars=no,width=500,height=360";	
			prop = prop + ",left=200,top=160";
			window.open(varQryString,title,prop);	
		}
	}
	else
	{
		if(document.forms[0].cmdedit.disabled)
		{
			var varQryString = appURL+"action/ops_sanctionhelp.jsp?id=47&pagename="+page+"&hidBeanId=additionalParameter&hidBeanGetMethod=getSearch";
			var title = "CBS_DATAS_HELP";
			var prop = "scrollbars=no,width=650,height=400";	
			prop = prop + ",left=200,top=200";
			window.open(varQryString,title,prop);		
		}
		else
		{
			alert("Press Edit button to activate the Industry Group Help");
		}
	}
}
</script>
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading()">
<form class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home-&gt; Setup -&gt; Corporate Products -&gt; Industry Master
		</td>
	</tr>
</table>
<br>
<table width="98%" border="0" cellspacing="0" cellpadding="4" align="center" class="outertable">
  <tr>
    <td><table width="55%" border="0" cellspacing="0" cellpadding="2" class="outertable border1 tableBg" align="center"  >
      <tr>
        <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td width="20%">Industry Group </td>
                  <td width="80%"> 
                    <input type="text" name="txt_indgrp"
							size="75" maxlength="100" value="<%=Helper.correctNull((String)hshValues.get("ind_grp"))%>">
                    <input type="hidden" name="txt_indgrpcode" value="<%=Helper.correctNull((String)hshValues.get("ind_grpcode"))%>">
                    <b><span
							onClick="callDescHelp('industrygroup')" style="cursor:hand"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span></b></td>
                </tr>
                <tr> 
                  <td width="20%">Industry Name </td>
                  <td>
                    <input type="text" name="txt_industryname"
											size="75"
											value="<%=Helper.correctDoubleQuotesHtml((String)hshValues.get("ind_name"))%>"
											maxlength="300">
                    <b><span
							onClick="callDescHelp('industrymaster')" style="cursor:hand"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span></b></td>
                </tr>
               
                <tr> 
                  <td width="20%">BSR Code </td>
                  <td width="80%"> 
                    <input type="text" name="txt_bsrcode"
											size="18" maxlength="6"
											value="<%=Helper.correctDoubleQuotesHtml((String)hshValues.get("ind_bsr_code"))%>">
                    <b></b></td>
                </tr>
                <tr> 
                 <td>Active<span class="mantatory">*</span></td>
                 <td><select name="selactive">
                  	<option value="Y" selected>Yes</option>
                  	<option value="N">No</option>
                  </select></td>
                </tr>
          
              </table>
            </td>
      </tr>
    </table></td>
  </tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/> 	
<input type="hidden" name="hidinudstryname" value="<%=Helper.correctDoubleQuotesHtml((String)hshValues.get("hidinudstryname"))%>">
<INPUT TYPE="hidden" name="hidAudit" value="<%=Helper.correctNull((String)hshValues.get("oldVal"))%>"> 
<input type="hidden" name="hidmaxterm" value="<%=request.getParameter("hidmaxterm") %>"> 
<input type="hidden" name="selsno" value=""> 
<input type="hidden" name="newmode" value="<%=request.getParameter("newmode")%>"> 
<input type=hidden name="hidPageName" value="com_indus_master.jsp">
<input type ="hidden" name ="hidkeyid" value="set">
</form>
</body>
</html>
