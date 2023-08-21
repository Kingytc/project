<%@include file="../share/directives.jsp"%>
<%String Valuesin=Helper.correctNull((String) request.getParameter("valuesin"));%>
<html>
<head>
<title>Broad Terms of the Proposal</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function onloading()
{
	disableFields(true);
}
function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
		}
	}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="broadsancterms"
		document.forms[0].hidBeanGetMethod.value="getBSTCustProfitData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/combst_custprofit.jsp";
		document.forms[0].submit();
	 }	
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		 {
			document.forms[0].hidAction.value="Delete"
		 	document.forms[0].hidBeanId.value="broadsancterms"
			document.forms[0].hidBeanMethod.value="updateBSTCustProfitData";
			document.forms[0].hidBeanGetMethod.value="getBSTCustProfitData";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/combst_custprofit.jsp";
	 		document.forms[0].submit();
		 }
	}
	else
	{
		ShowAlert(158);
	}
}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true)
}
function doSave()
{	
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidAction.value="Insert"
	document.forms[0].hidBeanId.value="broadsancterms"
	document.forms[0].hidBeanMethod.value="updateBSTCustProfitData";
	document.forms[0].hidBeanGetMethod.value="getBSTCustProfitData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/combst_custprofit.jsp";
	document.forms[0].submit();
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/combstpge.jsp";
		document.forms[0].submit();
	}	
}
function callLink1(page,bean,method)
{	
	 document.forms[0].hidAction.value="";
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form name="frmpri" method="post" class="normal">
<lapstab:applurllinkbst pageid='7' category='bst' valuesin='<%=Valuesin%>'/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable"><tr><td class="page_flow">
Corporate &amp; SME -&gt; Broad Terms of Proposal -&gt; Customer Profitability
</td>
</tr>
</table>
<lapschoice:BST/>
<table width="80%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable border1">   
    <tr> 
    <td>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">       
    <tr> 
      <td  colspan="4" align="center">
        <table width="75%" border="0" cellspacing="3" cellpadding="5" class="outertable">
          <tr> 
            <td width="2%">1.</td>
            <td colspan="2">Commission earned on bills purchased/discounted</td>
            <td width="55%"><lapschoice:CurrencyTag name="txt_billscommission" size="13" maxlength='14'
								 	value='<%=Helper.correctNull((String)hshValues.get("bstcpbillscommission"))%>'/> </td>
          </tr>
          <tr> 
            <td width="2%">2.</td>
            <td colspan="2" >Processing Charges </td>
            <td width="55%"><lapschoice:CurrencyTag name="txt_processcharges" size="13" maxlength='14'
								 	value='<%=Helper.correctNull((String)hshValues.get("bstcpprocesscharges"))%>'/> </td>
          </tr>
          <tr> 
            <td width="2%">3.</td>
            <td colspan="2">Commission on LC/LG</td>
            <td width="55%"><lapschoice:CurrencyTag name="txt_lgcommission" size="13" maxlength='14'
								 	value='<%=Helper.correctNull((String)hshValues.get("bstcplgcommission"))%>'/> </td>
          </tr>
          <tr> 
            <td width="2%">4.</td>
            <td colspan="2">Credit balances in </td>
            <td width="55%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="2%">&nbsp;</td>
            <td width="5%">a.</td>
            <td width="38%">SB</td>
            <td width="55%"><lapschoice:CurrencyTag name="txt_sb" size="13" maxlength='14'
								 	value='<%=Helper.correctNull((String)hshValues.get("bstcpsb"))%>'/> </td>
          </tr>
          <tr> 
            <td width="2%">&nbsp;</td>
            <td width="5%">b.</td>
            <td width="38%">CD</td>
            <td width="55%"><lapschoice:CurrencyTag name="txt_cd" size="13" maxlength='14'
								 	value='<%=Helper.correctNull((String)hshValues.get("bstcpcd"))%>'/> </td>
          </tr>
          <tr> 
            <td width="2%">5.</td>
            <td colspan="2">Term deposits</td>
            <td width="55%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="2%">&nbsp;</td>
            <td width="5%">a.</td>
            <td width="38%">Through own sources</td>
             <td width="55%"><lapschoice:CurrencyTag name="txt_ownsources" size="13" maxlength='14'
								 	value='<%=Helper.correctNull((String)hshValues.get("bstcpownsources"))%>'/> </td>
          </tr>
          <tr> 
            <td width="2%" >&nbsp;</td>
            <td  width="5%">b.</td>
            <td  width="38%">Through thrid Party</td>
             <td width="55%"><lapschoice:CurrencyTag name="txt_thridparty" size="13" maxlength='14'
								 	value='<%=Helper.correctNull((String)hshValues.get("bstcpthirdparty"))%>'/> </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td  colspan="4">&nbsp;</td>
    </tr>
  </table>
  </td>
  </tr></table>
  <br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>

