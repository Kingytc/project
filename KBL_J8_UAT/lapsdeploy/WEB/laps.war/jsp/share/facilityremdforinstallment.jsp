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
	String strProposal = Helper.correctNull(request
			.getParameter("hidproposal"));
	 //Added by Zahoorunnisa.S for button functionality
    String strapplevel = Helper.correctNull((String)request.getParameter("applevel"));
	String strstatus = Helper.correctNull((String) request.getParameter("hidstatus"));
	if (strstatus.equals(""))
		strstatus = Helper.correctNull((String) hshValues.get("status"));
	//End
%>

<html>
<head>
<title>Facility For Recommendation</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"> </script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varOrgLevel="<%=strOrgLevel%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";
function selectValues(val1,val2,val3,val4)
{
	document.forms[0].busOperation.value=val1;
	document.forms[0].txt_number.value=val2;
	document.forms[0].txt_amt.value=val3;
	document.forms[0].hidsno.value=val4;
	
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

	if(document.forms[0].busOperation.value=='')
	{
		alert("Enter Particulars");
		document.forms[0].busOperation.focus();	
		return;
	}
	else
	{
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidBeanId.value="inwardRegister";		
		document.forms[0].hidSourceUrl.value="/action/facilityremdforinstallment.jsp";
		document.forms[0].hidBeanMethod.value="updateBusinessOperationsDetails";
		document.forms[0].hidBeanGetMethod.value="getBusinessOperationsDetails";
		document.forms[0].action=appURL+"controllerservlet?hidbustype=DI";
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
			document.forms[0].hidSourceUrl.value="action/facilityremdforinstallment.jsp";	
			document.forms[0].action=appURL+"controllerservlet?hidbustype=DI";
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
    disableCommandButtons(true,true,false,true,false,true);
    document.forms[0].hideditflag.value="Y";
  	document.forms[0].busOperation.value='';
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
		document.forms[0].action=appURL+"action/facilityremdforinstallment.jsp?hidbustype=DI";
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
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form method="post" name="frmbrrecmd" class="normal">
<%
	if (strSaral.equalsIgnoreCase("saral")) {
%> <lapschoice:saralreportTag
	tabid="8" sector='<%=strSector%>' applied='<%=strappliedfor%>'
	proposal='<%=strProposal%>' /> <lapschoice:inward /> <%
 	} else if (strApploantype.equalsIgnoreCase("c")) {
 %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top"><jsp:include
			page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="15" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Corporate&nbsp;&amp;&nbsp;SME&nbsp;-&gt;&nbsp;Proposal&nbsp;-&gt;
		&nbsp;Business Turn Over&nbsp;-&gt;&nbsp;Defaults in Installments</td>
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%
	} else if (strApploantype.equalsIgnoreCase("T")) {
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../share/menus.jsp"
			flush="true"/>
		 <jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="10" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow"><b>Home -&gt; Tertiary -&gt;
		Application -&gt; Reports -&gt; Recommendation by Branch</b></td>
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<lapstab:TerReportTab tabid="3" applevel='<%=strApplevel%>'
	applied='<%=strappliedfor%>' /> <%
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
		<td class="page_flow">Home -&gt; Retail -&gt; <%=(String) session.getAttribute("pgeLabel")%>
		-&gt; Appraisal -&gt; Recommendation by Branch</td>
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
		<td valign="top"><jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="12" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Adhoc
		Limit -&gt; Business Turn Over -&gt; Defaults in Installment</td>
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
		<td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onClick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getAccountOperationalDetails','facilityrecmdforrenewal.jsp')"
			onMouseOut="window.status='';return true;">Term Loan</a> </b></td>
		<td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onClick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getBusinessOperationsDetails','facilityremdforbusiess.jsp?hidbustype=BP')"
			onMouseOut="window.status='';return true;">Conduct of Working Capital</a> </b></td>
		<td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onClick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getBusinessOperationsDetails','facilityremdforadverse.jsp?hidbustype=AF')"
			onMouseOut="window.status='';return true;">Non Funded Loans</a> </b></td>
		<td class="sub_tab_active" align="center"><b>
		Comments </b></td>
		  <td class="sub_tab_inactive" align="center"><b> <a
			href="#"
			onclick="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getOthersDetails','com_others.jsp')"
			onMouseOut="window.status='';return true;">Others</a> </b></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
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
						<td valign="top">
						<table width="80%" border="0" cellspacing="0" cellpadding="3"
							align="center" class="outertable border1">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3"
									class="outertable">
									<tr>
										<td nowrap="nowrap" width="25%" colspan="4"><b>Defaults
										in Term Loan / DPGL etc </b></td>
									</tr>
									<tr>
										<td width="25%" nowrap="nowrap">Particular <span
											class="mantatory">*</span></td>
										<td width="36%"><input type="text" name="busOperation"
											size="45" maxlength="60"></td>
										<td width="25%" nowrap="nowrap">&nbsp;</td>
										<td width="36%">&nbsp;</td>
									</tr>
									<tr>
										<td width="25%" nowrap="nowrap">Number</td>
										<td width="36%"><input type="text" name="txt_number"
											size="15" onKeyPress="allowNumber(this)" maxlength="7">
										</td>
										<td width="25%" nowrap="nowrap">Amount (<%=ApplicationParams.getCurrency()%><%=strValuesin%>)</td>
										<td width="36%"><input type="text" name="txt_amt"
											size="25" maxlength="12" style="text-align: right"
											onBlur="roundtxt(this)" onKeyPress="allowNumber(this)">
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						<br>
						<lapschoice:combuttonnew
							btnnames='New_Edit_Save_Cancel_Delete_Audit Trail'
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' /><br>
						<table width="80%" border="0" class="outertable border1" cellspacing="0" cellpadding="0"
							align="center">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="3"
									class="outertable">
									<tr class="dataheader">
										<td width="5%">&nbsp;</td>
										<td align="center" width="39%"><b>Particular</b></td>
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
										<td width="39%" align="left">&nbsp; <%=Helper.correctNull((String) arrCol.get(3))%><!-- input type="hidden" name = "buss_oper" value="<%//=Helper.correctNull((String) arrCol.get(3))%>"--></td>
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
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="cattype" value="<%=strCategoryType%>"> <input
	type="hidden" name="ssitype" value="<%=strSSIType%>"> <input
	type="hidden" name="hidsno" value=""></form>

</body>
</html>
