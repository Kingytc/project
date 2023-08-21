<%@include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<laps:handleerror />
<%
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	arrRow = (ArrayList) hshValues.get("arrRow");
	String strSector = Helper.correctNull((String) request
			.getParameter("hidsector"));
	String strSaral = Helper.correctNull((String) request
			.getParameter("hidsaral"));
	String strApploantype = Helper.correctNull((String) request
			.getParameter("apploantype"));
	String strApplevel = Helper.correctNull((String) request
			.getParameter("applevel"));

	String strValuesin = Helper.correctNull((String) request
			.getParameter("valuesin"));
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	
	if (strValuesin.equals("L")) {
		strValuesin = " in Lacs";
	} else {
		strValuesin = "";
	}
	String strappholder = Helper.correctNull((String) request
			.getParameter("appholder"));
	String strappliedfor = Helper.correctNull((String) request
			.getParameter("appliedfor"));
	String strProposal = Helper.correctNull(request
			.getParameter("hidproposal"));
	
	//Added by Zahoorunnisa.S for button functionality
    String strapplevel = Helper.correctNull((String)request.getParameter("applevel"));
	String strstatus = Helper.correctNull((String) request.getParameter("hidstatus"));
	if (strstatus.equals(""))
		strstatus = Helper.correctNull((String) hshValues.get("status"));
	String strAppno = request.getParameter("appno");
		//end
	
String strExpTodate=Helper.correctNull((String) hshValues.get("strExpTOdate"));
String strExpFrmdate=Helper.correctNull((String) hshValues.get("strExpFrmdate"));
%>

<html>
<head>
<title>Facility For Recommendation</title>


<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varOrgLevel="<%=strOrgLevel%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";
var appno="<%=request.getParameter("appno")%>";
var currentdate= "<%=Helper.getCurrentDateTime()%>";
var varToDate="<%=strExpTodate%>";
var varFromDate="<%=strExpFrmdate%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function doCancel()
{
	if (ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="inwardRegister";		
		document.forms[0].hidBeanGetMethod.value="getOthersDetails";
		document.forms[0].action=appURL+"action/com_others.jsp";
		document.forms[0].submit();
	}
}

function selectValues(v1,v2,v3,v4,v5,v6,v7,v8,v9,v10)
{
	document.forms[0].txt_int.value=v1;
	document.forms[0].txt_otherincome.value=v2;
	document.forms[0].txt_frmdate.value=v3;
	document.forms[0].txt_todate.value=v4;
	document.forms[0].hidsno.value=v5;
	document.forms[0].txt_recoverystatus.value=v6;
	document.forms[0].txt_odinterest.value=v7;
	document.forms[0].txt_forexincome.value=v8;
	document.forms[0].txt_tlintincome.value=v9;
	document.forms[0].txt_otherfacincome.value=v10;

		if(document.forms[0].btnenable.value=="Y")
	{
			enableButtons(true,false,true,false,true,true,true);
	}
	
	
}

function doSave()
{
	if(document.forms[0].txt_frmdate.value=="")
	{
		alert("select From Date");
		return;
	}
	else if(document.forms[0].txt_todate.value=="")
	{
		alert("select To Date");
		return;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="inwardRegister";
	document.forms[0].hidBeanMethod.value="updateOtherDetails";
	document.forms[0].hidBeanGetMethod.value="getOthersDetails";
	document.forms[0].hidSourceUrl.value="/action/com_others.jsp";
	document.forms[0].submit();	
}

function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="inwardRegister";
		document.forms[0].hidBeanMethod.value="updateOtherDetails";
		document.forms[0].hidBeanGetMethod.value="getOthersDetails";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_others.jsp";
		document.forms[0].submit();
	 }	
}
function dohlp()     
{
  	var hlpvar = appURL+"phlp/corp_propobriefbg.htm";
  	var title = "BorrowerDemographics";
  	var prop = "scrollbars=yes,width=600,height=450";	
  	prop = prop + ",left=50,top=150";
  	window.open(hlpvar,title,prop);
}
function doClose()
{
	var cattype=document.forms[0].cattype.value;
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
}
function doComments()
{
	var btnenable=document.forms[0].btnenable.value;
	var hidAppNo = document.forms[0].hidAppNo.value;
	var hidCommentPage = document.forms[0].hidCommentPage.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidCommentPage="+hidCommentPage+"&appstatus="+appstatus+"&btnenable="+btnenable;
	window.open(url,"Comments",prop);
}

function doNew()
{
	disablefields(false);
    document.forms[0].hidAction.value ="insert";
    document.forms[0].hideditflag.value="Y";
    enableButtons(true,true,false,false,true,true,true);  
    document.forms[0].txt_int.readOnly=true;	
}

function doEdit()
{	
	disablefields(false);
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value ="update"
	enableButtons(true,true,false,false,false,true,true);
	document.forms[0].txt_int.readOnly=true;	
}

function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6,bool7)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdcomments.disabled=bool6;
	document.forms[0].cmdclose.disabled=bool7;	
}
function placevalues()
{
	if(varFromDate=="FD")
	{
		alert("From Date is Already  Existing");
	}
	if(varToDate=="TD")
	{
		alert("To Date is Already Existing");
	}
	

	disablefields(true);
	if(document.forms[0].appstatus.value=="Open/Pending")
	{
		enableButtons(false,true,true,true,true,false,false);
	}
	else
	{
		enableButtons(true,true,true,true,true,true,false);
	}
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		
		if("<%=strstatus%>"=="O" && varright=="w"){
		    enableButtons(false,true,true,true,true,true,false);
		}else{
			enableButtons(true,true,true,true,true,true,false);	
		}
			
	}else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		
		enableButtons(true,true,true,true,true,true,false);
			
    }else{
    	
		if("<%=strapplevel%>" == "S"){
			<%if(!strCategoryType.equalsIgnoreCase("OPS"))
			{
				%>
			enableButtons(true,true,true,true,true,false,false);
		<%	}
			else
			{%>
				  enableButtons(true,true,true,true,true,false,false);
		<%	}%>
		}else{
			if(document.forms[0].btnenable.value=="Y"){
				enableButtons(false,true,true,true,true,false,false);
				
			}else {
				
				enableButtons(true,true,true,true,true,false,false);
			}
		}
	}	
	if(document.forms[0].hidNonPoolFlag.value=="Y")
	{
		enableButtons(true,true,true,true,true,true,false);
	}
}

function callCalender(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		 showCal(appURL,val);
	}
}

function disablefields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=val;
		}	  
		else if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		else if(document.forms[0].elements[i].type=='select-multiple')
		{
			document.forms[0].elements[i].disabled=val;
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}		
	}
	
}
function calculateInt()
{
	document.forms[0].txt_int.value=eval(document.forms[0].txt_odinterest.value)+eval(document.forms[0].txt_forexincome.value)+eval(document.forms[0].txt_tlintincome.value)+eval(document.forms[0].txt_otherfacincome.value);
	document.forms[0].txt_int.value=roundVal(NanNumber(document.forms[0].txt_int.value));
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placevalues()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form method="post" name="frmbrrecmd" class="normal">
<%
if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
class="outertable">
<tr>
	<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
		<jsp:param name="pageid" value="9" />
		<jsp:param name="subpageid" value="122" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
		<jsp:param name="ssitype" value="<%=strSSIType%>" />
	</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
	</td>
</tr>
</table>
<%}else{
	if (strSaral.equalsIgnoreCase("saral")) {
%> <lapschoice:saralreportTag tabid="8" sector="<%=strSector%>"
	applied="<%=strappliedfor%>" proposal="<%=strProposal%>" /> <lapschoice:inward />
<%
	} else if (strApploantype.equalsIgnoreCase("c")||strApploantype.equalsIgnoreCase("a") || strCategoryType.equalsIgnoreCase("AGR"))  {
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="15" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
	     <%if(strSessionModuleType.equals("AGR")){%>
	<td class="page_flow">Home&nbsp;-&gt;&nbsp;Agriculture-&gt;&nbsp;Proposal&nbsp;-&gt; &nbsp;Business Turn
		Over&nbsp;-&gt;&nbsp;Business Operation</td>
	<%}else{ %>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Corporate&nbsp;&amp;
		SME -&gt;&nbsp;Proposal&nbsp;-&gt; &nbsp;Business Turn
		Over&nbsp;-&gt;&nbsp;Business Operation</td>
		<%} %>			
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%
	} else if (strApploantype.equalsIgnoreCase("T")) {
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top"><jsp:include
			page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="10" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<b><i>Home -&gt; Tertiary -&gt; Application -&gt; Reports -&gt;
Recommendation by Branch</i></b> 
<span style="display: none"><lapschoice:borrowertype /></span>
<lapschoice:application /> <lapstab:TerReportTab tabid="3"
	applevel="<%=strApplevel%>" applied="<%=strappliedfor%>" /> <%
 	} else if ((strCategoryType.equals("ADC"))) {
 %>
<table border="0" width="100%" class="outertable">
	<tr>
		<td valign="top"><jsp:include
			page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="12" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Adhoc
		Limit -&gt; Business Turn Over -&gt; Others</td>
	</tr>
	<tr>
		<td><span style="display: none"><lapschoice:borrowertype /></span><lapschoice:application />
		</td>
	</tr>
</table>
<%
	}}
%>
<table border="0" cellspacing="1" cellpadding="3" class="outertable"
	width="90%">
	<tr>
	<td class="sub_tab_active" align="center"><b>Business Operation</b></td>
	     <td class="sub_tab_inactive" align="center" ><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','facilities','getComments','com_termloancomments.jsp?hidPage=term')"
			onMouseOut="window.status='';return true;">Term Loan</a> </b></td>
		<td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getOdCcLimits','facilityremdforbusiess.jsp')"
			onMouseOut="window.status='';return true;">Conduct of Working Capital Facilities</a> </b></td>
		<td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','compro','getcom_nonfundloanlcdata','facilityremdforadverse.jsp')"
			onMouseOut="window.status='';return true;">Non Funded Loans</a> </b></td>
		<td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','compro','getOtherLimits','com_OtherLimits.jsp')"
			onMouseOut="window.status='';return true;">Others</a> </b></td>
		<td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','compro','getFinancialComments','com_otherfaccomments.jsp?hidPage=otherfac')"
			onMouseOut="window.status='';return true;">Overall Comments</a> </b></td>	 
		<td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','facilities','getComments','comments_transaction.jsp?hidPage1=commentsTrans')"
			onMouseOut="window.status='';return true;">Comments on Transaction in the existing accounts</a> </b></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable">
	<tr>
		<td align="right">
		<table width="95%" border="0" cellspacing="0" cellpadding="3"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="95%" border="0" cellspacing="0" cellpadding="3"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="95%" border="0" cellspacing="0" cellpadding="0"
							align="center" class="outertable border1">
							<tr>
								<td>
								<table width="100%" border="0" class="outertable">
									
									 <tr class="dataheader"> 
										<td colspan="7" align="center"><b>Income Earned by the Bank</b></td>									
									</tr>
									<tr>
										<td>OD Interest &nbsp; </td>
										<td><lapschoice:CurrencyTag name="txt_odinterest" size="15"
											maxlength="10" onBlur="roundtxt(this);calculateInt()" value='<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(Helper.correctNull((String)hshValues.get("COM_INTEREST")))))%>'/></td>
									</tr>
									<tr>
										<td>Forex Income &nbsp; </td>
										<td><lapschoice:CurrencyTag name="txt_forexincome" size="15"
											maxlength="10" onBlur="roundtxt(this);calculateInt()" value='<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(Helper.correctNull((String)hshValues.get("COM_INTEREST")))))%>'/></td>
									</tr>
									<tr>
										<td>TL Interest Income &nbsp; </td>
										<td><lapschoice:CurrencyTag name="txt_tlintincome" size="15"
											maxlength="10" onBlur="roundtxt(this);calculateInt()" value='<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(Helper.correctNull((String)hshValues.get("COM_INTEREST")))))%>'/></td>
									</tr>
									<tr>
										<td>Other facilities income &nbsp; </td>
										<td><lapschoice:CurrencyTag name="txt_otherfacincome" size="15"
											maxlength="10" onBlur="roundtxt(this);calculateInt()" value='<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(Helper.correctNull((String)hshValues.get("COM_INTEREST")))))%>'/></td>
									</tr>
									<tr>
										<td>Interest Earned from all facilities &nbsp; </td>
										<td><lapschoice:CurrencyTag name="txt_int" size="15"
											maxlength="10" onBlur="roundtxt(this);" value='<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(Helper.correctNull((String)hshValues.get("COM_INTEREST")))))%>'/></td>
										<td>All other Income</td>
										<td><lapschoice:CurrencyTag name="txt_otherincome" size="15"
											maxlength="15" onBlur="roundtxt(this);" value='<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(Helper.correctNull((String)hshValues.get("COM_OTHERINCOME")))))%>'/></td>
									</tr>
									
									<tr>
										<td width="20%">From Date</td>
										<td width="30%"><input type="text" name="txt_frmdate" size="12" value="" 
										onBlur="checkDate(this);checkmaxdate(this,currentdate);checkmaxdate(this,document.forms[0].txt_todate.value)">
										<a style="vertical-align: middle" alt="Select date from calender" href="#"
												onClick="callCalender('txt_frmdate')"
												onMouseOver="window.status='Date Picker';return true;"
												onMouseOut="window.status='';return true;"><img
												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
												border='0' alt="Select date from calender"></a>
										</td>										
										<td width="20%">To Date</td>
										<td width="30%"><input type="text" name="txt_todate" size="12" value="" 
										onBlur="checkDate(this);checkmindate(this,document.forms[0].txt_frmdate.value)">
										<a style="vertical-align: middle" alt="Select date from calender" href="#"
												onClick="callCalender('txt_todate')"
												onMouseOver="window.status='Date Picker';return true;"
												onMouseOut="window.status='';return true;"><img
												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
												border='0' alt="Select date from calender"></a>
										</td>										
									</tr>
									
									<tr>
										<td nowrap="nowrap">Income leakage noted and recovery status</td>
										<td nowrap="nowrap" colspan="3">
										<textarea name="txt_recoverystatus"   rows="3"	cols="90" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea>
										</td>
									</tr>
<!--									<tr>
										<td nowrap="nowrap" width="20%">Ancillary business given to us</td>
										<td width="15%"><select name="sel_abg">
										<option value="">--Select--</option>
										<option value="Y">Yes</option>
										<option value="N">No</option>								
										</select></td>									
									</tr>
										<tr>
										<td nowrap="nowrap" width="20%">Whether pro-rata business given to us</td>
										<td width="20%"><select name="sel_prta">
										<option value="">--Select--</option>
										<option value="Y">Yes</option>
										<option value="N">No</option>								
										</select></td>											
									</tr>
									
										<tr>
										<td nowrap="nowrap" width="20%">Any diversion of business to other Banks not in consortium</td>
										<td width="20%"><select name="sel_adbotherbanks">
										<option value="">--Select--</option>
										<option value="Y">Yes</option>
										<option value="N">No</option>								
										</select></td>										
									</tr>-->
									
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
								
						
						
							</table>
							
								
								
						<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Comments_Audit Trail'  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>					
	
<br>

<table width="80%" border="1" cellspacing="0" cellpadding="0"
			align="center" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="1" cellpadding="3"
					class="outertable">
					<tr class="dataheader">
						<td width="5%">&nbsp;</td>
						<td align="center" width="25%"><b>Interest from all facilities</b></td>
						<td align="center" width="25%"><b>All other Income</b></td>
						<td align="center" width="22%"><b>From Date</b></td>
						<td align="center" width="23%"><b>To Date</b></td>
					</tr>
				</table>
				<table width="100%" border="0" cellspacing="1" cellpadding="3"
					class="outertable">
					<%
						if (arrRow != null && arrRow.size() > 0) {
							if (arrRow.size() > 0) {
								for (int i = 0; i < arrRow.size(); i++) {
									arrCol = (ArrayList) arrRow.get(i);
									
					%>
					     
					<tr class="datagrid">
						<td width="5%" align="center"><input type="radio"
							style="border: none" name="radiobutton" value="radiobutton"
							onClick="javascript:selectValues(
						   '<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(0))))%>',
						   '<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))%>',
						   '<%=Helper.correctNull((String) arrCol.get(2))%>',
                           '<%=Helper.correctNull((String) arrCol.get(3))%>',
                           '<%=Helper.correctNull((String) arrCol.get(4))%>',
                           '<%=Helper.replcaeNewLine(Helper.correctDoubleQuotesHtml((String) arrCol.get(5)))%>',
                            '<%=Helper.correctNull((String) arrCol.get(6))%>', '<%=Helper.correctNull((String) arrCol.get(7))%>', '<%=Helper.correctNull((String) arrCol.get(8))%>', '<%=Helper.correctNull((String) arrCol.get(9))%>')" />
                           <input type="hidden" name="hidothersno"  value="<%=Helper.correctNull((String) arrCol.get(4))%>">
                        	</td>
						<td width="25%" align="left">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(0))))%></td>
						<td width="25%" align="left">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))%></td>
						<td width="22%" align="center">&nbsp;<%=Helper.correctNull((String) arrCol.get(2))%></td>
						<td width="23%" align="center">&nbsp;<%=Helper.correctNull((String) arrCol.get(3))%></td>
					</tr>
					<%
						}
							}
						} else {
					%>
					<tr class="datagrid">
						<td align="center" colspan="5">No Data Found</td>
					</tr>
					<%
						}
					%>
				</table>
				</td>
			</tr>
		</table>
<lapschoice:hiddentag pageid="<%=PageId%>" /> <input type="hidden"
	name="hidsno"> <input type="hidden" name="cattype"
	value="<%=strCategoryType%>"> <input type="hidden"
	name="ssitype" value="<%=strSSIType%>">
	<input type="hidden"
	name="hidAppNo" value="<%=strAppno%>">
	
	<input type="hidden"
	name="hidCommentPage" value="Turnover">	
	
		
	
		
</form>
</body>
</html>
