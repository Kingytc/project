<%@include file="../share/directives.jsp"%> 
<%
String cbsaccno=Helper.correctNull((String)hshValues.get("cbsaccno"));
String strcbsid = Helper.correctNull((String)hshValues.get("strcbsid"));

%>
<html>
<head>
<title>Proposed Asset</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var limit_type="<%=Helper.correctNull((String)hshValues.get("limit_type"))%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varRecordflag = "<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
var varOrgLev = "<%=strOrgLevel.trim()%>";
function onloading()
{
   disableFields(true);
   //disableControls(false,false,true,true,true,false);
   if(varOrgLev != 'A')
   {
	   disableControls(true,true,true,true,true,false);
   }
   
   document.forms[0].txt_remarks.readOnly=true;
}  
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
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
		document.forms[0].txt_date.readOnly=true;
		document.forms[0].txt_expdate.readOnly=true;
		document.forms[0].txt_moddate.readOnly=true;		
	}	
}

function callLink(page,bean,method)
{
		if(!document.forms[0].cmdsave.disabled)
		{
			ShowAlert(103);
			return;
		}
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();	
} 

function disableControls(bcmdNew,bcmdEdit,bcmdApply,bcmdDelete,bcmdCancel,bcmdClose)
{
	document.forms[0].cmdedit.disabled=bcmdEdit;
	document.forms[0].cmdsave.disabled=bcmdApply;
	document.forms[0].cmddelete.disabled=bcmdDelete;
	document.forms[0].cmdcancel.disabled=bcmdCancel;
	document.forms[0].cmdclose.disabled=bcmdClose;
}
 

function doEdit() 
{ 
	if(document.forms[0].cmdsave.disabled)
	document.forms[0].hidAction.value="Edit";
	disableFields(true);
	document.forms[0].txt_remarks.readOnly=false;
	document.forms[0].txt_margin.readOnly=false;
	document.forms[0].txt_marginbookdebt.readOnly=false;
	disableControls(true,true,false,false,false,false);
}
 
function doSave()
{
	document.forms[0].hidRecordflag.value = varRecordflag;
   	document.forms[0].hidBeanId.value="Register";
	document.forms[0].hidBeanMethod.value="updateLimitRegisster";
	document.forms[0].hidBeanGetMethod.value="getLimitRegister";
	document.forms[0].hidSourceUrl.value="/action/limit_register.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
} 
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="Register";
		document.forms[0].hidBeanGetMethod.value="getLimitRegister";
		document.forms[0].action=appURL+"action/limit_register.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
 
function doDelete()
{
	if(varRecordflag=="Y")
	{
		if(ConfirmMsg(101))
	 	{
			disableFields(false);
			document.forms[0].txt_remarks.value="";
		   	disableControls(true,true,false,true,false,false);
		   	document.forms[0].hidAction.value="Delete";
		    document.forms[0].hidBeanId.value="Register";
			document.forms[0].hidBeanMethod.value="updateLimitRegisster";
			document.forms[0].hidBeanGetMethod.value="getLimitRegister";
			document.forms[0].hidSourceUrl.value="/action/limit_register.jsp";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert(158);
	}
}

 
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form method="post" class="normal"> 
<lapschoice:monitortag pageid="1"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="normal">
<tr> 
  <td class="page_flow">Home-&gt;Monitoring-&gt;Monitoring Register -&gt; Limit Register</td>
</tr>
</table>
<lapschoice:Monitor strSource="MREG"/> 
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable"><tr> 
    <td valign="top"> 
            <table border="0" cellspacing="0" cellpadding="3" width="100%" class="outertable">
              <tr> 
                <td> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
                    <tr> 
                      <td> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                          <tr> 
                            <td> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
                                 <tr> 
                                    <td  width="9%" nowrap="nowrap">Nature of Limit</td>
                                    <td  width="24%" nowrap="nowrap"> <b> 
                                      <input type="text" name="txt_nature" size="30" value='<%=Helper.correctNull((String)hshValues.get("limit_facility"))%>'>
                                      </b></td>
                                    <td  width="22%" nowrap="nowrap">Amount of Limit</td>
                                    <td  nowrap="nowrap" width="44%"> <lapschoice:CurrencyTag name="txt_amount" value='<%=Helper.correctNull((String)hshValues.get("limit_sanctamt"))%>' maxlength="15" tabindex="4"/> 
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td  width="9%" nowrap="nowrap">Margin (%) </td>
                                    <td  width="24%" nowrap="nowrap"><b> <lapschoice:CurrencyTag name="txt_margin" value='<%=Helper.correctNull((String)hshValues.get("limit_margin"))%>' maxlength="6" onBlur="checkPercentage(this)" size="10"tabindex="5"/> 
                                      </b></td>
                                    <td  width="22%" nowrap="nowrap">Interest / commission</td>
                                    <td  nowrap="nowrap" width="44%"> <lapschoice:CurrencyTag name="txt_rate" value='<%=Helper.correctNull((String)hshValues.get("limit_roi"))%>'  maxlength="15" tabindex="6"/> 
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td  width="9%" nowrap="nowrap">Sanctioned Date </td>
                                    <td  width="24%" nowrap="nowrap"> 
                                      <table border="0" cellspacing="0" cellpadding="1" class="outertable">
                                        <tr> 
                                          <td> 
                                            <input type="text" name="txt_date" size="12" maxlength="10" value='<%=Helper.correctNull((String)hshValues.get("limit_sanctdate"))%>'  onBlur="" tabindex="7">
                                          </td>
                                          <td align="left"></td>
                                        </tr>
                                      </table>
                                    </td>
                                    <td width="22%" nowrap="nowrap">Sanctioned By </td>
                                    <td width="44%" nowrap="nowrap"> <b> 
                                      <input type="text" name="txt_sanction" size="35" value='<%=Helper.correctNull((String)hshValues.get("limit_sancauth"))%>' onKeyPress="allowAlphabets()" tabindex="8">
                                      </b></td>
                                  </tr>                                 
                                  <tr>
                                    <td  width="9%" nowrap="nowrap">&nbsp;Sanction Level </td>
                                    <td  width="24%" nowrap="nowrap"><b>
                                      <input type="text" name="txt_sanctionlevel" size="35" value='<%=Helper.correctNull((String)hshValues.get("limit_sanctionlevel"))%>' onKeyPress="allowAlphabets()" tabindex="8">
                                      </b></td>
                                    <td  width="22%" nowrap="nowrap">&nbsp;</td>
                                    <td  nowrap="nowrap" width="44%">&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td  width="9%" nowrap="nowrap">Expiry Date </td>
                                    <td  width="24%" nowrap="nowrap"> 
                                      <table border="0" cellspacing="0" cellpadding="1" class="outertable">
                                        <tr> 
                                          <td> 
                                            <input type="text" name="txt_expdate" size="12" maxlength="10" value="<%=Helper.correctNull((String)hshValues.get("limit_expirydate"))%>" >
                                          </td>
                                          <td align="left"></td>
                                        </tr>
                                      </table>
                                    </td>
                                    <td  width="22%" nowrap="nowrap">Remarks</td>
                                    <td  nowrap="nowrap" width="44%"> 
                                      <textarea name="txt_remarks"
											onKeyPress="notAllowSingleQuote();textlimit(this,3999)" onKeyUp="textlimit(this,3999)"
											rows="3" cols="32" wrap="virtual" tabindex="10"><%=Helper.correctNull((String)hshValues.get("limit_remarks"))%></textarea>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td  width="9%" nowrap="nowrap">Sanction ref. No </td>
                                    <td  width="24%" nowrap="nowrap"><b> 
                                      <input type="text" name="txt_modified" value="<%=Helper.correctNull((String)hshValues.get("limit_sancrefno"))%>" tabindex="11">
                                      </b></td>
                                    <td  width="22%" nowrap="nowrap">Renewal 
                                      / Review Date </td>
                                    <td  nowrap="nowrap" width="44%"> 
                                      <table border="0" cellspacing="0" cellpadding="1" class="outertable">
                                        <tr> 
                                          <td> 
                                            <input type="text" name="txt_moddate" size="12" maxlength="10" value="<%=Helper.correctNull((String)hshValues.get("limit_reviewdate"))%>" tabindex="12" onBlur="">
                                          </td>
                                          <td align="left" width="32">                                             
                                          </td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="9%" nowrap="nowrap">Margin for Book debt [%]</td>
                                    <td width="24%" nowrap="nowrap">&nbsp;<b><lapschoice:CurrencyTag name="txt_marginbookdebt" value='<%=Helper.correctNull((String)hshValues.get("mon_marginbookdebt"))%>' onBlur="checkPercentage(this)" maxlength="6" size="10"tabindex="5"/> 
                                      </b></td>
                                    <td width="22%" nowrap="nowrap">&nbsp;</td>
                                    <td nowrap="nowrap" width="44%">&nbsp;</td>
                                  </tr>
                                </table>
                            </td>
                          </tr>
                          </table>
                              <br>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                  </td>
                  </tr>
            </table>
          </td>
        </tr>
      </table>

      <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
      <lapschoice:hiddentag pageid='<%=PageId%>'/>
      <input type="hidden" name="hid_sno" value="<%=Helper.correctNull((String)hshValues.get("hid_sno"))%>">
      <input type="hidden" name="hidCustomerId" value="<%=Helper.correctNull((String)hshValues.get("hidCustomerId"))%>">
      <input type="hidden" name="mon_accno" value="<%=cbsaccno%>">
    
</form>
</body>
</html>
