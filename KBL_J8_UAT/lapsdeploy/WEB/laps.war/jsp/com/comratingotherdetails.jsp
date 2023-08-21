<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();

	if (hshValues != null) {
		arrRow = (ArrayList) hshValues.get("arrRowRating");
	}
	int arSize = 0;
	if (arrRow != null && arrRow.size() > 0) {
		arSize = arrRow.size();
	}

	String strChekFlag = Helper.correctNull((String) hshValues
			.get("strFlag"));
	String strChekSendFlag = Helper.correctNull((String) hshValues
			.get("strSendFlag"));
	String appstatus=Helper.correctNull((String)request.getParameter("appstatus"));
	String strSessionModuleType = Helper.correctNull(
			(String) session.getAttribute("sessionModuleType")).trim();
	String strfacSNO = "";
	String strFinalFlag = "", strBusiID = "";
	String strRatType = "", strMisFlag = "";
	ArrayList arRatRow = new ArrayList();
	ArrayList arRatCol = new ArrayList();
	String strDataSecFlag = "";
	String strROIValue = "";
	if (hshValues != null) {
		strfacSNO = Helper.correctNull((String) hshValues
				.get("strFacSno"));
		strFinalFlag = Helper.correctNull((String) hshValues
				.get("strFinalFlag"));
		strBusiID = Helper.correctNull((String) hshValues
				.get("strBusId"));
		strRatType = Helper.correctNull((String) hshValues
				.get("strRatType"));
		strMisFlag = Helper.correctNull((String) hshValues
				.get("strDataFlag"));
		arRatRow = (ArrayList) hshValues.get("arRatRow");
		strDataSecFlag = Helper.correctNull((String) hshValues
				.get("strDataSecFlag"));
		strROIValue = Helper.correctNull((String) hshValues
				.get("ROIUpdateFlag"));

	}
	int vecsize=0;
	if(arrRow !=null)
	{
		vecsize=arrRow.size();
	}

	String strPrdType=Helper.correctNull((String)hshValues.get("APP_LOANSUBTYPE_DIGI"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Previous Rating</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callOnLoad()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">
var varGrpRights="<%=(Helper.correctNull((String)session.getAttribute("strGroupRights"))).charAt(18)%>";
var appstatus="<%=appstatus%>";
if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
<script>

function callOnLoad()
{
	disableFields(true);
	/*if(document.forms[0].btnenable.value=="Y")
	{
		disableCommandButtons(false,false, true, true, true, false);
	}
	else
	{
		disableCommandButtons(true,true, true, true, true, false);
	}
	if(varGrpRights=='r')
	{
		disableCommandButtons(true,true, true, true, true, false);
	}*/
	
}

function disableFields(bool) {
	for ( var i = 0; i < document.forms[0].elements.length; i++) {
		if (document.forms[0].elements[i].type == "select-one") {
			document.forms[0].elements[i].disabled = bool;
		}
		if (document.forms[0].elements[i].type == "text") {
			document.forms[0].elements[i].readOnly = bool;
		}
		if (document.forms[0].elements[i].type == "checkbox") {
			document.forms[0].elements[i].disabled = bool;
		}
	}

}

function doNew()
{
	document.forms[0].hidAction.value = "insert";
	disableFields(false);
	disableCommandButtons(true,true, false, false, false, false);
	
}
function doEdit()
{
	document.forms[0].hidAction.value = "Print";
	disableFields(false);
	disableCommandButtons(true,true, false, false, false, false);
	
}

function disableCommandButtons(cmdnew,cmdedit, cmdsave, cmdcancel, cmddelete, cmdclose)
{
	//document.forms[0].cmdnew.disabled = cmdnew;
	document.forms[0].cmdedit.disabled = cmdedit;
	document.forms[0].cmdsave.disabled = cmdsave;
	document.forms[0].cmdcancel.disabled = cmdcancel;
	document.forms[0].cmddelete.disabled = cmddelete;
	document.forms[0].cmdclose.disabled = cmdclose;
	document.forms[0].cmdcomments.disabled = false;

}
function doSave()
{
	if(document.forms[0].chk_print)
	{
		if(document.forms[0].chk_print.length==undefined)
		{
			if(document.forms[0].chk_print.checked)
			{
				document.forms[0].hid_print.value="Y";
			}
			else
			{
				document.forms[0].hid_print.value="N";
			}
		}
		else
		{
			for(var i=0;i<document.forms[0].chk_print.length;i++)
			{
				if(document.forms[0].chk_print[i].checked)
				{
					document.forms[0].hid_print[i].value="Y";
				}
				else
				{
					document.forms[0].hid_print[i].value="N";
				}
			}
		}
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value = "perapplicant";
	document.forms[0].hidSourceUrl.value = "/action/comratingotherdetails.jsp";
	document.forms[0].hidBeanGetMethod.value = "getotherratingParameters";
	document.forms[0].hidBeanMethod.value = "updateotherratingParameters";
	document.forms[0].action = appURL + "controllerservlet";
	document.forms[0].submit();
}
function doCancel() {
	if (ConfirmMsg('102')) {
		document.forms[0].hidBeanId.value = "perapplicant";
		document.forms[0].hidBeanGetMethod.value = "getotherratingParameters";
		document.forms[0].action = appURL + "action/comratingotherdetails.jsp";
		document.forms[0].submit();
	}
}
function doDelete() {
	if (ConfirmMsg('101')) {
		document.forms[0].hidAction.value = "delete";
		document.forms[0].hidBeanId.value = "perapplicant";
		document.forms[0].hidSourceUrl.value = "/action/comratingotherdetails.jsp";
		document.forms[0].hidBeanGetMethod.value = "getotherratingParameters";
		document.forms[0].hidBeanMethod.value = "updateotherratingParameters";
		document.forms[0].action = appURL + "controllerservlet";
		document.forms[0].submit();
	}
}
function doClose() {
	if (ConfirmMsg('100')) {
		window.close();
	}
}

function callCalender(fname)
{
 	if(document.forms[0].cmdsave.disabled==false)
	{
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}


function corporaterating()
{

	 document.forms[0].action=appURL+"action/comrating.jsp?strFromN=T";
	 document.forms[0].hidBeanId.value="perapplicant";	
	 document.forms[0].hidBeanGetMethod.value="getRetailrating";
	 document.forms[0].submit();
}
function scorecardDetails()
{
	 document.forms[0].action=appURL+"action/msmeScoreCard.jsp";
	 document.forms[0].hidBeanId.value = "MsmeDigitalAppInterface";
	 document.forms[0].hidBeanGetMethod.value = "getScorecardDetails";
	 document.forms[0].submit();
}
function Selectval(val1,val2,val3,val4)
{
	document.forms[0].txt_yrrating.value=val1;
	document.forms[0].sel_financial.value=val2;
	document.forms[0].sel_yrdating.value=val3;
	document.forms[0].hidsno.value=val4;
	disableCommandButtons(true,false, true, false, false, false);
}
function doComments()
{
	var btnenable=document.forms[0].btnenable.value;
	var strAppno = document.forms[0].hidAppNo.value;
	var pagetype = document.forms[0].hidCommentPage.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/com_bankingcomments.jsp?hidBeanId=facilities&hidBeanGetMethod=getComments&appno="+strAppno+"&hidPage1="+pagetype+"&btnenable="+btnenable+"&appstatus="+appstatus;
	window.open(url,"Comments",prop);
}
</script>
</div></div>
<form name="misdet" method="post" class="normal">
<%
if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
class="outertable">
<tr>
	<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
		<jsp:param name="pageid" value="13" />
		<jsp:param name="subpageid" value="135" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
		<jsp:param name="ssitype" value="<%=strSSIType%>" />
	</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
	</td>
</tr>
</table>
<%}else{
	if (strCategoryType.equalsIgnoreCase("CORP")
			|| strCategoryType.equalsIgnoreCase("SME")
			|| strCategoryType.equalsIgnoreCase("AGR")) {
%>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable"> 
			<tr> 
				<td valign="top" colSpan="5"> 
					<jsp:include page="../com/proposallinks.jsp" flush="true"> 
						<jsp:param name="pageid" value="21" /> 
						<jsp:param name="cattype" value="<%=strCategoryType%>" /> 
						<jsp:param name="ssitype" value="<%=strSSIType%>" /> 
					</jsp:include> 
				</td>
			</tr> 
		</table>
		<%
			} else if (strCategoryType.equalsIgnoreCase("SRE")
					|| strCategoryType.equalsIgnoreCase("OPS")
					|| strCategoryType.equals("STL")) {
		%>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	    <tr> 
	      <td valign="top"> 
	        <jsp:include page="../share/applurllinkscom.jsp" flush="true">         
	        <jsp:param name="pageid" value="14" />
	        <jsp:param name="cattype" value="<%=strCategoryType%>" />
	        <jsp:param name="ssitype" value="<%=strSSIType%>" />
	        </jsp:include>
	      </td>
	    </tr>
  </table>
  <%
  	}
  %>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
		<tr>
		 <%
		 	if (strSessionModuleType.equals("AGR")) {
		 %>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Proposal -&gt; Other Parameters</td>
	<%
		} else {
	%>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Other Parameters </td> 
		<%
 			}
 		%>		
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%} %>
<br>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
    <tr> 
      <td >
         <table border="0" cellspacing="1" cellpadding="3" align="left" class="outertable" width="30%">
                <tr align="center">                
                   
                   <%if(strPrdType.equalsIgnoreCase("PC")) {%>  
                   <td width="15%" class="sub_tab_active">Previous Rating</td>
                   <td width="15%" class="sub_tab_inactive"><a
                 	 href="javascript:scorecardDetails();"<b>
                 	 Digi Rating</b></a></td>
                   <%} else { %>
				<td width="20%" align="center" class="sub_tab_inactive"><a
					href="javascript:corporaterating();"
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Applicant';return true;"> <b>
				Corporate Rating </b></a></td>
				 <td width="15%" class="sub_tab_active">Previous Rating</td>
				<%} %>
			</tr>
              </table>
        </td>
    </tr>
  </table>
<br>
<%-- <table align="center" border="0" cellpadding="3" cellspacing="3" class="outertable" width="98%">
<tr>
	<td>
		<table align="center" border="0" cellpadding="2" cellspacing="0" class="outertable" width="100%">
				
				<tr><td>&nbsp;</td></tr>			
			
		   		<tr class="datagrid">
				<td colspan="3">
				<table width="100%" class="outertable">
					<tr class="datagrid">
						<td align="center">
						<input type="hidden" name="hidsno">
						previous year Rating as on date</td>
						<td><input type="text" name="txt_yrrating"  value="<%=Helper.correctNull((String) hshValues
									.get("RDR_YEAR"))%>" onBlur="checkDate(this);"/><a
							alt="Select date from calender" 
							href="javascript:callCalender('txt_yrrating');">&nbsp;<img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
						<td><select name="sel_financial">
							<option value="">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited</option>
							<option value="p">Projection</option>
						</select></td>
						<td><select name="sel_yrdating">
							<option value="">--Select--</option>
							<lapschoice:Previousyeardating selrating='149' />
						</select></td>
					</tr>
				</table>
			
		</table>
	</td>
</tr>
</table>
<br>--%>

<table width="98%" border="0" cellspacing="1" cellpadding="0" class="outertable" align="center">
	<tr class="dataheader" align="center">
	<td align="center">Sl. No</td>
	<td align="center">Proposal No</td>
	<td align="center">Year</td>
	<td align="center">Type</td>
	<td align="center">Rating</td>
	</tr>
	<%
	for(int i=0;i<vecsize;i++)
	{
		arrCol = (ArrayList) arrRow.get(i);
	%>
	
	<tr class="datagrid">
	<td width="5%" align="center"><input type="checkbox" name="chk_print" style="border-style:none" <%if(Helper.correctNull((String) arrCol.get(5)).equalsIgnoreCase("Y")){%>checked<%} %>>
	<input type="hidden" name="hidsno" value="<%=Helper.correctNull((String) arrCol.get(3))%>"></td>
	<input type="hidden" name="hid_print" value="<%=Helper.correctNull((String) arrCol.get(5))%>"></td>
		<td align="center" width="10%"><%=Helper.correctNull((String) arrCol.get(6))%></td>
		<td  width="20%" align="center">&nbsp;<%=Helper.correctNull((String) arrCol.get(0))%></td>
		<td align="center" width="10%"><%=Helper.correctNull((String) arrCol.get(4))%></td>
		
		<td width="15%" align="center">&nbsp;<%=Helper.correctNull((String) arrCol.get(2))%></td>
		
	</tr>
	<%} if(vecsize<=0)
	{ %>
	<tr class="datagrid">
	<td colspan="4">&nbsp;</td>
	</tr>
	<tr class="datagrid">
	<td colspan="4" align="center">No Data Found</td>
	</tr>
	<tr class="datagrid">
	<td colspan="4">&nbsp;</td>
	</tr>
	<%} %>
</table>
<lapschoice:combuttonnew btnnames='Edit_Save_Delete_Cancel_Comments' btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidrowsize" value="<%=arSize%>">
<input type="hidden" name="hidModelCode" value="<%=Helper.correctNull((String) hshValues
									.get("strModelCode"))%>">
<input type="hidden" name="hfacsno">
<input type="hidden" name="hbusid">
<input type="hidden" name="hidBusiId" value="<%=Helper.correctNull((String) hshValues
									.get("RSK_RULE_ID"))%>">
<input type="hidden" name="hdCheckFlag" value="<%=strChekFlag%>">
<input type="hidden" name="hidFinalFlag" value="<%=strFinalFlag%>">
<input type="hidden" name="hidstrRatType" value="<%=strRatType%>">
<input type="hidden" name="hidCommentPage" value="ratingcomments">
<input type="hidden" name="hidAppNo" value="<%=Helper.correctNull((String)request.getParameter("appno"))%>">
</form>
</body>
</html>