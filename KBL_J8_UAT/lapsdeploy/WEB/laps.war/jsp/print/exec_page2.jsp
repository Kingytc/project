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

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";

function callLink(page,bean,method)
{	
	
	document.forms[0].hidSourceUrl.value=page;
	
	 document.forms[0].hidSourceUrl.value=page;
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 <%if(strCategoryType.equalsIgnoreCase("SRE")){%>
	 document.forms[0].hidCategoryType.value="SRE";
	 <%}else{%> 
	 document.forms[0].hidCategoryType.value="CORP"; 
 	
	 	 <%}%>
 	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
	

}

function placevalues()
{
	disableFields(true);
	var a="<%=Helper.correctNull((String)hshValues.get("exec_summ_indlevelrbiY"))%>";
	
	if(a!="")
	{
		document.forms[0].exec_summ_indlevelrbiY.value=a;
	}
	else
	{
		document.forms[0].exec_summ_indlevelrbiY.value="0";
	}
	var b="<%=Helper.correctNull((String)hshValues.get("exec_summ_indlevelbankY"))%>";
	
	<%if(!strCategoryType.equalsIgnoreCase("SRE")){%>
	if(b!="")
	{
		document.forms[0].exec_summ_indlevelbankY.value=b;
	}
	else
	{
		document.forms[0].exec_summ_indlevelbankY.value="0";
	}
	<%}%>
	
	var c="<%=Helper.correctNull((String)hshValues.get("exec_summ_mortage"))%>";
	
	if(c!="")
	{
		document.forms[0].exec_summ_mortage.value=c;
	}
	else
	{
		document.forms[0].exec_summ_mortage.value="0";
	}
	var d="<%=Helper.correctNull((String)hshValues.get("exec_summ_roc"))%>";
	
	if(d!="")
	{
		document.forms[0].exec_summ_roc.value=d;
	}
	else
	{
		document.forms[0].exec_summ_roc.value="0";
	}
	var e="<%=Helper.correctNull((String)hshValues.get("exec_summ_validdoc"))%>";
	
	if(e!="")
	{
		document.forms[0].exec_summ_validdoc.value=e;
	}
	else
	{
		document.forms[0].exec_summ_validdoc.value="0";
	}
	var f="<%=Helper.correctNull((String)hshValues.get("exec_summ_terms"))%>";
	<%if(!strCategoryType.equalsIgnoreCase("SRE")){%>
	if(f!="")
	{
		document.forms[0].exec_summ_terms.value=f;
	}
	else
	{
		document.forms[0].exec_summ_terms.value="0";
	}
	<%}%>
	var g="<%=Helper.correctNull((String)hshValues.get("exec_summ_meetingheld"))%>";
	
	if(g!="")
	{
		document.forms[0].exec_summ_meetingheld.value=g;
	}
	else
	{
		document.forms[0].exec_summ_meetingheld.value="0";
	}
	
	var h="<%=Helper.correctNull((String)hshValues.get("conduct_acc"))%>";
	
	if(h!="")
	{
		document.forms[0].conduct_acc.value=h;
	}
	else
	{
		document.forms[0].conduct_acc.value="0";
	}
	
	var i="<%=Helper.correctNull((String)hshValues.get("conduct_accstock"))%>";
	
	if(i!="")
	{
		document.forms[0].conduct_accstock.value=i;
	}
	else
	{
		document.forms[0].conduct_accstock.value="0";
	}
	
	var j="<%=Helper.correctNull((String)hshValues.get("conduct_msod"))%>";
	
	if(j!="")
	{
		document.forms[0].conduct_msod.value=j;
	}
	else
	{
		document.forms[0].conduct_msod.value="0";
	}
	
	var k="<%=Helper.correctNull((String)hshValues.get("conduct_qpr"))%>";
	
	if(k!="")
	{
		document.forms[0].conduct_qpr.value=k;
	}
	else
	{
		document.forms[0].conduct_qpr.value="0";
	}
	
	var l="<%=Helper.correctNull((String)hshValues.get("conduct_fin"))%>";
	
	if(l!="")
	{
		document.forms[0].conduct_fin.value=l;
	}
	else
	{
		document.forms[0].conduct_fin.value="0";
	}
	
	var m="<%=Helper.correctNull((String)hshValues.get("conduct_cma"))%>";
	
	if(m!="")
	{
		document.forms[0].conduct_cma.value=m;
	}
	else
	{
		document.forms[0].conduct_cma.value="0";
	}
	
	var g="<%=Helper.correctNull((String)hshValues.get("exec_summ_meetingheld"))%>";
	
	if(g!="")
	{
		document.forms[0].exec_summ_meetingheld.value=g;
	}
	else
	{
		document.forms[0].exec_summ_meetingheld.value="0";
	}

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
	enableButtons(true,false,false,false,false,true)
}

function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
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
		document.forms[0].hidBeanId.value="executive";
		//document.forms[0].hidBeanMethod.value="getData2";
		document.forms[0].hidBeanGetMethod.value="getData2";
		document.forms[0].action=appURL+"action/exec_page2.jsp";
		//document.forms[0].hidSourceUrl.value="/action/exec_page2.jsp";
		document.forms[0].submit();
	 }
}

function doClose()
{	
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
}

function doSave()
{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value="update";
	document.forms[0].hidBeanId.value="executive";
	document.forms[0].hidBeanMethod.value="updateData2";
	document.forms[0].hidBeanGetMethod.value="getData2";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/exec_page2.jsp";
	document.forms[0].submit();
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="executive";
		document.forms[0].hidBeanMethod.value="updateData2";
		document.forms[0].hidBeanGetMethod.value="getData2";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/exec_page2.jsp";
		document.forms[0].submit();
	}
}

</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
</head>

<body onload="placevalues()">
<form name="exec_page2" method = post class="normal">


<%if(strCategoryType.equalsIgnoreCase("SRE")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colSpan=5>
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="8" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class=page_flow>Home -&gt; Corporate &amp; SME -&gt; Short Review/Extension  -&gt; Process Note </td>
	</tr>
</table>
<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />

		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">
			Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Executive Summary -&gt; Page 2
		</td>
	</tr>
</table>
<%} %>
  
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="0" class="outertable">
  <tr> 
    <td width="20%"><span style="display:none;"><lapschoice:borrowertype /></span>
  <lapschoice:application/></td>
  </tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" height="380"  align="center" class="outertable">
    <tr> 
      <td valign="top"> 
        <div align="left"> </div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="1" cellspacing="0" cellpadding="5" height="100%"  align="center" class="outertable">
                <tr> 
                  
                <td valign="top">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" colspan="3">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" colspan="3"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
                            <tr> 
                              <td colspan="2">REGULATORY / COMPLIANCE RISK: 
                              </td>
                            </tr>
                            <tr> 
                              <td width="31%">Compliance of RBI regulatory guidelines 
                              </td>
                              <td width="69%"> 
                                <select name="exec_summ_indlevelrbiY">
                                  <option value="0" >----Select----</option>
                                  <option value="1">Yes</option>
                                  <option value="2">No</option>
                                </select>
                              </td>
                            </tr>
                            <tr> 
                              <td width="31%">If no, give details with brief reasons 
                                &amp; justification<br>
                              </td>
                              <td width="69%"> 
                                <textarea name="exec_summ_indlevelrbiremarks" cols="80" onKeyPress="textlimit(document.forms[0].exec_summ_indlevelrbiremarks,3999)" onKeyUp="textlimit(this,3999)" rows="5"><%=Helper.correctNull((String)hshValues.get("exec_summ_indlevelrbiremarks"))%></textarea>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" colspan="3">&nbsp;</td>
                      </tr>
                      <%if(!strCategoryType.equalsIgnoreCase("SRE")){ %>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" colspan="3"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
                            <tr> 
                              <td width="31%">Compliance on Loan Policy</td>
                              <td width="69%"> 
                                <select name="exec_summ_indlevelbankY">
                                  <option value="0" >----Select----</option>
                                  <option value="1">Yes</option>
                                  <option value="2">No</option>
                                </select>
                              </td>
                            </tr>
                            <tr> 
                              <td width="31%">If no, give details with brief reasons 
                                &amp; justification<br>
                              </td>
                              <td width="69%"> 
                                <textarea name="exec_summ_indlevelbankremarks" cols="80" onKeyPress="textlimit(document.forms[0].exec_summ_indlevelbankremarks,250)" onKeyUp="textlimit(this,250)"  rows="5" value=""><%=Helper.correctNull((String)hshValues.get("exec_summ_indlevelbankremarks"))%></textarea>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <%} %>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">Completion of mortgage formalities</td>
                        <td valign="top" colspan="2"> 
                          <select name="exec_summ_mortage" value="<%=Helper.correctNull((String)hshValues.get("exec_summ_mortage"))%>">
                            <option value="0" >----Select----</option>
                            <option value="1">Yes</option>
                            <option value="2">No</option>
                          </select>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">If no, give details with 
                          brief reasons &amp; justification</td>
                        <td valign="top" colspan="2"> 
                          <textarea name="exec_summ_mortageY" cols="80" value="" onKeyPress="textlimit(document.forms[0].exec_summ_mortageY,250)" onKeyUp="textlimit(this,250)" rows="5"><%=Helper.correctNull((String)hshValues.get("exec_summ_mortageY"))%></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">Registration of charges with 
                          ROC </td>
                        <td valign="top" colspan="2"> 
                          <select name="exec_summ_roc" value="<%=Helper.correctNull((String)hshValues.get("exec_summ_roc"))%>">
                            <option value="0" >----Select----</option>
                            <option value="1">Yes</option>
                            <option value="2">No</option>
                          </select>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">If no, give details with 
                          brief reasons &amp; justification</td>
                        <td valign="top" colspan="2"> 
                          <textarea name="exec_summ_rocY" cols="80" value="" onKeyPress="textlimit(document.forms[0].exec_summ_rocY,250)" onKeyUp="textlimit(this,250)"  rows="5"><%=Helper.correctNull((String)hshValues.get("exec_summ_rocY"))%></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">Whether documents valid and 
                          in force</td>
                        <td valign="top" colspan="2"> 
                          <select name="exec_summ_validdoc" value="<%=Helper.correctNull((String)hshValues.get("exec_summ_validdoc"))%>">
                            <option value="0" >----Select----</option>
                            <option value="1">Yes</option>
                            <option value="2">No</option>
                          </select>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">If no, give details with 
                          brief reasons &amp; justification</td>
                        <td valign="top" colspan="2"> 
                          <textarea name="exec_summ_validdocY" cols="80" value="" onKeyPress="textlimit(document.forms[0].exec_summ_validdocY,250)" onKeyUp="textlimit(this,250)"  rows="5"><%=Helper.correctNull((String)hshValues.get("exec_summ_validdocY"))%></textarea>
                        </td>
                      </tr>
                      <%if(!strCategoryType.equalsIgnoreCase("SRE")) {%>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">Whether all other terms and 
                          conditions complied with</td>
                        <td valign="top" colspan="2"> 
                          <select name="exec_summ_terms" value="<%=Helper.correctNull((String)hshValues.get("exec_summ_terms"))%>">
                            <option value="0" >----Select----</option>
                            <option value="1">Yes</option>
                            <option value="2">No</option>
                          </select>
                        </td>
                      </tr>
                      
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">If no, give details with 
                          brief reasons &amp; justification</td>
                        <td valign="top" colspan="2"> 
                          <textarea name="exec_summ_termsY" cols="80" value="" onKeyPress="textlimit(document.forms[0].exec_summ_termsY,250)" onKeyUp="textlimit(this,250)" rows="5"><%=Helper.correctNull((String)hshValues.get("exec_summ_termsY"))%></textarea>
                        </td>
                      </tr>
                      <%} %>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">Whether consortium meetings 
                          held at prescribed periodic intervals where the bank 
                          is the leader</td>
                        <td valign="top" colspan="2"> 
                          <select name="exec_summ_meetingheld" value="<%=Helper.correctNull((String)hshValues.get("exec_summ_meetingheld"))%>">
                            <option value="0" >----Select----</option>
                            <option value="1">Yes</option>
                            <option value="2">No</option>
                          </select>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">If no, give details with 
                          brief reasons &amp; justification</td>
                        <td valign="top" colspan="2"> 
                          <textarea name="exec_summ_meetingheldY" cols="80" value="" onKeyPress="textlimit(document.forms[0].exec_summ_meetingheldY,250)" onKeyUp="textlimit(this,250)" rows="5"><%=Helper.correctNull((String)hshValues.get("exec_summ_meetingheldY"))%></textarea>
                        </td>
                      </tr>
                      <%if(!strCategoryType.equalsIgnoreCase("SRE")) { %>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">Dates of Inspection During 
                          the financial Year</td>
                        <td valign="top" colspan="2"> 
                          <textarea name="exec_summ_dateofinspc" cols="80" onKeyPress="textlimit(document.forms[0].exec_summ_dateofinspc,250)" onKeyUp="textlimit(this,250)" rows="5" value=""><%=Helper.correctNull((String)hshValues.get("exec_summ_dateofinspc"))%></textarea>
                        </td>
                      </tr>
                      <%} %>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">&nbsp;</td>
                        <td valign="top" colspan="2">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">CONDUCT OF THE ACCOUNT</td>
                        <td valign="top" colspan="2"> 
                          <select name="conduct_acc" value="<%=Helper.correctNull((String)hshValues.get("conduct_acc"))%>">
                            <option value="0" >----Select----</option>
                            <option value="1">Satisfactory</option>
                            <option value="2">Not Satisfactory</option>
                            <option value="3">Good</option>
                            <option value="4">Poor</option>
                            <option value="5">Not Healthy</option>
                          </select>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">If Not Satisfactory / Poor 
                          / Not Healthy, give details with brief reasons &amp; 
                          justification</td>
                        <td valign="top" colspan="2"> 
                          <textarea name="conduct_no" cols="80" onKeyPress="textlimit(document.forms[0].conduct_no,250)" onKeyUp="textlimit(this,250)"  rows="5" value=""><%=Helper.correctNull((String)hshValues.get("conduct_no"))%></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">REGULARITY IN SUBMISSION 
                          OF </td>
                        <td valign="top" colspan="2">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">Stock Statements/Book Debt 
                          Statement</td>
                        <td valign="top" colspan="2"> 
                          <select name="conduct_accstock" value="<%=Helper.correctNull((String)hshValues.get("conduct_accstock"))%>">
                            <option value="0" >----Select----</option>
                            <option value="1">Yes</option>
                            <option value="2">No</option>
                          </select>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">If no, give details with 
                          brief reasons &amp; justification</td>
                        <td valign="top" colspan="2"> 
                          <textarea name="conduct_stockno" cols="80" onKeyPress="textlimit(document.forms[0].conduct_stockno,250)" onKeyUp="textlimit(this,250)" rows="5"  value=""><%=Helper.correctNull((String)hshValues.get("conduct_stockno"))%></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">MSOD</td>
                        <td valign="top" colspan="2"> 
                          <select name="conduct_msod" value="<%=Helper.correctNull((String)hshValues.get("conduct_msod"))%>">
                            <option value="0" >----Select----</option>
                            <option value="1">Yes</option>
                            <option value="2">No</option>
                          </select>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">If no, give details with 
                          brief reasons &amp; justification</td>
                        <td valign="top" colspan="2"> 
                          <textarea name="conduct_msodno" cols="80" onKeyPress="textlimit(document.forms[0].conduct_msodno,250)" onKeyUp="textlimit(this,250)" rows="5" value=""><%=Helper.correctNull((String)hshValues.get("conduct_msodno"))%></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">QPR Statements/Half Yearly 
                          Statement </td>
                        <td valign="top" colspan="2"> 
                          <select name="conduct_qpr" value="<%=Helper.correctNull((String)hshValues.get("conduct_qpr"))%>">
                            <option value="0" >----Select----</option>
                            <option value="1">Yes</option>
                            <option value="2">No</option>
                          </select>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">If no, give details with 
                          brief reasons &amp; justification</td>
                        <td valign="top" colspan="2"> 
                          <textarea name="conduct_qprno" cols="80" onKeyPress="textlimit(document.forms[0].conduct_qprno,250)" onKeyUp="textlimit(this,250)" rows="5" value=""><%=Helper.correctNull((String)hshValues.get("conduct_qprno"))%></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">Financial Statements</td>
                        <td valign="top" colspan="2"> 
                          <select name="conduct_fin" value="<%=Helper.correctNull((String)hshValues.get("conduct_fin"))%>">
                            <option value="0" >----Select----</option>
                            <option value="1">Yes</option>
                            <option value="2">No</option>
                          </select>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">If no, give details with 
                          brief reasons &amp; justification</td>
                        <td valign="top" colspan="2"> 
                          <textarea name="conduct_finno" cols="80" onKeyPress="textlimit(document.forms[0].conduct_finno,250)" onKeyUp="textlimit(this,250)" rows="5" value=""><%=Helper.correctNull((String)hshValues.get("conduct_finno"))%></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">CMA Data</td>
                        <td valign="top" colspan="2"> 
                          <select name="conduct_cma" value="<%=Helper.correctNull((String)hshValues.get("conduct_cma"))%>">
                            <option value="0" >----Select----</option>
                            <option value="1">Yes</option>
                            <option value="2">No</option>
                          </select>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">If no, give details with 
                          brief reasons &amp; justification</td>
                        <td valign="top" colspan="2"> 
                          <textarea name="conduct_cmano" cols="80" onKeyPress="textlimit(document.forms[0].conduct_cmano,250)" onKeyUp="textlimit(this,250)" rows="5" value=""><%=Helper.correctNull((String)hshValues.get("conduct_cmano"))%></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">&nbsp;</td>
                        <td valign="top" colspan="2">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">Name of the Statement/Return</td>
                        <td valign="top" width="23%">No of Statements/Return 
                          recd.during the year</td>
                        <td valign="top" width="46%">LastStat./Return recd.</td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">Stock Statement/BD</td>
                        <td valign="top" width="23%"> 
                          <input type="text" name="conduct_stockstamt" value="<%=Helper.correctNull((String)hshValues.get("conduct_stockstamt"))%>" size="30" maxlength="20">
                        </td>
                        <td valign="top" width="46%"> 
                          <input type="text" name="conduct_stockdate" value="<%=Helper.correctNull((String)hshValues.get("conduct_stockdate"))%>"- size="30" maxlength="20">
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">MSOD</td>
                        <td valign="top" width="23%"> 
                          <input type="text" name="conduct_msodstmt" value="<%=Helper.correctNull((String)hshValues.get("conduct_msodstmt"))%>" size="30" maxlength="20">
                        </td>
                        <td valign="top" width="46%"> 
                          <input type="text" name="conduct_msoddate" value="<%=Helper.correctNull((String)hshValues.get("conduct_msoddate"))%>" size="30" maxlength="20">
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">QPR/Half Yearly Statement</td>
                        <td valign="top" width="23%"> 
                          <input type="text" name="conduct_qprstmt" value="<%=Helper.correctNull((String)hshValues.get("conduct_qprstmt"))%>" size="30" maxlength="20">
                        </td>
                        <td valign="top" width="46%"> 
                          <input type="text" name="conduct_qprdate" value="<%=Helper.correctNull((String)hshValues.get("conduct_qprdate"))%>" size="30" maxlength="20">
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">&nbsp;</td>
                        <td valign="top" colspan="2">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">Comments On Operations/OverDues:</td>
                        <td valign="top" colspan="2">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">&nbsp;</td>
                        <td valign="top" colspan="2">&nbsp;</td>
                      </tr>
                      <%if(strCategoryType.equalsIgnoreCase("SRE")) {%>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" colspan="2"> 
                          <textarea name="conduct_turn" cols="80" onKeyPress="textlimit(document.forms[0].conduct_turn,250)" onKeyUp="textlimit(this,250)" rows="5" value=""><%=Helper.correctNull((String)hshValues.get("conduct_turn"))%></textarea>
                        </td>
                      </tr>
                      <% }else{%>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">Whether turnover in the account 
                          is commensurate with the limits</td>
                        <td valign="top" colspan="2"> 
                          <textarea name="conduct_turn" cols="80" onKeyPress="textlimit(document.forms[0].conduct_turn,250)" onKeyUp="textlimit(this,250)" rows="5" value=""><%=Helper.correctNull((String)hshValues.get("conduct_turn"))%></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">Whether the frequent excess 
                          are given</td>
                        <td valign="top" colspan="2"> 
                          <textarea name="conduct_excess" cols="80" onKeyPress="textlimit(document.forms[0].conduct_excess,250)" onKeyUp="textlimit(this,250)" rows="5" value=""><%=Helper.correctNull((String)hshValues.get("conduct_excess"))%></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">Whether cheques are returned 
                          frequently</td>
                        <td valign="top" colspan="2"> 
                          <textarea name="conduct_cheques" cols="80" onKeyPress="textlimit(document.forms[0].conduct_cheques,250)"  onKeyUp="textlimit(this,250)" rows="5"  value=""><%=Helper.correctNull((String)hshValues.get("conduct_cheques"))%></textarea>
                        </td>
                      </tr>
                      <%} %>
                      <tr> 
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="0%">&nbsp;</td>
                        <td valign="top" width="31%">&nbsp;</td>
                        <td valign="top" colspan="2"> </td>
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

        <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0" height="0" class="outertable"> 
    <tr> 
      <td colspan="3"></td>
    </tr>
    <tr> 
      <td width="33%">&nbsp; 
        <div align="left"><a href="javascript:callLink('exec_page1.jsp','executive','getData')"> 
          &lt;&lt; &nbsp;Previous </a> </div>
      </td>
      <td width="33%" align="center"> 
        <jsp:include page="../com/link1.jsp" flush="true"> 
         <jsp:param name="cattype" value="<%=strCategoryType%>" />
         <jsp:param name="tabid" value="2" />
        </jsp:include>
        </td>
        <%if(strCategoryType.equalsIgnoreCase("SRE")){ %>
      <td width="33%">&nbsp; 
        <div align="right">Pg.2/9 &nbsp;<a href="javascript:callLink('exec_page5.jsp','executive','getData5')"> 
          Next &gt;&gt; </a> </div>
      </td>
      <%}else{%>
      <td width="33%">&nbsp; 
        <div align="right">Pg.2/8 &nbsp;<a href="javascript:callLink('exec_page4.jsp','executive','getData4')"> 
          Next &gt;&gt; </a> </div>
      </td>
      <%} %>
    </tr>
  </table>
    <lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>  
</body>

</html>

