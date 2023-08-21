<%@include file="../share/directives.jsp"%>
<%String strappliedfor=Helper.correctNull((String)request.getParameter("appliedfor"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String strAppno=Helper.correctNull((String)request.getParameter("appno"));

%>
<html>
<head>
<title>ROC Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";  
var varOrgLevel="<%=strOrgLevel%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";	
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";


function placeValues()
{
disableFields(true);
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
	}
}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanGetMethod.value="getcom_Rbiloanpolicyguidedata";
		document.forms[0].action=appURL+"action/com_Rbiloanpolicyguide.jsp";
		document.forms[0].submit();
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
function doDelete()
{
	
	
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanMethod.value="updatecom_Rbiloanpolicyguidedata";
		document.forms[0].hidBeanGetMethod.value="getcom_Rbiloanpolicyguidedata";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_Rbiloanpolicyguide.jsp";
 		document.forms[0].submit();
	 }
	   }

function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true)
	
}


function doSave()
{	
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanMethod.value="updatecom_Rbiloanpolicyguidedata";
		document.forms[0].hidBeanGetMethod.value="getcom_Rbiloanpolicyguidedata";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_Rbiloanpolicyguide.jsp";
		document.forms[0].submit();
}


</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 200;
	overflow: auto;
}
.dateAlign{
	position: relative;
	padding-right: 40px;
}
.rightAlign{
	position: absolute;
    right: 13px;
    top: 20px;
}
</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
	

</head>

<body onload="placeValues()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">
if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>

<form method="post" class="normal">
<%
if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
class="outertable">
<tr>
	<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
		<jsp:param name="pageid" value="4" />
		<jsp:param name="subpageid" value="130" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
		<jsp:param name="ssitype" value="<%=strSSIType%>" />
	</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
	</td>
</tr>
</table>
<%}else{
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="20" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<%if(strSessionModuleType.equals("AGR")){%>
	<tr>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Proposal -&gt; Audit Observations -&gt; Audit / Inspection Observations</td>
	</tr>
	<%}else{ %>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Audit Observations -&gt; Audit / Inspection Observations</td>
	</tr>
	<%} %>
</table>
<span style="display: none"><lapschoice:borrowertype /></span><lapschoice:application />
<%} %>
<lapstab:Rbisubpage tabid="1" applevel='<%=Helper.correctNull((String)request.getParameter("applevel"))%>' applied='<%=strappliedfor%>' appno='<%=strAppno %>'/>
<br>
<table width="95%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td >
			<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable" align="center">
			  <tr>	
				  <td>	
					
					  <table width="100%" border="0" cellspacing="1" cellpadding="1" class="outertable" align="center">
			            <tr align="center" class="dataheader" >	
					         <td width="10%" colspan="2">As on date</td>
					         
					         <td width="20%">&nbsp;</td>
					         
					         <td width="20%" >Comments</td>
					         <td width="20%" nowrap="nowrap">Compliance/ Action taken/ time frame for rectification	</td>
					          <td width="20%" nowrap="nowrap">Comments on Process note	</td>
					     </tr>
					     <tr class="datagrid">
					     
						            <td align="right" class="dateAlign"><input type="text" name="txt_asdate" size="10" maxlength="10" onBlur="checkDate(this);checkmaxdate(this,currentDate)"value="<%=Helper.correctNull((String)hshValues.get("COMRBI_ASDATEIPOAS"))%>">&nbsp;
						              <a
										alt="Select date from calender"
										href="javascript:callCalender('txt_asdate[0]')" class="rightAlign"><img
										src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
										border="0"></a>
								        <input type="hidden" name="hidtype" value="IPOAS">&nbsp;</td>
								   
								    <td  align="left">Internal(position as on) <input type="text" name="txt_conductedby" value="" style="display: none;"></td>
								   <td  align="left"><textarea NAME="txt_comments"COLS="50" ROWS="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("COMRBI_COMMENTSIPOAS"))%></textarea></td>
								    <td  align="left"><textarea NAME="txt_cCompliance"COLS="50" ROWS="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("COMRBI_COMPLIANCEIPOAS"))%></textarea></td>
								    <td  align="left"><textarea NAME="txt_processnotecmts" COLS="50" ROWS="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("COMRBI_CMDPROCESSIPOAS"))%></textarea></td>
							</tr>
							
							 <tr class="datagrid">
					    
					         <td align="right" class="dateAlign"><input type="text" name="txt_asdate" size="10" maxlength="10" onBlur="checkDate(this);checkmaxdate(this,currentDate)" value="<%=Helper.correctNull((String)hshValues.get("COMRBI_ASDATERBIPO"))%>">&nbsp;
					              <a
									alt="Select date from calender"
									href="javascript:callCalender('txt_asdate[1]')" class="rightAlign"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
									border="0"></a>
							<input type="hidden" name="hidtype" value="RBIPO"></td>
							<!-- <td>&nbsp;</td> -->
							<td>RBI Position as on <input type="text" name="txt_conductedby" value="" style="display: none;"></td>
							<td ><textarea NAME="txt_comments"COLS="50" ROWS="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String)hshValues.get("COMRBI_COMMENTSRBIPO"))%></textarea></td>
							<td ><textarea NAME="txt_cCompliance"COLS="50" ROWS="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String)hshValues.get("COMRBI_COMPLIANCERBIPO"))%></textarea></td>
							<td  align="left"><textarea NAME="txt_processnotecmts" COLS="50" ROWS="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("COMRBI_CMDPROCESSRBIPO"))%></textarea></td>
							</tr>
							
							<tr class="datagrid">
					        
					         <td align="right" class="dateAlign"><input type="text" name="txt_asdate" size="10" maxlength="10" onBlur="checkDate(this);checkmaxdate(this,currentDate)" value="<%=Helper.correctNull((String)hshValues.get("COMRBI_ASDATESTAUR"))%>">&nbsp;
					              <a
									alt="Select date from calender"
									href="javascript:callCalender('txt_asdate[2]')" class="rightAlign"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
									border="0"></a>
							<input type="hidden" name="hidtype" value="STAUR"></td>
							<!-- <td>&nbsp;</td> -->
							<td>Stock Audit Reports &nbsp;&nbsp; conducted by <input type="text" name="txt_conductedby" value="<%=Helper.correctNull((String)hshValues.get("COM_AUDITCONDUCTEDBYSTAUR")) %>" size="30" onkeypress="allowAlphabetsForName();" maxlength="50"></td>
							<td ><textarea NAME="txt_comments"COLS="50" ROWS="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String)hshValues.get("COMRBI_COMMENTSSTAUR"))%></textarea></td>
							<td ><textarea NAME="txt_cCompliance"COLS="50" ROWS="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String)hshValues.get("COMRBI_COMPLIANCESTAUR"))%></textarea></td>
							<td  align="left"><textarea NAME="txt_processnotecmts" COLS="50" ROWS="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("COMRBI_CMDPROCESSSTAUR"))%></textarea></td>
							</tr>
							
							<tr class="datagrid">
					         
					         <td align="right" class="dateAlign"><input type="text" name="txt_asdate" size="10" maxlength="10" onBlur="checkDate(this);checkmaxdate(this,currentDate)" value="<%=Helper.correctNull((String)hshValues.get("COMRBI_ASDATECRAUR"))%>">&nbsp;
					              <a
									alt="Select date from calender"
									href="javascript:callCalender('txt_asdate[3]')" class="rightAlign"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
									border="0"></a>
							<input type="hidden" name="hidtype" value="CRAUR"></td>
							<td>&nbsp;</td>
							<td>Credit Audit Report &nbsp;&nbsp; conducted by <input type="text" name="txt_conductedby" value="<%=Helper.correctNull((String)hshValues.get("COM_AUDITCONDUCTEDBYCRAUR")) %>" size="30" onkeypress="allowAlphabetsForName();" maxlength="50"></td>
							<td ><textarea NAME="txt_comments"COLS="50" ROWS="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String)hshValues.get("COMRBI_COMMENTSCRAUR"))%></textarea></td>
							<td ><textarea NAME="txt_cCompliance"COLS="50" ROWS="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String)hshValues.get("COMRBI_COMPLIANCECRAUR"))%></textarea></td>
							<td  align="left"><textarea NAME="txt_processnotecmts" COLS="50" ROWS="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("COMRBI_CMDPROCESSCRAUR"))%></textarea></td>
							</tr>
							
							<tr class="datagrid">
					         
					         <td align="right" class="dateAlign"><input type="text" name="txt_asdate" size="10" maxlength="10" onBlur="checkDate(this);checkmaxdate(this,currentDate)" value="<%=Helper.correctNull((String)hshValues.get("COMRBI_ASDATEUNINR"))%>">&nbsp;
					              <a
									alt="Select date from calender"
									href="javascript:callCalender('txt_asdate[4]')" class="rightAlign"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
									border="0"></a>
							<input type="hidden" name="hidtype" value="UNINR"></td>
							<td>&nbsp;</td>
							<td>Unit Inspection Reports <input type="text" name="txt_conductedby" value="" style="display: none;"></td>
							<td ><textarea NAME="txt_comments"COLS="50" ROWS="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String)hshValues.get("COMRBI_COMMENTSUNINR"))%></textarea></td>
							<td ><textarea NAME="txt_cCompliance"COLS="50" ROWS="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String)hshValues.get("COMRBI_COMPLIANCEUNINR"))%></textarea></td>
							<td  align="left" style="display: none;"><textarea NAME="txt_processnotecmts" COLS="50" ROWS="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea></td>
							</tr>
							
							<tr class="datagrid">
					         
					         <td align="right" class="dateAlign"><input type="text" name="txt_asdate" size="10" maxlength="10" onBlur="checkDate(this);checkmaxdate(this,currentDate)" value="<%=Helper.correctNull((String)hshValues.get("COMRBI_ASDATERMDOB"))%>">&nbsp;
					               <a
									alt="Select date from calender"
									href="javascript:callCalender('txt_asdate[5]')" class="rightAlign"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
									border="0"></a>
							<input type="hidden" name="hidtype" value="RMDOB"></td>
							<td>&nbsp;</td>
							<td>RMD's observations <input type="text" name="txt_conductedby" value="" style="display: none;"></td>
							<td ><textarea NAME="txt_comments"COLS="50" ROWS="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String)hshValues.get("COMRBI_COMMENTSRMDOB"))%></textarea></td>
							<td ><textarea NAME="txt_cCompliance"COLS="50" ROWS="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String)hshValues.get("COMRBI_COMPLIANCERMDOB"))%></textarea></td>
							<td  align="left" style="display: none;"><textarea NAME="txt_processnotecmts" COLS="50" ROWS="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea></td>
							</tr>
							
							<tr class="datagrid">
					         
					         <td align="right" class="dateAlign"><input type="text" name="txt_asdate" size="10" maxlength="10" onBlur="checkDate(this);checkmaxdate(this,currentDate)" value="<%=Helper.correctNull((String)hshValues.get("COMRBI_ASDATECONAR"))%>">&nbsp;
					               <a
									alt="Select date from calender"
									href="javascript:callCalender('txt_asdate[6]')" class="rightAlign"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
									border="0"></a>
							<input type="hidden" name="hidtype" value="CONAR"></td>
							<td>&nbsp;</td>
							<td>Concurrent Audit Report <input type="text" name="txt_conductedby" value="" style="display: none;"></td>
							<td ><textarea NAME="txt_comments"COLS="50" ROWS="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String)hshValues.get("COMRBI_COMMENTSCONAR"))%></textarea></td>
							<td ><textarea NAME="txt_cCompliance"COLS="50" ROWS="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String)hshValues.get("COMRBI_COMPLIANCECONAR"))%></textarea></td>
							<td  align="left" style="display: none;"><textarea NAME="txt_processnotecmts" COLS="50" ROWS="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea></td>
							</tr>
							
							<tr class="datagrid">
					         
					         <td align="right"><input type="hidden" name="txt_asdate" size="10" maxlength="10" onBlur="checkDate(this);checkmaxdate(this,currentDate)" >&nbsp;
					            <input type="text" name="txt_conductedby" value="" style="display: none;">  
							<input type="hidden" name="hidtype" value="LEGAL"></td>
							<td>&nbsp;</td>
							<td>Legal Audit </td>
							<td ><textarea NAME="txt_comments"COLS="50" ROWS="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String)hshValues.get("COMRBI_COMMENTSLEGAL"))%></textarea></td>
							<td ><textarea NAME="txt_cCompliance"COLS="50" ROWS="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String)hshValues.get("COMRBI_COMPLIANCELEGAL"))%></textarea></td>
							<td><textarea NAME="txt_processnotecmts" COLS="50" ROWS="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("COMRBI_CMDPROCESSLEGAL"))%></textarea></td>
							</tr>
							
						</table>
						</td>
						</tr>
						</table>
								<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel_Audit Trail"
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' /></form>
<br>
<br>
						
						</body>
						</html>
							
							
							
					         	
						
								


