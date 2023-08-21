<%@include file="../share/directives.jsp"%>
<%
	ArrayList arryRow = (ArrayList) hshValues.get("arrRow");
	ArrayList arryCol = new ArrayList();
	String strSessionModuleType = Helper.correctNull(
			(String) session.getAttribute("sessionModuleType")).trim();
%>
<html>
<head>
<title>Proposal</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var appstatus="<%=Helper.correctNull((String) request
							.getParameter("appstatus"))%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var sel_dealing = "<%=Helper.correctNull((String) hshValues
							.get("MD_DEALING"))%>";
var sel_fulfill = "<%=Helper.correctNull((String) hshValues
							.get("MD_WHETHERTAKEOVER_FULFIL"))%>";

function placeValues()
{
	document.forms[0].sel_dealing.value=sel_dealing;
	document.forms[0].sel_takeoverfulfil.value=sel_fulfill;
	disableFields(true);
	displayComments(sel_fulfill);

	if(document.forms[0].hidapplicationType.value == "Restructure")
	{
		document.all.FVCtab.style.display="table-cell";
	}
	else
	{
		document.all.FVCtab.style.display="none";
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
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="executive"
		document.forms[0].hidBeanGetMethod.value="getMDSanctiontoEC";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_mdsanctiontoec.jsp";
		document.forms[0].submit();
	 }
	
}
function doDelete()
{
	
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="executive"
		document.forms[0].hidBeanMethod.value="updateMDSanctiontoEC";
		document.forms[0].hidBeanGetMethod.value="getMDSanctiontoEC";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_mdsanctiontoec.jsp";
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
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true);
	document.forms[0].hidAction.value ="update";
}
function doSave()
{
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidBeanId.value="executive"
		document.forms[0].hidBeanMethod.value="updateMDSanctiontoEC";
		document.forms[0].hidBeanGetMethod.value="getMDSanctiontoEC";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_mdsanctiontoec.jsp";
		document.forms[0].submit();


}
function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appURL+"action/"+"corppge.jsp";
		document.forms[0].submit();
	}
	
}

var strvalue="corp_otherinf.htm";
function doHelp()     
{
  var hlpvar = appURL+"phlp/corp_otherinf.htm";
  var title = "OtherInformation";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}

function showpage1(url,method)
{
	document.forms[0].hidBeanId.value="executive" ;
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
	document.forms[0].submit();
}
function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}

function displayComments(sel) {
	
		if(sel=='Y') {
			document.forms[0].txt_deviationreason.style.display="table-cell";
			document.all.lbl_devreason.style.display="table-cell";
		}
		else {
			document.forms[0].txt_deviationreason.value='';
			document.forms[0].txt_deviationreason.style.display="none";
			document.all.lbl_devreason.style.display="none";
		}
		
}
function showKFS(url,method)
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
	document.forms[0].submit();
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 150;
	overflow: auto;
}
</STYLE>
</head>

<body onload="placeValues()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url=""><script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top" colSpan=5><jsp:include
			page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="10" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />

		</jsp:include></td>
	</tr>
	<tr>
		<%
			if (strSessionModuleType.equals("AGR")) {
		%>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Agriculture
		-&gt;&nbsp;Proposal&nbsp;-&gt;&nbsp;MD Sanction to EC</td>
		<%
			} else {
		%>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Corporate&nbsp; &amp;
		SME -&gt;&nbsp;Proposal&nbsp;-&gt;&nbsp;MD Sanction to EC</td>
		<%
			}
		%>

	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span><lapschoice:application />

<table width="60%" border="0" cellspacing="1" cellpadding="3"
	class="outertable">
	<tr>
		<td class="sub_tab_inactive" align="center"><a
			href="JavaScript:showpage1('com_delegation.jsp','getDelegationData')"
			onMouseOut="window.status='';return true;"
			onMouseOver="window.status='Cash Flow';return true;"><b>Proposal
		Flow</b></a></td>
		<td class="sub_tab_active" align="center">MD Sanction to EC</td>
		<td class="sub_tab_inactive" align="center"><a
			href="JavaScript:showpage1('exec_page1.jsp','getData')"
			onMouseOut="window.status='';return true;"
			onMouseOver="window.status='Cash Flow';return true;"><b>Executive
		Summary</b></a></td>
		
		<%if(Helper.correctNull((String) request.getParameter("appstatus")).equalsIgnoreCase("Processed/Approved")){ %>
		<td class="sub_tab_inactive" align="center"><a
			href="JavaScript:showKFS('com_keyfactstatement.jsp','getKeyFactStatementData')"
			onMouseOut="window.status='Key Fact Statement';return true;"
			onMouseOver="window.status='Key Fact Statement';return true;"><b>Key
		Fact Statement</b></a></td>
		<%} %>
<td id="FVCtab" class="sub_tab_inactive" align="center"><a
			href="JavaScript:showpage1('com_fairvalue_proposal.jsp','')"
			onMouseOut="window.status='';return true;"
			onMouseOver="window.status='FVC';return true;"><b>Fair value Calculation</b></a></td>

	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5"
	align="center" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="6"
					class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							align="center" class="outertable border1">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3"
									class="outertable">
									<tr>
										<td>Estimated for</td>
										<td><input type="text" TABINDEX="1"
											name="txt_estimatefor" size="37" maxlength="50"
											value="<%=Helper.correctNull((String) hshValues
							.get("MD_ESTIMATEFOR"))%>">
										</td>
										<td>Provisional receipts/sales as on</td>
										<td><input type="text" name="txt_provisionalason"
											TABINDEX="2"
											value="<%=Helper.correctNull((String) hshValues
							.get("MD_PROVISIONALASON"))%>"
											maxlength="10" size="12" alt="Select date from calender"
											href="#" onBlur="checkDate(this);">&nbsp;<a
											style="vertical-align: middle"
											onClick="callCalender('txt_provisionalason')"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											border="0" alt="Select date from calender"></a></td>
									</tr>
									<tr>
										<td>Actuals upto</td>
										<td><input type="text" name="txt_actualsupto"
											TABINDEX="3"
											value="<%=Helper.correctNull((String) hshValues
							.get("MD_ACTUALSUPTO"))%>"
											maxlength="10" size="12" alt="Select date from calender"
											href="#" onBlur="checkDate(this);">&nbsp;<a
											style="vertical-align: middle"
											onClick="callCalender('txt_actualsupto')"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											border="0" alt="Select date from calender"></a></td>
										<td>Projections for</td>
										<td><input type="text" TABINDEX="4"
											name="txt_projectionsfor" size="37" maxlength="50"
											value="<%=Helper.correctNull((String) hshValues
							.get("MD_PROJECTIONFOR"))%>">
										</td>
									</tr>
									<tr>
										<td>Accepted for</td>
										<td><input type="text" TABINDEX="5"
											name="txt_acceptedfor" size="37" maxlength="50"
											value="<%=Helper.correctNull((String) hshValues
							.get("MD_ACCEPTEDFOR"))%>">
										</td>
										<td>Remarks</td>
										<td><textarea rows="3" cols="36" name="txt_remarks"
											wrap="VIRTUAL" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" tabindex="6"><%=Helper.correctNull((String) hshValues.get("MD_REMARKS"))%></textarea></td>
									</tr>
									<!-- 
									<tr>
										<td>Whether the account is a take over</td>
										<td><select name="sel_accounttakeover" tabindex="7"
											onchange="displayComments('a',this.value)">
											<option value="">--Select--</option>
											<option value="Y">Yes</option>
											<option value="N">No</option>
										</select></td>
										<td id="lbl_furnish">If yes furnish details</td>
										<td><textarea rows="3" cols="36" wrap="VIRTUAL"
											onKeyPress="textlimit(this,3999)" name="txt_furnishdetails"
											tabindex="8"><%=Helper.correctNull((String) hshValues
							.get("MD_FURNISHDETAILS"))%></textarea></td>
									</tr>
									-->
									<tr>
									<!-- 
										<td>Name of the bank from which limits <br>
										are taken over</td>
										<td><input type="text" TABINDEX="9" name="txt_bankname"
											size="37" maxlength="50"
											value="<%=Helper.correctNull((String) hshValues
									.get("MD_BANKNAME"))%>">
										</td>
										 -->
										 <td>Dealing</td>
										<td><select name="sel_dealing" tabindex="7">
											<option value="">--Select--</option>
											<option value="NN">New Borrower-New Unit</option>
											<option value="NT">New Borrower-Taken Over</option>
											<option value="EB">Existing Borrower</option>
										</select></td>
										<td>Reasons for shifting the account</td>
										<td><textarea rows="3" cols="36" wrap="VIRTUAL"
											onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" name="txt_shiftingreason"
											tabindex="10"><%=Helper.correctNull((String) hshValues
							.get("MD_SHIFTINGREASON"))%></textarea></td>
									</tr>
									<tr>
										<td>Whether take over norms are fulfilled</td>
										<td><select name="sel_takeoverfulfil" tabindex="11"
											onchange="displayComments(this.value)">
											<option value="">--Select--</option>
											<option value="Y">Yes</option>
											<option value="N">No</option>
										</select></td>
										<td id="lbl_devreason">If no what is the deviation</td>
										<td><textarea rows="3" cols="36" wrap="VIRTUAL"
											onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" name="txt_deviationreason"
											tabindex="12"><%=Helper.correctNull((String) hshValues
							.get("MD_DEVIATIONCOMMENTS"))%></textarea></td>
									</tr>
									<tr>
										<td>Justification for taking over the account<br>
										with deviation</td>
										<td><textarea rows="3" cols="36" name="txt_justification"
											wrap="VIRTUAL" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"
											tabindex="13"><%=Helper.correctNull((String) hshValues
							.get("MD_JUSTIFICATION"))%></textarea></td>
										<td>Any other Information</td>
										<td><textarea rows="3" cols="36"  onKeyUp="textlimit(this,3999)" name="txt_anyotherinfo"
											wrap="VIRTUAL" onKeyPress="textlimit(this,3999)"
											tabindex="14"><%=Helper.correctNull((String) hshValues
							.get("MD_ANYOTHERINFO"))%></textarea></td>
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

<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel_Audit Trail"
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<br>

<input type="hidden" name="hidsno" value=""> <lapschoice:hiddentag
	pageid='<%=PageId%>' /></form>
</body>
</html>
