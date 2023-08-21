<%@include file="../share/directives.jsp"%>
<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>


<laps:handleerror />

<%
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	arrRow = (ArrayList) hshValues.get("arryRow");
	String strSector = Helper.correctNull((String) request
			.getParameter("hidsector"));
	String strSaral = Helper.correctNull((String) request
			.getParameter("hidsaral"));
	String strApploantype = Helper.correctNull((String) request
			.getParameter("apploantype"));
	String strApplevel = Helper.correctNull((String) request
			.getParameter("applevel"));
	String strProposal = Helper.correctNull(request
			.getParameter("hidproposal"));
	String strValuesin = Helper.correctNull((String) request
			.getParameter("valuesin"));

	if (strValuesin.equals("L")) {
		strValuesin = " in Lacs";
	} else if (strValuesin.equals("C")) {
		strValuesin = " in Crores";
	} else {
		strValuesin = "";
	}
	String strappholder = Helper.correctNull((String) request
			.getParameter("appholder"));
	String strappliedfor = Helper.correctNull((String) request
			.getParameter("appliedfor"));
//Added by Zahoorunnisa.S for button functionality
String strstatus = Helper.correctNull((String) request.getParameter("hidstatus"));
	
if (strstatus.equals(""))
 strstatus = Helper.correctNull((String) hshValues.get("status"));

String strapplevel = Helper.correctNull((String)request.getParameter("applevel"));

String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String appnoval = Helper.correctNull((String)request.getParameter("appno"));
//end
%>

<html>
<head>
<title>Facility For Recommendation</title>


<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varOrgLevel="<%=strOrgLevel%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
function callCalender(fname)
 {
 	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
 }
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text'  )
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=='textarea'  )
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=='select-one'  )
		{
			document.forms[0].elements[i].disabled=val;
		}
	}
}
function enableButtons(valnew,valedit,valapply,valcancel,valdel,valcom,valclose)
{
	document.forms[0].cmdnew.disabled=valnew;
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	//document.forms[0].cmdcomments.disabled=valcom;
	document.forms[0].cmdclose.disabled=valclose;
}
function selectValues(val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16,val17,val18)
{
	
	document.forms[0].txt_sanction.value=val3;
	document.forms[0].com_creditsum.value=val4;
	//document.forms[0].com_debitsum.value=val5;
	document.forms[0].txt_maxdr.value=val6;
	document.forms[0].txt_mindr.value=val7;
	document.forms[0].txt_maxcr.value=val8;
	document.forms[0].txt_mincr.value=val9;
	document.forms[0].txt_notimeexcess.value=val10;
	document.forms[0].txt_noamtcheque.value=val11;
	document.forms[0].txt_amt.value=val12;
	document.forms[0].hidsno.value=val13;
	document.forms[0].txt_creditsumtn.value=val14;
	document.forms[0].txt_debitsumtn.value=val15;
	document.forms[0].sel_date.value=val16;
	document.forms[0].com_odcccomments.value=val17;
	document.forms[0].com_creditsummationcmts.value=val18;

	if(document.forms[0].btnenable.value=="Y")
	{
	
	enableButtons(true,false,true,false,false,false);	
   }
	
	disableFields(true);
	showothers();
}



function onloading()
{	  
	disableFields(true);
	//enableButtons(false,true,true,true,true,false);
	if(appstatus=="Open/Pending")
	{
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		enableButtons(false,true,true,true,true,false);
	}
	else
	{
		enableButtons(true,true,true,true,true,false);
	}
	}
	else
	{
		enableButtons(true,true,true,true,true,false);
	}
	showothers();
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons(true,true,false,false,false,true);
	document.forms[0].sel_date.disabled = true; 
	
}

function doSave()
{

	
	if(document.forms[0].sel_date.value=="")
		{
			alert("Select the year");
			document.forms[0].sel_date.focus();	
			return;
		}
	else if(document.forms[0].txt_sanction.value=="" || document.forms[0].txt_sanction.value=="0.00"|| document.forms[0].txt_sanction.value=="0")
	{
		alert("Enter Sanction Limit");
		document.forms[0].txt_sanction.focus();
		return;
	}
	
	
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].sel_date.disabled = false;
		document.forms[0].hidBeanId.value="inwardRegister";		
		document.forms[0].hidBeanMethod.value="updateOdCcLimits";
		document.forms[0].hidBeanGetMethod.value="getOdCcLimits";
		document.forms[0].action=appURL+"controllerservlet?hidbustype=BP";
		document.forms[0].hidSourceUrl.value="/action/facilityremdforbusiess.jsp";
		document.forms[0].submit();
	
}

function doDelete()
{
	
	 if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanId.value="inwardRegister";
		document.forms[0].hidBeanMethod.value="updateOdCcLimits";
		document.forms[0].hidBeanGetMethod.value="getOdCcLimits";	
		document.forms[0].hidSourceUrl.value="action/facilityremdforbusiess.jsp";	
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();	
	 }	
   
}

function disableCommandButtons(cmdnew,cmdedit,cmdapply,cmddel,cmdcancel,cmdclose)
{  
	  document.forms[0].cmdnew.disabled =cmdnew;
	  document.forms[0].cmdedit.disabled=cmdedit;	  
	  document.forms[0].cmdsave.disabled=cmdapply;
	  document.forms[0].cmddelete.disabled=cmddel;
	  document.forms[0].cmdcancel.disabled=cmdcancel;
	  document.forms[0].cmdclose.disabled=cmdclose;
}
function doNew()
{
	
	disableFields(false);
    document.forms[0].hidAction.value ="insert";
    disableCommandButtons(true,true,false,true,false,true);
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="inwardRegister";
		document.forms[0].hidBeanGetMethod.value="getOdCcLimits";
		document.forms[0].action=appURL+"action/facilityremdforbusiess.jsp";
		document.forms[0].submit();
	}
}

 function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}

function showothers()
{
	
	if(document.forms[0].txt_noamtcheque.value>0)
	{
		document.all.R1.style.visibility="visible";
		document.all.R2.style.visibility="visible";
		document.all.R1.style.position="relative";
		document.all.R2.style.position="relative";
	}
	else
	{
		document.all.R1.style.visibility="hidden";
		document.all.R2.style.visibility="hidden";
		document.all.R1.style.position="absolute";
		document.all.R2.style.position="absolute";
	}
}
function comparedate(date1,date2)
{	
	var pgdt=changeDateformat(date1);
	var maxdt=changeDateformat(date2);
	if(pgdt.value!="")
	{
		if(Date.parse(pgdt) > Date.parse(maxdt))
		{
			alert("To Date cannot be lesser than From Date");
			document.forms[0].txt_todate.value="";
			document.forms[0].txt_todate.focus();								
		}			
	}
}
function doComments()
{
	var btnenable=document.forms[0].btnenable.value;
	
		var appno=document.forms[0].appno.value;
		var pagetype=document.forms[0].hidPage.value;
		var purl ="<%=ApplicationParams.getAppUrl()%>action/com_commentpage.jsp?hidBeanGetMethod=get_Others&hidBeanId=compro&hidpage="+pagetype+"&appno="+appno+"&btnenable="+btnenable+"&appstatus="+appstatus;		
		var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
		var xpos = (screen.width - 600) / 2;
		var ypos = (screen.height - 450) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);	 
}

function checkYear()
{
	<%
	if (arrRow != null && arrRow.size() > 0) {
		if (arrRow.size() > 0) {
			for (int i = 0; i < arrRow.size(); i++) {
				arrCol = (ArrayList) arrRow.get(i);
			String yearslno= Helper.correctNull((String) arrCol.get(13));
	%>
		var yearslno="<%=yearslno %>";	
		var selYear=document.forms[0].sel_date.value; 

		if(yearslno==selYear)
		{
			alert("Already data exist for the selected year");
			document.forms[0].cmdsave.disabled=true;
			return;
		}
		else
		{
			document.forms[0].cmdsave.disabled=false;
		}

	<%} } } %>
	
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
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
		<jsp:param name="subpageid" value="124" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
		<jsp:param name="ssitype" value="<%=strSSIType%>" />
	</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
	</td>
</tr>
</table>
<%}else{
	if (strSaral.equalsIgnoreCase("saral")) {
%> <lapschoice:saralreportTag
	tabid="8" sector='<%=strSector%>' applied='<%=strappliedfor%>'
	proposal='<%=strProposal%>' /> <lapschoice:inward /> <%
 	} else if (strApploantype.equalsIgnoreCase("c")||strApploantype.equalsIgnoreCase("a")) {
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
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Agriculture&nbsp;-&gt;&nbsp;Proposal&nbsp;-&gt;
		&nbsp;Business Turn Over&nbsp;-&gt;&nbsp;Conduct of Working Capital Facilities-&gt;&nbsp;OD / CC Limits</td>
	<%}else{ %>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Corporate&nbsp;&amp;&nbsp;SME&nbsp;-&gt;&nbsp;Proposal&nbsp;-&gt;
		&nbsp;Business Turn Over&nbsp;-&gt;&nbsp;Conduct of Working Capital Facilities-&gt;&nbsp;OD / CC Limits</td>
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
		<td valign="top"><jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<b><i>Home -&gt; Tertiary -&gt; Application -&gt; Reports -&gt;
Recommendation by Branch</i></b> <span style="display: none"><lapschoice:borrowertype /></span>
<lapschoice:application /> <lapstab:TerReportTab tabid="3"
	applevel='<%=strApplevel%>' applied='<%=strappliedfor%>' /> <%
 	} else if (strApploantype.equalsIgnoreCase("P")) {
 %>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable border1">
	<tr>
		<td id="mainlnk1"><jsp:include page="../share/Applurllinkper.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><b><i>Home -&gt; Retail -&gt; <%=(String) session.getAttribute("pgeLabel")%>
		-&gt; Appraisal -&gt; Recommendation by Branch</i></b></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td id="mainlnk1"><lapschoice:application /></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable border1">
	<tr>
		<td><jsp:include page="../share/apprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="12" />
		</jsp:include></td>
	</tr>
</table>
<%
	}


	else if ((strCategoryType.equals("ADC"))) {
%>
<table border="0" width="100%" class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../share/menus.jsp"
			flush="true"/>
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="12" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Adhoc
		Limit -&gt; Business Turn Over -&gt; Business Operation</td>
	</tr>
	<tr>
		<td><span style="display: none"> <lapschoice:borrowertype /></span>
		<lapschoice:application /></td>
	</tr>
</table>
<%
	}}
%>
<table border="0" cellspacing="1" cellpadding="3" class="outertable"
	width="90%">
	<tr>
	
	 <td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getOthersDetails','com_others.jsp')"
			onMouseOut="window.status='';return true;">Business Operation</a> </b></td>
		<td class="sub_tab_inactive" align="center" ><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','facilities','getComments','com_termloancomments.jsp?hidPage1=term')"
			onMouseOut="window.status='';return true;">Term Loan</a> </b></td>
		<td class="sub_tab_active" " align="center" ><b>
		 Conduct of Working Capital Facilities</b></td>
		<td class="sub_tab_inactive" align="center" ><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','compro','getcom_nonfundloanlcdata','facilityremdforadverse.jsp')"
			onMouseOut="window.status='';return true;">Non Funded Loans</a> </b></td>
		<td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','compro','getOtherLimits','com_OtherLimits.jsp')"
			onMouseOut="window.status='';return true;">Others</a> </b></td>
		<td class="sub_tab_inactive" align="center" ><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','compro','getFinancialComments','com_otherfaccomments.jsp?hidPage1=otherfac')"
			onMouseOut="window.status='';return true;">Overall Comments</a> </b></td>
		<td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','facilities','getComments','comments_transaction.jsp?hidPage1=commentsTrans')"
			onMouseOut="window.status='';return true;">Comments on Transaction in the existing accounts</a> </b></td>
	</tr>
</table>
<table border="0" cellspacing="1" cellpadding="3" class="outertable"
	width="60%">
	<tr>
		<td class="sub_tab_active" " align="center" ><b>
		 OD / CC Limits</b></td>
		
		<td class="sub_tab_inactive" align="center" nowrap="nowrap"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getPackingCredit','com_packingcredit.jsp?hidbustype=AF')"
			onMouseOut="window.status='';return true;">BPC &amp; PC / Shipping Loan</a> </b></td>
		<td class="sub_tab_inactive" align="center" ><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getBillsPurchasedDetails','com_billspurchased.jsp')"
			onMouseOut="window.status='';return true;">Bills Purchased</a> </b></td>			
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="80%" border="0" cellspacing="0" cellpadding="0"
							align="center" class="outertable border1">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3"
									class="outertable">
									<tr><td>Select the year<b><span class="mantatory">*&nbsp;</span></b></td><td> 
									<select name="sel_date" onchange="checkYear()">
     									<option value="">-- Select -- </option>
     									<laps:AgrFinancialYear appno="<%=appnoval%>" page="" />
     									 </select></td></tr>
     									 <tr>
										<td nowrap="nowrap">Sanctioned limit</td>
										<td nowrap="nowrap"><lapschoice:CurrencyTag name="txt_sanction" tabindex="3" onBlur="roundtxt(this)" maxlength="10" style="text-align: right"
											/></td>
										<td nowrap="nowrap">&nbsp;</td>
										<td nowrap="nowrap">&nbsp;</td>
									</tr>
						
									<tr>
										<td nowrap="nowrap">Maximum Dr. Balance</td>
										<td nowrap="nowrap"><lapschoice:CurrencyTag name="txt_maxdr" tabindex="4" maxlength="10" onBlur="roundtxt(this)" style="text-align: right"
											/></td>
										<td nowrap="nowrap">Minimum Dr. Balance</td>
										<td nowrap="nowrap"><lapschoice:CurrencyTag name="txt_mindr" tabindex="5" maxlength="10" onBlur="roundtxt(this)" style="text-align: right"
											/></td>
									</tr>
									<tr>
										<td nowrap="nowrap">Maximum Cr. Balance</td>
										<td nowrap="nowrap"><lapschoice:CurrencyTag name="txt_maxcr" tabindex="8" maxlength="10" onBlur="roundtxt(this)" style="text-align: right"
											/></td>
										<td nowrap="nowrap">Minimum Cr. Balance</td>
										<td nowrap="nowrap"><lapschoice:CurrencyTag name="txt_mincr"  tabindex="9" maxlength="10" onBlur="roundtxt(this)" style="text-align: right"
											/></td>
									</tr>
									<tr>
										<td width="14%" nowrap="nowrap">Credit Summation</td>
										<td width="36%" nowrap="nowrap"><lapschoice:CurrencyTag name="txt_creditsumtn" tabindex="6" maxlength="10" onBlur="roundtxt(this)" style="text-align: right"
											/></td>
										<td width="14%" nowrap="nowrap">Debit Summation</td>
										<td width="36%" nowrap="nowrap"><lapschoice:CurrencyTag name="txt_debitsumtn" tabindex="7" maxlength="10" onBlur="roundtxt(this)" style="text-align: right"
											/></td>
									</tr>
									<tr>
										<td nowrap="nowrap">Whether Credit summation Commensurate with the Sales turnover</td>
										<td nowrap="nowrap" colspan="3">
										<textarea name="com_creditsummationcmts"   rows="3"	cols="90"  tabindex="12" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea>
										</td>
									</tr>
									<tr>
										<td nowrap="nowrap">Number of times excess permitted</td>
										<td nowrap="nowrap"><input type="text" name="txt_notimeexcess" tabindex="10" maxlength="10" style="text-align: right"
											 onKeyPress="allowInteger(this)" ></td>
									</tr>
									
									<tr>
									<td nowrap="nowrap">No of Cheques returned for want of Funds</td>
										<td nowrap="nowrap"><input type="text" name="txt_noamtcheque" tabindex="11" maxlength="10" style="text-align: right"
											 onchange="showothers();" onKeyPress="allowInteger(this)" ></td>
										<td nowrap="nowrap" id="R1">Amount </td>
										<td id="R2"><input type="text" name="txt_amt" tabindex="10"
											size="20" maxlength="12" style="text-align: right" maxlength="10"
											onBlur="roundtxt(this)" onKeyPress="allowNumber(this)"
											tabindex="4"></td>
									</tr>
												<tr>
										<td nowrap="nowrap">Remarks</td>
										<td nowrap="nowrap" colspan="3">
										<textarea name="com_creditsum"   rows="3"	cols="90"  tabindex="12" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea>
										</td>
									</tr>
									<tr>
										<td nowrap="nowrap">Comments (On operation of OD limit along with TOD's granted if any)</td>
										<td nowrap="nowrap" colspan="3">
										<textarea name="com_odcccomments"   rows="3"	cols="90"  tabindex="12" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<br>
				<tr><td>
				<table border="0" cellspacing="0" cellpadding="0" align="center"width="0">
						
						<lapschoice:combuttonnew
							btnnames='New_Edit_Save_Cancel_Delete_Audit Trail'
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
						</table></td></tr>	
					<tr>
						<td>
						<table width="80%" border="0" cellspacing="0" cellpadding="0"
							align="center" class="outertable border1">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="3"
									class="outertable">
									<tr class="dataheader">
										<td width="5%">&nbsp;</td>
										<td align="center" width="10%"><b>Sno</b></td>
										<td align="center" width="30%"><b>Credit Summation</b></td>
										<td align="center" width="30%"><b>Debit Summation</b></td>
										<td align="center" width="30%"><b>Sanctioned Limit</b></td>
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
											style="border: none" name="rdoUser"
											onClick="javascript:selectValues('<%=Helper.correctDouble((String) arrCol.get(0))%>',
											'<%=Helper.replaceForJavaScriptString((String) arrCol.get(1))%>',
											'<%=Helper.checkDecimal((String) arrCol.get(2))%>',
											'<%=Helper.checkDecimal((String) arrCol.get(3))%>',
											'<%=Helper.checkDecimal((String) arrCol.get(4))%>',
											'<%=Helper.checkDecimal((String) arrCol.get(5))%>',
											'<%=Helper.checkDecimal((String) arrCol.get(6))%>',
											'<%=Helper.checkDecimal((String) arrCol.get(7))%>',
											'<%=Helper.checkDecimal((String) arrCol.get(8))%>',
											'<%=Helper.checkDecimal((String) arrCol.get(9))%>',
											'<%=Helper.checkDecimal((String) arrCol.get(10))%>',
											'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(11))))%>',
											'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(12))))%>',
											'<%=Helper.correctNull((String) arrCol.get(13))%>','<%=Helper.replaceForJavaScriptString((String) arrCol.get(14))%>','<%=Helper.replaceForJavaScriptString((String) arrCol.get(15))%>')">
							
											
							
										</td>
										<td width="10%" align="left"><%=i+1%></td>
										<td width="30%" align="right"> <%=Helper.checkDecimal((String)arrCol.get(11))%></td>
										<td width="30%" align="right"><%=Helper.checkDecimal((String)arrCol.get(12))%></td>
										<td width="30%" align="right"><%=Helper.checkDecimal((String)arrCol.get(0))%></td>
									
									</tr>
									<%
										}
											}
										} else {
									%>
									<tr class="datagrid">
										<td align="center" colspan="6">No Data Found</td>
									</tr>
									<%
										}
									%>
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
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="hidsno" value=""> <input type="hidden"
	name="busOperation_text" value=""> <input type="hidden"
	name="cattype" value="<%=strCategoryType%>"> <input
	type="hidden" name="ssitype" value="<%=strSSIType%>">
	 <input
type="hidden" name="hidPage" value="odcc"></form>

</body>
</html>
