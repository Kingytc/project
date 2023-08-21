<%@include file="../share/directives.jsp"%>
<%	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	arrRow = (ArrayList) hshValues.get("arrRow");			
	String category = Helper.correctNull((String) request.getParameter("hidcatory"));
	String Valuesin = Helper.correctNull((String) request.getParameter("valuesin"));
	
	%>
<html>
<head>
<title>Credit Facilities</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varOrgLevel="<%=strOrgLevel%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var btnenable = "<%=Helper.correctNull((String)request.getParameter("btnenable"))%>";
function selectValues(varsno, vargrp)
{
	if(vargrp=="0")
	{
		document.forms[0].txt_bankname.value=document.forms[0].elements["hidbankname"+varsno].value;
		document.forms[0].txt_facility.value=document.forms[0].elements["hidfacility"+varsno].value;
		document.forms[0].txt_limitexist.value=document.forms[0].elements["hidexistlimit"+varsno].value;
		document.forms[0].txt_applicable_roi.value=document.forms[0].elements["hidapproi"+varsno].value;
		document.forms[0].txt_present_roi.value=document.forms[0].elements["hidpresentroi"+varsno].value;		
		document.forms[0].txt_subbankname.value="";
		document.forms[0].txt_subfacility.value="";
		document.forms[0].txt_sublimitexist.value="";
		document.forms[0].txt_subapplicable_roi.value="";
		document.forms[0].txt_subpresent_roi.value="";
		document.forms[0].chksublimit.checked=false;
		document.forms[0].chksublimit.value="N";
		document.forms[0].hidfactype.value="limit";		
	}
	else
	{
		document.forms[0].txt_bankname.value=document.forms[0].elements["hidbankname"+vargrp].value;
		document.forms[0].txt_facility.value=document.forms[0].elements["hidfacility"+vargrp].value;
		document.forms[0].txt_limitexist.value=document.forms[0].elements["hidexistlimit"+vargrp].value;
		document.forms[0].txt_applicable_roi.value=document.forms[0].elements["hidapproi"+vargrp].value;
		document.forms[0].txt_present_roi.value=document.forms[0].elements["hidpresentroi"+vargrp].value;			
		document.forms[0].txt_subbankname.value=document.forms[0].elements["hidbankname"+varsno].value;
		document.forms[0].txt_subfacility.value=document.forms[0].elements["hidfacility"+varsno].value;
		document.forms[0].txt_sublimitexist.value=document.forms[0].elements["hidexistlimit"+varsno].value;
		document.forms[0].txt_subapplicable_roi.value=document.forms[0].elements["hidapproi"+varsno].value;
		document.forms[0].txt_subpresent_roi.value=document.forms[0].elements["hidpresentroi"+varsno].value;
		document.forms[0].chksublimit.checked=true;
		document.forms[0].chksublimit.value="Y";
		document.forms[0].hidfactype.value="sublimit";
	}
	document.forms[0].hidsno.value=varsno;
	document.forms[0].hidfacgrp.value=vargrp;
	if(btnenable == "Y")
	{
		disableCommandButtons(true,false,true,true,false,true);
	}
	else
	{
		disableCommandButtons(true,true,true,true,true,false);
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
	if(document.forms[0].hidfactype.value=="sublimit")
	{	
		document.forms[0].txt_bankname.readOnly=true;
		document.forms[0].txt_facility.readOnly=true;
    	document.forms[0].txt_present_roi.readOnly=true;
		document.forms[0].txt_applicable_roi.readOnly=true;
		document.forms[0].txt_limitexist.readOnly=true;
	}
}
function onloading()
{	  
 disableCommandButtons(false,true,true,true,true,false);
 disableFields(true);
}
function doSave()
{
	if(document.forms[0].hidfactype.value=="limit")
	{
		if(checktrim(document.forms[0].txt_bankname.value) == "")
		{
			ShowAlert(112,'Name of the Bank/FI');
			document.forms[0].txt_bankname.value="";
			document.forms[0].txt_bankname.focus();
			return false;
		}
		else if(checktrim(document.forms[0].txt_facility.value) == "")
		{
			ShowAlert(112,'Nature of facility');
			document.forms[0].txt_facility.value="";
			document.forms[0].txt_facility.focus();
			return false;
		}
		else if(checktrim(document.forms[0].txt_limitexist.value) == "")
		{
			ShowAlert(112,'Existing Limit');
			document.forms[0].txt_limitexist.value="";
			document.forms[0].txt_limitexist.focus();
			return false;
		}		
		else if(checktrim(document.forms[0].txt_present_roi.value) == "")
		{
			ShowAlert(112,'Presently charged ROI/Commission');
			document.forms[0].txt_present_roi.value="";
			document.forms[0].txt_present_roi.focus();
			return false;
		}
	}
	else
	{
		if(checktrim(document.forms[0].txt_subbankname.value) == "")
		{
			ShowAlert(112,'Nameof the Bank/FI');
			document.forms[0].txt_subbankname.value="";
			document.forms[0].txt_subbankname.focus();
			return false;
		}
		else if(checktrim(document.forms[0].txt_subfacility.value) == "")
		{
			ShowAlert(112,'Nature of facility');
			document.forms[0].txt_subfacility.value="";
			document.forms[0].txt_subfacility.focus();
			return false;
		}
		else if(checktrim(document.forms[0].txt_sublimitexist.value) == "")
		{
			ShowAlert(112,'Existing Limit');
			document.forms[0].txt_sublimitexist.value="";
			document.forms[0].txt_sublimitexist.focus();
			return false;
		}
		else if(eval(document.forms[0].txt_sublimitexist.value)>eval(document.forms[0].txt_limitexist.value))
		{
			alert('Sublimit Existing amount cannot be greater than Main limit Existing amount');
			return false;
		}			
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="broadsancterms";		
	document.forms[0].hidSourceUrl.value="/action/combst_creditfacilities.jsp";
	document.forms[0].hidBeanMethod.value="updateCreditFacilitiesData";
	document.forms[0].hidBeanGetMethod.value="getCreditFacilitiesData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value ="delete";
			document.forms[0].hidBeanMethod.value="updateCreditFacilitiesData";
			document.forms[0].hidBeanGetMethod.value="getCreditFacilitiesData";	
			document.forms[0].hidBeanId.value="broadsancterms";
			document.forms[0].hidSourceUrl.value="action/combst_creditfacilities.jsp";	
			document.forms[0].action=appURL+"controllerservlet";
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
    if(document.forms[0].hidfactype.value=="sublimit")
    {
   		document.forms[0].hidfacgrp.value=document.forms[0].hidsno.value;
    	document.forms[0].txt_subfacility.focus();
    }
    else
    {
  		document.forms[0].txt_bankname.value="";
		document.forms[0].txt_facility.value="";
		document.forms[0].txt_limitexist.value="";
		document.forms[0].txt_applicable_roi.value="";
		document.forms[0].txt_present_roi.value="";
		document.forms[0].hidfactype.value="limit";
		document.forms[0].txt_bankname.focus();
	}	
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	document.forms[0].hideditflag.value="Y";
	disableCommandButtons(true,true,false,false,false,true);
	document.forms[0].txt_bankname.focus();
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="broadsancterms";
		document.forms[0].hidBeanGetMethod.value="getCreditFacilitiesData";
		document.forms[0].action=appURL+"action/combst_creditfacilities.jsp";
		document.forms[0].submit();
	}
}
   
 function disableCommandButtons(cmdnew,cmdedit,cmdsave,cmddelete,cmdcancel,cmdclose)
 {  
	  document.forms[0].cmdnew.disabled =cmdnew;
	  document.forms[0].cmdedit.disabled=cmdedit;	  
	  document.forms[0].cmdsave.disabled=cmdsave;
	  document.forms[0].cmddelete.disabled=cmddelete;
	  document.forms[0].cmdcancel.disabled=cmdcancel;
	  document.forms[0].cmdclose.disabled=cmdclose;
 }
function doClose()
{
   if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/combstpge.jsp";
		document.forms[0].submit();
	}
}
function enableButtons(valnew,valedit,valsave,valcancel,valdelete,valclose)
{
	document.forms[0].cmdnew.disabled=valnew;
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valsave;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdelete;
	document.forms[0].cmdclose.disabled=valclose;
}
function callSublimit()
{
	if(document.forms[0].chksublimit.checked && document.forms[0].hideditflag.value=="Y")
	{
		document.forms[0].chksublimit.checked=false;
		alert("Can't check in edit mode or add mode");			
		return;
	}	
	if(document.forms[0].chksublimit.checked==false && document.forms[0].hideditflag.value=="Y")
	{
		document.forms[0].chksublimit.checked=true;
		alert("Can't uncheck");			
		return;
	}	
	if(document.forms[0].chksublimit.checked==false && document.forms[0].hidfacgrp.value!="0")
	{
		document.forms[0].chksublimit.checked=true;
		alert("Can't uncheck sublimit exists");			
		return;
	}	
	if(document.forms[0].hidsno.value=="")
	{
		document.forms[0].chksublimit.checked=false;
		alert("Select Main Limit");
		return;
	}
	if(document.forms[0].chksublimit.checked)
	{
		document.forms[0].hidfactype.value="sublimit";
		document.forms[0].txt_subbankname.value=document.forms[0].txt_bankname.value
		disableCommandButtons(false,true,true,true,true,false);
	}
	else
	{
		document.forms[0].hidfactype.value="limit";
		disableCommandButtons(false,false,true,true,true,false);
	}
}
function callLink(page,bean,method)
{
	if (document.forms[0].cmdsave.disabled)
	{
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
	 }
	else
	{
		ShowAlert(103);
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form method="post" name="frmbrrecmd" class="normal">
<lapstab:applurllinkbst pageid='11' category='<%=category%>' valuesin='<%=Valuesin%>' />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Corporate &amp; SME -&gt; Broad Terms of Proposal -&gt; Credit Facilities</td>
	</tr>
</table>
<lapschoice:BST />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td height="20" width="45%" valign="bottom">
		<table width="30%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr align="center">

				<td align="center" class="sub_tab_inactive"><b><a
					href="javascript:callLink('combst_bankingdetails.jsp','broadsancterms','getBankingArrangementData')"
					>Banking Arrangement</a></b></td>
				<td align="center" class="sub_tab_active"><b>Credit Facilities</b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
					<tr>
						<td valign="top">
						<table width="80%" border="0" cellspacing="0" cellpadding="0" class="outertable border1" align="center">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td width="24%" nowrap>Name of the Bank/FI<span class="mantatory">*&nbsp;</span></td>
										<td width="25%"><input type="text" name="txt_bankname"
											size="25" maxlength="50"></td>
										<td width="21%" nowrap>&nbsp;</td>
										<td width="30%">&nbsp;</td>
									</tr>
									<tr>
										<td width="21%" nowrap>Nature of Facility <span class="mantatory">*&nbsp;</span></td>
										<td width="30%"><input type="text" name="txt_facility"
											size="25" maxlength="50"></td>
										<td width="24%" nowrap>Existing Limit<span class="mantatory">*&nbsp;</span></td>
										<td width="25%"><input type="text" name="txt_limitexist"
											size="15" maxlength="10" style="text-align:right"
											onBlur="roundtxt(this)" onKeyPress="allowNumber(this)"></td>
									</tr>
									<tr>
										
                              <td width="21%">Applicable ROI/Commission</td>
										<td width="30%"><input type="text" name="txt_applicable_roi"
											size="25" maxlength="20"></td>
										<td width="24%" nowrap>Presently charged ROI/Commission<span class="mantatory">*&nbsp;</span></td>
										<td width="25%"><input type="text" name="txt_present_roi"
											size="25" maxlength="20" onBlur="" onKeyPress=""></td>
									</tr>
									<tr>
										<td width="24%" nowrap>&nbsp;</td>
										<td colspan="3">&nbsp;</td>
									</tr>
									<tr>
										<td width="24%" nowrap><input type="checkbox"
											name="chksublimit" value="N" style="border:none"
											onClick="callSublimit()"> Sub-Limits</td>
										<td colspan="3">&nbsp;</td>
									</tr>
									<tr>
										<td width="21%" nowrap>Nature of Facility<span class="mantatory">*&nbsp;</span></td>
										<td width="30%"><input type="text" name="txt_subfacility"
											size="25" maxlength="50"> <input type="hidden"
											name="txt_subbankname" size="25" maxlength="50"></td>
										<td width="24%" nowrap>Existing Limit<span class="mantatory">*&nbsp;</span></td>
										<td width="25%"><input type="text" name="txt_sublimitexist"
											size="15" maxlength="10" style="text-align:right"
											onBlur="roundtxt(this)" onKeyPress="allowNumber(this)"></td>
									</tr>
									<tr>
										
                              <td width="21%">Applicable ROI/Commission</td>
										<td width="30%"><input type="text"
											name="txt_subapplicable_roi" size="25" maxlength="20"></td>

										
                              <td width="24%" nowrap>Presently charged ROI/Commission</td>
										<td width="25%"><input type="text" name="txt_subpresent_roi"
											size="25" maxlength="20" onBlur="" onKeyPress=""></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
						</tr>
						</table></td>
						</tr>
						</table>
						</td>
						</tr>
						</table>
						<br>
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br> 
					<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
							<tr>
								<td>

								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
									<tr class="dataheader">
										<td width="5%" >&nbsp;</td>
										<td align="center" width="25%" ><b>Name of the Bank/FI</b></td>
										<td align="center" width="25%" ><b>Nature of Facility</b></td>
										<td align="center" width="15%" ><b>Existing Limit</b></td>
										
            <td align="center" width="15%" ><b>Applicable ROI/Commission</b></td>
										<td align="center" width="15%" ><b>Presently charged ROI/Commission</b></td>
									</tr>
								<%String strSno="";
                            double dblExistLimit=0.0;
			if (arrRow != null && arrRow.size() > 0) {
				if (arrRow.size() > 0) {
					int count=0;
					for (int i = 0; i < arrRow.size(); i++) {
						arrCol = (ArrayList) arrRow.get(i);
						
						strSno=Helper.correctNull((String)arrCol.get(0));
						if(Helper.correctNull((String)arrCol.get(1)).equalsIgnoreCase("0")){
							dblExistLimit=dblExistLimit+Double.parseDouble(Helper.correctDouble((String)arrCol.get(4)));
							count=0;%>
									<tr class="datagrid">
										<td width="5%" align="center"><input type="radio"
											style="border:none" name="rdoUser"
											onClick="javascript:selectValues('<%=strSno%>','<%=Helper.correctNull((String)arrCol.get(1))%>')">
										<input type="hidden" name="hidbankname<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(2))%>" /> <input
											type="hidden" name="hidfacility<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(3))%>" /> <input
											type="hidden" name="hidexistlimit<%=strSno%>"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(4))))%>" />
										<input type="hidden" name="hidapproi<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(5))%>" /> <input
											type="hidden" name="hidpresentroi<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(6))%>" /> <input
											type="hidden" name="hidfacsno<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(0))%>" /> <input
											type="hidden" name="hidfacgroup<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(1))%>" /></td>
										<td width="25%" align="left">&nbsp; <%=Helper.correctNull((String) arrCol.get(2))%></td>
										<td width="25%" align="left">&nbsp;<%=Helper.correctNull((String) arrCol.get(3))%></td>
										<td width="15%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(4))))%></td>
										<td align="left" width="15%">&nbsp;<%=Helper.correctNull((String) arrCol.get(5))%></td>
										<td align="left" width="15">&nbsp;<%=Helper.correctNull((String) arrCol.get(6))%></td>
									</tr>
									<%}else if(!Helper.correctNull((String)arrCol.get(1)).equalsIgnoreCase("0")){%>
									<tr class="dataheader">
										<%if(count==0){ %>
										<td>&nbsp;</td>
										<td colspan="6"><b>&gt;&gt;Sub Limit</b></td>
									</tr>				
										<%} %>
										<tr class="datagrid">
										<td width="5%" align="center"><input type="radio"
											style="border:none" name="rdoUser"
											onClick="javascript:selectValues('<%=strSno%>','<%=Helper.correctNull((String)arrCol.get(1))%>')">
										<input type="hidden" name="hidbankname<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(2))%>" /> <input
											type="hidden" name="hidfacility<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(3))%>" /> <input
											type="hidden" name="hidexistlimit<%=strSno%>"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(4))))%>" />
										<input type="hidden" name="hidapproi<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(5))%>" /> <input
											type="hidden" name="hidpresentroi<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(6))%>" /> <input
											type="hidden" name="hidfacsno<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(0))%>" /> <input
											type="hidden" name="hidfacgroup<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(1))%>" /></td>
										<td width="25%" align="left"><%=Helper.correctNull((String) arrCol.get(2))%>&nbsp;</td>
										<td width="25%" align="left"><%=Helper.correctNull((String) arrCol.get(3))%>&nbsp;</td>
										<td width="15%" align="right">&nbsp;(<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(4))))%>)</td>
										<td align="left" width="15%"><%=Helper.correctNull((String) arrCol.get(5))%>&nbsp;</td>
										<td align="left" width="15%"><%=Helper.correctNull((String) arrCol.get(6))%>&nbsp;</td>
									</tr>
									<%count++;}}}%>
									<tr class="dataheader">
										<td colspan="3" align="right">&nbsp;<b>Total</b></td>
										<td align="right">&nbsp;<%=Helper.formatDoubleValue(dblExistLimit)%></td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<%}else {%>
									<tr class="datagrid">
										<td align="center" colspan="6">No Data Found</td>
									</tr>
									<%}%>
								</table>
								</td>
							</tr>
						</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidsno" value=""> 
<input type="hidden" name="hidfacgrp" value=""> 
<input type="hidden" name="hidfactype">
</form>
</body>
</html>
