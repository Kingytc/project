<%@include file="../share/directives.jsp"%>
<%	String strGrouplimit=Helper.correctNull((String)hshValues.get("npa_delegatepower"));
	String strwriteoff=Helper.correctNull((String)hshValues.get("npa_sacrificewriteoff"));
	String strVal=Helper.correctNull((String)hshValues.get("hidval"));%>
<html>
<head>
<title>Limit Master</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/set/navigate.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var grouplimit="<%=strGrouplimit%>";
var wirteoff="<%=strwriteoff%>";
var strval="<%=strVal%>";
var mode="";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}

function enableButtons(bool2,bool3,bool4,bool5)
{
	
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function doEdit()
{
	mode="edit";
	if(document.forms[0].grouplimitslist.value!="0")
	{
		enableButtons(true,false,false,false);
	}
	else
	{
		alert("Select  the Lending Power");
		document.forms[0].grouplimitslist.focus();
		return false;
	}
		document.forms[0].sel_writeoff.disabled=false;
		document.forms[0].txt_saclimit.disabled=false;
		document.forms[0].txt_writeoff.disabled=false;
		document.forms[0].txt_sarfaesi.disabled=false;
		document.forms[0].txt_suit.disabled=false;
		document.forms[0].txt_status.disabled=false;	
		document.forms[0].hidAction.value="update";
		document.forms[0].grouplimitslist.disabled=true;
}

function doSave()
{	
	if(document.forms[0].grouplimitslist.value!="0")
	{		
		var len = document.forms[0].grouplimitslist.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].grouplimitslist.options[i].selected==true)
			 {
				 document.forms[0].grouplimitslist1.value = document.forms[0].grouplimitslist.options[i].text; 
				break;
			 }
		}
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidRecordflag.value=varRecordFlag;	
		document.forms[0].hidval.value="1";
		document.forms[0].hidBeanId.value="setproducts";
		document.forms[0].hidBeanMethod.value="updateNPADelegatePower";
		document.forms[0].hidBeanGetMethod.value="getNPADelegatePower";
		document.forms[0].hidSourceUrl.value="/action/npadelegatepower.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
	else
	{
		alert("Select the Lending Power");
		return false;
	}
}
   
function onLoading()
{
	if(grouplimit!="")
	{
		document.forms[0].grouplimitslist.value=grouplimit;
		document.forms[0].sel_writeoff.disabled=true;
		document.forms[0].txt_saclimit.disabled=true;
		document.forms[0].txt_writeoff.disabled=true;
		document.forms[0].txt_sarfaesi.disabled=true;
		document.forms[0].txt_suit.disabled=true;
		document.forms[0].txt_status.disabled=true;
		enableButtons(false,true,true,false);
	}
	else
	{
		document.forms[0].grouplimitslist.value="0";
		enableButtons(false,true,true,false);
	}
	if(wirteoff!="")
	{
		document.forms[0].sel_writeoff.value=wirteoff;
	}
	else
	{	
		document.forms[0].sel_writeoff.value="S";
	}	
	if(strval=="1")
	{
		enableButtons(false,true,true,false);
	}
}

function getPower()
{
		document.forms[0].hidBeanId.value="setproducts";
		document.forms[0].hidBeanGetMethod.value="getNPADelegatePower";
		document.forms[0].hidSourceUrl.value="/action/npadelegatepower.jsp";
		document.forms[0].submit();
}
function doCancel()
{
if(ConfirmMsg(102))
	{
		document.forms[0].grouplimitslist.value="0";
		document.forms[0].hidgrouplimit.value="0";
		document.forms[0].hidval.value="1";
		document.forms[0].hidBeanId.value="setproducts";
		document.forms[0].hidBeanGetMethod.value="getNPADelegatePower";
		document.forms[0].hidSourceUrl.value="/action/npadelegatepower.jsp";
		document.forms[0].submit();
		}
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body  onLoad="onLoading()" >
<form class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; Setup -&gt; NPA -&gt; Delegated Powers
       </td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="4" align="center" class="outertable">
                <tr> 
                  <td> 
                    <table width="75%" border="0" cellspacing="0" cellpadding="3"align="center" class="outertable border1">
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                            <tr>
                              <td width="47%">Lending power</td>
                              <td width="53%"><select name="grouplimitslist" 
													class="stylereadonly" onChange="getPower()">
													<option value="0">---Select---</option>													
													<lapschoice:grouplimits />
												</select>
                            </tr>
                            <tr> 
                              <td width="47%">Sacrifice Limit</td>
                              <td width="53%"> 
                                <input type="text" name="txt_saclimit"  style="text-align:right" size="30" 
                                onKeyPress="allowNumber(document.forms[0].txt_saclimit)" 
                                value="<%= Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("npa_sacrificelimit"))))%>" maxlength="15">
                            </tr>
                            <tr> 
                              <td width="47%">Sacrifice limit can involves Write Off</td>
                              <td width="53%"> 
                                <select name="sel_writeoff">
                                  <option value="S" selected>&lt;-- Select --&gt;</option>
                                  <option value="Y">Yes</option>
                                  <option value="N">No</option>
                                </select>
                              </td>
                            </tr>
                            <tr> 
                              <td width="47%">Prudential/Absolute Write Off</td>
                              <td width="53%"> 
                                <input type="text" name="txt_writeoff" size="30"  style="text-align:right" onKeyPress="allowNumber(document.forms[0].txt_writeoff)" 
                                value="<%= Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("npa_writeofflimit"))))%>" maxlength="15">
                              </td>
                            </tr>
                            <tr> 
                              <td width="47%">Sarfaesi Act</td>
                              <td width="53%"> 
                                <input type="text" name="txt_sarfaesi" size="30"  style="text-align:right" onKeyPress="allowNumber(document.forms[0].txt_sarfaesi)" value="<%= Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("npa_sarfaesilimit"))))%>" maxlength="15">
                              </td>
                            </tr>
                            <tr> 
                              <td width="47%">Filing of Suit</td>
                              <td width="53%"> 
                                <input type="text" name="txt_suit" size="30"   style="text-align:right" onKeyPress="allowNumber(document.forms[0].txt_suit)" value="<%= Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("npa_suitlimit"))))%>" maxlength="15">
                              </td>
                            </tr>
                             <tr> 
                              <td width="47%">Status Note</td>
                              <td width="53%"> 
                                <input type="text" name="txt_status" size="30"   style="text-align:right" onKeyPress="allowNumber(document.forms[0].txt_status)" value="<%= Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("npa_statusnote"))))%>" maxlength="15">
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
      </td>
    </tr>
  </table>
  <br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="grouplimitslist1">
<input type="hidden" name="hidval" >
<input type="hidden" name="hidgrouplimit" value="<%=Helper.correctNull((String)hshValues.get("npa_delegatepower"))%>">
<input type ="hidden" name ="hidkeyid" value="set">
</form>
</body>
</html>
