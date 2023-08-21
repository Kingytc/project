<%@include file="../share/directives.jsp"%>
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
//end
%>

<html>
<head>
<title>Facility For Recommendation</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>	

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varOrgLevel="<%=strOrgLevel%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";
function callCalender(fname)
 {
 	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
 }
 
 
function selectValues(val1,val2,val3,val4)
{
	document.forms[0].txt_number.value=val2;
	document.forms[0].txt_amt.value=val3;
	document.forms[0].hidsno.value=val4;
	document.forms[0].txt_others.value=val1;
	
	for(var i=0;i<document.forms[0].busOperation.length;i++)
	{
		if(document.forms[0].busOperation.options[i].value == val1)
		{
			document.forms[0].busOperation.value=val1;
			break;
		} 
		else
		{
			document.forms[0].busOperation.value='Any Others';
		}
	}
	showothers();
	//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh

	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		if("<%=strstatus%>"=="O"  &&  varright=="w"){
		    enableButtons(true,false,true,true,true,false);
		}else{
			enableButtons(true,true,true,true,true,false);	
		}
			
	} else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		
		enableButtons(true,true,true,true,true,false);	
		
    }else{
		
		if("<%=strapplevel%>" == "S"){
			enableButtons(true,true,true,true,true,false);
		}else{
			if(document.forms[0].btnenable.value=="Y"){
				enableButtons(true,false,true,true,true,false);
				
			}else {
				
				enableButtons(true,true,true,true,true,false);
			}
	    }
	}

	//End

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
	
	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		if("<%=strstatus%>"=="O"  &&  varright=="w"){
		    enableButtons(false,true,true,true,true,false);
		}else{
			enableButtons(true,true,true,true,true,false);	
		}
			
	} else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		
		enableButtons(true,true,true,true,true,false);
			
    }else{
		
		if("<%=strapplevel%>" == "S"){
			enableButtons(true,true,true,true,true,false);
		}
	}

	//End
	
	disableFields(true);
	showothers();
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	 document.forms[0].hideditflag.value="Y";
	disableCommandButtons(true,true,false,false,false,true);
	document.forms[0].busOperation.focus();
}

function doSave()
{

	
	if(document.forms[0].busOperation.value=='' || document.forms[0].busOperation.value=='0')
	{
		alert("Enter Business Operations");
		document.forms[0].busOperation.focus();	
		return;
	}
	else if(document.forms[0].txt_fromdate.value=="")
	{
		alert("Enter From Date");
		document.forms[0].txt_fromdate.focus();	
		return;
	}
	else if(document.forms[0].txt_todate.value=="")
	{
		alert("Enter To Date");
		document.forms[0].txt_todate.focus();	
		return;
	}
	else
	{
		var len = document.forms[0].busOperation.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].busOperation.options[i].selected==true)
			 {
				 document.forms[0].busOperation_text.value = document.forms[0].busOperation.options[i].text; 
				break;
			 }
		}
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidBeanId.value="inwardRegister";		
		document.forms[0].hidSourceUrl.value="/action/facilityremdforbusiess.jsp";
		document.forms[0].hidBeanMethod.value="updateBusinessOperationsDetails";
		document.forms[0].hidBeanGetMethod.value="getBusinessOperationsDetails";
		document.forms[0].action=appURL+"controllerservlet?hidbustype=BP";
		document.forms[0].submit();
	}
}

function doDelete()
{
	if(varRecordFlag=="Y")
	{
	 if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanMethod.value="updateBusinessOperationsDetails";
		document.forms[0].hidBeanGetMethod.value="getBusinessOperationsDetails";	
		document.forms[0].hidBeanId.value="inwardRegister";
		document.forms[0].hidSourceUrl.value="action/facilityremdforbusiess.jsp";	
		document.forms[0].action=appURL+"controllerservlet?hidbustype=BP";
		document.forms[0].submit();	
	 }	
   }
	else
	{
		ShowAlert(158);
	}
}

function doNew()
{
	disableFields(false);
    document.forms[0].hidAction.value ="insert";
     document.forms[0].hideditflag.value="Y";
    disableCommandButtons(true,true,false,true,false,true);
  	document.forms[0].busOperation.value=0;
	document.forms[0].txt_number.value='';
	document.forms[0].txt_amt.value='';
	document.forms[0].busOperation.focus();
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="inwardRegister";
		document.forms[0].hidBeanGetMethod.value="getBusinessOperationsDetails";
		document.forms[0].action=appURL+"action/facilityremdforbusiess.jsp?hidbustype=BP";
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
function enableButtons(valnew,valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdnew.disabled=valnew;
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
}
function showothers()
{
	if(document.forms[0].busOperation.value=='Any Others')
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
	if (strSaral.equalsIgnoreCase("saral")) {
%> <lapschoice:saralreportTag
	tabid="8" sector="<%=strSector%>" applied="<%=strappliedfor%>"
	proposal="<%=strProposal%>" /> <lapschoice:inward /> <%
 	} else if (strApploantype.equalsIgnoreCase("c")) {
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
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Corporate&nbsp;&amp;&nbsp;SME&nbsp;-&gt;&nbsp;Proposal&nbsp;-&gt;
		&nbsp;Business Turn Over&nbsp;-&gt;&nbsp;Bussiness Operation</td>
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
	}
%>
<table border="0" cellspacing="1" cellpadding="3" class="outertable"
	width="60%">
	<tr>
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
			onMouseOut="window.status='';return true;">Comments</a> </b></td>
			
			  <td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getOthersDetails','com_others.jsp')"
			onMouseOut="window.status='';return true;">Others</a> </b></td>
	</tr>
</table>
<table border="0" cellspacing="1" cellpadding="3" class="outertable"
	width="60%">
	<tr>
	     	<td class="sub_tab_inactive" align="center" ><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getOdCcLimits','facilityremdforbusiess.jsp')"
			onMouseOut="window.status='';return true;">OD/CC Limit</a> </b></td>
		
		<td class="sub_tab_inactive" align="center" nowrap="nowrap"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getPackingCredit','com_packingcredit.jsp?hidbustype=AF')"
			onMouseOut="window.status='';return true;">BPC &amp; PC/Shipping Loan</a> </b></td>
		<td class="sub_tab_inactive" align="center" ><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getBusinessOperationsDetails','com_billspurchased.jsp?hidbustype=DI')"
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
									<tr>
										<td>From Date</td>
										<td><input type="text" name="txt_fromdate"
											value="<%=Helper.correctNull((String) hshValues
							.get("bussoprns_fromdate"))%>"
											size="13" maxlength="10"
											onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')">
										<a alt="Select date from calender"
											href="javascript:callCalender('txt_fromdate')"> <img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											width="21" border="0"></a></td>
										<td>To Date</td>
										<td><input type="text" name="txt_todate"
											value="<%=Helper.correctNull((String) hshValues
							.get("bussoprns_todate"))%>"
											size="13" maxlength="10"
											onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>');comparedate(document.forms[0].txt_fromdate.value,document.forms[0].txt_todate.value)">
										<a alt="Select date from calender"
											href="javascript:callCalender('txt_todate')"> <img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											width="21" border="0"></a></td>
									</tr>
									<tr>
										<td nowrap="nowrap">&nbsp;</td>
										<td nowrap="nowrap">&nbsp;</td>
										<td nowrap="nowrap">&nbsp;</td>
										<td nowrap="nowrap">&nbsp;</td>
									</tr>
									<tr>
										<td width="14%" nowrap="nowrap">Business Operations</td>
										<td width="36%"><select name="busOperation" tabindex="1"
											onchange="showothers()">
											<option value="0" selected="selected">&lt;----Select----&gt;</option>
											<option value="Inland Bills Purchased/Discounted">Inland
											Bills Purchased/Discounted</option>
											<option value="Foreign Bills Purchased/Discounted">Foreign
											Bills Purchased/Discounted</option>
											<option value="Cheques Purchased/Discounted">Cheques
											Purchased/Discounted</option>
											<option value="Inland L/Gs Opened">Inland L/Gs
											Opened</option>
											<option value="Inland L/Cs Opened">Inland L/Cs
											Opened</option>
											<option value="Inland L/Cs Issused">Inland L/Cs
											Issused</option>
											<option value="Bid Bond guarantees Issued">Bid Bond
											guarantees Issued</option>
											<option value="DPGL issued">DPGL issued</option>
											<option value="Any Others">Any Others</option>
										</select></td>
										<td width="14%" nowrap="nowrap" id="R1">Please Specify</td>
										<td width="36%" id="R2"><input type="text"
											name="txt_others" size="45" maxlength="80" tabindex="2"></td>
									</tr>
									<tr>
										<td width="14%" nowrap="nowrap">Number</td>
										<td width="36%"><input type="text" name="txt_number"
											size="15" onKeyPress="allowNumber(this)" maxlength="7"
											tabindex="3"></td>
										<td width="14%" nowrap="nowrap">Amount (<%=ApplicationParams.getCurrency()%><%=strValuesin%>)</td>
										<td width="36%"><input type="text" name="txt_amt"
											size="25" maxlength="12" style="text-align: right"
											onBlur="roundtxt(this)" onKeyPress="allowNumber(this)"
											tabindex="4"></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
						<br>
						<lapschoice:combuttonnew
							btnnames='New_Edit_Save_Cancel_Delete_Audit Trail'
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
										<td align="center" width="39%"><b>Business Operations</b></td>
										<td align="center" width="31%"><b>Number</b></td>
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
									%>
									<tr class="datagrid">
										<td width="5%" align="center"><input type="radio"
											style="border: none" name="rdoUser"
											onClick="javascript:selectValues(
							'<%=Helper.correctNull((String) arrCol.get(3))%>',
							'<%=Helper.correctNull((String) arrCol.get(4))%>'
                            ,'<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(5))))%>'
                            ,'<%=Helper.correctNull((String) arrCol.get(1))%>')">
										</td>
										<td width="39%" align="left">&nbsp; <%=Helper.correctNull((String) arrCol.get(3))%><!-- <input type="hidden" name="buss_oper" value="<%//=Helper.correctNull((String) arrCol.get(3))%>">--></td>
										<td width="30%" align="left">&nbsp;<%=Helper.correctNull((String) arrCol.get(4))%></td>
										<td width="26%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(5))))%></td>
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
<lapschoice:hiddentag pageid="<%=PageId%>" /> <input type="hidden"
	name="hidsno" value=""> <input type="hidden"
	name="busOperation_text" value=""> <input type="hidden"
	name="cattype" value="<%=strCategoryType%>"> <input
	type="hidden" name="ssitype" value="<%=strSSIType%>"></form>

</body>
</html>
