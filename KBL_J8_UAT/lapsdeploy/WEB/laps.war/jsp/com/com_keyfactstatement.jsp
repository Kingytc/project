<%@include file="../share/directives.jsp"%>
	<%
	String strSessionModuleType = Helper.correctNull((String) session.getAttribute("sessionModuleType")).trim();
	String strFacSno = Helper.correctNull((String)hshValues.get("strFacSno"));
	String strUserFlag = Helper.correctNull((String)hshValues.get("UserallowFlag"));
	%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
	<STYLE>
	
	DIV.cellContainer {	

  width: 100%; height: 150;
  overflow: auto;
}
</STYLE>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>

<SCRIPT>
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varUserFlag = "<%=strUserFlag%>";
var varUserOrg="<%=Helper.correctNull((String)session.getAttribute("strOrgCode"))%>";
var varPertainsBranch="<%=Helper.correctNull((String)hshValues.get("strPertainsBranch"))%>";
var varForexFac="<%=Helper.correctNull((String)hshValues.get("strForexFac"))%>";
var varDisbBranch="<%=Helper.correctNull((String)hshValues.get("strDisbBranch"))%>";
var varSancOrgcode="<%=Helper.correctNull((String)hshValues.get("strSancOrgCode"))%>";
var varSancDept="<%=Helper.correctNull((String)hshValues.get("strSancDept"))%>";
var varPostSancFlag="<%=Helper.correctNull((String)hshValues.get("strPostFacFlag"))%>";

function showpage1(url,method)
{
	if(document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidBeanId.value="executive" ;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function doKeyFactStatement()
{
	if(document.forms[0].sel_facilitysno.value!="")
	{
		var com_appno = document.forms[0].hidAppNo.value;
		var url = "<%=ApplicationParams.getAppUrl()%>action/keyfactstatement.jsp?hidBeanId=documentresults&hidBeanGetMethod=getKeyFactStatementData&appno="+com_appno+"&hidapplicantid="+document.forms[0].hidapplicantid.value+"&hidSNo="+document.forms[0].sel_facilitysno.value;
		var title = "Sanction_Letter";
		var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
		var xpos = (screen.width - 810) / 2;
		var ypos = (screen.height - 668) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(url,title,prop);
	}else{
		alert("Please Choose Any Facility");
		document.forms[0].sel_facilitysno.focus();
		return;
	}
}
function callOnLoad()
{
	document.forms[0].sel_facilitysno.value = "<%=strFacSno%>";
	disabledFields(true);
	document.forms[0].sel_facilitysno.disabled=false;

	if(document.forms[0].hidapplicationType.value == "Restructure")
	{
		document.all.FVCtab.style.display="table-cell";
	}
	else
	{
		document.all.FVCtab.style.display="none";
	}
	if(document.forms[0].hidAppProcessAt.value=="6" && document.forms[0].hidAppOrgcode.value==varUserOrg)
	{
		disablebuttons(false,true,true,true,false);
	} 
	if(varPostSancFlag=="P" && (varSancDept!="007"))
	{
		if(varForexFac=="Y" && varUserOrg==varPertainsBranch)
		{
			disablebuttons(false,true,true,true,false);
		}
		else if(varForexFac=="Y" && varUserOrg==document.forms[0].hidAppOrgcode.value)
		{
			disablebuttons(false,true,true,true,false);
		}
		else if((varForexFac=="N"||varForexFac=="") && varUserOrg==varDisbBranch)
		{
			disablebuttons(false,true,true,true,false);
		}
		else
		{
			disablebuttons(true,true,true,true,false);
		}
	}
	else if(varPostSancFlag=="P" || varSancDept=="007")
	{
		if(varForexFac=="Y" && varUserOrg==document.forms[0].hidAppOrgcode.value)
		{
			disablebuttons(false,true,true,true,false);
		}
		else if((varForexFac=="N"||varForexFac=="") && varUserOrg==varDisbBranch)
		{
			disablebuttons(false,true,true,true,false);
		}
		else
		{
			disablebuttons(true,true,true,true,false);
		}
	}
	else
	{
		if(varSancDept=="012" &&(varUserOrg!=varSancOrgcode) && ((varUserOrg.substring(0,6)==varSancOrgcode.substring(0,6))&&(varUserOrg.substring(9,15)==varSancOrgcode.substring(9,15))))
		{
			disablebuttons(false,true,true,true,false);
		}
		else if(varSancDept!="012" && varUserOrg==varSancOrgcode)
		{
			disablebuttons(false,true,true,true,false);
		}	
		else
		{
			disablebuttons(true,true,true,true,false);
		}
	}
	
}

function disablebuttons(edit,save,del,cancel,close)
{
	document.forms[0].cmdedit.disabled=edit;
	document.forms[0].cmdsave.disabled=save;
	document.forms[0].cmddelete.disabled=del;
	document.forms[0].cmdcancel.disabled=cancel;
	document.forms[0].cmdclose.disabled=close;
}

function doEdit()
{
	if(document.forms[0].sel_facilitysno.value=="")
	{
		alert("Please Choose a facility to modify the details");
	}
	else
	{
		disabledFields(false);
		disablebuttons(true,false,false,false,true);
		document.forms[0].sel_facilitysno.disabled=true;
		document.forms[0].txt_onappln.readOnly=true;
	}
}

function doSave()
{
	document.forms[0].sel_facilitysno.disabled=false;
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="documentresults";
	document.forms[0].hidBeanMethod.value="updateKeyFactFeesdata";
	document.forms[0].hidBeanGetMethod.value="getKeyFactFeesdata";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_keyfactstatement.jsp";
	document.forms[0].submit();
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].sel_facilitysno.disabled=false;
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="documentresults";
		document.forms[0].hidBeanMethod.value="updateKeyFactFeesdata";
		document.forms[0].hidBeanGetMethod.value="getKeyFactFeesdata";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_keyfactstatement.jsp";
		document.forms[0].submit();
	}
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="documentresults";
		document.forms[0].hidBeanGetMethod.value="getKeyFactFeesdata";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_keyfactstatement.jsp";
		document.forms[0].submit();
	}
}

function doGetdata()
{
	document.forms[0].hidBeanId.value="documentresults";
	document.forms[0].hidBeanGetMethod.value="getKeyFactFeesdata";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_keyfactstatement.jsp";
	document.forms[0].submit();
}
function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appURL+"action/"+"retailpge.jsp";
		document.forms[0].submit();
	}
	
}

</SCRIPT>

</head>

<body onLoad="callOnLoad();">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">

</div></div>
<form name="frmpri" method="post" class="normal">
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){
	if(!strSessionModuleType.equals("RET")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="10" />
			<jsp:param name="subpageid" value="211" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		<input type="hidden" id="FVCtab">
		</td>
	</tr>
</table>
<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
			<jsp:param name="subpageid" value="116" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<jsp:include page="../share/postsanctionapprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="105" />
		</jsp:include>
		<input type="hidden" id="FVCtab">
<%}}else{ %>
<%if (strSessionModuleType.equals("AGR") || strSessionModuleType.equals("CORP")) { %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colSpan=5><jsp:include
			page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="10" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />

		</jsp:include></td>
	</tr>
	<tr>
	    <%if (strSessionModuleType.equals("AGR")) { %>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Agriculture -&gt;&nbsp;Proposal&nbsp;-&gt;&nbsp;Key Fact Statement</td>
		<%} else if (strSessionModuleType.equals("CORP")) {%>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Corporate&nbsp; &amp; SME -&gt;&nbsp;Proposal&nbsp;-&gt;&nbsp;Key Fact Statement</td> 
		<%}%>
	</tr>
</table>
<%} else if(strSessionModuleType.equals("DIGI")){%>
<jsp:include page="../share/applurllinkerdigi.jsp" flush="true">
<jsp:param name="pageid" value="10" /></jsp:include>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Digi Retail -&gt; Appraisal -&gt; Key Fact Statement</td>
	</tr>
</table>
<%} else { %>
<jsp:include page="../share/Applurllinkper.jsp" flush="true">
<jsp:param name="pageid" value="10" /></jsp:include>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Appraisal -&gt; Key Fact Statement</td>
	</tr>
</table>
<%} %>
<span style="display:none"><lapschoice:borrowertype /></span><lapschoice:application />

		
<%if (strSessionModuleType.equals("AGR") || strSessionModuleType.equals("CORP")) {%>		
<table width="60%" border="0" cellspacing="1" cellpadding="3"
	class="outertable">
	<tr>
		<td class="sub_tab_inactive" align="center"><a
			href="JavaScript:showpage1('com_delegation.jsp','getDelegationData')"
			onMouseOut="window.status='';return true;"
			onMouseOver="window.status='Cash Flow';return true;"><b>Proposal
		Flow</b></a></td>
		<td class="sub_tab_inactive" align="center"><a
			href="JavaScript:showpage1('com_mdsanctiontoec.jsp','getMDSanctiontoEC')"
			onMouseOut="window.status='';return true;"
			onMouseOver="window.status='MD Sanction to EC';return true;"><b>MD
		Sanction to EC</b></a></td>
		<td class="sub_tab_inactive" align="center"><a
			href="JavaScript:showpage1('exec_page1.jsp','getData')"
			onMouseOut="window.status='';return true;"
			onMouseOver="window.status='Cash Flow';return true;"><b>Executive
		Summary</b></a></td>
		<td class="sub_tab_active" align="center">Key Fact Statement</td>
		
		<td id="FVCtab" class="sub_tab_inactive" align="center">
		<a href="JavaScript:showpage1('com_fairvalue_proposal.jsp','')"
			onMouseOut="window.status='';return true;"
			onMouseOver="window.status='FVC';return true;"><b>Fair value Calculation</b></a>
		</td>

	</tr>
</table>
<%}else{ %>
<jsp:include page="../share/apprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="105" />
		</jsp:include>
		<input type="hidden" id="FVCtab">
<%} %>
<%} %>
<table width="98%"  height="200px" border="1" cellspacing="0" cellpadding="5"
	class="shadow" align="center" bordercolordark="#B6C1D2"
	bordercolorlight="#FFFFFF">
	<tr>
		<td valign="top">
		<table width="100%" border="0" align="center" cellspacing="0" cellpadding="5"  class="outertable">
			<%if (strSessionModuleType.equals("AGR") || strSessionModuleType.equals("CORP")) {%>
			<tr>
				<td colspan="4">Select Facility
				&nbsp;&nbsp;<select name="sel_facilitysno" tabindex="1" onChange="doGetdata();">
				<option value="" selected="selected">--Select--</option>
                <lapschoice:ComMisDetailsTag apptype='<%=Helper.correctNull((String) request.getParameter("appno"))%>' page='mis'/>
				</select>
				</td>
			</tr>
			<%}else{ %>
			<tr>
				<td colspan="4"><input type="hidden" name="sel_facilitysno" value="1"></td>
			</tr>
			<%} %>
			<tr><td colspan="4"><b>Fee Payable</b></td></tr>
			<tr>
			<td width="30%">On application /Sanction</td>
			<td width="20%" valign="middle"><input type="text" name="txt_onappln"  value="<%=Helper.correctNull((String)hshValues.get("KF_APP_FEE"))%>" maxlength="15" size="20" onkeypress="allowNumber(this)" style="text-align: right;" onblur="roundtxt(this);"></td>
			<td>On foreclosure</td>
			<td><input type="text" name="txt_foreclosure" value="<%=Helper.correctNull((String)hshValues.get("KF_FORECLOSURE_FEE"))%>" maxlength="15"   size="20"></td>
			
			</tr>
			
			<tr>
			<td>Fee refundable if loan not sanctioned/disbursed</td>
			<td><input type="text" name="txt_refundable" value="<%=Helper.correctNull((String)hshValues.get("KF_REFUND_FEE"))%>" maxlength="15"  size="20"></td>
			<td>Conversion charges for switching from floating to fixed interest and vice-versa</td>
			<td><input type="text" name="txt_conv_charge" value="<%=Helper.correctNull((String)hshValues.get("KF_CONVERSION_FEE"))%>" maxlength="15"   size="20"></td>
			</tr>
			
			<tr>
			<td>Penalty for delayed payments</td>
			<td colspan="3"><textarea name="txt_penalty" cols="100" rows="6" onkeyup="textlimitcorp1(this,1000);" onkeydown="textlimitcorp1(this,1000);"><%=Helper.correctNull((String)hshValues.get("KF_PENALTY_FEE"))%></textarea></td>
			</tr>
			<tr><td width="30%">During the term of the loan</td>
			<td colspan="3"><textarea name="txt_duringterm" cols="100" rows="6" onKeyPress="textlimit(this,999)" onkeyup="textlimit(this,999)"><%=Helper.correctNull((String)hshValues.get("KF_TERM_FEE"))%></textarea></td></tr>
		</table>
		</td>
	</tr>
</table>

<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel"
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
		<table border="0" class="outertable border1" cellpadding="2" cellspacing="0" width="10%" align="center">
		<tr><td><input type="button" name="cmdkeyfact" value="Key Fact Statement" class="buttonstyle" onClick="doKeyFactStatement();"></td></tr>
		</table>
<br>
<input type="hidden" name="hidsno" value="">
<INPUT TYPE="hidden" name="hidAppNo" VALUE=<%=Helper.correctNull((String) request
									.getParameter("appno"))%>>
<lapschoice:hiddentag pageid='<%=PageId%>' />
</form>
</body>
</html>
							