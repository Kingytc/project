<%@ include file="../share/directives.jsp"%>
<html>
<head>
<title>Limit Master</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL      ="<%=ApplicationParams.getAppUrl()%>";
var selindex;
var isnew="false";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function onloading()
{   
	for(i=0;i<document.forms[0].selectlimit.length;i++)
	{	if(document.forms[0].hidId.value == document.forms[0].selectlimit[i].value)
		{
			document.forms[0].selectlimit.selectedIndex=i;
		}
	}	
	selindex=document.forms[0].selectlimit[document.forms[0].selectlimit.selectedIndex].value;
	if(selindex=='')
	{
	disableCommandButtons(true,true,true,true,false);
	disableFields(true);
	}
	else if(selindex=='0')
	{
  		onNew();
	}
	else
	{
	disableCommandButtons(false,true,true,true,false);
	disableFields(true);
	}
}

function getValue()
{		
	selindex=document.forms[0].selectlimit[document.forms[0].selectlimit.selectedIndex].value;
 		if(selindex=='')		
		{	
			document.forms[0].txtlimit_from.value="";
			document.forms[0].txtlimit_to.value="";
			document.forms[0].txtlimit_class.value="";
			document.forms[0].txtskip_class.value="";
			disableCommandButtons(true,true,true,false,false);
		}
		else if(selindex==0)
		{
			document.forms[0].hidId.value="";
			document.forms[0].txtlimit_from.value="";
			document.forms[0].txtlimit_to.value="";
			document.forms[0].txtlimit_class.value="";
			document.forms[0].txtskip_class.value="";
			onNew();
		}
		else
		{
		document.forms[0].hidId.value = selindex;
		document.forms[0].hidBeanId.value="modsancterms"
		document.forms[0].hidBeanGetMethod.value="getMstLimitMasterData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/setmst_limit.jsp";
		document.forms[0].submit();
		}
		
}

function onNew()
{	
	isnew="true";
	disableFields(false);
	disableCommandButtons(true,false,true,false,false);
	
}
function doEdit()
{
	disableFields(false);
	disableCommandButtons(true,false,false,false,true);
}

function doSave()
{
	
			if(isnew=="true")
			{
			document.forms[0].hidAction.value="insert";
			}
			else
			{
			document.forms[0].hidAction.value="update";
			}
			if(checktrim(document.forms[0].txtlimit_from.value)=="")
			{		
				ShowAlert('121','Limit From');
				document.forms[0].txtlimit_from.focus();
				return false;
			}

			if(checktrim(document.forms[0].txtlimit_to.value)=="")
			{		
				ShowAlert('121','Limit To');
				document.forms[0].txtlimit_to.focus();
				return false;
			}

			if(checktrim(document.forms[0].txtlimit_class.value)=="")
			{		
				ShowAlert('121','User Class');
				document.forms[0].txtlimit_class.focus();
				return false;
			}
			document.forms[0].hidId.value =
			document.forms[0].selectlimit[document.forms[0].selectlimit.selectedIndex].value;
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidBeanId.value="modsancterms";
			document.forms[0].hidBeanMethod.value="updateMstLimitMasterData";
			document.forms[0].hidBeanGetMethod.value="getMstLimitMasterData";
			document.forms[0].hidSourceUrl.value="/action/setmst_limit.jsp";
			document.forms[0].submit();	
}

function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg('101'))
		{
				document.forms[0].hidAction.value="delete";
				document.forms[0].hidId.value =
				document.forms[0].selectlimit[document.forms[0].selectlimit.selectedIndex].value;
				document.forms[0].action=appURL+"controllerservlet";		
				document.forms[0].hidBeanId.value="modsancterms";
				document.forms[0].hidBeanMethod.value="updateMstLimitMasterData";
				document.forms[0].hidBeanGetMethod.value="getMstLimitMasterData";
				document.forms[0].hidSourceUrl.value="/action/setmst_limit.jsp";
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
	if(ConfirmMsg('102'))
	{
		disableCommandButtons(false,false,true,true,false);
		selindex=document.forms[0].selectlimit[document.forms[0].selectlimit.selectedIndex].value;
		document.forms[0].hidId.value = selindex;
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="modsancterms";
		document.forms[0].hidBeanGetMethod.value="getMstLimitMasterData";
		document.forms[0].hidSourceUrl.value="/action/setmst_limit.jsp";
		document.forms[0].submit();
	}
}

function doClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].action=appURL+"action/setmst_mainnav.jsp";
		document.forms[0].submit();
	}
}

function disableCommandButtons(cmdedit,cmdsave,cmddelete,cmdcancel,cmdclose)
{  
	  document.forms[0].cmdedit.disabled=cmdedit;	  
	  document.forms[0].cmdsave.disabled=cmdsave;
	  document.forms[0].cmddelete.disabled=cmddelete;
	  document.forms[0].cmdcancel.disabled=cmdcancel;
	  document.forms[0].cmdclose.disabled=cmdclose;
}
 
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text' )
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
	}
}

 
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body  onload="onloading()">
<form class="normal">
<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class=page_flow>Home -&gt; Setup -&gt; Corporate Products -> Modification in Sanction Terms -&gt; Limit Master </td>
	</tr>
</table>
  <br>
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5" >
   <tr> 
      <td> 
        <table class="outertable border1" width="60%" border="0" cellspacing="0" cellpadding="5" align="center">
          <tr> 
            <td> 
              <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="8" align="center" >
                <tr> 
                  <td colspan="2" align ="left" valign="middle">Select 
                    Existing Limits </td>
                  <td width="64%"> 
                    <select name="selectlimit" onChange="getValue()" >
                      <lapschoice:limitlist/> 
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td colspan="2" valign="middle"> 
                    Loan limit from <b>(Rs. in Lacs)</b></td>
                  <td width="64%"> 
                    <input type="text" name="txtlimit_from" size="25" maxlength="15" onkeypress="allowNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("prd_rng_from"))%>">
                  </td>
                </tr>
                <tr> 
                  <td colspan="2" valign="middle">Loan limit
                    To <b>(Rs. in Lacs)</b></td>
                  <td width="64%"> 
                    <input type="text" name="txtlimit_to" size="25" maxlength="15" onkeypress="allowNumber(this)"  value="<%=Helper.correctNull((String)hshValues.get("prd_rng_to"))%>" >
                  </td>
                </tr>
              <tr> 
                  <td colspan="2" valign="middle">Minimum Class for Approval / Rejection  </td>
                  <td width="64%"> 
                    <input type="text" name="txtlimit_class" size="25" maxlength="3"  value="<%=Helper.correctNull((String)hshValues.get("prd_maxappclass"))%>" >
                  </td>
                </tr>
                     <tr> 
                  <td colspan="2" valign="middle">Minimum Class for Skip flowpoints</td>

                        <td> 
                          <input type="text" name="txtskip_class" size="25" maxlength="3"  value="<%=Helper.correctNull((String)hshValues.get("prd_maxskipclass"))%>" >
                        </td>
                      </tr> 
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
   <lapschoice:hiddentag pageid='<%=PageId%>'/> 
  <input type="hidden" name="prdtype" value="M">
  <input type="hidden" name="hidId" value="<%=request.getParameter("hidId") %>">
  <input type ="hidden" name ="hidkeyid" value="set">
</form>
</body>
</html>
