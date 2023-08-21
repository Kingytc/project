<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Executive Summary</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "<%=ApplicationParams.getAppUrl()%>";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";

function callLink(page,bean,method)
{	
	if (document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}	
}

function placevalues()
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
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		  
		}
	}
}

function doEdit()
{
	disableFields(false);
	document.forms[0].hideditflag.value="Y";
	enableButtons(true,false,false,false,true)
}

function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="executive"
		document.forms[0].hidBeanGetMethod.value="getData3";
		document.forms[0].action=appUrl+"action/exec_page3.jsp";
		document.forms[0].submit();
	 }
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/corppge.jsp";
		document.forms[0].submit();
	}
}

function doSave()
{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value="update";
	document.forms[0].hidBeanId.value="executive";
	document.forms[0].hidBeanMethod.value="updateData3";
	document.forms[0].hidBeanGetMethod.value="getData3";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/exec_page3.jsp";
	document.forms[0].submit();
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="executive"
		document.forms[0].hidBeanMethod.value="updateData3";
		document.forms[0].hidBeanGetMethod.value="getData3";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/exec_page3.jsp";
		document.forms[0].submit();
	 }
}

</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
</head>

<body onload="placevalues()">
	<form name="frmevaluation" method = post class="normal">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
			<td valign="top" colSpan=5> 
              <jsp:include page="../com/proposallinks.jsp" flush="true"> 
              <jsp:param name="pageid" value="2" />
			   <jsp:param name="cattype" value="<%=strCategoryType%>" />
			  <jsp:param name="ssitype" value="<%=strSSIType%>" />
			
              </jsp:include>
            </td>
          </tr>
          <tr>
          	<td class="page_flow">Home&nbsp;-&gt;&nbsp;Corporate &amp; SME -&gt;&nbsp;Proposal&nbsp;-&gt;&nbsp;Evaluation
          	</td>
          </tr>
        </table>
	<span style="display:none"><lapschoice:borrowertype /></span><lapschoice:application/>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
                <tr> 
                <td valign="top">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                      <tr> 
                        <td valign="top"> 
                          <table width="100%" border="1" cellspacing="0" cellpadding="3" class="outertable" align="center" >
                            <tr> 
                              <td valign="top"> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
                                  <tr class="dataheader"> 
                                    <td colspan="2">EVALUATION OF MANAGEMENT</td>
                                  </tr>
                                  <tr class="datagrid"> 
                                    <td width="75%" align="left"> 
                                        <textarea name="exec_summ_company" cols="65" 
                                        rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" wrap="VIRTUAL"><%=Helper.correctNull((String)hshValues.get("EXEC_EVAL_MAGMT"))%></textarea>
                                        
                                    </td>
                                    <td width="25%" align="justify" valign="middle"> 
                                      <ul>
                                        <li> Market reputation on the promoter/management 
                                          of the company </li>
                                        <li>Hands on experience of the management 
                                          personnel in the industry/Business managed 
                                          by qualified personnel </li>
                                        <li>Ability 
                                          of the promoters/management to bail 
                                          out the company in case of crisis (for 
                                          example, this could be derived from 
                                          a strong group company) </li>
                                        <li>Decision 
                                          making-Is it concentrated?</li>
                                        <li>Organisation structure/Succession 
                                          planning/Labour relations</li>
                                        <li>Is any group comapny in default/Any 
                                          directors on RBI's negative list/Borrower's 
                                          track-record in honouring financial 
                                          commitment</li>
                                        <li>Length 
                                          of relationship with the bank</li>
                                      </ul>
                                    </td>
                                  </tr>
                                  <tr class="datagrid"> 
                                    <td colspan="2">&nbsp;</td>
                                  </tr>
                                  <tr class="dataheader"> 
                                    <td colspan="2">EVALUATION OF INDUSTRY:	</td>
                                  </tr>
                                  <tr class="datagrid"> 
                                    <td width="36%"> 
                                      <textarea name="exec_summ_indriskdemand" cols="65" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" wrap="VIRTUAL"><%=Helper.correctNull((String)hshValues.get("EXEC_EVAL_INDUSTRY"))%></textarea>
                                      </td>
                                    <td width="45%" align="justify" valign="middle"> 
                                      <ul>
                                        <li>Market 
                                          potential/demand situation</li>
                                        <li>Intensity 
                                          of competition in the industry</li>
                                        <li>Structure 
                                          of the industry in the sense is the 
                                          industry fragmented </li>
                                        <li>Cyclicality/seasonality in the industry</li>
                                        <li>Government policies</li>
                                        <li>Any 
                                          other industry issue</li>
                                      </ul>
                                    </td>
                                  </tr>
                                  <tr class="datagrid"> 
                                    <td colspan="2">&nbsp;</td>
                                  </tr>
                                  <tr class="dataheader"> 
                                    <td colspan="2">EVALUATION OF BUSINESS 
                                      RISK: </td>
                                  </tr>
                                  <tr class="datagrid"> 
                                    <td width="36%"> 
                                      <textarea name="exec_summ_indriskdiversity" cols="65" rows="8"  onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"
                                      wrap="VIRTUAL"><%=Helper.correctNull((String)hshValues.get("EXEC_EVAL_BUSSINESSRISK"))%></textarea>
                                      </td>
                                    <td width="45%" align="justify" valign="middle"> 
                                      <ul>
                                        <li>Diversity 
                                          in customer base and products</li>
                                        <li>Market 
                                          share of the company's main products 
                                          </li>
                                        <li>Avaliability 
                                          of raw material</li>
                                        <li>Selling and distribution arrangement</li>
                                        <li>Technology issue if any</li>
                                        <li>Any 
                                          other issues related to business of 
                                          the company</li>
                                      </ul>
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
      </td>
    </tr>
  </table>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' btnnames='Edit_Save_Cancel_Delete'/>
<input type="hidden" name="cattype" value="<%=strCategoryType%>">
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>  
</body>
<script language="javascript1.2">
editor_generate('exec_summ_company');
</script>
<script language="javascript1.2">
editor_generate('exec_summ_indriskdemand');
</script>
<script language="javascript1.2">
editor_generate('exec_summ_indriskdiversity');
</script>

</html>

