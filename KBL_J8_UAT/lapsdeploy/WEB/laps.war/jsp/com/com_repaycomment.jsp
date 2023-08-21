<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>

<%
String catgeryType = Helper.correctNull((String) session.getAttribute("sessionModuleType"));
String StrDigiLoanType=Helper.correctNull((String)session.getAttribute("StrDigiLoanType"));
String COM_BANKSCHEME = Helper.correctNull((String)hshValues.get("COM_BANKSCHEME"));
%>
<html>
<head>
<title>Other Facilities Comments</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript"	src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="javascript"	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript"	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2"	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2"	src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var varstagewiserls="<%=Helper.correctNull((String)hshValues.get("FIN_STAGEWISE_RELEASE"))%>";

var varfacility="<%=Helper.correctNull((String) hshValues.get("fin_facility"))%>";
var varTLDLfacility="<%=Helper.correctNull((String) hshValues.get("strPrdLoanType"))%>";
var varSessionModuleType="<%=catgeryType%>";

function onLoading()
{
	if(varSessionModuleType=="AGR" || varSessionModuleType=="CORP")
	{
		if(varfacility!="" && varfacility!="0")
		{ 
			document.forms[0].select_facility.value=varfacility;
		}
		else
		{
			document.forms[0].select_facility.value="0";
			document.forms[0].cmdedit.disabled=true;
		}	
	}
	if(varstagewiserls!=""){
		document.forms[0].sel_stagewise_release.value=varstagewiserls;
	}
    //disabledFields(true);
	EditorEnableDisable("id_div","block","id_editor","none");
	document.forms[0].sel_stagewise_release.disabled=true;
	if((varTLDLfacility=="TL"||varTLDLfacility=="DL"))
		document.all.idTLDL.style.display="table-row";
	else
		document.all.idTLDL.style.display="none";
}
function enableButtons(bool1, bool2, bool3, bool4)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
}
function doEdit()
{
	disabledFields(false);
	enableButtons(true,false,false,false);
	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('txt_industryanalysis');
	document.forms[0].sel_stagewise_release.disabled=false;
}
function doSave()
{ 
	if((varTLDLfacility=="TL"||varTLDLfacility=="DL") && document.forms[0].sel_stagewise_release.value=="")
	{
		alert("Select Whether Stagewise Release?");
		document.forms[0].sel_stagewise_release.focus();
		return;	
	}
    document.forms[0].hidAction.value="insert"
    document.forms[0].hidBeanId.value="comproposal";
    document.forms[0].pagetype2.value="repaycomment";
	document.forms[0].hidBeanMethod.value="updateDataComments";
	document.forms[0].hidBeanGetMethod.value="getDataComments"
	document.forms[0].hidSourceUrl.value="/action/com_repaycomment.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanId.value="comproposal";
	    document.forms[0].pagetype.value="repaycomment";
	    document.forms[0].hidBeanMethod.value="updateDataComments";
		document.forms[0].hidBeanGetMethod.value="getDataComments"
		document.forms[0].hidSourceUrl.value="action/com_repaycomment.jsp";	
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/controllerservlet";	
		document.forms[0].submit();
	}
}
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].pagetype.value="repaycomment";
		document.forms[0].hidBeanGetMethod.value="getDataComments";
		document.forms[0].action=appURL+"action/com_repaycomment.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}

function callfacility()
{
	document.forms[0].pagetype2.value="repaycomment";
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanGetMethod.value="getDataComments";
	document.forms[0].action = appURL+"action/com_repaycomment.jsp";
	document.forms[0].submit();
}
</script>
</head>
<body onload="onLoading()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<% String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim(); %>   
<form method=post class="normal">

<%if(strSessionModuleType.equalsIgnoreCase("AGR") || strSessionModuleType.equalsIgnoreCase("CORP")) { %>
	<jsp:include page="../com/proposallinks.jsp" flush="true"> 
	<jsp:param name="pageid" value="28" />
	<jsp:param name="cattype" value="<%=strCategoryType%>" />
	<jsp:param name="ssitype" value="<%=strSSIType%>" />
	</jsp:include>  
       
<span class="page_flow">Home -&gt;
  <%if(strSessionModuleType.equalsIgnoreCase("AGR")) {%>Agriculture -&gt;
 <%}else{ %>Corporate &amp; SME -&gt;
 <%} %>Proposal -&gt;  Repayment Schedule -&gt;  Comments<br></span>
<span style="display:none;"><lapschoice:borrowertype /></span> <lapschoice:application/>
<table width="50%" border="0" cellspacing="1" cellpadding="3" class="outertable">
 <tr>					
	<td class="sub_tab_inactive" align="center"><a href="javascript:gotoTab(appURL,'comrepayschedule','getTermFinanceFac','com_fac_repayment.jsp')"><b>Repayment Schedule for EMI</b></a></td>
	<td class="sub_tab_inactive" align="center"><a href="javascript:gotoTab(appUrl,'comrepayschedule','getFacNonEMIRepayment','com_fac_repaymentnonemi.jsp')"><b>Repayment Schedule for Non-EMI</b></a></td>
	<%if(StrDigiLoanType.equals("") && COM_BANKSCHEME.equalsIgnoreCase("052")){%>	
	<td class="sub_tab_inactive" align="center"><a href="javascript:gotoTab(appUrl,'appraisal','getCreditSalesData','com_creditsales.jsp')"><b>Reason for Manual Processing</b></a></td>
	<%} %>
	<td class="sub_tab_active" align="center"><b>Terms of Repayment</b></td>
 </tr>
</table>
<%}else{ 
	if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){
%>
         <table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	
	<% if(strSessionModuleType.equalsIgnoreCase("DIGI")) { %>
<jsp:include page="../share/applurllinkerdigi.jsp" flush="true">
<jsp:param name="pageid" value="10" /></jsp:include>
	<tr>
		<td class="page_flow">Home -&gt; Digi Retail -&gt; Appraisal -&gt; Terms Of Repayment</td>
	</tr>
<% } else { %>
	<tr>
		<td><jsp:include page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="10" />
		</jsp:include></td>
	</tr>   
	<tr>       
  <td class="page_flow">Home -&gt; Retail -&gt; Appraisal -&gt;Terms Of Repayment</td>
		</tr>
		<%} %>
  <span style="display:none;"><lapschoice:borrowertype /></span> <lapschoice:application/>
  <jsp:include page="../share/apprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="52" />
</jsp:include>
  </table>
<%}else{ %>
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		class="outertable">
		<tr>
			<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
				<jsp:param name="pageid" value="11" />
				<jsp:param name="subpageid" value="" />
				<jsp:param name="cattype" value="<%=strCategoryType%>" />
				<jsp:param name="ssitype" value="<%=strSSIType%>" />
			</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
			</td>
		</tr>
	</table>
	<%}	
} %>
<br>
<table width="95%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">

<%if(catgeryType.equalsIgnoreCase("CORP") || catgeryType.equalsIgnoreCase("AGR")) {%>
<tr>
	<td nowrap>Facility<span class="mantatory">*</span>
					<SELECT NAME="select_facility" onChange="callfacility()" TABINDEX="1" STYLE="width: 200">
					<option value="0" selected>---Select---</option>
					<lapschoice:termfinancefac pagename="ALL" />
					</SELECT>
	</TD>
</tr>
<br>
<%}
else{%>
<tr>
	<td><input type="hidden" name="select_facility" value="1"></td>
</tr>
<br>

<%} %>	
<tr id="idTLDL">
<td nowrap="nowrap">Stage Wise release of TLs/DPNs<b><span class="mantatory">*</span></b>
								<select name="sel_stagewise_release">
									<option value="">&lt;---Select---&gt;</option>
									<option value="Y">Yes</option>
									<option value="N">No</option>
								</select></td>
</tr>
<tr><td>&nbsp;</td></tr>						
 <tr class="datagrid"> 
   <td width="60%"> 
    <div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("fin_comments")) %></div></div>
	<div id="id_editor">
	<textarea name="txt_industryanalysis" cols="100"  rows="8" tabindex="2" wrap="VIRTUAL"><%=Helper.correctNull((String)hshValues.get("fin_comments"))%></textarea></div>
   </td>
 </tr>
 </table>
<br>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' btnnames='Edit_Save_Cancel_Delete_Audit Trail' /> 
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="pagetype" value="" > 
<input type="hidden" name="pagetype2" value="" > 

</form>
</body>
</html>