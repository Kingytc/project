<%@include file="../share/directives.jsp"%>
<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
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
	String strProposal = Helper.correctNull(request
			.getParameter("hidproposal"));
	String strValuesin = Helper.correctNull((String) request
			.getParameter("valuesin"));

	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
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
String strappno=Helper.correctNull((String)request.getParameter("appno"));
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
var currentdate= "<%=Helper.getCurrentDateTime()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function callCalender(fname)
 {
 	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
 }
 
 
function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11)
{
	document.forms[0].sel_type.value=val2;
	onloading();
	document.forms[0].txt_sancamt.value=val3;
	
	if(document.forms[0].sel_type.value=="1")
	{
		document.forms[0].txt_nos.value=val4;
		document.forms[0].txt_amt.value=val5;
		document.forms[0].txt_nosret.value=val6;
		document.forms[0].txt_amtret.value=val7;
	}
	else if(document.forms[0].sel_type.value=="2")
	{
		document.forms[0].txt_loannos.value=val4;
		document.forms[0].txt_loanamt.value=val5;
		document.forms[0].txt_agrno.value=val6;
		document.forms[0].txt_agramt.value=val7;
	}		
	document.forms[0].txt_remarks.value=val8;
	document.forms[0].hidsno1.value=val9;
	document.forms[0].sel_date.value=val10;
	document.forms[0].txt_excesspermitted.value=val11;
	
	
	
	//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh

	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		if("<%=strstatus%>"=="O"  &&  varright=="w"){
		    enableButtons(true,false,true,false,false,false,false);
		}else{
			enableButtons(true,true,true,true,true,false,false);	
		}
			
	} else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		
		enableButtons(true,true,true,true,true,false,false);	
		
    }else{
		
		if("<%=strapplevel%>" == "S"){
			enableButtons(true,true,true,true,true,false,false);
		}else{
			if(document.forms[0].btnenable.value=="Y"){
				enableButtons(true,false,true,false,false,false);
				
			}else {
				
				enableButtons(true,true,true,true,true,false);
			}
	    }
	}

	//End
	if(document.forms[0].hidNonPoolFlag.value=="Y")
	{
		enableButtons(true,true,true,true,true,false);
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

function onloading()
{	  
	//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh
	if(document.forms[0].hidNonPoolFlag.value=="Y")
	{
	enableButtons(false,true,true,true,true,false,false);
	}
	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		if("<%=strstatus%>"=="O"  &&  varright=="w"){
		    enableButtons(false,true,true,true,true,false,false);
		}else{
			enableButtons(false,true,true,true,true,false,false);	
		}
			
	} else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		
		enableButtons(false,false,false,false,true,false,false);
			
    }else{
		
		if("<%=strapplevel%>" == "S"){
			enableButtons(false,true,true,true,true,false,false);
		}
	}

	//End
	showdetails();
	disableFields(true);
	if(document.forms[0].hidNonPoolFlag.value=="Y")
	{
		enableButtons(true,true,true,true,true,false,false);
	}
	
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	document.forms[0].hideditflag.value="Y";
	disableCommandButtons(true,true,false,false,false,true,false);
	document.forms[0].sel_date.disabled = true; 
	
}

function doSave()
{
	if(document.forms[0].sel_date.value=="")
	{
		alert("Select the year");
		document.forms[0].sel_date.focus();
		return false;
	}	
	else if(document.forms[0].txt_sancamt.value=="" || document.forms[0].txt_sancamt.value=="0.00"|| document.forms[0].txt_sancamt.value=="0")
	{
		alert("Enter Sanction Limit");
		document.forms[0].txt_sancamt.focus();
		return;
	}	
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].sel_date.disabled = false;
		document.forms[0].hidBeanId.value="inwardRegister";		
		document.forms[0].hidSourceUrl.value="/action/com_packingcredit.jsp";
		document.forms[0].hidBeanMethod.value="updatePackingCredit";
		document.forms[0].hidBeanGetMethod.value="getPackingCredit";
		document.forms[0].action=appURL+"controllerservlet?hidbustype=BP";
		document.forms[0].submit();
	
}


function checkYear()
{
	<%
	if (arrRow != null && arrRow.size() > 0) {
		if (arrRow.size() > 0) {
			for (int i = 0; i < arrRow.size(); i++) {
				arrCol = (ArrayList) arrRow.get(i);
			String yearslno= Helper.correctNull((String) arrCol.get(9));
			String strSno= Helper.correctNull((String) arrCol.get(1));
	%>
		var yearslno="<%=yearslno %>";	
		var selYear=document.forms[0].sel_date.value; 
		var varSno="<%=strSno%>";
		if(yearslno==selYear && document.forms[0].sel_type.value==varSno)
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



function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanMethod.value="updatePackingCredit";
		document.forms[0].hidBeanGetMethod.value="getPackingCredit";	
		document.forms[0].hidBeanId.value="inwardRegister";
		document.forms[0].hidSourceUrl.value="action/com_packingcredit.jsp";	
		document.forms[0].action=appURL+"controllerservlet?hidbustype=BP";
		document.forms[0].submit();	
	 }	
}

function doNew()
{
	disableFields(false);
    document.forms[0].hidAction.value ="insert";
    document.forms[0].hideditflag.value="Y";
    disableCommandButtons(true,true,false,true,false,true,false);
  	
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="inwardRegister";
		document.forms[0].hidBeanGetMethod.value="getPackingCredit";
		document.forms[0].action=appURL+"action/com_packingcredit.jsp?hidbustype=BP";
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
 function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function enableButtons(valnew,valedit,valapply,valcancel,valdel,valclose,valpccomments,valbpccomments)
{
	document.forms[0].cmdnew.disabled=valnew;
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
	document.forms[0].cmdpccomments.disabled=valpccomments;
	document.forms[0].cmdbpccomments.disabled=valbpccomments;
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
function showdetails()
{
	if(document.forms[0].sel_type.value=="1")
	{
		document.all.BPC.style.visibility="visible";
		document.all.BPC.style.position="relative";
		document.all.BPC1.style.visibility="visible";
		document.all.BPC1.style.position="relative";
		document.all.PC.style.visibility="hidden";
		document.all.PC.style.position="absolute";
		document.all.PC1.style.visibility="hidden";
		document.all.PC1.style.position="absolute";
		document.all.PC2.style.visibility="hidden";
		document.all.PC2.style.position="absolute";
	}
	else if(document.forms[0].sel_type.value=="2")
	{
		document.all.BPC.style.visibility="hidden";
		document.all.BPC.style.position="absolute";
		document.all.BPC1.style.visibility="hidden";
		document.all.BPC1.style.position="absolute";
		document.all.PC.style.visibility="visible";
		document.all.PC.style.position="relative";
		document.all.PC1.style.visibility="hidden";
		document.all.PC1.style.position="absolute";
		document.all.PC2.style.visibility="visible";
		document.all.PC2.style.position="relative";
	}
	else
	{
		document.all.BPC.style.visibility="visible";
		document.all.BPC.style.position="relative";
		document.all.BPC1.style.visibility="visible";
		document.all.BPC1.style.position="relative";
		document.all.PC.style.visibility="hidden";
		document.all.PC.style.position="absolute";
		document.all.PC1.style.visibility="hidden";
		document.all.PC1.style.position="absolute";
		document.all.PC2.style.visibility="hidden";
		document.all.PC2.style.position="absolute";
	}	
				
}
function doPccomments()
{
	var btnenable=document.forms[0].btnenable.value;
	var hidAppNo = document.forms[0].hidappno.value;
	var hidCommentPage = "PC";
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidCommentPage="+hidCommentPage+"&appstatus="+appstatus+"&btnenable="+btnenable;
	window.open(url,"Comments",prop);
}
function doBpccomments()
{
	var btnenable=document.forms[0].btnenable.value;
	var hidAppNo = document.forms[0].hidappno.value;
	var hidCommentPage = "BPC";
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidCommentPage="+hidCommentPage+"&appstatus="+appstatus+"&btnenable="+btnenable;
	window.open(url,"Comments",prop);
}
function checkcnt(val)
{
	if(val=="No")
	{
		if(eval(document.forms[0].txt_nos.value)<eval(document.forms[0].txt_nosret.value))
		{
			alert("No of cheques returned should not be greater than the cheques");
			document.forms[0].txt_nosret.value="";
			document.forms[0].txt_nosret.focus();
			return;
		}
	}
	else
	{
		if(eval(document.forms[0].txt_amt.value)<eval(document.forms[0].txt_amtret.value))
		{
			alert("No of returned cheque amount should not be greater than the cheques amount");
			document.forms[0].txt_amtret.value="";
			document.forms[0].txt_amtret.focus();
			return;
		}
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading();showdetails();">
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

<form method="post" name="frmbrrecmd" class="normal">
<%
if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
class="outertable">
<tr>
	<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
		<jsp:param name="pageid" value="9" />
		<jsp:param name="subpageid" value="125" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
		<jsp:param name="ssitype" value="<%=strSSIType%>" />
	</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
	</td>
</tr>
</table>
<%}else{
	if (strSaral.equalsIgnoreCase("saral")) {
%> <lapschoice:saralreportTag
	tabid="8" sector="<%=strSector%>" applied="<%=strappliedfor%>"
	proposal="<%=strProposal%>" /> <lapschoice:inward /> <%
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
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Agriculture-&gt;&nbsp;Proposal&nbsp;-&gt;
		&nbsp;Business Turn Over&nbsp;-&gt;&nbsp;Conduct of Working Capital Facilities&nbsp;-&gt;&nbsp;BPC & PC / Shipping Loan</td>
	<%}else{ %>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Corporate&nbsp;&amp;&nbsp;SME&nbsp;-&gt;&nbsp;Proposal&nbsp;-&gt;
		&nbsp;Business Turn Over&nbsp;-&gt;&nbsp;Conduct of Working Capital Facilities&nbsp;-&gt;&nbsp;BPC & PC / Shipping Loan</td>
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
	applevel="<%=strApplevel%>" applied="<%=strappliedfor%>" /> <%
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
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','facilities','getComments','com_termloancomments.jsp?hidPage=term')"
			onMouseOut="window.status='';return true;">Term Loan</a> </b></td>
		<td class="sub_tab_active" " align="center" ><b>Conduct of Working Capital Facilities</b></td>
		<td class="sub_tab_inactive" align="center" ><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','compro','getcom_nonfundloanlcdata','facilityremdforadverse.jsp')"
			onMouseOut="window.status='';return true;">Non Funded Loans</a> </b></td>
		<td class="sub_tab_inactive" align="center" ><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','compro','getFinancialComments','com_otherfaccomments.jsp?hidPage=otherfac')"
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
	     	<td class="sub_tab_inactive" align="center" ><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getOdCcLimits','facilityremdforbusiess.jsp?hidbustype=AF')"
			onMouseOut="window.status='';return true;">OD / CC Limit</a> </b></td>		
		
			<td class="sub_tab_active" " align="center" nowrap="nowrap"><b>BPC &amp; PC / Shipping Loan</b></td>
		<td class="sub_tab_inactive" align="center" ><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getBillsPurchasedDetails','com_billspurchased.jsp')"
			onMouseOut="window.status='';return true;">Bills Purchased</a> </b></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable">
					<tr>
						<td>
						<table width="80%" border="0" cellspacing="0" cellpadding="0"
							align="center" class="outertable border1">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="2" cellpadding="5"
									class="outertable">
									 <tr><td>Select the year<b><span class="mantatory">*&nbsp;</span></b></td><td> 
									<select name="sel_date" onchange="checkYear()">
     									<option value="">-- Select -- </option>
     									 <laps:AgrFinancialYear appno="<%=strappno%>" page="" />
     									 </select></td></tr>
									
									<tr>
									<td>Type</td>
									<td><select name="sel_type" tabindex="1" onchange="showdetails();checkYear();">
										<option value="0" selected="selected">&lt;----Select----&gt;</option>
										<option value="1">BPC Details</option>
										<option value="2">Packing Credit /Shipping Loan</option>
									</select></td>
									<td>Sanctioned Amount</td>
									<td ><input type="text" name="txt_sancamt" size="17" style="text-align: right"
									maxlength="9" value="" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
									</td>										
									</tr>
										
									
						<tr><td colspan="4">			
					<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable" align="center">
                    <tr class="dataheader">
                      <td width="25%" align="center">Particular</td>
                      <td width="25%" align="center">Nos.</td>
                      <td align="center" width="25%">Amount<b></b></td>
                     </tr>
                   
                    <tr class="datagrid" align="left" id="BPC">
                      <td>Cheque</td>
                      <td width="25%" align="center"><input type="text" name="txt_nos" size="17"
							maxlength="9" value="" onKeyPress="allowInteger()" onblur="checkcnt('No')">
                      </td>
                      <td width="25%" align="center"><input type="text" name="txt_amt" size="17"
							maxlength="9" value="" style="text-align: right" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);checkcnt('Amt')">
                      </td>
                      </tr>
                      
                      <tr  class="datagrid" align="left" id="BPC1">
                      <td>Cheque returned</td>
                      <td width="25%" align="center"><input type="text" name="txt_nosret" size="17"
							maxlength="9" value="" onKeyPress="allowInteger()" onblur="checkcnt('No')">
                      </td>
                      <td width="25%" align="center"><input type="text" name="txt_amtret" size="17"
							maxlength="9" value="" style="text-align: right" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);checkcnt('Amt');">
                      </td>
                      </tr> 
                      
                      <tr  class="datagrid" align="left" id="PC">
                      <td>Loans released </td>
                      <td width="25%" align="center"><input type="text" name="txt_loannos" size="17"
							maxlength="9" value="" onKeyPress="allowInteger()">
                      </td>
                      <td width="25%" align="center"><input type="text" name="txt_loanamt" size="17"
							maxlength="9" value="" style="text-align: right" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
                      </td>
                      </tr>
                      
                      <tr  class="datagrid" align="left" id="PC1">
                      <td>Aggregate Amount</td>
                      <td width="25%" align="center"><input type="text" name="txt_agrno" size="17"
							maxlength="9" value="" onKeyPress="allowInteger()">
                      </td>
                      <td width="25%" align="center"><input type="text" name="txt_agramt" size="17"
							maxlength="9" value="" style="text-align: right" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)">
                      </td>
                      </tr>
                      <tr  class="datagrid" align="left" id="PC2">
                      <td>No. of occasion excesses permitted</td>
                      <td width="25%" align="center"><input type="text" name="txt_excesspermitted" size="17"
							maxlength="9" value="" onKeyPress="allowInteger()">
                      </td>
                      </tr>
                     </table> 
                     </td></tr>
                     <tr><td colspan="4"> 
                       <table width="100%" border="0" cellspacing="0" cellpadding="3"
					 > 
					<tr>
					<td>&nbsp;</td>
					</tr>
					<tr  class="datagrid">
                      	<td width="30%" align="center"> Remarks</td>
						<td width="70%">
						<textarea NAME="txt_remarks"
						COLS="75" ROWS="5" WRAP="VIRTUAL"
						onKeyPress="textlimit(document.forms[0].txt_remarks,3999)" onKeyUp="textlimit(this,3999)"> </textarea>
						</td>
						</tr> 
						</table>
						</td></tr>
                      </table>
                       
                         </td>
                         </tr>
                         </table>
                         </td>
                         </tr>
                         </table>
                         </td>
                         </tr>
						<br>
		
		 <lapschoice:combuttonnew
							btnnames='New_Edit_Save_Cancel_Delete_BPCComments_PCComments_Audit Trail'
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	
												
						
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
										<td width="5%">S.No</td>
										<td align="center" width="30%"><b>Type</b></td>
										<td align="center" width="30%"><b>Number</b></td>
										<td align="center" width="25%"><b>Amount (<%=ApplicationParams.getCurrency()%><%=strValuesin%>)</b></td>
									</tr>
								</table>
								<table width="100%" border="0" cellspacing="1" cellpadding="3"
									class="outertable">
									<%
										if (arrRow != null && arrRow.size() > 0) {
											if (arrRow.size() > 0) {
												for (int i = 0; i < arrRow.size(); i++) {
													arrCol = (ArrayList) arrRow.get(i);
													String strSno=Helper.correctNull((String) arrCol.get(8));
													String strtype=Helper.correctNull((String) arrCol.get(1)),strseltype="";
													if(strtype.equalsIgnoreCase("1"))
													{
														strseltype="BPC Details";
													}
													else if(strtype.equalsIgnoreCase("2"))
													{
														strseltype="Packing Credit";
													}
									%>
									     
									<tr class="datagrid">
										<td width="5%" align="center"><input type="radio"
											style="border: none" name="radiobutton" value="radiobutton"
											onClick="javascript:selectValues(
										'<%=Helper.correctNull((String) arrCol.get(0))%>',
										'<%=Helper.correctNull((String) arrCol.get(1))%>',
			                            '<%=Helper.correctNull((String) arrCol.get(2))%>',
			                            '<%=Helper.correctNull((String) arrCol.get(3))%>',
			                            '<%=Helper.correctNull((String) arrCol.get(4))%>',
			                            '<%=Helper.correctNull((String) arrCol.get(5))%>',
			                            '<%=Helper.correctNull((String) arrCol.get(6))%>',
			                            '<%=Helper.replaceForJavaScriptString((String) arrCol.get(7))%>',
			                            '<%=Helper.correctNull((String) arrCol.get(8))%>',
			                            '<%=Helper.correctNull((String) arrCol.get(9))%>',
			                            '<%=Helper.correctNull((String) arrCol.get(10))%>')" />
			                            <input type="hidden" name="hidsno"  value="<%=Helper.correctNull((String) arrCol.get(8))%>">
			                         	</td>
										<td width="5%" align="left">&nbsp; <%=i+1%></td>
										<td width="30%" align="left">&nbsp; <%=strseltype%></td>
										<td width="30%" align="left">&nbsp;<%=Helper.correctNull((String) arrCol.get(3))%></td>
										<td width="25%" align="right">&nbsp;<%=Helper.correctNull((String) arrCol.get(2))%></td>
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
	
<br>
<lapschoice:hiddentag pageid="<%=PageId%>" />  <input type="hidden"
	name="busOperation_text" value=""> <input type="hidden"
	name="cattype" value="<%=strCategoryType%>"> <input
	type="hidden" name="ssitype" value="<%=strSSIType%>">
	<input type="hidden"
	name="hidappno" value="<%=strappno%>">
	 <input type="hidden" name="hidsno1"  value="">
</form>
</body>
</html>
